# res://game/combat/BattleManager.gd
# Orquestrador do Combate
# Responsabilidade: Gerenciar estados, entidades, e comunicação entre subsistemas

class_name BattleManager
extends Node

# ============ REFERENCES ============
var player: Entity
var enemies: Array[Node] = []
var player_hand_manager: HandManager
var player_stats: PlayerStats

# ============ FSM ============
var states: Dictionary = {}
var current_state: BattleState
var current_state_name: String = "SetupState"

# ============ LIFECYCLE ============
func _ready() -> void:
	_initialize_entities()
	_initialize_fsm()
	change_state("SetupState")

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

# ============ ENTITY INITIALIZATION ============
func _initialize_entities() -> void:
	# Criar Player
	player = Player.new()
	player.name = "Player"
	add_child(player)
	
	# Criar PlayerStats
	player_stats = PlayerStats.new()
	player_stats.name = "PlayerStats"
	add_child(player_stats)
	
	# Criar HandManager
	player_hand_manager = HandManager.new()
	player_hand_manager.name = "HandManager"
	add_child(player_hand_manager)
	
	# Criar inimigos de teste
	var enemy_1 = Enemy.new()
	enemy_1.enemy_name = "Goblin 1"
	enemy_1.base_attack_damage = 5
	add_child(enemy_1)
	enemies.append(enemy_1)
	
	var enemy_2 = Enemy.new()
	enemy_2.enemy_name = "Goblin 2"
	enemy_2.base_attack_damage = 4
	add_child(enemy_2)
	enemies.append(enemy_2)
	
	# Inicializar deck de teste (5 cópias do Ás de Espadas)
	var card_resource = load("res://game/cards/data/card_ace_spades.tres")
	if card_resource:
		var test_deck: Array[CardData] = []
		for i in range(10):
			test_deck.append(card_resource.duplicate_instance())
		player_hand_manager.set_deck(test_deck)
	
	print("[BattleManager] Entities initialized")

# ============ FSM MANAGEMENT ============
func _initialize_fsm() -> void:
	states = {
		"SetupState": SetupState.new(self),
		"PlayerTurnState": PlayerTurnState.new(self),
		"ResolutionState": ResolutionState.new(self),
		"EnemyTurnState": EnemyTurnState.new(self),
		"OutcomeState": OutcomeState.new(self),
	}

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state_name = new_state_name
	current_state = states.get(new_state_name)
	
	if current_state:
		current_state.enter()
	else:
		push_error("State '%s' not found in FSM!" % new_state_name)

# ============ QUERIES ============
func get_all_enemies() -> Array[Node]:
	return enemies.filter(func(e): return e is Entity and e.is_alive())

func player_turn_end() -> void:
	if current_state is PlayerTurnState:
		current_state.end_turn()
