# res://game/combat/fsm/EnemyTurnState.gd
# Estado: Turno do Inimigo
# Responsabilidades: Determinar intenção, executar ações

class_name EnemyTurnState
extends BattleState

func _init(p_battle_manager: BattleManager) -> void:
	super(p_battle_manager)
	state_name = "EnemyTurnState"

func enter() -> void:
	super.enter()
	SignalBus.enemy_turn_started.emit()
	
	# 1. Determinar intenção de cada inimigo
	for enemy in battle_manager.enemies:
		if enemy is Entity and enemy.is_alive():
			var intent = _determine_intent(enemy)
			print("[EnemyTurnState] %s intent: %s" % [enemy.name, intent])
			SignalBus.show_enemy_intent.emit(enemy, intent)
	
	# 2. Executar ações dos inimigos (com animação)
	await _execute_enemy_actions()
	
	# 3. Transicionar para resolução
	SignalBus.enemy_turn_ended.emit()
	transition_to("ResolutionState")

func _determine_intent(enemy: Entity) -> String:
	# TODO: Implementar lógica de IA (padrões, randomização, etc)
	return "Attack for 10 damage"

func _execute_enemy_actions() -> void:
	for enemy in battle_manager.enemies:
		if enemy is Entity and enemy.is_alive():
			# Simular ataque (placeholder)
			var damage = 5
			battle_manager.player.take_damage(damage)
			SignalBus.entity_damaged.emit(battle_manager.player, damage)
			await get_tree().create_timer(0.5).timeout  # Aguardar animação
	
	# Aguardar para dar tempo de ver o feedback visual
	await get_tree().create_timer(1.0).timeout
