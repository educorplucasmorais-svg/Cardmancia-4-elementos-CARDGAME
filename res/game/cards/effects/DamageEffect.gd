# res://res/game/cards/effects/DamageEffect.gd
# Implementação de Efeito: Dano (Paus/Fogo)
# Exemplo prático do Command Pattern

class_name DamageEffect
extends CardEffect

@export var amount: int = 5
@export var scales_with_strength: bool = true

func _init(p_damage: int = 5) -> void:
	effect_name = "Deal Damage"
	amount = p_damage

func get_tooltip() -> String:
	return "Causa %d de dano." % amount

func execute(targets: Array[Node], context: Dictionary = {}) -> void:
	if not can_execute(targets, context):
		return
	
	var source: Node = context.get("source", null)
	
	for target in targets:
		# Lembre-se: Use o SignalBus ou verifique componentes.
		# Aqui, verificamos se o alvo tem um método "take_damage".
		if target.has_method("take_damage"):
			var damage = amount
			
			# Modificadores (exemplo: força do jogador)
			if scales_with_strength and source and source.has_method("get_stat"):
				damage += source.get_stat("strength")
			
			target.take_damage(damage)
			SignalBus.entity_damaged.emit(target, damage)
			
			# VFX opcional
			if visual_vfx and target.has_method("get_global_position"):
				SignalBus.vfx_requested.emit(visual_vfx, target.global_position)
