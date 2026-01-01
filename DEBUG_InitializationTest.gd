# res://DEBUG_InitializationTest.gd
# Script de debug para testar inicialização
# Coloque este script em um Node na cena Main para validar

extends Node

func _ready() -> void:
	print("\n========== INITIALIZATION TEST ==========\n")
	
	# Verificar SignalBus
	print("[DEBUG] SignalBus: %s" % ("✅ OK" if SignalBus else "❌ FAIL"))
	
	# Verificar estrutura de nós
	var main = get_tree().root.get_child(0)
	print("[DEBUG] Main node: %s" % main.name)
	
	var battle_manager = main.get_node_or_null("BattleManager")
	print("[DEBUG] BattleManager found: %s" % ("✅ YES" if battle_manager else "❌ NO"))
	
	if battle_manager:
		print("  - Player: %s" % ("✅ %s" % battle_manager.player.name if battle_manager.player else "❌ NULL"))
		print("  - Player HP: %d" % battle_manager.player.current_health if battle_manager.player else "")
		print("  - Enemies: %d" % battle_manager.enemies.size())
		print("  - HandManager: %s" % ("✅ OK" if battle_manager.player_hand_manager else "❌ NULL"))
		print("  - PlayerStats: %s" % ("✅ OK" if battle_manager.player_stats else "❌ NULL"))
		print("  - Current State: %s" % battle_manager.current_state_name)
	
	var ui_manager = main.get_node_or_null("BattleUIManager")
	print("[DEBUG] BattleUIManager found: %s" % ("✅ YES" if ui_manager else "❌ NO"))
	
	var mock_controller = main.get_node_or_null("MockUIController")
	print("[DEBUG] MockUIController found: %s" % ("✅ YES" if mock_controller else "❌ NO"))
	
	print("\n========================================\n")
	print("👉 Press SPACE to play a card, press E to end turn")
	print("👉 Check console for game flow logs\n")
