# CARDMANCIA: OS 4 ELEMENTOS - WALKING SKELETON (v0.1.0)

## Arquitetura Implementada

### 1. Core Systems (✅ IMPLEMENTADO)

#### A. Data Layer (Resources)
- **CardData.gd**: Definição de dados da carta (Naipe, Valor, Efeitos, Rarity)
- **CardEffect.gd**: Classe base para efeitos (Command Pattern)
- **DamageEffect.gd**: Exemplo de efeito concreto
- **Entity.gd**: Base para Player/Enemies (Health, Armor, Stats, Status)

#### B. Gameplay Systems
- **HandManager.gd**: Gerenciamento de Mão/Deck/Discard
- **PlayerStats.gd**: Saúde, Mana, Buffs/Debuffs do Jogador
- **SignalBus.gd**: Event Bus centralizado (desacoplamento)

#### C. Combat FSM (Finite State Machine)
- **BattleState.gd**: Classe base para estados
- **SetupState.gd**: Inicialização do combate
- **PlayerTurnState.gd**: Turno do jogador (input, play cards)
- **ResolutionState.gd**: Processamento de efeitos, verificação de morte
- **EnemyTurnState.gd**: Turno dos inimigos (IA placeholder)
- **OutcomeState.gd**: Vitória/Derrota e recompensas
- **BattleManager.gd**: Orquestrador principal (FSM controller)

### 2. Fluxo de Jogo Atual

```
SetupState
  ↓ (shuffle deck, spawn enemies)
PlayerTurnState
  ↓ (draw 5 cards, wait for input)
[UI emits: request_play_card]
  ↓ (validate mana, execute effects)
ResolutionState
  ↓ (check victory/defeat)
EnemyTurnState
  ↓ (execute enemy actions)
ResolutionState
  ↓ (check again)
[Loop ou OutcomeState]
```

### 3. Padrões de Design Aplicados

| Padrão | Localização | Propósito |
|--------|------------|----------|
| **Command** | CardEffect + DamageEffect | Encapsular ações de cartas |
| **State** | BattleState + subclasses | FSM de combate |
| **Observer** | SignalBus | Desacoplamento entre sistemas |
| **Singleton** | SignalBus (autoload) | Event hub centralizado |
| **Resource** | CardData, CardEffect | Data-driven design |

---

## Próximas Tarefas (Priority Order)

### Fase 2: UI & Input Handling
1. **CardView.tscn**: Renderizar carta genérica (nome, mana, icon)
2. **HandView.tscn**: Exibir mão de 5 cartas
3. **BattleUIManager.gd**: Controller para UI do combate
   - Conexão com SignalBus para atualizar visualmente
   - Detecção de cliques em cartas
   - Mostrar intenção de inimigos

### Fase 3: Enemy & AI
1. **Enemy.gd**: Classe que herda Entity
   - Padrão de ataque (array de ações)
   - Intenção visual
2. **AIController.gd**: Lógica de IA dos inimigos
3. **EnemyData.gd**: Resource para dados de inimigos

### Fase 4: Mais Efeitos
1. **DrawEffect.gd**: Comprar cartas
2. **BlockEffect.gd**: Ganhar armadura
3. **StatusEffect.gd**: Aplicar status (poison, stun)
4. **StrengthEffect.gd**: Buff de dano

### Fase 5: Relíquias (Relics)
1. **RelicData.gd**: Dados de relíquia
2. **RelicSystem.gd**: Aplicar efeitos de relíquia globalmente
3. Triggers: StartOfBattle, EndOfTurn, OnCardPlayed, etc.

### Fase 6: Meta-Game (Run Progression)
1. **RunManager.gd**: Persistência de progresso (unlocks, stats)
2. **MapGenerator.gd**: DAG de nós (combates, eventos, lojas)
3. **MainMenu.tscn**: Seleção de deck inicial

---

## Estrutura de Pastas Finalizada

```
res://
├── globals/
│   └── SignalBus.gd              [✅ FEITO]
├── game/
│   ├── cards/
│   │   ├── core/
│   │   │   └── CardData.gd        [✅ FEITO]
│   │   ├── effects/
│   │   │   ├── CardEffect.gd      [✅ FEITO]
│   │   │   ├── DamageEffect.gd    [✅ FEITO]
│   │   │   ├── DrawEffect.gd      [⏳ TODO]
│   │   │   ├── BlockEffect.gd     [⏳ TODO]
│   │   │   └── ...
│   │   └── data/
│   │       └── card_ace_spades.tres [✅ FEITO]
│   └── combat/
│       ├── fsm/
│       │   ├── BattleState.gd      [✅ FEITO]
│       │   ├── SetupState.gd       [✅ FEITO]
│       │   ├── PlayerTurnState.gd  [✅ FEITO]
│       │   ├── ResolutionState.gd  [✅ FEITO]
│       │   ├── EnemyTurnState.gd   [✅ FEITO]
│       │   └── OutcomeState.gd     [✅ FEITO]
│       └── BattleManager.gd        [✅ FEITO]
├── entities/
│   ├── Entity.gd                   [✅ FEITO]
│   ├── Player.gd                   [✅ FEITO]
│   └── Enemy.gd                    [✅ FEITO]
├── ui/
│   ├── managers/
│   │   ├── HandManager.gd          [✅ FEITO]
│   │   └── PlayerStats.gd          [✅ FEITO]
│   ├── views/
│   │   └── CardView.tscn           [✅ FEITO]
│   ├── BattleUIManager.gd          [✅ FEITO]
│   └── MockUIController.gd         [✅ FEITO]
├── scenes/
│   └── Main.tscn                   [✅ FEITO]
├── project.godot                   [✅ FEITO]
├── ARCHITECTURE.md                 [✅ FEITO]
├── TEST_AND_VALIDATION.md          [✅ FEITO]
└── DEBUG_InitializationTest.gd     [✅ FEITO]
```

---

## Como Testar o Walking Skeleton

### Pré-requisitos
1. Instale o **Godot 4.x** (versão LTS recomendada)
2. Abra o projeto em `c:\Users\Pichau\Desktop\Cardmancia Os 4 elementos CARDGAME`
3. Aguarde o parse de scripts

### Teste Básico (Console Logging)
1. Abra **Main.tscn**
2. Clique em **Play** (▶️)
3. Verifique no **Output Console** os logs da FSM:
   ```
   [BattleManager] Entered state: SetupState
   [SetupState] Spawning enemies...
   [SetupState] Applying 'Start of Battle' effects...
   [BattleManager] Entered state: PlayerTurnState
   ...
   ```

### Próximo Passo: UI Mocking
Para validar fluxo sem UI gráfica:
1. Crie um **MockUIManager.gd** que emite sinais automaticamente
2. `request_play_card` com delay (simular clique do jogador)
3. Verifique se a FSM transiciona corretamente

---

## ROADMAP VISUAL (Brain Chain)

```
[FASE 1: DATA LAYER] ✅
   ↓
[FASE 2: FSM SKELETON] ✅
   ↓
[FASE 3: SIGNAL BUS] ✅
   ↓
[FASE 4: UI MOCKING] ⏳ PRÓXIMO
   ↓
[FASE 5: VISUAL UI] ⏳
   ↓
[FASE 6: ENEMIES + AI] ⏳
   ↓
[FASE 7: RELICS] ⏳
   ↓
[FASE 8: META-GAME] ⏳
```

---

## Notas do Architect

1. **Determinismo vs Mística**: Todo "efeito mágico" é um comando determinístico. A "magia" emerge da composição de efeitos, não de randomização não-controlada.

2. **Extensibilidade**: Novos efeitos → herdar de `CardEffect`. Novos estados → herdar de `BattleState`. Padrão consistente.

3. **Testing Strategy**: Cada estado pode ser testado independentemente emitindo sinais do SignalBus.

4. **Performance**: Resource pooling para cartas (duplicação vs clone) será necessário em late-game.

5. **Segurança**: Sempre validar `can_execute()` antes de `execute()`. Nunca confie em inputs da UI.

---

**Fim da Documentação v0.1.0**
**Próximo Checkpoint: UI Mocking + Teste de Fluxo Completo**
