# res://StartGame.gd
# Script simples para iniciar o jogo sem UI de debug
# Coloque como script da cena Main.tscn se quiser

extends Node

func _ready() -> void:
	print("\n" + "="*70)
	print("🎮 CARDMANCIA: OS 4 ELEMENTOS - STARTING")
	print("="*70)
	print("\nModo: Mechanical Test (sem design)")
	print("Status: Auto-play ativado")
	print("Duração esperada: ~30 segundos\n")
	
	# Aguardar um frame para garantir que tudo inicializar
	await get_tree().process_frame
	
	print("[StartGame] Sistema iniciado!")
	print("[StartGame] Verifique o console para logs do jogo\n")
