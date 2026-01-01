# res://game/combat/fsm/BattleState.gd
# Classe Base para Estados da FSM de Combate
# Padrão: State Pattern (encapsula lógica de estado)

class_name BattleState
extends Node

var battle_manager: BattleManager
var state_name: String = "BaseState"

func _init(p_battle_manager: BattleManager) -> void:
	battle_manager = p_battle_manager

# Chamado ao ENTRAR no estado
func enter() -> void:
	print("[%s] Entered state: %s" % [battle_manager.name, state_name])

# Chamado ao SAIR do estado
func exit() -> void:
	print("[%s] Exited state: %s" % [battle_manager.name, state_name])

# Processamento de entrada (input handling)
func handle_input(event: InputEvent) -> void:
	pass

# Processamento por frame
func update(delta: float) -> void:
	pass

# Transição para próximo estado
func transition_to(next_state_name: String) -> void:
	battle_manager.change_state(next_state_name)
