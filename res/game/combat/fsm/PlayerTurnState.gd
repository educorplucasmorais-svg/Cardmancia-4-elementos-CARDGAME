# res://res/game/combat/fsm/PlayerTurnState.gd
# Estado: Turno do Jogador
# Responsabilidades: Recarga de mana, compra de cartas, input handling

class_name PlayerTurnState
extends BattleState

var turn_count: int = 0

func _init(p_battle_manager: BattleManager) -> void:
	super(p_battle_manager)
	state_name = "PlayerTurnState"

func enter() -> void:
	super.enter()
	turn_count += 1
	
	if not battle_manager.player_stats:
		push_error("[PlayerTurnState] player_stats is null!")
		return
	
	# 1. Recarregar mana
	battle_manager.player_stats.refill_mana()
	SignalBus.mana_changed.emit(battle_manager.player_stats.current_mana, battle_manager.player_stats.max_mana)
	
	# 2. Comprar cartas (draw 5 ou configurável)
	if not battle_manager.player_hand_manager:
		push_error("[PlayerTurnState] hand_manager is null!")
		return
	
	var draw_count: int = 5
	for i in range(draw_count):
		var card: CardData = battle_manager.player_hand_manager.draw_card()
		if card:
			SignalBus.hand_card_drawn.emit(card)
	
	# 3. Sinalizar atualização da mão
	SignalBus.hand_updated.emit(battle_manager.player_hand_manager.hand)
	
	# 4. Emitir sinal de início do turno
	SignalBus.player_turn_started.emit()
	
	# 5. Conectar ao sinal de "jogar carta" (UI vai emitir isso)
	if not SignalBus.request_play_card.is_connected(_on_play_card_requested):
		SignalBus.request_play_card.connect(_on_play_card_requested)

func exit() -> void:
	if SignalBus.request_play_card.is_connected(_on_play_card_requested):
		SignalBus.request_play_card.disconnect(_on_play_card_requested)
	SignalBus.player_turn_ended.emit()
	super.exit()

func handle_input(_event: InputEvent) -> void:
	# Input é processado pela UI (HandManager).
	# Se a carta for jogada com sucesso, HandManager emite request_play_card.
	pass

func _on_play_card_requested(card_data: CardData, target: Node) -> void:
	# 1. Validar se o jogador tem mana suficiente
	if not battle_manager.player_stats.can_afford_card(card_data):
		print("[PlayerTurnState] Insufficient mana!")
		return
	
	# 2. Deduzir mana
	battle_manager.player_stats.spend_mana(card_data.cost)
	
	# 3. Executar efeitos
	var targets: Array[Node] = [target]
	if card_data.target_type == CardData.TargetType.ALL_ENEMIES:
		targets = battle_manager.get_all_enemies()
	
	var context: Dictionary = {"source": battle_manager.player, "battle_manager": battle_manager, "hand_manager": battle_manager.player_hand_manager}
	
	for effect in card_data.effects:
		if effect and effect.can_execute(targets, context):
			effect.execute(targets, context)
			SignalBus.card_effect_executed.emit(effect, targets)
	
	# 4. Emitir sinal de carta jogada
	SignalBus.card_played.emit(card_data, targets)
	
	# 5. Remover carta da mão
	if battle_manager.player_hand_manager:
		battle_manager.player_hand_manager.remove_card_from_hand(card_data)
		SignalBus.hand_updated.emit(battle_manager.player_hand_manager.hand)

# Jogador clica em "Finalizar Turno"
func end_turn() -> void:
	transition_to("ResolutionState")
