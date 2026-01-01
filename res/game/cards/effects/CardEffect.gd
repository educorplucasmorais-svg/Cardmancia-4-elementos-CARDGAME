# res://game/cards/effects/CardEffect.gd
# Classe Base para Efeitos de Cartas
# Padrão: Command Pattern (encapsula ações)

class_name CardEffect
extends Resource

# ============ EFFECT METADATA ============
@export_group("Metadata")
@export var effect_name: String = "Default Effect"
@export_multiline var effect_description: String = "This effect does nothing."
@export var priority: int = 0  # Ordem de execução na pilha (stack)

# ============ VISUALS ============
@export_group("Visuals")
@export var visual_vfx: PackedScene  # Efeito visual opcional

# ============ TOOLTIP ============
## Texto para aparecer na carta (ex: "Causa 5 de Dano")
## Sobrescrever em subclasses para gerar texto dinâmico
func get_tooltip() -> String:
	return effect_description

# ============ EXECUTION ============
## O "BattleManager" chamará isso. Targets podem ser Inimigos ou o Player.
## Sobrescrever em subclasses para implementar lógica específica
func execute(targets: Array[Node], context: Dictionary = {}) -> void:
	push_warning("CardEffect.execute() foi chamado na classe base. Sobrescreva em uma subclasse!")

# Validação pré-execução (retorna false se o efeito não pode ser executado)
func can_execute(targets: Array[Node], source: Node) -> bool:
	return targets.size() > 0 and source != null

# Chamada de retorno pós-execução (para efeitos que precisam de cleanup)
func on_effect_resolved(targets: Array[Node], source: Node) -> void:
	pass
