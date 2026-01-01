#!/bin/bash
# Simples - Roda o servidor web em http://localhost:8000

cd "$(dirname "$0")"

if [ ! -d "html" ]; then
    echo "Erro: Jogo não foi exportado para Web"
    echo "Use START_GODOT.sh para exportar"
    exit 1
fi

echo "Iniciando servidor em http://localhost:8000"
python3 -m http.server 8000
