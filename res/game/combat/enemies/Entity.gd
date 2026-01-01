# res://entities/Entity.gd
# Classe Base para Entidades (Jogador, Inimigos)
# Padrão: Component-based (saúde, status, estatísticas)

class_name Entity
extends Node

# ============ VITAL STATS ============
@export var max_health: int = 100
var current_health: int
var current_armor: int = 0

# ============ STATS (modificáveis por relíquias) ============
var stats: Dictionary = {
	"strength": 0,
	"defense": 0,
	"dexterity": 0,
	"wisdom": 0
}

# ============ STATUS CONDITIONS ============
var status_effects: Dictionary = {}  # ex: {"poison": 3} (3 turnos)

# ============ LIFECYCLE ============
func _ready() -> void:
	current_health = max_health

# ============ DAMAGE & HEALING ============
func take_damage(damage: int) -> int:
	var mitigated_damage = max(1, damage - current_armor)
	current_health -= mitigated_damage
	
	if current_health <= 0:
		current_health = 0
		on_death()
	
	return mitigated_damage

func heal(amount: int) -> int:
	var old_health = current_health
	current_health = min(current_health + amount, max_health)
	var healed = current_health - old_health
	
	SignalBus.entity_healed.emit(self, healed)
	return healed

func on_death() -> void:
	SignalBus.entity_died.emit(self)

# ============ STATS & BUFFS ============
func get_stat(stat_name: String) -> int:
	return stats.get(stat_name, 0)

func add_stat(stat_name: String, amount: int) -> void:
	if stat_name in stats:
		stats[stat_name] += amount

func add_status(status_name: String, duration: int) -> void:
	status_effects[status_name] = duration
	SignalBus.entity_status_changed.emit(self, status_name)

func reduce_status_durations() -> void:
	for status in status_effects:
		status_effects[status] -= 1
		if status_effects[status] <= 0:
			status_effects.erase(status)

# ============ QUERIES ============
func is_alive() -> bool:
	return current_health > 0
