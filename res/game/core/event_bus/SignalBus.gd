extends Node

# ============ COMBAT SIGNALS ============
signal battle_started
signal battle_ended(victory: bool)

signal player_turn_started
signal player_turn_ended
signal enemy_turn_started
signal enemy_turn_ended

# Emitido pela UI da carta quando o jogador tenta usá-la
signal request_play_card(card_data: CardData, target: Node)
# Emitido quando a carta é jogada com sucesso
signal card_played(card_data: CardData, targets: Array[Node])
# Emitido quando o sistema valida que a carta PODE ser jogada
signal card_resolved(card_data: CardData)
signal card_effect_executed(effect: CardEffect, targets: Array[Node])

# ============ ENTITY SIGNALS ============
signal entity_damaged(entity: Node, damage: int)
signal entity_healed(entity: Node, heal: int)
signal entity_died(entity: Node)
signal entity_status_changed(entity: Node, status: String)
# Para atualizar barras de vida sem acoplamento
signal stats_changed(entity: Node, current_hp: int, max_hp: int)

# ============ HAND SIGNALS ============
signal hand_updated(cards: Array[CardData])
signal hand_card_drawn(card: CardData)
signal mana_changed(current: int, max_mana: int)

# ============ UI SIGNALS ============
signal show_enemy_intent(enemy: Node, intent_text: String)
signal hide_enemy_intent(enemy: Node)
signal floating_damage(position: Vector2, damage: int)
signal vfx_requested(vfx_scene: PackedScene, position: Vector2)

# ============ META SIGNALS ============
signal run_started
signal run_ended(victory: bool)
signal deck_modified(cards: Array[CardData])
