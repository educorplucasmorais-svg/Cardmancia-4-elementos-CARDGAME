# 🎮 Cardmancia: Os 4 Elementos - Guia de Reorganização

## ✅ Reorganização Concluída!

O projeto foi completamente reorganizado seguindo as melhores práticas de arquitetura **Modular Monolith** para Godot 4, conforme documentação técnica de desenvolvimento profissional.

---

## 📋 Mudanças Realizadas

### 1. ✅ Nova Estrutura de Pastas
Migração de organização por tipo → organização por funcionalidade:

```
Antes:                     Depois:
res/globals/          →    res/game/core/event_bus/
res/entities/         →    res/game/combat/enemies/ + res/game/player/character/
res/game/cards/       →    res/game/cards/ (reorganizada em logic/data/ui)
res/ui/managers/      →    res/game/combat/turn_system/ + res/game/player/character/
```

### 2. ✅ Configuração VS Code
Criados arquivos de configuração profissional:

- **`.vscode/launch.json`**: Depuração com portas corretas (LSP: 6005, DAP: 6006)
- **`.vscode/settings.json`**: Configurações de formatação e exclusões
- **`.vscode/extensions.json`**: Extensões recomendadas
- **`.cursorrules`**: Padrões de código para IA (Cursor/Copilot)

### 3. ✅ Atualização de Referências
Todos os caminhos foram atualizados:
- `project.godot`: SignalBus agora em `res://game/core/event_bus/`
- `Main.tscn`: BattleManager agora em `res://game/combat/turn_system/`
- Scripts internos: Comentários de cabeçalho atualizados

### 4. ✅ Documentação
- **`ARCHITECTURE.md`**: Nova documentação completa da arquitetura
- **`.cursorrules`**: Regras de código e padrões obrigatórios

---

## 🚀 Próximos Passos

### 1. Reabrir no Godot
```bash
# O Godot detectará automaticamente as mudanças
# Pode ser necessário reimportar recursos
```

### 2. Verificar Importações
No Godot Editor:
1. Abra o projeto
2. Aguarde o reimport automático dos arquivos movidos
3. Verifique se não há erros no Output

### 3. Testar o Jogo
1. Pressione F5 no Godot
2. O sistema de batalha deve funcionar normalmente
3. Verifique o console para logs

### 4. Configurar VS Code (Opcional mas Recomendado)
```bash
# 1. Instale a extensão godot-tools no VS Code
# 2. Abra a pasta do projeto no VS Code
# 3. No Godot: Editor > Editor Settings > Text Editor > External
#    - Exec Path: Caminho para code.cmd
#    - Exec Flags: {project} --goto {file}:{line}:{col}
```

---

## 🔧 Possíveis Ajustes Necessários

### Se houver erros de "File not found":
1. Abra os arquivos mencionados no erro
2. Atualize os caminhos de `load()` ou `preload()` para refletir a nova estrutura
3. Use busca global (Ctrl+Shift+F) para encontrar referências antigas

### Se o depurador VS Code não conectar:
1. Verifique se o caminho do Godot está correto em `.vscode/settings.json`
2. No Godot: Editor > Editor Settings > Network > Language Server
   - Confirme que Remote Port = 6005
3. Reinicie ambos (Godot e VS Code)

---

## 📚 Arquivos de Referência

| Arquivo | Propósito |
|---------|-----------|
| `ARCHITECTURE.md` | Documentação completa da arquitetura |
| `.cursorrules` | Padrões de código para IA |
| `.vscode/launch.json` | Configuração de depuração |
| `ARCHITECTURE_OLD.md` | Documentação anterior (backup) |

---

## 🎯 Benefícios da Nova Estrutura

### Para Desenvolvimento:
- ✅ Mais fácil encontrar arquivos relacionados
- ✅ Menos conflitos em merge (Git)
- ✅ IntelliSense melhorado (VS Code)
- ✅ Depuração mais eficiente

### Para Escalabilidade:
- ✅ Adicionar novos módulos sem bagunçar estrutura
- ✅ Testar módulos isoladamente
- ✅ Refatorar sem quebrar dependências

### Para Manutenção:
- ✅ Código organizado por domínio (cartas, combate, mapa)
- ✅ Documentação atualizada
- ✅ Padrões de projeto documentados

---

**Reorganização realizada em**: Janeiro 2026  
**Próxima milestone**: Implementar geração de mapa roguelike
