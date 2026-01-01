# res://game/cards/effects/DrawEffect.gd
# Implementação de Efeito: Comprar Cartas (Espadas/Ar)
# Padrão: Command Pattern

class_name DrawEffect
extends CardEffect

@export var amount: int = 1
@export var scales_with_intelligence: bool = false

func _init(p_draw: int = 1) -> void:
	effect_name = "Draw Cards"
	amount = p_draw

func get_tooltip() -> String:
	if amount == 1:
		return "Compra 1 carta."
	return "Compra %d cartas." % amount

func execute(targets: Array[Node], context: Dictionary = {}) -> void:
	var source: Node = context.get("source", null)
	var hand_manager: Node = context.get("hand_manager", null)
	
	if not hand_manager:
		push_warning("DrawEffect: hand_manager não fornecido no contexto!")
		return
	
	var draw_amount = amount
	
	# Modificadores (inteligência pode aumentar compra)
	if scales_with_intelligence and source and source.has_method("get_stat"):
		draw_amount += source.get_stat("intelligence")
	
	if hand_manager.has_method("draw_cards"):
		hand_manager.draw_cards(draw_amount)
	
	# VFX opcional
	if visual_vfx and source:
		SignalBus.emit_signal("vfx_requested", visual_vfx, source.global_position)
