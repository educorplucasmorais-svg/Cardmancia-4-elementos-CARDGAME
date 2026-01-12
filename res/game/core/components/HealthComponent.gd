class_name HealthComponent
extends Node

@export var max_health: int = 100
var current_health: int

func _ready() -> void:
	current_health = max_health
	SignalBus.stats_changed.emit(get_parent(), current_health, max_health)

func take_damage(amount: int) -> void:
	current_health = clampi(current_health - amount, 0, max_health)
	
	SignalBus.stats_changed.emit(get_parent(), current_health, max_health)
	
	if current_health == 0:
		SignalBus.entity_died.emit(get_parent())

func heal(amount: int) -> void:
	take_damage(-amount)

func get_health_percent() -> float:
	return float(current_health) / float(max_health)

func is_alive() -> bool:
	return current_health > 0
