# res://game/cards/core/CardData.gd
# Definição de Dados da Carta (Resource)
# Padrão: Scriptable Objects (Data-Driven Design)

class_name CardData
extends Resource

enum Suit { SPADES, HEARTS, CLUBS, DIAMONDS }  # Ar, Água, Fogo, Terra
enum Rarity { COMMON, UNCOMMON, RARE, LEGENDARY }
enum TargetType { SELF, SINGLE_ENEMY, ALL_ENEMIES, RANDOM_ENEMY }

# ============ IDENTITY ============
@export_category("Card Identity")
@export var id: String  # ex: "card_ace_spades"
@export var title: String  # ex: "Ás de Espadas"
@export var element: ElementData  # <--- LIGAÇÃO AO ELEMENTO
@export var art: Texture2D

# ============ LEGACY/COMPATIBILITY ============
@export_group("Legacy")
@export var suit: Suit
@export var value: int  # 1 a 13 (A a K)
@export var rarity: Rarity = Rarity.COMMON
@export_multiline var lore_description: String  # Texto da Cartomancia do Zeca

# ============ COST & STATS ============
@export_category("Cost & Stats")
@export var cost: int = 1
@export var is_playable: bool = true
@export var target_type: TargetType = TargetType.SINGLE_ENEMY
@export var upgradeable: bool = true  # Pode ser melhorado por relíquias?

# ============ BEHAVIOR (Command Pattern) ============
@export_category("Behavior (Command Pattern)")
## Lista de comandos que esta carta executa quando jogada.
@export var effects: Array[CardEffect] = []

# ============ UPGRADE TRACKING ============
var upgrade_count: int = 0  # Rastreia melhorias aplicadas

func _init(p_id: String = "", p_title: String = "", p_suit: Suit = Suit.SPADES, p_value: int = 1) -> void:
	id = p_id
	title = p_title
	suit = p_suit
	value = p_value

## Gera descrição dinâmica baseada nos efeitos
func get_description() -> String:
	var desc = ""
	for effect in effects:
		desc += effect.get_tooltip() + "\n"
	return desc.strip_edges()

func get_suit_name() -> String:
	return Suit.keys()[suit]

func get_rarity_name() -> String:
	return Rarity.keys()[rarity]

## Retorna a cor do tema baseado no elemento, ou branco se não tiver elemento
func get_theme_color() -> Color:
	if element:
		return element.color_theme
	return Color.WHITE

# Clona a carta (para mão do jogador, não afeta a original)
func duplicate_instance() -> CardData:
	var clone = duplicate()
	clone.upgrade_count = upgrade_count
	return clone
