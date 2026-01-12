# res://game/core/data/ElementData.gd
# Definição de Dados do Elemento (Resource)
# Padrão: Data-Driven Design - Define os 4 elementos do Tarot
# Copas (Água/Cura), Paus (Fogo/Dano), Ouros (Terra/Block), Espadas (Ar/Draw)

class_name ElementData
extends Resource

# ============ IDENTITY ============
@export_group("Identity")
@export var id: String = "element_id"  # ex: "fire", "water", "earth", "air"
@export var display_name: String = "Element Name"  # ex: "Fogo", "Água"
@export var suit_name: String = "Suit Name"  # ex: "Paus", "Copas"

# ============ VISUALS ============
@export_group("Visuals")
@export var icon: Texture2D
@export var color_theme: Color = Color.WHITE
@export var secondary_color: Color = Color.GRAY
@export var particle_scene: PackedScene  # Opcional: Efeito visual ao jogar

# ============ GAMEPLAY LORE ============
@export_group("Lore")
@export_multiline var description: String  # Texto do "Curso do Zeca"
@export_multiline var gameplay_hint: String  # Dica de gameplay

# ============ GAMEPLAY STATS ============
@export_group("Gameplay")
@export var primary_effect: String = "damage"  # damage, heal, block, draw
@export var stat_modifier: String = "strength"  # stat que modifica este elemento

func _init(
	p_id: String = "element_id",
	p_display_name: String = "Element Name",
	p_suit_name: String = "Suit Name"
) -> void:
	id = p_id
	display_name = p_display_name
	suit_name = p_suit_name

func get_full_name() -> String:
	return "%s (%s)" % [suit_name, display_name]
