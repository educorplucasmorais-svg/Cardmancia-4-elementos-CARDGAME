#!/bin/bash
# CARDMANCIA - LAUNCHER (Linux/Mac)
# Este script abre o Godot automaticamente

clear
echo "====================================="
echo "CARDMANCIA: OS 4 ELEMENTOS"
echo "====================================="
echo ""
echo "Iniciando Godot..."
echo "Aguarde 30-60 segundos para carregar."
echo ""

# Encontrar Godot
GODOT=$(command -v godot)

if [ -z "$GODOT" ]; then
    echo "[ERRO] Godot não encontrado no PATH"
    echo ""
    echo "Instale Godot 4.x:"
    echo "https://godotengine.org/download"
    exit 1
fi

# Ir para diretório do projeto
cd "$(dirname "$0")"

# Abrir Godot
"$GODOT" --editor .

if [ $? -ne 0 ]; then
    echo ""
    echo "[ERRO] Falha ao abrir Godot"
    exit 1
fi

echo ""
echo "===== COMO RODAR ====="
echo "1. No Godot, abra: res/scenes/Main.tscn"
echo "2. Pressione F5 ou clique no botão Play"
echo "3. Observe o console para logs"
echo ""
