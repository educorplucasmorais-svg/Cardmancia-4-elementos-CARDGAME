# res://ui/PixelTheme.gd
# Tema global pixel art para o jogo
# Cria estilos consistentes para todos os elementos de UI

extends Node

const PIXEL_SCALE = 2

# Cores do tema (inspirado em tons terra/elementos)
const COLOR_BG_DARK = Color(0.15, 0.12, 0.1)
const COLOR_BG_LIGHT = Color(0.25, 0.22, 0.18)
const COLOR_PRIMARY = Color(0.9, 0.75, 0.5)
const COLOR_SECONDARY = Color(0.7, 0.85, 0.95)
const COLOR_ACCENT = Color(1.0, 0.65, 0.3)
const COLOR_TEXT = Color(0.95, 0.9, 0.8)
const COLOR_BORDER = Color(0.6, 0.5, 0.35)

# Elementos (cores dos 4 elementos)
const COLOR_FIRE = Color(1.0, 0.4, 0.2)
const COLOR_WATER = Color(0.3, 0.6, 0.95)
const COLOR_EARTH = Color(0.5, 0.35, 0.2)
const COLOR_AIR = Color(0.9, 0.95, 1.0)

static func create_button_style(bg_color: Color = COLOR_BG_LIGHT) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = bg_color
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.border_color = COLOR_BORDER
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_right = 4
	style.corner_radius_bottom_left = 4
	style.content_margin_left = 16
	style.content_margin_top = 12
	style.content_margin_right = 16
	style.content_margin_bottom = 12
	return style

static func create_panel_style(bg_color: Color = COLOR_BG_DARK) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = bg_color
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.border_color = COLOR_BORDER
	style.corner_radius_top_left = 8
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_right = 8
	style.corner_radius_bottom_left = 8
	return style

static func create_card_style(element_color: Color) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.95, 0.93, 0.88)
	style.border_width_left = 4
	style.border_width_top = 4
	style.border_width_right = 4
	style.border_width_bottom = 4
	style.border_color = element_color
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_right = 12
	style.corner_radius_bottom_left = 12
	style.shadow_size = 6
	style.shadow_color = Color(0, 0, 0, 0.3)
	return style
