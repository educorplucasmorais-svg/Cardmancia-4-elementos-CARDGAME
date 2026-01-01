# res://game/cards/effects/DamageEffect.gd
# Implementação de Efeito: Dano
# Exemplo prático do Command Pattern

class_name DamageEffect
extends CardEffect

@export var base_damage: int = 5
@export var scales_with_strength: bool = true

func _init(p_damage: int = 5) -> void:
	effect_name = "Deal Damage"
	effect_description = "Deal %d damage to target." % p_damage
	base_damage = p_damage

func execute(targets: Array[Node], source: Node) -> void:
	if not can_execute(targets, source):
		return
	
	for target in targets:
		if target is Entity:
			var damage = base_damage
			
			# Modificadores (exemplo: força do jogador)
			if scales_with_strength and source is Entity:
				damage += source.get_stat("strength")
			
			target.take_damage(damage)
			SignalBus.entity_damaged.emit(target, damage)
