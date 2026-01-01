@echo off
REM ========================================
REM CARDMANCIA - LAUNCHER AUTOMÁTICO
REM ========================================
REM Este script inicia TUDO automaticamente

setlocal enabledelayedexpansion
cls

echo.
echo =====================================
echo CARDMANCIA: OS 4 ELEMENTOS
echo =====================================
echo.

REM OPÇÃO 1: Tentar abrir arquivo HTML local
echo [1] Tentando abrir versao offline (HTML)...
if exist "index.html" (
    start "" "index.html"
    echo     OK! Navegador abrirá em segundos...
    echo.
    echo [2] Se desejar a versao Godot completa:
    echo     Pressione [ENTER] para abrir Godot
    pause
    
    REM OPÇÃO 2: Abrir Godot
    echo.
    echo Procurando Godot...
    
    for %%X in (godot.exe godot4.exe) do (set "GODOT=%%~$PATH:X")
    
    if defined GODOT (
        echo Abrindo Godot...
        "%GODOT%" --editor .
    ) else (
        echo.
        echo [ERRO] Godot nao encontrado
        echo Instale de: https://godotengine.org/download
        echo.
        pause
    )
) else (
    echo [ERRO] index.html nao encontrado!
    pause
    exit /b 1
)
