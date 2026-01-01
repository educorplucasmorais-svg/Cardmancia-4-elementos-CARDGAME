# res://ui/MainMenu.gd
# Menu Principal do Jogo
# Estilo: Pixel Art / Roguelike Deckbuilder

extends Control

func _ready() -> void:
	print("=== CARDMANCIA: OS 4 ELEMENTOS ===")
	print("Menu Principal Carregado")
	
	# Configurar pixel art
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	
	# Animar entrada do menu
	_animate_menu_entrance()

func _animate_menu_entrance() -> void:
	# Fade in suave
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func _on_new_run_pressed() -> void:
	print("[MainMenu] Iniciando nova run...")
	_transition_to_scene("res://scenes/Main.tscn")

func _on_challenges_pressed() -> void:
	print("[MainMenu] Desafios ainda não implementados")
	# TODO: Implementar tela de desafios

func _on_settings_pressed() -> void:
	print("[MainMenu] Configurações ainda não implementadas")
	# TODO: Implementar tela de configurações

func _on_quit_pressed() -> void:
	print("[MainMenu] Saindo do jogo...")
	get_tree().quit()

func _transition_to_scene(scene_path: String) -> void:
	# Fade out antes de trocar cena
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	get_tree().change_scene_to_file(scene_path)
