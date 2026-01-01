# res://ui/BattleUIManager.gd
# Conecta o SignalBus com a UI
# Responsabilidades: Atualizar labels, animar dano, mostrar intenções

class_name BattleUIManager
extends CanvasLayer

@onready var mana_label: Label = Label.new()
@onready var health_label: Label = Label.new()
@onready var log_output: Label = Label.new()

var player_stats: PlayerStats
var battle_manager: BattleManager
var log_messages: Array[String] = []
var max_log_lines: int = 15

func _ready() -> void:
	# Setup UI labels
	_setup_ui()
	
	# Encontrar referências
	battle_manager = get_parent().get_node_or_null("BattleManager")
	if battle_manager:
		player_stats = battle_manager.player_stats
	
	# Conectar a sinais do jogo
	SignalBus.mana_changed.connect(_on_mana_changed)
	SignalBus.entity_damaged.connect(_on_entity_damaged)
	SignalBus.entity_healed.connect(_on_entity_healed)
	SignalBus.entity_status_changed.connect(_on_entity_status_changed)
	SignalBus.card_played.connect(_on_card_played)
	SignalBus.show_enemy_intent.connect(_on_show_enemy_intent)
	SignalBus.player_turn_started.connect(_on_player_turn_started)
	SignalBus.enemy_turn_started.connect(_on_enemy_turn_started)
	SignalBus.battle_started.connect(_on_battle_started)
	SignalBus.battle_ended.connect(_on_battle_ended)
	
	_add_log("Battle UI ready!")

func _setup_ui() -> void:
	# Mana display (canto superior esquerdo)
	mana_label.text = "Mana: 0/0"
	mana_label.position = Vector2(10, 10)
	mana_label.add_theme_font_size_override("font_size", 24)
	add_child(mana_label)
	
	# Health display (canto superior direito)
	health_label.text = "HP: 0/0"
	health_label.position = Vector2(get_viewport_rect().size.x - 200, 10)
	health_label.add_theme_font_size_override("font_size", 24)
	add_child(health_label)
	
	# Log output (canto inferior)
	log_output.text = ""
	log_output.position = Vector2(10, get_viewport_rect().size.y - 300)
	log_output.custom_minimum_size = Vector2(get_viewport_rect().size.x - 20, 280)
	log_output.add_theme_font_size_override("font_size", 14)
	add_child(log_output)

func _update_ui() -> void:
	if player_stats:
		mana_label.text = "Mana: %d/%d" % [player_stats.current_mana, player_stats.max_mana]
		health_label.text = "HP: %d/%d" % [player_stats.current_health, player_stats.max_health]

func _add_log(message: String) -> void:
	log_messages.append(message)
	if log_messages.size() > max_log_lines:
		log_messages.pop_front()
	
	log_output.text = "\n".join(log_messages)
	print("[BattleUI] %s" % message)

# ============ SIGNAL HANDLERS ============

func _on_battle_started() -> void:
	_add_log("⚔️  BATTLE STARTED!")
	_update_ui()

func _on_battle_ended(victory: bool) -> void:
	if victory:
		_add_log("✅ VICTORY!")
	else:
		_add_log("❌ DEFEAT!")

func _on_player_turn_started() -> void:
	_add_log(">>> PLAYER TURN")
	_update_ui()

func _on_enemy_turn_started() -> void:
	_add_log("<<< ENEMY TURN")

func _on_mana_changed(current: int, max_mana: int) -> void:
	_update_ui()

func _on_entity_damaged(entity: Node, damage: int) -> void:
	var entity_name = entity.name if entity else "Unknown"
	_add_log("💢 %s took %d damage" % [entity_name, damage])
	_update_ui()

func _on_entity_healed(entity: Node, heal: int) -> void:
	var entity_name = entity.name if entity else "Unknown"
	_add_log("💚 %s healed for %d HP" % [entity_name, heal])
	_update_ui()

func _on_entity_status_changed(entity: Node, status: String) -> void:
	var entity_name = entity.name if entity else "Unknown"
	_add_log("🔄 %s status: %s" % [entity_name, status])

func _on_card_played(card: CardData, targets: Array[Node]) -> void:
	var target_names = []
	for target in targets:
		target_names.append(target.name if target else "Unknown")
	_add_log("🎴 Card played: %s → %s" % [card.name, ", ".join(target_names)])

func _on_show_enemy_intent(enemy: Node, intent_text: String) -> void:
	var enemy_name = enemy.name if enemy else "Unknown"
	_add_log("🗨️  %s: %s" % [enemy_name, intent_text])
