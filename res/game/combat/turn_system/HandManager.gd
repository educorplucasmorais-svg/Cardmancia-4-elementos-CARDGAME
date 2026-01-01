# res://game/combat/turn_system/HandManager.gd
# Gerenciador da Mão de Cartas do Jogador
# Responsabilidades: Compra, armazenamento, descarte de cartas

class_name HandManager
extends Node

var hand: Array[CardData] = []
var deck: Array[CardData] = []
var discard_pile: Array[CardData] = []

func _ready() -> void:
	pass

# Embaralhar o deck
func shuffle_deck() -> void:
	deck.shuffle()
	print("[HandManager] Deck shuffled. Size: %d" % deck.size())

# Comprar uma carta do topo do deck
func draw_card() -> CardData:
	if deck.is_empty():
		# Recarregar deck do discard pile
		if discard_pile.is_empty():
			print("[HandManager] No cards to draw!")
			return null
		
		deck = discard_pile.duplicate()
		discard_pile.clear()
		deck.shuffle()
		print("[HandManager] Deck recharged from discard pile.")
	
	var card = deck.pop_front()
	hand.append(card)
	return card

# Remover carta da mão (ao jogar)
func remove_card_from_hand(card: CardData) -> void:
	if card in hand:
		hand.erase(card)
		discard_pile.append(card)

# Limpar a mão (fim de turno ou combate)
func clear_hand() -> void:
	discard_pile.append_array(hand)
	hand.clear()

# Inicializar deck com cartas (chamado no ínicio da run ou combate)
func set_deck(cards: Array[CardData]) -> void:
	deck = cards.duplicate()
	shuffle_deck()
