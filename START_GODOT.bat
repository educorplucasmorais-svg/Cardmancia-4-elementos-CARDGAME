@echo off
REM ========================================
REM CARDMANCIA - LAUNCHER (Windows)
REM ========================================
REM Este script abre o Godot automaticamente

cls
echo.
echo =====================================
echo CARDMANCIA: OS 4 ELEMENTOS
echo =====================================
echo.
echo Iniciando Godot...
echo Aguarde 30-60 segundos para carregar.
echo.

REM Encontrar Godot no PATH ou em locais comuns
for %%X in (godot.exe godot4.exe) do (set "GODOT=%%~$PATH:X")

if not defined GODOT (
    echo [ERRO] Godot nao encontrado no PATH
    echo.
    echo Verifique se Godot 4.x esta instalado:
    echo https://godotengine.org/download
    echo.
    pause
    exit /b 1
)

REM Obter caminho do projeto
cd /d "%~dp0"

REM Abrir Godot com o projeto
"%GODOT%" --editor .

if errorlevel 1 (
    echo.
    echo [ERRO] Falha ao abrir Godot
    pause
    exit /b 1
)

echo.
echo ===== COMO RODAR =====
echo 1. No Godot, abra: res/scenes/Main.tscn
echo 2. Pressione F5 ou clique no botao Play
echo 3. Observe o console para logs
echo.
pause
