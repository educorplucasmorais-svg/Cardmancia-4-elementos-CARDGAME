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

# ============ EXECUTION ============
# Sobrescrever em subclasses para implementar lógica específica
func execute(targets: Array[Node], source: Node) -> void:
	push_warning("CardEffect.execute() foi chamado na classe base. Sobrescreva em uma subclasse!")

# Validação pré-execução (retorna false se o efeito não pode ser executado)
func can_execute(targets: Array[Node], source: Node) -> bool:
	return targets.size() > 0 and source != null

# Chamada de retorno pós-execução (para efeitos que precisam de cleanup)
func on_effect_resolved(targets: Array[Node], source: Node) -> void:
	pass
