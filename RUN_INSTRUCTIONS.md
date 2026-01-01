# 🎮 RODAR O JOGO - GUIA RÁPIDO

## Pré-requisitos
- ✅ Godot 4.x instalado
- ✅ Projeto Godot aberto em: `c:\Users\Pichau\Desktop\Cardmancia Os 4 elementos CARDGAME`

---

## OPÇÃO 1: Rodar via Godot Editor (Recomendado)

### Passo 1: Abrir a Cena Principal
```
FileSystem (lado esquerdo)
→ res/
→ scenes/
→ Main.tscn
[Clique duplo para abrir]
```

### Passo 2: Pressionar PLAY
```
Botão ▶️ (canto superior direito)
ou
Pressione: F5
```

### Passo 3: Observar o Console
```
Output (abaixo do editor)
Você verá os logs:
  [BattleManager] Entities initialized
  [BattleManager] Entered state: SetupState
  [SetupState] Spawning enemies...
  [PlayerTurnState] Player turn started!
  [MockUIController] Playing card: Ás de Espadas on target: Goblin 1
  ...
```

---

## OPÇÃO 2: Rodar via CLI (Alternativa)

Se você tiver Godot instalado e no PATH:

```powershell
cd "c:\Users\Pichau\Desktop\Cardmancia Os 4 elementos CARDGAME"
godot --debug-collisions
```

---

## O Que Você Vai Ver

A janela do jogo vai aparecer com:

### Console Output (Esperado)
```
========== INITIALIZATION TEST ==========

[DEBUG] SignalBus: ✅ OK
[DEBUG] BattleManager found: ✅ YES
  - Player: ✅ Player
  - Player HP: 100
  - Enemies: 2
  - HandManager: ✅ OK
  - PlayerStats: ✅ OK
  - Current State: PlayerTurnState

[BattleManager] Entities initialized
[SetupState] Entered state: SetupState
[BattleManager] Entered state: PlayerTurnState
[MockUIController] Player turn started!

⏳ Aguardando 2 segundos...

[MockUIController] Playing card: Ás de Espadas on target: Goblin 1
[BattleUI] 🎴 Card played: Ás de Espadas → Goblin 1
[BattleUI] 💢 Goblin 1 took 8 damage
[MockUIController] Playing card: Ás de Espadas on target: Goblin 2
...

✅ VICTORY!
```

---

## Fluxo Mecânico Esperado

| Etapa | O Que Acontece | Console Log |
|-------|---------------|------------|
| **1. Setup** | Carrega player, inimigos, embaralha deck | `[SetupState]` |
| **2. Draw** | Compra 5 cartas | `[hand_card_drawn]` x5 |
| **3. Play** | Joga 2-3 cartas aleatórias | `[MockUIController] Playing card` |
| **4. Damage** | Aplica dano aos inimigos | `[💢 ... took X damage]` |
| **5. Enemy Turn** | Inimigos atacam | `[PlayerTurnState] took X damage` |
| **6. Victory** | Todos inimigos mortos | `[✅ VICTORY!]` |

---

## Testes Manuais (Opcional)

Se você quiser controlar manualmente (desabilitar auto-play):

### Editar MockUIController
```gdscript
# No método _ready() de MockUIController
auto_play_enabled = false  # Mude para False

# Você pode usar:
# SPACE = Jogar próxima carta
# E = Finalizar turno
```

---

## Solução de Problemas

### ❌ Erro: "SignalBus is not declared"
**Solução:**
1. Abra `project.godot`
2. Procure por `[autoload]`
3. Verifique se tem: `SignalBus="*res://globals/SignalBus.gd"`
4. Se não tiver, adicione

### ❌ Erro: "CardData not found"
**Solução:**
1. Verifique se `res://game/cards/data/card_ace_spades.tres` existe
2. Se não existir, o arquivo precisa ser criado no Godot

### ❌ Jogo não inicia
**Solução:**
1. Verifique o console para mensagens de erro
2. Procure pela linha `[BattleManager] Entities initialized`
3. Se não aparecer, há erro na inicialização

### ❌ Nenhuma carta é jogada
**Solução:**
1. Verifique se `MockUIController` está em `Main.tscn`
2. Verifique se `auto_play_enabled = true` no MockUIController

---

## Comandos Úteis no Console

Enquanto o jogo está rodando:

```gdscript
# Ver estado atual
print(get_node("BattleManager").current_state_name)

# Ver HP do player
print(get_node("BattleManager").player_stats.current_health)

# Ver mão do jogador
print(get_node("BattleManager").player_hand_manager.hand.size())

# Simular dano
get_node("BattleManager").player.take_damage(10)
```

---

## Próximo Passo Após Confirmar Funciona

Uma vez que você confirmar que:
- ✅ O jogo roda sem erros
- ✅ Cartas são jogadas
- ✅ Dano é aplicado
- ✅ Inimigos morrem
- ✅ Vitória é declarada

Você pode escolher:
1. **Adicionar mais efeitos** (DrawEffect, BlockEffect)
2. **Melhorar IA dos inimigos** (padrões de ataque)
3. **Adicionar visual** (animações, UI)
4. **Implementar relíquias** (modificadores globais)

---

## Tempo Esperado

- **Inicializar:** 5-10 segundos
- **Primeira volta:** 20-30 segundos
- **Vitória:** 15-20 segundos

**Total: ~1 minuto por execução completa**

---

**Está pronto? Rode e reporte se funciona! 🚀**
