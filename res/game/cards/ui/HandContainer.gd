# res://res/game/cards/ui/HandContainer.gd
# Container visual para a mão do jogador
# Gerencia o layout, animações e interações das cartas na mão

class_name HandContainer
extends Control

# ============ SIGNALS ============
signal card_selected(card_data: CardData, card_view: CardView)
signal card_played(card_data: CardData, target: Node)

# ============ EXPORTED ============
@export var card_scene: PackedScene
@export var max_hand_width: float = 800.0
@export var card_spacing: float = -40.0  # Negative for overlap
@export var fan_angle: float = 5.0  # Degrees per card from center
@export var hover_lift: float = 30.0

# ============ STATE ============
var card_views: Array[CardView] = []
var selected_card: CardView = null

# ============ LIFECYCLE ============

func _ready() -> void:
	# Load default card scene if not set
	if not card_scene:
		card_scene = preload("res://res/game/cards/ui/CardView.tscn")

# ============ PUBLIC METHODS ============

func set_hand(cards: Array[CardData]) -> void:
	clear_hand()
	
	for card_data in cards:
		add_card(card_data)
	
	_arrange_cards()

func add_card(card_data: CardData) -> CardView:
	var card_view = card_scene.instantiate() as CardView
	card_view.card_data = card_data
	
	# Connect signals
	card_view.card_clicked.connect(_on_card_clicked)
	card_view.card_hovered.connect(_on_card_hovered)
	card_view.card_unhovered.connect(_on_card_unhovered)
	card_view.card_drag_started.connect(_on_card_drag_started)
	card_view.card_drag_ended.connect(_on_card_drag_ended)
	
	add_child(card_view)
	card_views.append(card_view)
	
	_arrange_cards()
	
	return card_view

func remove_card(card_view: CardView) -> void:
	if card_view in card_views:
		card_views.erase(card_view)
		card_view.queue_free()
		_arrange_cards()

func clear_hand() -> void:
	for card_view in card_views:
		card_view.queue_free()
	card_views.clear()

func get_card_count() -> int:
	return card_views.size()

# ============ LAYOUT ============

func _arrange_cards() -> void:
	var count = card_views.size()
	if count == 0:
		return
	
	var container_width = min(size.x, max_hand_width)
	var card_width = 180.0  # Default card width
	
	# Calculate spacing
	var total_width = card_width + (count - 1) * (card_width + card_spacing)
	var start_x = (size.x - total_width) / 2
	
	for i in range(count):
		var card_view = card_views[i]
		
		# Calculate position
		var x_pos = start_x + i * (card_width + card_spacing)
		var center_index = (count - 1) / 2.0
		var offset_from_center = i - center_index
		
		# Fan effect (rotation)
		var rotation_deg = offset_from_center * fan_angle
		
		# Arc effect (y position)
		var arc_offset = abs(offset_from_center) * 5.0
		var y_pos = size.y - 260 + arc_offset  # 260 = card height
		
		# Apply position and rotation
		card_view.position = Vector2(x_pos, y_pos)
		card_view.rotation_degrees = rotation_deg
		card_view.original_position = card_view.position
		card_view.z_index = i

# ============ SIGNAL HANDLERS ============

func _on_card_clicked(card_data: CardData) -> void:
	var card_view = _find_card_view(card_data)
	if card_view:
		selected_card = card_view
		card_selected.emit(card_data, card_view)

func _on_card_hovered(card_data: CardData) -> void:
	# Bring hovered card to front
	var card_view = _find_card_view(card_data)
	if card_view:
		card_view.z_index = 100

func _on_card_unhovered(card_data: CardData) -> void:
	var card_view = _find_card_view(card_data)
	if card_view:
		var index = card_views.find(card_view)
		card_view.z_index = index

func _on_card_drag_started(card_data: CardData) -> void:
	pass

func _on_card_drag_ended(card_data: CardData) -> void:
	var card_view = _find_card_view(card_data)
	if card_view:
		# Check if dropped on valid target
		# For now, just return to hand
		_arrange_cards()

func _find_card_view(card_data: CardData) -> CardView:
	for card_view in card_views:
		if card_view.card_data == card_data:
			return card_view
	return null

# ============ VISUAL EFFECTS ============

func highlight_playable_cards(current_mana: int) -> void:
	for card_view in card_views:
		var is_playable = card_view.card_data.cost <= current_mana
		card_view.set_playable(is_playable)

func disable_all_cards() -> void:
	for card_view in card_views:
		card_view.set_playable(false)

func enable_all_cards() -> void:
	for card_view in card_views:
		card_view.set_playable(true)
