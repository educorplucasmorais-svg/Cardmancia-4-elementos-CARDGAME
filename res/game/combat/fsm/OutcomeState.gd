# res://game/combat/fsm/OutcomeState.gd
# Estado: Resultado
# Responsabilidades: Determinar vitória/derrota, distribuir recompensas, carregar run-state

class_name OutcomeState
extends BattleState

func _init(p_battle_manager: BattleManager) -> void:
	super(p_battle_manager)
	state_name = "OutcomeState"

func enter() -> void:
	super.enter()
	
	var player_alive = battle_manager.player.is_alive()
	var enemies_alive = battle_manager.enemies.filter(func(e): return e is Entity and e.is_alive())
	
	if player_alive and enemies_alive.is_empty():
		# VITÓRIA
		print("[OutcomeState] VICTORY!")
		_on_victory()
		SignalBus.battle_ended.emit(true)
	else:
		# DERROTA
		print("[OutcomeState] DEFEAT!")
		_on_defeat()
		SignalBus.battle_ended.emit(false)

func _on_victory() -> void:
	# TODO: Distribuir loot
	# TODO: Desbloquear relíquias
	# TODO: Retornar ao mapa (DAG)
	print("[OutcomeState] Distributing rewards...")

func _on_defeat() -> void:
	# TODO: Retornar ao meta-game (Menu)
	print("[OutcomeState] Returning to meta-game...")
