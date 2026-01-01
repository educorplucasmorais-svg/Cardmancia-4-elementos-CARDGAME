#!/usr/bin/env python3
"""
CARDMANCIA - Web Server
Serve o jogo Godot compilado em http://localhost:8000

Uso:
    python3 RUN_SERVER.py
    
Depois acesse: http://localhost:8000
"""

import http.server
import socketserver
import os
import sys
import webbrowser
from pathlib import Path

PORT = 8000
HANDLER = http.server.SimpleHTTPRequestHandler

def main():
    # Mudar para diretório do projeto
    project_dir = Path(__file__).parent
    os.chdir(project_dir)
    
    # Verificar se existe export do Godot
    if not Path("html").exists():
        print("\n" + "="*60)
        print("ERRO: Jogo não foi exportado para Web")
        print("="*60)
        print("\nVocê precisa:")
        print("1. Abrir Godot")
        print("2. Project → Export → Selecionar 'Web'")
        print("3. Clicar em 'Export Project'")
        print("4. Rodar este script novamente")
        print("\nOu: use START_GODOT.bat para rodar o editor\n")
        return 1
    
    # Iniciar servidor
    print("\n" + "="*60)
    print("CARDMANCIA - Web Server")
    print("="*60)
    print(f"\n✅ Servidor iniciado em http://localhost:{PORT}")
    print("\n📖 Navegador abrirá automaticamente...")
    print("Se não abrir, acesse manualmente: http://localhost:8000")
    print("\nPressione Ctrl+C para parar\n")
    
    # Abrir navegador
    webbrowser.open(f"http://localhost:{PORT}")
    
    # Iniciar servidor
    with socketserver.TCPServer(("", PORT), HANDLER) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n[Servidor parado]")
            return 0
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
