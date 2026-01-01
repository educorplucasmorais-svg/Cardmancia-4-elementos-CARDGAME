# CARDMANCIA - PowerShell Launcher
# Uso: ./RUN.ps1

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "====================================" -ForegroundColor Yellow
Write-Host "CARDMANCIA: OS 4 ELEMENTOS" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Yellow
Write-Host ""

# Função para abrir arquivo
function Open-File {
    param([string]$Path)
    
    if (Test-Path $Path) {
        Write-Host "[OK] Abrindo arquivo..." -ForegroundColor Green
        & $Path
        return $true
    }
    return $false
}

# PASSO 1: Abrir HTML (funciona offline)
Write-Host "[1] Abrindo versão HTML (offline)..." -ForegroundColor Cyan

$htmlPath = Join-Path $PSScriptRoot "index.html"

if (Open-File $htmlPath) {
    Write-Host ""
    Write-Host "Navegador abrirá em alguns segundos..." -ForegroundColor Green
    Write-Host ""
    
    # Aguardar antes de oferecer Godot
    Start-Sleep -Seconds 3
    
    Write-Host ""
    Write-Host "====================================" -ForegroundColor Yellow
    Write-Host "Deseja abrir Godot também?" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Yellow
    Write-Host "[S] Sim  [N] Não" -ForegroundColor White
    Write-Host ""
    
    $choice = Read-Host "Escolha"
    
    if ($choice -eq "S" -or $choice -eq "s") {
        Write-Host ""
        Write-Host "[2] Procurando Godot..." -ForegroundColor Cyan
        
        $godotPaths = @(
            "C:\Program Files\Godot\Godot.exe",
            "C:\Program Files (x86)\Godot\Godot.exe",
            "${env:APPDATA}\Godot\bin\Godot.exe"
        )
        
        $godot = $null
        foreach ($path in $godotPaths) {
            if (Test-Path $path) {
                $godot = $path
                break
            }
        }
        
        # Tentar encontrar no PATH
        if ($null -eq $godot) {
            $godot = (Get-Command godot -ErrorAction SilentlyContinue).Source
        }
        if ($null -eq $godot) {
            $godot = (Get-Command godot4 -ErrorAction SilentlyContinue).Source
        }
        
        if ($null -ne $godot) {
            Write-Host "    Encontrado: $godot" -ForegroundColor Green
            Write-Host "    Abrindo Godot..." -ForegroundColor Green
            & $godot --editor .
        } else {
            Write-Host ""
            Write-Host "[ERRO] Godot não encontrado" -ForegroundColor Red
            Write-Host ""
            Write-Host "Instale de: https://godotengine.org/download" -ForegroundColor Yellow
            Write-Host ""
            pause
        }
    }
} else {
    Write-Host ""
    Write-Host "[ERRO] index.html não encontrado!" -ForegroundColor Red
    Write-Host "Verifique se está na pasta correta" -ForegroundColor Yellow
    Write-Host ""
    pause
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Yellow
Write-Host "Obrigado por usar Cardmancia!" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Yellow
