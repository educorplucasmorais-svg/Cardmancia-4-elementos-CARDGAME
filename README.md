# 🎴 Cardmancia: Os 4 Elementos

<div align="center">

**Um Roguelike Deckbuilder Pixel Art inspirado em Slay the Spire**

*Domine os 4 Elementos através de cartas estratégicas*

[![Godot Engine](https://img.shields.io/badge/Godot-4.5.1-blue.svg)](https://godotengine.org/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

</div>

---

## 🎮 Sobre o Jogo

**Cardmancia** é um jogo de cartas roguelike onde você controla os 4 elementos primordiais (Fogo 🔥, Água 💧, Terra 🌍, Ar 💨) para derrotar inimigos em combates táticos baseados em turnos.

### ✨ Características

- 🎨 **Arte Pixel Art** - Visual retrô e charmoso
- 🃏 **Sistema de Cartas Modular** - Command Pattern para efeitos flexíveis
- 🎲 **Geração Procedural** - Mapas únicos a cada run
- 🔄 **Elementos Interativos** - Combos entre elementos
- 📈 **Progressão** - Desbloqueie cartas e relíquias

---

## 🚀 Como Jogar

### Requisitos
- **Godot 4.5.1** ou superior
- Windows 10/11, Linux, ou macOS

### Instalação - Desenvolvimento

1. Clone o repositório:
```bash
git clone https://github.com/educorplucasmorais-svg/Cardmancia-4-elementos-CARDGAME.git
cd Cardmancia-4-elementos-CARDGAME
```

2. Abra o projeto no Godot 4.5.1

3. Pressione **F5** para jogar!

### Instalação - VS Code

Para desenvolvimento com VS Code:

1. Instale a extensão **godot-tools**
2. Configure o caminho do Godot em `.vscode/settings.json`
3. Use **F5** no VS Code para depurar

---

## 🏗️ Arquitetura

O projeto segue o padrão **Modular Monolith**:

```
res/game/
├── core/          # Sistemas globais (SignalBus, SaveManager)
├── cards/         # Sistema de cartas (dados, lógica, UI)
├── combat/        # Sistema de batalha e turnos
├── map/           # Geração procedural de mapas
└── player/        # Personagem e progressão
```

**Padrões de Projeto:**
- 🚌 **Event Bus** - Comunicação desacoplada via SignalBus
- 🤖 **State Machine** - Gerenciamento de turnos (FSM)
- ⚡ **Command Pattern** - Efeitos de cartas modulares
- 📦 **Data-Oriented** - Resources para dados de jogo

Veja [ARCHITECTURE.md](ARCHITECTURE.md) para detalhes completos.

---

## 🎴 Sistema de Elementos

| Elemento | Cor | Especialidade | Fraqueza |
|----------|-----|---------------|----------|
| 🔥 Fogo  | Vermelho | Dano alto | Água |
| 💧 Água  | Azul | Cura/Escudo | Terra |
| 🌍 Terra | Marrom | Defesa | Ar |
| 💨 Ar    | Branco | Velocidade | Fogo |

**Combos Elementais:**
- Fogo + Ar = Explosão (dano em área)
- Água + Terra = Lama (diminui velocidade)
- Fogo + Água = Vapor (escudo temporário)

---

## 📋 Status do Desenvolvimento

### ✅ Implementado (v0.1.0)
- [x] Menu principal pixel art
- [x] Sistema de combate básico
- [x] FSM de turnos
- [x] Sistema de cartas com Command Pattern
- [x] SignalBus para comunicação
- [x] Configuração VS Code profissional

### 🚧 Em Progresso
- [ ] Sistema de elementos
- [ ] Geração de mapa roguelike
- [ ] Arte de cartas pixel art
- [ ] Efeitos visuais (VFX)

### 📅 Planejado
- [ ] Sistema de relíquias
- [ ] Save/Load
- [ ] Mais 50+ cartas
- [ ] 3 chefes únicos
- [ ] Steam integration

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Add: MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

---

## 📚 Documentação

- [📐 Arquitetura do Projeto](ARCHITECTURE.md)
- [🎯 Guia de Desenvolvimento](.cursorrules)
- [🔧 Configuração VS Code](.vscode/)

---

## 📜 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🙏 Agradecimentos

- **Godot Engine** - Engine incrível e open-source
- **Slay the Spire** - Inspiração de gameplay
- **Everything is Crab** - Inspiração visual pixel art

---

<div align="center">

**Feito com ❤️ e ☕ por Lucas Morais**

[GitHub](https://github.com/educorplucasmorais-svg) • [Itch.io](#) • [Discord](#)

</div>
