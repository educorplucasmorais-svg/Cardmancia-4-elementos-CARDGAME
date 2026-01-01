# res://game/combat/fsm/SetupState.gd
# Estado: Configuração do Combate
# Responsabilidades: Spawn de inimigos, embaralhamento, aplicação de efeitos "Start of Battle"

class_name SetupState
extends BattleState

func _init(p_battle_manager: BattleManager) -> void:
	super(p_battle_manager)
	state_name = "SetupState"

func enter() -> void:
	super.enter()
	
	# 1. Embaralhar deck do jogador
	if battle_manager.player_hand_manager:
		battle_manager.player_hand_manager.shuffle_deck()
	
	# 2. Spawnar inimigos (placeholder)
	print("[SetupState] Spawning enemies...")
	# TODO: Spawn enemies based on node configuration
	
	# 3. Aplicar efeitos "Start of Battle"
	print("[SetupState] Applying 'Start of Battle' effects...")
	# TODO: Apply relics with StartOfBattle trigger
	
	# 4. Emit signal de início de combate
	SignalBus.battle_started.emit()
	
	# 5. Transicionar para o turno do jogador
	await get_tree().process_frame  # Aguardar 1 frame para evitar transições muito rápidas
	transition_to("PlayerTurnState")
