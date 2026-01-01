# res://game/cards/core/CardData.gd
# Definição de Dados da Carta (Resource)
# Padrão: Scriptable Objects (Data-Driven Design)

class_name CardData
extends Resource

enum Suit { SPADES, HEARTS, CLUBS, DIAMONDS }  # Ar, Água, Fogo, Terra
enum Rarity { COMMON, UNCOMMON, RARE, LEGENDARY }
enum TargetType { SELF, SINGLE_ENEMY, ALL_ENEMIES, RANDOM_ENEMY }

# ============ IDENTITY ============
@export_group("Identity")
@export var id: String  # ex: "card_ace_spades"
@export var name: String  # ex: "Ás de Espadas"
@export var suit: Suit
@export var value: int  # 1 a 13 (A a K)
@export var rarity: Rarity = Rarity.COMMON
@export_multiline var lore_description: String  # Texto da Cartomancia do Zeca

# ============ GAMEPLAY ============
@export_group("Gameplay")
@export var mana_cost: int = 1
@export var icon: Texture2D
@export var target_type: TargetType = TargetType.SINGLE_ENEMY
@export var upgradeable: bool = true  # Pode ser melhorado por relíquias?

# ============ EFFECTS (Command Pattern) ============
@export_group("Effects")
@export var effects: Array[CardEffect] = []

# ============ UPGRADE TRACKING ============
var upgrade_count: int = 0  # Rastreia melhorias aplicadas

func _init(p_id: String = "", p_name: String = "", p_suit: Suit = Suit.SPADES, p_value: int = 1) -> void:
	id = p_id
	name = p_name
	suit = p_suit
	value = p_value

func get_suit_name() -> String:
	return Suit.keys()[suit]

func get_rarity_name() -> String:
	return Rarity.keys()[rarity]

# Clona a carta (para mão do jogador, não afeta a original)
func duplicate_instance() -> CardData:
	var clone = duplicate()
	clone.upgrade_count = upgrade_count
	return clone
