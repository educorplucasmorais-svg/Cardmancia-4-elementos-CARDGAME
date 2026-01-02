# res://res/scenes/BossCardsPreviewController.gd
# Controller para preview das cartas Boss
# Mostra todas as 52 cartas + Joker organizadas por naipe

extends Control

# ============ CONSTANTS ============
const CARD_VALUES: Array = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
const CARD_NAMES: Array = ["Ás", "Dois", "Três", "Quatro", "Cinco", "Seis", "Sete", "Oito", "Nove", "Dez", "Valete", "Dama", "Rei"]

# Naipes e seus elementos
const SUITS: Dictionary = {
	"clubs": {
		"name": "Paus",
		"element": "Fogo",
		"symbol": "♣",
		"color": Color(0.9, 0.3, 0.1, 1),  # Vermelho fogo
		"bg_color": Color(0.9, 0.3, 0.1, 0.15)
	},
	"hearts": {
		"name": "Copas",
		"element": "Água",
		"symbol": "♥",
		"color": Color(0.2, 0.5, 0.9, 1),  # Azul água
		"bg_color": Color(0.2, 0.5, 0.9, 0.15)
	},
	"diamonds": {
		"name": "Ouros",
		"element": "Terra",
		"symbol": "♦",
		"color": Color(0.8, 0.7, 0.2, 1),  # Dourado terra
		"bg_color": Color(0.8, 0.7, 0.2, 0.15)
	},
	"spades": {
		"name": "Espadas",
		"element": "Ar",
		"symbol": "♠",
		"color": Color(0.4, 0.8, 0.9, 1),  # Ciano ar
		"bg_color": Color(0.4, 0.8, 0.9, 0.15)
	}
}

# Boss card descriptions (figuras e ás)
const BOSS_LORE: Dictionary = {
	"A": "O Início - Poder primordial do elemento",
	"J": "O Guardião - Protetor do reino elemental",
	"Q": "A Soberana - Mestre da magia elemental",
	"K": "O Rei Supremo - Dominador absoluto do elemento"
}

# ============ NODE REFERENCES ============
@onready var fire_cards: GridContainer = $ScrollContainer/MainContent/FireSection/FireCards
@onready var water_cards: GridContainer = $ScrollContainer/MainContent/WaterSection/WaterCards
@onready var earth_cards: GridContainer = $ScrollContainer/MainContent/EarthSection/EarthCards
@onready var air_cards: GridContainer = $ScrollContainer/MainContent/AirSection/AirCards
@onready var joker_cards: HBoxContainer = $ScrollContainer/MainContent/JokerSection/JokerCards

var selected_card: Control = null

func _ready() -> void:
	_generate_all_cards()
	print("[BossCardsPreview] Preview loaded with 53 cards!")

func _generate_all_cards() -> void:
	# Generate cards for each suit
	_generate_suit_cards("clubs", fire_cards)
	_generate_suit_cards("hearts", water_cards)
	_generate_suit_cards("diamonds", earth_cards)
	_generate_suit_cards("spades", air_cards)
	
	# Generate Joker
	_generate_joker()

func _generate_suit_cards(suit_key: String, container: GridContainer) -> void:
	var suit_data: Dictionary = SUITS[suit_key]
	
	for i in range(13):
		var card_value: String = CARD_VALUES[i]
		var card_name: String = CARD_NAMES[i]
		var is_boss: bool = card_value in ["A", "J", "Q", "K"]
		
		var card_panel: PanelContainer = _create_card_visual(
			card_value,
			card_name,
			suit_data,
			is_boss,
			i + 1  # Card number 1-13
		)
		container.add_child(card_panel)

func _create_card_visual(value: String, name: String, suit_data: Dictionary, is_boss: bool, number: int) -> PanelContainer:
	var panel: PanelContainer = PanelContainer.new()
	panel.custom_minimum_size = Vector2(80, 110)
	
	# Style based on boss status
	var style: StyleBoxFlat = StyleBoxFlat.new()
	if is_boss:
		style.bg_color = suit_data.bg_color * 2  # Brighter for bosses
		style.border_color = suit_data.color
		style.border_width_left = 3
		style.border_width_top = 3
		style.border_width_right = 3
		style.border_width_bottom = 3
	else:
		style.bg_color = Color(0.12, 0.12, 0.15, 1)
		style.border_color = suit_data.color * 0.6
		style.border_width_left = 1
		style.border_width_top = 1
		style.border_width_right = 1
		style.border_width_bottom = 1
	
	style.corner_radius_top_left = 6
	style.corner_radius_top_right = 6
	style.corner_radius_bottom_right = 6
	style.corner_radius_bottom_left = 6
	panel.add_theme_stylebox_override("panel", style)
	
	# Content container
	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 2)
	panel.add_child(vbox)
	
	# Top row: Value + Suit symbol
	var top_label: Label = Label.new()
	top_label.text = value + suit_data.symbol
	top_label.add_theme_font_size_override("font_size", 16 if is_boss else 12)
	top_label.add_theme_color_override("font_color", suit_data.color)
	top_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(top_label)
	
	# Center: Large suit symbol
	var center_label: Label = Label.new()
	center_label.text = suit_data.symbol
	center_label.add_theme_font_size_override("font_size", 32 if is_boss else 24)
	center_label.add_theme_color_override("font_color", suit_data.color)
	center_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(center_label)
	
	# Boss crown indicator
	if is_boss:
		var crown_label: Label = Label.new()
		crown_label.text = "👑" if value == "K" else ("👸" if value == "Q" else ("⚔️" if value == "J" else "✨"))
		crown_label.add_theme_font_size_override("font_size", 16)
		crown_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(crown_label)
	
	# Card name
	var name_label: Label = Label.new()
	name_label.text = name
	name_label.add_theme_font_size_override("font_size", 10)
	name_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.8, 1))
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(name_label)
	
	# Phases indicator
	var phases_label: Label = Label.new()
	phases_label.text = "10 fases"
	phases_label.add_theme_font_size_override("font_size", 8)
	phases_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.6, 1))
	phases_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(phases_label)
	
	# Make interactive
	panel.mouse_filter = Control.MOUSE_FILTER_STOP
	panel.gui_input.connect(_on_card_clicked.bind(panel, value, name, suit_data, is_boss))
	
	# Hover effect
	panel.mouse_entered.connect(_on_card_hover.bind(panel, true))
	panel.mouse_exited.connect(_on_card_hover.bind(panel, false))
	
	return panel

func _generate_joker() -> void:
	var joker_panel: PanelContainer = PanelContainer.new()
	joker_panel.custom_minimum_size = Vector2(120, 160)
	
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color(0.4, 0.1, 0.4, 0.5)
	style.border_color = Color(0.9, 0.2, 0.9, 1)
	style.border_width_left = 4
	style.border_width_top = 4
	style.border_width_right = 4
	style.border_width_bottom = 4
	style.corner_radius_top_left = 8
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_right = 8
	style.corner_radius_bottom_left = 8
	joker_panel.add_theme_stylebox_override("panel", style)
	
	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 5)
	joker_panel.add_child(vbox)
	
	var icon: Label = Label.new()
	icon.text = "🃏"
	icon.add_theme_font_size_override("font_size", 48)
	icon.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(icon)
	
	var title: Label = Label.new()
	title.text = "JOKER"
	title.add_theme_font_size_override("font_size", 20)
	title.add_theme_color_override("font_color", Color(0.9, 0.2, 0.9, 1))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)
	
	var desc: Label = Label.new()
	desc.text = "O Coringa\nBoss Final"
	desc.add_theme_font_size_override("font_size", 12)
	desc.add_theme_color_override("font_color", Color(0.7, 0.7, 0.8, 1))
	desc.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(desc)
	
	var phases: Label = Label.new()
	phases.text = "10 fases épicas"
	phases.add_theme_font_size_override("font_size", 10)
	phases.add_theme_color_override("font_color", Color(0.5, 0.5, 0.6, 1))
	phases.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(phases)
	
	joker_cards.add_child(joker_panel)
	
	# Add spacing panels to center the joker
	var spacer1: Control = Control.new()
	spacer1.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	joker_cards.add_child(spacer1)
	joker_cards.move_child(spacer1, 0)
	
	var spacer2: Control = Control.new()
	spacer2.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	joker_cards.add_child(spacer2)

func _on_card_hover(panel: PanelContainer, hovering: bool) -> void:
	var tween: Tween = create_tween()
	if hovering:
		tween.tween_property(panel, "scale", Vector2(1.1, 1.1), 0.15)
		tween.parallel().tween_property(panel, "modulate", Color(1.2, 1.2, 1.2, 1), 0.15)
	else:
		tween.tween_property(panel, "scale", Vector2(1.0, 1.0), 0.15)
		tween.parallel().tween_property(panel, "modulate", Color(1.0, 1.0, 1.0, 1), 0.15)

func _on_card_clicked(event: InputEvent, panel: PanelContainer, value: String, name: String, suit_data: Dictionary, is_boss: bool) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_show_card_details(value, name, suit_data, is_boss)

func _show_card_details(value: String, name: String, suit_data: Dictionary, is_boss: bool) -> void:
	# Create popup with card details
	var popup: PopupPanel = PopupPanel.new()
	popup.size = Vector2(400, 300)
	
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.15, 0.95)
	style.border_color = suit_data.color
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_right = 12
	style.corner_radius_bottom_left = 12
	popup.add_theme_stylebox_override("panel", style)
	
	var margin: MarginContainer = MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 20)
	margin.add_theme_constant_override("margin_bottom", 20)
	popup.add_child(margin)
	
	var vbox: VBoxContainer = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 15)
	margin.add_child(vbox)
	
	# Title
	var title: Label = Label.new()
	title.text = "%s de %s %s" % [name, suit_data.name, suit_data.symbol]
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", suit_data.color)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(title)
	
	# Element
	var element: Label = Label.new()
	element.text = "Elemento: %s" % suit_data.element
	element.add_theme_font_size_override("font_size", 18)
	element.add_theme_color_override("font_color", Color(0.8, 0.8, 0.9, 1))
	element.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(element)
	
	# Boss status
	if is_boss:
		var boss_info: Label = Label.new()
		boss_info.text = "👑 BOSS CARD 👑\n%s" % BOSS_LORE.get(value, "Carta poderosa do elemento")
		boss_info.add_theme_font_size_override("font_size", 14)
		boss_info.add_theme_color_override("font_color", Color(1, 0.85, 0.2, 1))
		boss_info.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		vbox.add_child(boss_info)
	
	# Phases info
	var phases_info: Label = Label.new()
	phases_info.text = "📍 10 Fases Temáticas\nCada fase explora um aspecto do %s" % suit_data.element
	phases_info.add_theme_font_size_override("font_size", 12)
	phases_info.add_theme_color_override("font_color", Color(0.6, 0.6, 0.7, 1))
	phases_info.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vbox.add_child(phases_info)
	
	# Close button
	var close_btn: Button = Button.new()
	close_btn.text = "Fechar"
	close_btn.pressed.connect(popup.queue_free)
	vbox.add_child(close_btn)
	
	add_child(popup)
	popup.popup_centered()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://res/scenes/MainMenu.tscn")
