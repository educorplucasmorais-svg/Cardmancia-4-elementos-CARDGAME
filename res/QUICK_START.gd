# res://QUICK_START.gd
# Script para validar e debugar estrutura antes de rodar
# Execute isto no Godot Editor para verificar se está tudo OK

extends Node

const SEPARATOR = "============================================================"

func _ready() -> void:
	print("\n" + SEPARATOR)
	print("CARDMANCIA - QUICK VALIDATION")
	print(SEPARATOR + "\n")
	
	var errors = []
	var warnings = []
	
	# 1. Validar SignalBus
	if not _validate_signalbus():
		errors.append("❌ SignalBus não inicializado")
	else:
		print("✅ SignalBus carregado")
	
	# 2. Validar recursos de cartas
	if not _validate_card_resources():
		warnings.append("⚠️  Arquivo de carta não encontrado")
	else:
		print("✅ CardData recursos OK")
	
	# 3. Validar classes
	if not _validate_classes():
		errors.append("❌ Algumas classes não compilaram")
	else:
		print("✅ Todas as classes compiladas")
	
	# 4. Validar cena
	if not _validate_scene():
		warnings.append("⚠️  Main.tscn pode ter problemas")
	else:
		print("✅ Main.tscn estrutura OK")
	
	print("\n" + SEPARATOR)
	if errors.is_empty():
		print("✅ ESTRUTURA VÁLIDA - Pronto para rodar!")
		print("\n📖 Como executar:")
		print("  1. Abra: res://res/scenes/Main.tscn")
		print("  2. Pressione F5 para play")
		print("  3. Verifique o console para logs")
	else:
		print("❌ ERROS ENCONTRADOS:")
		for error in errors:
			print("  " + error)
	
	if not warnings.is_empty():
		print("\n⚠️  AVISOS:")
		for warning in warnings:
			print("  " + warning)
	
	print(SEPARATOR + "\n")

func _validate_signalbus() -> bool:
	return SignalBus != null

func _validate_card_resources() -> bool:
	var card = load("res://res/game/cards/data/card_ace_spades.tres")
	if card == null:
		return false
	return card is CardData

func _validate_classes() -> bool:
	var classes = ["CardData", "CardEffect", "Entity", "Player", "Enemy", 
				   "BattleManager", "BattleState", "HandManager", "PlayerStats"]
	
	for cls in classes:
		if ClassDB.class_exists(cls):
			continue
		else:
			print("⚠️  Classe não encontrada: %s" % cls)
			return false
	
	return true

func _validate_scene() -> bool:
	var main_scene = load("res://res/scenes/Main.tscn")
	return main_scene != null
