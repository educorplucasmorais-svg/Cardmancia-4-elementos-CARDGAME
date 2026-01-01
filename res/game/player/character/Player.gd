# res://entities/Player.gd
# Entidade do Jogador
# Herda de Entity, adiciona lógica específica

class_name Player
extends Entity

func _ready() -> void:
	super._ready()
	name = "Player"
	max_health = 100
	current_health = max_health
	print("[Player] Initialized with %d HP" % max_health)
