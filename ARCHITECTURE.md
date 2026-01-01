# Arquitetura do Projeto: Cardmancia - Os 4 Elementos

## 🏗️ Visão Geral

Este projeto segue a arquitetura **Modular Monolith**, organizando código por **funcionalidade** em vez de tipo de arquivo. Esta abordagem facilita o entendimento, manutenção e escalabilidade do projeto.

---

## 📁 Estrutura de Diretórios

```
res://
├── game/                    # LÓGICA DO JOGO
│   ├── core/                # Sistemas Globais (Autoloads)
│   │   ├── event_bus/       # SignalBus - Comunicação desacoplada
│   │   ├── save_system/     # (Futuro) SaveManager
│   │   ├── audio_manager/   # (Futuro) SoundQueue
│   │   └── game_state/      # (Futuro) GameState singleton
│   │
│   ├── cards/               # Módulo de Cartas
│   │   ├── logic/           # CardData, CardEffect, DamageEffect
│   │   ├── data/            # Resources (.tres) de cartas
│   │   └── ui/              # CardView.tscn, HandContainer
│   │
│   ├── combat/              # Módulo de Batalha
│   │   ├── turn_system/     # BattleManager, HandManager
│   │   ├── fsm/             # Estados da FSM (Setup, PlayerTurn, etc)
│   │   ├── enemies/         # Entity, Enemy, AI
│   │   └── arena/           # (Futuro) Backgrounds, grid tático
│   │
│   ├── map/                 # Módulo de Mapa Roguelike
│   │   ├── generator/       # (Futuro) MapGenerator.gd
│   │   └── nodes/           # (Futuro) MapNode.tscn
│   │
│   └── player/              # Módulo do Jogador
│       ├── character/       # Player, PlayerStats
│       └── relics/          # (Futuro) Sistema de relíquias
│
├── ui/                      # UI Global (não específica de módulos)
│   ├── BattleUIManager.gd
│   └── MockUIController.gd
│
├── scenes/                  # Cenas principais
│   └── Main.tscn
│
└── assets/                  # Assets Brutos (Sprites, Audio)
    ├── sprites/
    │   ├── ui/
    │   └── characters/
    └── audio/
```

---

## 🧩 Padrões Arquiteturais Implementados

### 1. **Event Bus Pattern** (Barramento de Eventos)
**Localização**: `res://game/core/event_bus/SignalBus.gd` (Autoload)

**Propósito**: Desacoplar comunicação entre sistemas.

**Exemplo**:
```gdscript
# Emissor (Carta sendo jogada)
SignalBus.card_played.emit(card_data, target)

# Receptor (Sistema de áudio)
SignalBus.card_played.connect(_on_card_played)
```

**Benefícios**:
- Nenhum sistema precisa conhecer diretamente outros sistemas
- Facilita testes unitários (mockar sinais)
- Permite adicionar novos sistemas que reagem a eventos existentes

---

### 2. **Finite State Machine (FSM)** para Turnos
**Localização**: `res://game/combat/fsm/`

**Estados**:
1. **SetupState**: Compra mão inicial, aplica relíquias
2. **PlayerTurnState**: Jogador pode jogar cartas
3. **ResolutionState**: Processa efeitos de cartas
4. **EnemyTurnState**: IA dos inimigos age
5. **OutcomeState**: Verifica vitória/derrota

**Fluxo**:
```
Setup → PlayerTurn → Resolution → EnemyTurn → (volta para PlayerTurn ou vai para Outcome)
```

**Implementação**:
- Classe base: `BattleState` (possui `enter()`, `exit()`, `update()`)
- Cada estado herda e implementa lógica específica
- Transições controladas por `BattleManager.change_state()`

---

### 3. **Command Pattern** para Efeitos de Cartas
**Localização**: `res://game/cards/logic/`

**Estrutura**:
```gdscript
# CardData (Resource)
class_name CardData extends Resource
@export var effects: Array[CardEffect]  # Lista de efeitos

# CardEffect (Classe Base Abstrata)
class_name CardEffect extends Resource
func execute(targets: Array[Node], context) -> void:
    pass

# DamageEffect (Implementação Concreta)
class_name DamageEffect extends CardEffect
@export var damage_amount: int = 5
func execute(targets: Array[Node], context) -> void:
    for target in targets:
        target.take_damage(damage_amount)
```

**Benefícios**:
- Cartas são **dados** (Resources), não código
- Efeitos são **compostos** (uma carta pode ter múltiplos efeitos)
- Facilita criação de cartas no editor Godot sem programar

---

### 4. **Data-Oriented Design** com Resources
**Localização**: `res://game/cards/data/`

**Princípio**: Separar dados de lógica.

**Exemplo**:
- **CardData.tres**: Define nome, custo, ícone, efeitos
- **DamageEffect.gd**: Implementa como o dano funciona

**Vantagens**:
- Designers podem criar cartas sem tocar em código
- Dados são serializáveis (facilita save/load)
- Tipagem forte (IntelliSense funciona)

---

## 🔌 Configuração do Ambiente VS Code

### Portas Configuradas:
- **LSP (Language Server)**: `6005` - Autocomplete, erros em tempo real
- **DAP (Debug Adapter)**: `6006` - Breakpoints, inspeção de variáveis

### Arquivos de Configuração:
1. **`.vscode/launch.json`**: Define como o VS Code inicia o Godot para depuração
2. **`.vscode/settings.json`**: Configura portas, formatação, exclusões de busca
3. **`.cursorrules`**: Regras de código para IA (Cursor/Copilot)

---

## 🎯 Fluxo de Desenvolvimento Recomendado

### Adicionando uma Nova Carta:
1. Crie um novo `CardEffect` (ex: `HealEffect.gd`) em `cards/logic/`
2. No editor Godot, crie um `CardData.tres` em `cards/data/`
3. Configure nome, custo, ícone
4. Arraste o `HealEffect` para o array `effects`
5. A carta está pronta para uso!

### Adicionando um Novo Estado de Batalha:
1. Crie `NovoEstado.gd` em `combat/fsm/`
2. Herde de `BattleState`
3. Implemente `enter()`, `exit()`, `update()`
4. Adicione ao dicionário de estados no `BattleManager._initialize_fsm()`

### Depurando um Bug:
1. Coloque breakpoints no VS Code (F9)
2. Inicie depuração (F5) - o Godot abrirá automaticamente
3. Execute o jogo no Godot
4. O VS Code pausará nos breakpoints

---

## 📦 Dependências e Extensões

### Extensões VS Code Essenciais:
- **godot-tools** (geequlim): LSP, depuração, preview de cenas

### Ferramentas Externas (Futuro):
- **Aseprite**: Criação de pixel art
- **ComfyUI**: Geração de arte com IA
- **GodotSteam**: Integração com Steam

---

## 🚀 Próximos Passos

### Sistemas a Implementar:
1. **Geração de Mapa** (Algoritmo Slay the Spire)
   - DAG (Directed Acyclic Graph)
   - Garantia de conectividade
   - Tipos de salas (Combate, Elite, Loja, Fogueira)

2. **Sistema de Save**
   - Serialização do GameState
   - Criptografia básica (anti save-scumming)
   - Cloud save (Steam)

3. **Sistema de Relíquias**
   - Passivos que modificam comportamento
   - Aplicados via sinais (Event Bus)

4. **Polimento (Game Feel)**
   - Tweens para animações
   - Particle effects
   - Screen shake

---

## 📚 Referências Técnicas

- [Godot 4 Docs - Resources](https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Design Patterns in Godot - GDQuest](https://www.gdquest.com/tutorial/godot/design-patterns/)
- [Slay the Spire Map Generation Algorithm](https://steamcommunity.com/sharedfiles/filedetails/?id=2830078257)

---

**Última atualização**: Janeiro 2026  
**Versão do Projeto**: 0.1.0  
**Engine**: Godot 4.5.1
