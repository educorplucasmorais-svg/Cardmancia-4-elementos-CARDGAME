# res://res/ui/MainMenu.gd
# Menu Principal do Jogo - Cardmancia: Os 4 Elementos
# Estilo: Pixel Art / Roguelike Deckbuilder

extends Control

# Referências para animação das cartas
@onready var card_decorations: Control = $CardDecorations

var _time: float = 0.0

func _ready() -> void:
	print("=== CARDMANCIA: OS 4 ELEMENTOS ===")
	print("Menu Principal Carregado")
	
	# Configurar pixel art - sem anti-aliasing para look pixelado
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	
	# Animar entrada do menu
	_animate_menu_entrance()
	_animate_cards_float()

func _process(delta: float) -> void:
	# Animação sutil de flutuação das cartas
	_time += delta
	if card_decorations:
		for i in card_decorations.get_child_count():
			var card: Control = card_decorations.get_child(i)
			var offset: float = sin(_time * 0.8 + i * 1.5) * 3.0
			card.position.y += offset * delta

func _animate_menu_entrance() -> void:
	# Fade in suave
	modulate.a = 0.0
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6).set_ease(Tween.EASE_OUT)

func _animate_cards_float() -> void:
	# Animação inicial das cartas entrando na tela
	if not card_decorations:
		return
	
	for i in card_decorations.get_child_count():
		var card: Control = card_decorations.get_child(i)
		var original_pos: Vector2 = card.position
		
		# Cartas começam fora da tela
		if i < 2:  # Cartas da esquerda
			card.position.x -= 200
		else:  # Cartas da direita
			card.position.x += 200
		
		# Animar entrada com delay
		var tween: Tween = create_tween()
		tween.tween_property(card, "position", original_pos, 0.8)\
			.set_delay(0.1 + i * 0.15)\
			.set_ease(Tween.EASE_OUT)\
			.set_trans(Tween.TRANS_BACK)

func _on_new_run_pressed() -> void:
	print("[MainMenu] Iniciando nova run...")
	_transition_to_scene("res://res/scenes/Main.tscn")

func _on_challenges_pressed() -> void:
	print("[MainMenu] Desafios ainda não implementados")

func _on_settings_pressed() -> void:
	print("[MainMenu] Configurações ainda não implementadas")

func _on_quit_pressed() -> void:
	print("[MainMenu] Saindo do jogo...")
	get_tree().quit()

func _transition_to_scene(scene_path: String) -> void:
	# Animar cartas saindo
	if card_decorations:
		for i in card_decorations.get_child_count():
			var card: Control = card_decorations.get_child(i)
			var tween: Tween = create_tween()
			if i < 2:
				tween.tween_property(card, "position:x", card.position.x - 300, 0.4)
			else:
				tween.tween_property(card, "position:x", card.position.x + 300, 0.4)
	
	# Fade out antes de trocar cena
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
	get_tree().change_scene_to_file(scene_path)
