# 🎴 Guia de Imagens das Cartas - Cardmancia

## 📁 Estrutura de Pastas para Imagens

Coloque suas imagens de cartas nas seguintes pastas:

```
res/assets/cards/
├── spades/          # Espadas (Ar) - Cor Ciano
│   ├── ace.png      # Ás de Espadas
│   ├── 2.png        # 2 de Espadas
│   ├── 3.png        # 3 de Espadas
│   └── ...
├── hearts/          # Copas (Água) - Cor Azul
│   ├── ace.png      # Ás de Copas
│   ├── 2.png        # 2 de Copas
│   └── ...
├── clubs/           # Paus (Fogo) - Cor Vermelha
│   ├── ace.png      # Ás de Paus
│   ├── 2.png        # 2 de Paus
│   └── ...
└── diamonds/        # Ouros (Terra) - Cor Amarela
    ├── ace.png      # Ás de Ouros
    ├── 2.png        # 2 de Ouros
    └── ...
```

## 📐 Especificações das Imagens

- **Formato recomendado**: PNG com transparência
- **Resolução recomendada**: 256x384 pixels (proporção 2:3)
- **Resolução mínima**: 128x192 pixels
- **Resolução máxima**: 512x768 pixels

## 🔗 Vinculando Imagens às Cartas

### No Editor do Godot:

1. Abra o arquivo `.tres` da carta (ex: `card_ace_spades.tres`)
2. No inspetor, encontre o campo `art`
3. Arraste a imagem da pasta `assets/cards/` para o campo

### Por Código (CardData.gd):

```gdscript
# Carregando imagem programaticamente
var card = load("res://res/game/cards/data/card_ace_spades.tres")
card.art = load("res://res/assets/cards/spades/ace.png")
```

## 🎨 Convenção de Nomes

| Carta | Nome do Arquivo |
|-------|-----------------|
| Ás    | `ace.png`       |
| 2     | `2.png`         |
| 3     | `3.png`         |
| ...   | ...             |
| 10    | `10.png`        |
| Valete| `jack.png`      |
| Dama  | `queen.png`     |
| Rei   | `king.png`      |

## 🌈 Cores dos Elementos

| Elemento | Naipe    | Cor Principal       | Código Hex |
|----------|----------|---------------------|------------|
| Fogo     | Paus     | Vermelho            | `#E64D1A`  |
| Água     | Copas    | Azul                | `#3380E6`  |
| Terra    | Ouros    | Amarelo/Dourado     | `#CCB333`  |
| Ar       | Espadas  | Ciano               | `#66CCE6`  |

## 📝 Exemplo de Arquivo .tres com Imagem

```tres
[gd_resource type="Resource" load_steps=5 format=3]

[ext_resource type="Script" path="res://res/game/cards/core/CardData.gd" id="1_carddata"]
[ext_resource type="Script" path="res://res/game/cards/effects/DamageEffect.gd" id="2_effect"]
[ext_resource type="Resource" path="res://res/game/core/data/elements/Fire.tres" id="3_element"]
[ext_resource type="Texture2D" path="res://res/assets/cards/clubs/ace.png" id="4_art"]

[resource]
script = ExtResource("1_carddata")
id = "card_ace_clubs"
title = "Ás de Paus"
element = ExtResource("3_element")
art = ExtResource("4_art")
cost = 2
...
```

## 🚀 Próximos Passos

1. Adicione suas imagens nas pastas correspondentes
2. Abra o Godot e deixe ele importar os assets
3. Vincule as imagens aos arquivos `.tres` das cartas
4. Execute a cena `CardPreview.tscn` para ver o resultado!
