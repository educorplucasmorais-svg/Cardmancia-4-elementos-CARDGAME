# res://res/game/cards/effects/HealEffect.gd
# Implementação de Efeito: Cura (Copas/Água)
# Padrão: Command Pattern

class_name HealEffect
extends CardEffect

@export var amount: int = 5
@export var scales_with_wisdom: bool = true

func _init(p_heal: int = 5) -> void:
	effect_name = "Heal"
	amount = p_heal

func get_tooltip() -> String:
	return "Cura %d de vida." % amount

func execute(targets: Array[Node], context: Dictionary = {}) -> void:
	if not can_execute(targets, context):
		return
	
	var source: Node = context.get("source", null)
	
	for target in targets:
		if target.has_method("heal"):
			var heal_amount = amount
			
			# Modificadores (sabedoria aumenta cura)
			if scales_with_wisdom and source and source.has_method("get_stat"):
				heal_amount += source.get_stat("wisdom")
			
			target.heal(heal_amount)
			SignalBus.entity_healed.emit(target, heal_amount)
			
			# VFX opcional
			if visual_vfx and target.has_method("get_global_position"):
				SignalBus.vfx_requested.emit(visual_vfx, target.global_position)
