# res://ui/MockUIController.gd
# Simula entrada do jogador para testar o fluxo de combate
# Estratégia: Emite request_play_card com delay (sem UI gráfica real)

class_name MockUIController
extends Node

var battle_manager: BattleManager
var hand_manager: HandManager
var target_enemy: Node = null
var is_player_turn: bool = false

# Configuração de teste
var auto_play_enabled: bool = true
var play_card_delay: float = 2.0  # segundos entre ações

func _ready() -> void:
	# Encontrar referências
	battle_manager = get_parent().get_node_or_null("BattleManager")
	if battle_manager:
		hand_manager = battle_manager.player_hand_manager
	
	# Conectar aos sinais
	SignalBus.player_turn_started.connect(_on_player_turn_started)
	SignalBus.player_turn_ended.connect(_on_player_turn_ended)
	SignalBus.battle_ended.connect(_on_battle_ended)
	
	# Debug output
	print("[MockUIController] Initialized")

func _on_player_turn_started() -> void:
	print("[MockUIController] Player turn started!")
	is_player_turn = true
	
	if auto_play_enabled:
		await get_tree().create_timer(1.0).timeout
		_auto_play_turn()

func _on_player_turn_ended() -> void:
	print("[MockUIController] Player turn ended!")
	is_player_turn = false

func _on_battle_ended(victory: bool) -> void:
	print("[MockUIController] Battle ended! Victory: %s" % victory)
	auto_play_enabled = false

# Simula ações do jogador automaticamente
func _auto_play_turn() -> void:
	if not is_player_turn or not hand_manager:
		return
	
	# Copiar mão para evitar modificação durante iteração
	var hand_copy = hand_manager.hand.duplicate()
	
	# Jogar 2-3 cartas aleatórias
	var cards_to_play = min(randi_range(1, 3), hand_copy.size())
	
	for i in range(cards_to_play):
		if not is_player_turn:
			break
		
		if hand_manager.hand.is_empty():
			print("[MockUIController] Hand is empty, cannot play more cards")
			break
		
		# Selecionar carta aleatória
		var card_index = randi_range(0, hand_manager.hand.size() - 1)
		var card = hand_manager.hand[card_index]
		
		# Selecionar alvo aleatório (inimigos vivos)
		var alive_enemies = battle_manager.get_all_enemies()
		if alive_enemies.is_empty():
			print("[MockUIController] No alive enemies to target!")
			break
		
		var target = alive_enemies[randi_range(0, alive_enemies.size() - 1)]
		
		# Emitir sinal (como se a UI tivesse detectado um clique)
		print("[MockUIController] Playing card: %s on target: %s" % [card.name, target.name])
		SignalBus.request_play_card.emit(card, target)
		
		# Aguardar animação
		await get_tree().create_timer(play_card_delay).timeout
	
	# Finalizar turno do jogador
	print("[MockUIController] Ending player turn")
	if battle_manager:
		battle_manager.player_turn_end()

# Permitir teste manual via input
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_SPACE:
				# Espaço para jogar próxima carta
				if is_player_turn:
					_auto_play_turn()
			KEY_E:
				# 'E' para finalizar turno
				if is_player_turn and battle_manager:
					battle_manager.player_turn_end()
