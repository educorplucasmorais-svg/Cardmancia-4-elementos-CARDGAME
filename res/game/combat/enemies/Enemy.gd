# res://entities/Enemy.gd
# Entidade do Inimigo
# Herda de Entity, adiciona lógica de IA e padrões de ataque

class_name Enemy
extends Entity

@export var enemy_name: String = "Goblin"
@export var base_attack_damage: int = 5

func _ready() -> void:
	super._ready()
	name = enemy_name
	max_health = 30
	current_health = max_health
	print("[Enemy] %s initialized with %d HP" % [name, max_health])

func get_attack_damage() -> int:
	var damage = base_attack_damage + get_stat("strength")
	return max(1, damage)
