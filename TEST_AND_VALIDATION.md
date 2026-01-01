# TESTE E VALIDAÇÃO - WALKING SKELETON v0.1.0

## Checklist Pré-Teste

Antes de rodar o projeto Godot, verifique:

- [ ] Godot 4.x instalado
- [ ] Projeto aberto em: `c:\Users\Pichau\Desktop\Cardmancia Os 4 elementos CARDGAME`
- [ ] Script Parser completou (sem erros vermelho no editor)
- [ ] `project.godot` está na raiz

---

## Como Executar o Teste

### Passo 1: Abrir o Projeto
1. Inicie **Godot 4.x**
2. Clique em **"Open Project"** e navegue para:
   ```
   c:\Users\Pichau\Desktop\Cardmancia Os 4 elementos CARDGAME
   ```
3. Aguarde o editor carregar (pode levar 30-60 segundos)

### Passo 2: Abrir a Cena Principal
1. No painel **FileSystem** (esquerda), navegue até: `res://scenes/Main.tscn`
2. Clique duas vezes para abrir

### Passo 3: Executar o Projeto
1. Clique no botão **▶️ Play** (ou pressione F5)
2. Uma janela do jogo abrirá com:
   - **Canto superior esquerdo:** Contador de Mana
   - **Canto superior direito:** Contador de HP
   - **Canto inferior:** Log de eventos

### Passo 4: Observar o Fluxo Automático
O MockUIController vai:
1. Aguardar 1 segundo após o início da batalha
2. Comprar 5 cartas automaticamente
3. Jogar 2-3 cartas aleatórias a cada 2 segundos
4. Finalizar o turno
5. Deixar o turno do inimigo passar
6. Repetir até vitória ou derrota

---

## Sinais Esperados no Console (Output)

```
[SignalBus] Initialized
[BattleManager] Entities initialized
[BattleManager] Entered state: SetupState
[SetupState] Entered state: SetupState
[SetupState] Spawning enemies...
[SetupState] Applying 'Start of Battle' effects...
[BattleManager] Entered state: PlayerTurnState
[PlayerTurnState] Entered state: PlayerTurnState
[MockUIController] Player turn started!
[MockUIController] Playing card: Ás de Espadas on target: Goblin 1
[BattleUI] 🎴 Card played: Ás de Espadas → Goblin 1
[BattleUI] 💢 Goblin 1 took X damage
[ResolutionState] All enemies defeated!
[BattleManager] Entered state: OutcomeState
[BattleUI] ✅ VICTORY!
```

---

## Controles Manuais (Opcional)

Se você desabilitar `auto_play_enabled` em `MockUIController.gd`:

| Tecla | Ação |
|-------|------|
| **SPACE** | Jogar próxima carta (aleatória) |
| **E** | Finalizar turno do jogador |

Para desabilitar auto_play:
```gdscript
# No método _ready() de MockUIController
auto_play_enabled = false  # Muda para True
```

---

## Checklist de Validação Pós-Teste

### ✅ Inicialização
- [ ] Projeto inicia sem erros críticos
- [ ] BattleManager cria Player, 2 Enemies, HandManager, PlayerStats
- [ ] SignalBus inicializa como AutoLoad
- [ ] BattleUIManager mostra labels de Mana e HP

### ✅ FSM State Machine
- [ ] SetupState → PlayerTurnState (transição visível no console)
- [ ] PlayerTurnState → ResolutionState → EnemyTurnState (loop correto)
- [ ] Estados saem e entram na ordem esperada (logs com timestamps)

### ✅ Gameplay Flow
- [ ] Cartas são compradas (5 no primeiro turno)
- [ ] Mana é deduzida ao jogar carta
- [ ] Efeitos de dano são executados (DamageEffect)
- [ ] Inimigos recebem dano e sua HP muda
- [ ] Inimigos atacam o jogador em seu turno

### ✅ Signal Bus & UI Updates
- [ ] Logs aparecem em tempo real no BattleUIManager
- [ ] Contador de Mana atualiza (3 → 1 ao jogar carta de 2)
- [ ] Contador de HP do jogador muda (feedback de dano)
- [ ] Mensagens de evento aparecem (card_played, entity_damaged)

### ✅ Victory Condition
- [ ] Todos os inimigos morrem (HP ≤ 0)
- [ ] OutcomeState é acionado
- [ ] Log exibe "✅ VICTORY!"

---

## Possíveis Erros & Soluções

### Erro: "SignalBus is not declared"
**Causa:** SignalBus não foi carregado como AutoLoad
**Solução:** Abra `project.godot` e verifique:
```ini
[autoload]
SignalBus="*res://globals/SignalBus.gd"
```

### Erro: "CardData resource not found"
**Causa:** `card_ace_spades.tres` não existe em `res://game/cards/data/`
**Solução:** Verifique se o arquivo foi criado. Se não, recrie-o manualmente.

### Erro: "HandManager/PlayerStats is null"
**Causa:** `_initialize_entities()` não foi chamado antes de `_initialize_fsm()`
**Solução:** Verifique a ordem no `_ready()` do BattleManager

### Nenhuma carta é jogada
**Causa:** `auto_play_enabled = false` ou MockUIController não está no nó
**Solução:** Verifique se MockUIController está em `Main.tscn` como child de Main

### Jogo trava em um estado
**Causa:** Await infinito ou signal nunca foi emitido
**Solução:** 
1. Verifique o console para ver qual estado travou
2. Procure por `await` que nunca termina
3. Verifique se os sinais estão sendo emitidos corretamente

---

## Próximos Passos (Itinerary)

Após validar o fluxo básico:

1. **Fase 5: Mais Efeitos**
   - [ ] DrawEffect.gd (comprar cartas)
   - [ ] BlockEffect.gd (ganhar armadura)
   - [ ] Criar mais cartas de exemplo

2. **Fase 6: Enemy AI**
   - [ ] AIController.gd com padrões de ataque
   - [ ] Enemy intents (visual + lógica)
   - [ ] Variedade de inimigos

3. **Fase 7: Reliquias (Relics)**
   - [ ] RelicData.gd
   - [ ] Triggers: StartOfBattle, EndOfTurn, OnCardPlayed

4. **Fase 8: Meta-Game**
   - [ ] RunManager.gd (persistência)
   - [ ] MapGenerator.gd (DAG)
   - [ ] MainMenu.tscn (seleção de deck)

---

## Métricas de Sucesso

| Métrica | Alvo | Resultado |
|---------|------|-----------|
| **Tempo de inicialização** | < 2 segundos | ⏳ |
| **Sem memory leaks** | Godot Profiler | ⏳ |
| **Fluxo completo** | SetupState → OutcomeState | ⏳ |
| **Sinais funcionam** | 100% dos sinais emitidos | ⏳ |
| **UI atualiza** | Mana, HP em tempo real | ⏳ |

---

**Última Atualização:** 01/01/2026
**Versão:** 0.1.0 (Walking Skeleton)
**Status:** Pronto para teste
