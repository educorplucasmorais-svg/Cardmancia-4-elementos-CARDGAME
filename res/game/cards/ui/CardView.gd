# res://res/game/cards/ui/CardView.gd
# Componente visual de uma carta
# Exibe: Imagem da carta, nome, custo, descrição dos efeitos
# A cor da borda e elementos visuais são definidos pelo ElementData

class_name CardView
extends Control

# ============ SIGNALS ============
signal card_clicked(card_data: CardData)
signal card_hovered(card_data: CardData)
signal card_unhovered(card_data: CardData)
signal card_drag_started(card_data: CardData)
signal card_drag_ended(card_data: CardData)

# ============ EXPORTED ============
@export var card_data: CardData:
	set(value):
		card_data = value
		_update_display()

# ============ NODE REFERENCES ============
@onready var card_panel: PanelContainer = $CardPanel
@onready var card_art: TextureRect = $CardPanel/VBox/CardArt
@onready var title_label: Label = $CardPanel/VBox/Header/TitleLabel
@onready var cost_label: Label = $CardPanel/VBox/Header/CostLabel
@onready var description_label: Label = $CardPanel/VBox/DescriptionLabel
@onready var element_icon: TextureRect = $CardPanel/VBox/Footer/ElementIcon
@onready var element_label: Label = $CardPanel/VBox/Footer/ElementLabel

# ============ STATE ============
var is_hovered: bool = false
var is_dragging: bool = false
var original_position: Vector2
var original_scale: Vector2

# ============ VISUAL SETTINGS ============
const HOVER_SCALE := Vector2(1.1, 1.1)
const HOVER_OFFSET := Vector2(0, -20)
const ANIMATION_DURATION := 0.15

func _ready() -> void:
	original_scale = scale
	original_position = position
	
	# Connect mouse events
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	gui_input.connect(_on_gui_input)
	
	_update_display()

func _update_display() -> void:
	if not is_inside_tree():
		return
	
	if not card_data:
		_set_placeholder()
		return
	
	# Update title and cost
	if title_label:
		title_label.text = card_data.title if card_data.title else "Carta"
	
	if cost_label:
		cost_label.text = str(card_data.cost)
	
	# Update card art
	if card_art and card_data.art:
		card_art.texture = card_data.art
	
	# Update description from effects
	if description_label:
		description_label.text = card_data.get_description()
	
	# Update element info and colors
	_apply_element_theme()

func _apply_element_theme() -> void:
	if not card_data or not card_data.element:
		return
	
	var element = card_data.element
	
	# Update element label
	if element_label:
		element_label.text = element.get_full_name()
	
	# Update element icon
	if element_icon and element.icon:
		element_icon.texture = element.icon
	
	# Update card border color based on element
	if card_panel:
		var style = card_panel.get_theme_stylebox("panel")
		if style is StyleBoxFlat:
			var new_style = style.duplicate() as StyleBoxFlat
			new_style.border_color = element.color_theme
			card_panel.add_theme_stylebox_override("panel", new_style)

func _set_placeholder() -> void:
	if title_label:
		title_label.text = "???"
	if cost_label:
		cost_label.text = "?"
	if description_label:
		description_label.text = "Carta desconhecida"

# ============ MOUSE HANDLING ============

func _on_mouse_entered() -> void:
	if is_dragging:
		return
	
	is_hovered = true
	card_hovered.emit(card_data)
	
	# Animate hover
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", HOVER_SCALE, ANIMATION_DURATION)
	tween.tween_property(self, "position", original_position + HOVER_OFFSET, ANIMATION_DURATION)
	
	# Bring to front
	z_index = 10

func _on_mouse_exited() -> void:
	if is_dragging:
		return
	
	is_hovered = false
	card_unhovered.emit(card_data)
	
	# Animate back
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", original_scale, ANIMATION_DURATION)
	tween.tween_property(self, "position", original_position, ANIMATION_DURATION)
	
	z_index = 0

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				card_clicked.emit(card_data)
				_start_drag()
			else:
				_end_drag()

func _start_drag() -> void:
	is_dragging = true
	card_drag_started.emit(card_data)
	z_index = 100

func _end_drag() -> void:
	is_dragging = false
	card_drag_ended.emit(card_data)
	z_index = 0

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - size / 2

# ============ PUBLIC METHODS ============

func set_card(data: CardData) -> void:
	card_data = data

func highlight(enabled: bool) -> void:
	if card_panel:
		modulate = Color(1.2, 1.2, 1.2) if enabled else Color.WHITE

func set_playable(playable: bool) -> void:
	modulate.a = 1.0 if playable else 0.5
