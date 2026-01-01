# res://game/combat/fsm/ResolutionState.gd
# Estado: Resolução
# Responsabilidades: Processar pilha (stack) de efeitos, animações, resolvidos

class_name ResolutionState
extends BattleState

var resolution_complete: bool = false

func _init(p_battle_manager: BattleManager) -> void:
	super(p_battle_manager)
	state_name = "ResolutionState"

func enter() -> void:
	super.enter()
	resolution_complete = false
	
	# 1. Processar pilha de efeitos pendentes (se houver)
	print("[ResolutionState] Processing effect stack...")
	# TODO: Iterar sobre stack de efeitos não resolvidos
	
	# 2. Animar dano/cura (via SignalBus)
	# A UI ouve os sinais e anima os números flutuantes
	
	# 3. Reduzir durações de status (poison, stun, etc)
	for enemy in battle_manager.enemies:
		if enemy is Entity:
			enemy.reduce_status_durations()
	
	battle_manager.player.reduce_status_durations()
	
	# 4. Verificar condições de vitória/derrota
	var enemies_alive = battle_manager.enemies.filter(func(e): return e is Entity and e.is_alive())
	
	if enemies_alive.is_empty():
		print("[ResolutionState] All enemies defeated!")
		transition_to("OutcomeState")
	elif not battle_manager.player.is_alive():
		print("[ResolutionState] Player defeated!")
		transition_to("OutcomeState")
	else:
		# 5. Transicionar para turno do inimigo
		await get_tree().process_frame
		transition_to("EnemyTurnState")
