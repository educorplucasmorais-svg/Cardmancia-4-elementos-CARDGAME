# res://res/scenes/CardPreviewController.gd
# Controller para a cena de preview das cartas
# Carrega e exibe as cartas de cada elemento

extends Control

# ============ CARD DATA PATHS ============
const CARD_ACE_SPADES = "res://res/game/cards/data/card_ace_spades.tres"
const CARD_ACE_HEARTS = "res://res/game/cards/data/card_ace_hearts.tres"
const CARD_ACE_CLUBS = "res://res/game/cards/data/card_ace_clubs.tres"
const CARD_ACE_DIAMONDS = "res://res/game/cards/data/card_ace_diamonds.tres"

# ============ NODE REFERENCES ============
@onready var fire_card_slot: Control = $MainLayout/ElementsSection/FirePanel/FireContent/FireCardSlot
@onready var water_card_slot: Control = $MainLayout/ElementsSection/WaterPanel/WaterContent/WaterCardSlot
@onready var earth_card_slot: Control = $MainLayout/ElementsSection/EarthPanel/EarthContent/EarthCardSlot
@onready var air_card_slot: Control = $MainLayout/ElementsSection/AirPanel/AirContent/AirCardSlot

var card_view_scene: PackedScene

func _ready() -> void:
	# Load CardView scene
	card_view_scene = load("res://res/game/cards/ui/CardView.tscn")
	
	# Load and display cards
	_load_cards()
	
	print("[CardPreview] Preview scene loaded!")

func _load_cards() -> void:
	# Fire/Clubs card
	var clubs_data = _try_load_card(CARD_ACE_CLUBS)
	if clubs_data:
		_spawn_card_in_slot(clubs_data, fire_card_slot)
	
	# Water/Hearts card
	var hearts_data = _try_load_card(CARD_ACE_HEARTS)
	if hearts_data:
		_spawn_card_in_slot(hearts_data, water_card_slot)
	
	# Earth/Diamonds card
	var diamonds_data = _try_load_card(CARD_ACE_DIAMONDS)
	if diamonds_data:
		_spawn_card_in_slot(diamonds_data, earth_card_slot)
	
	# Air/Spades card
	var spades_data = _try_load_card(CARD_ACE_SPADES)
	if spades_data:
		_spawn_card_in_slot(spades_data, air_card_slot)

func _try_load_card(path: String) -> CardData:
	if ResourceLoader.exists(path):
		var resource = load(path)
		if resource is CardData:
			return resource
		else:
			push_warning("Resource at %s is not a CardData" % path)
	else:
		push_warning("Card resource not found: %s" % path)
	return null

func _spawn_card_in_slot(card_data: CardData, slot: Control) -> void:
	if not card_view_scene:
		push_error("CardView scene not loaded!")
		return
	
	var card_view = card_view_scene.instantiate()
	slot.add_child(card_view)
	
	# Center the card in the slot
	card_view.position = Vector2.ZERO
	
	# Set the card data
	if card_view.has_method("set_card"):
		card_view.set_card(card_data)
	elif "card_data" in card_view:
		card_view.card_data = card_data

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_select"):
		# Return to main menu
		get_tree().change_scene_to_file("res://res/scenes/Main.tscn")
