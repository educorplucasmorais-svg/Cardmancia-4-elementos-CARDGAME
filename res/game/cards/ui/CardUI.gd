# res://res/game/cards/ui/CardUI.gd
# Componente Visual Básico de Carta (Átomo do Jogo)
# Apenas recebe dados e desenha. Mantém-se "burra" - sem lógica de jogo.

class_name CardUI
extends Control

# ============ SINAIS ============
signal card_clicked(card: CardUI)
signal card_hovered(card: CardUI)
signal card_unhovered(card: CardUI)

# ============ REFERÊNCIAS AOS NÓS ============
@onready var panel: Panel = $Panel
@onready var icon_texture: TextureRect = $Panel/VBox/Icon
@onready var title_label: Label = $Panel/VBox/Title
@onready var desc_label: RichTextLabel = $Panel/VBox/Description
@onready var cost_label: Label = $Panel/CostBadge/Cost

# ============ DADOS ============
var card_data: CardData

# ============ ESTADO VISUAL ============
var _original_scale: Vector2 = Vector2.ONE
var _is_hovered: bool = false

const HOVER_SCALE := Vector2(1.08, 1.08)
const HOVER_Y_OFFSET := -15.0
const ANIM_DURATION := 0.12

func _ready() -> void:
	_original_scale = scale
	
	# Conectar sinais de GUI nativos do Godot 4
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

## Função de Configuração (Chame isso logo após instanciar a carta)
func setup(data: CardData) -> void:
	card_data = data
	_update_display()

func _update_display() -> void:
	if not is_inside_tree():
		await ready
	
	if not card_data:
		_set_placeholder()
		return
	
	# Preencher UI
	if title_label:
		title_label.text = card_data.title if card_data.title else "???"
	
	if cost_label:
		cost_label.text = str(card_data.cost)
	
	if icon_texture and card_data.art:
		icon_texture.texture = card_data.art
	
	# Descrição dinâmica (vem dos efeitos)
	if desc_label:
		desc_label.text = card_data.get_description()
	
	# Pintar a borda com a cor do Elemento (Resource)
	_apply_element_style()

func _apply_element_style() -> void:
	if not card_data or not card_data.element:
		return
	
	if panel:
		var style = panel.get_theme_stylebox("panel")
		if style:
			var new_style: StyleBoxFlat = style.duplicate() as StyleBoxFlat
			if new_style:
				new_style.border_color = card_data.element.color_theme
				panel.add_theme_stylebox_override("panel", new_style)

func _set_placeholder() -> void:
	if title_label:
		title_label.text = "???"
	if cost_label:
		cost_label.text = "?"
	if desc_label:
		desc_label.text = "Carta desconhecida"

# ============ INPUT HANDLING ============

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			card_clicked.emit(self)

func _on_mouse_entered() -> void:
	_is_hovered = true
	card_hovered.emit(self)
	
	# Animação de "Pop Up"
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", HOVER_SCALE, ANIM_DURATION)
	tween.tween_property(self, "position:y", position.y + HOVER_Y_OFFSET, ANIM_DURATION)
	
	# Trazer para frente
	z_index = 10

func _on_mouse_exited() -> void:
	_is_hovered = false
	card_unhovered.emit(self)
	
	# Voltar ao normal
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_parallel(true)
	tween.tween_property(self, "scale", _original_scale, ANIM_DURATION)
	tween.tween_property(self, "position:y", position.y - HOVER_Y_OFFSET, ANIM_DURATION)
	
	z_index = 0

# ============ PUBLIC API ============

func set_playable(playable: bool) -> void:
	modulate.a = 1.0 if playable else 0.5

func highlight(enabled: bool) -> void:
	modulate = Color(1.2, 1.2, 1.2) if enabled else Color.WHITE

func get_card_data() -> CardData:
	return card_data
