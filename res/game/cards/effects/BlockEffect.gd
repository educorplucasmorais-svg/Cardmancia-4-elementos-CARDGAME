# res://game/cards/effects/BlockEffect.gd
# Implementação de Efeito: Bloqueio (Ouros/Terra)
# Padrão: Command Pattern

class_name BlockEffect
extends CardEffect

@export var amount: int = 5
@export var scales_with_endurance: bool = true

func _init(p_block: int = 5) -> void:
	effect_name = "Gain Block"
	amount = p_block

func get_tooltip() -> String:
	return "Ganha %d de bloqueio." % amount

func execute(targets: Array[Node], context: Dictionary = {}) -> void:
	var source: Node = context.get("source", null)
	if not can_execute(targets, source):
		return
	
	for target in targets:
		if target.has_method("add_block"):
			var block_amount = amount
			
			# Modificadores (resistência aumenta bloqueio)
			if scales_with_endurance and source and source.has_method("get_stat"):
				block_amount += source.get_stat("endurance")
			
			target.add_block(block_amount)
			SignalBus.entity_status_changed.emit(target, "block_gained")
			
			# VFX opcional
			if visual_vfx:
				SignalBus.emit_signal("vfx_requested", visual_vfx, target.global_position)
