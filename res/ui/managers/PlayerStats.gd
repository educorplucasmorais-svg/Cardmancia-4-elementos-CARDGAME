# res://ui/managers/PlayerStats.gd
# Gerenciador de Estatísticas do Jogador
# Responsabilidades: Saúde, Mana, Força, Defesa, etc.

class_name PlayerStats
extends Node

var max_health: int = 100
var current_health: int = 100

var max_mana: int = 3
var current_mana: int = 3

# Modificadores de um turno (buff/debuff)
var block_this_turn: int = 0  # Armadura temporária
var strength_modifier: int = 0  # Aumenta dano de cartas

func _ready() -> void:
	current_health = max_health
	current_mana = max_mana

# Recarregar mana no início do turno
func refill_mana() -> void:
	current_mana = max_mana
	block_this_turn = 0  # Limpar armadura (não persiste entre turnos)

# Gastar mana ao jogar uma carta
func spend_mana(amount: int) -> void:
	current_mana = max(0, current_mana - amount)

# Verificar se pode pagar o custo de uma carta
func can_afford_card(card: CardData) -> bool:
	return current_mana >= card.mana_cost

# Adicionar armadura
func add_block(amount: int) -> void:
	block_this_turn += amount

# Adicionar força (modificador de dano)
func add_strength(amount: int) -> void:
	strength_modifier += amount

# Receber dano (com mitigação de armadura)
func take_damage(damage: int) -> int:
	var mitigated_damage = max(1, damage - block_this_turn)
	current_health -= mitigated_damage
	block_this_turn = 0  # Consumir armadura
	
	if current_health <= 0:
		current_health = 0
	
	return mitigated_damage

# Restaurar saúde
func heal(amount: int) -> int:
	var old_health = current_health
	current_health = min(current_health + amount, max_health)
	return current_health - old_health

func is_alive() -> bool:
	return current_health > 0
