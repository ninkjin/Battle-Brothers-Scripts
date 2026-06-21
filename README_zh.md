# Battle Brothers 游戏脚本源码

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[English](README.md)

**Battle Brothers** 完整 Squirrel 脚本源码，可直接用于 Mod 制作。

## 包含内容

**3,084 个脚本文件**，覆盖全部游戏逻辑：

| 目录 | 文件数 | 内容 |
|------|--------|------|
| `scripts/items/` | 743 | 武器、护甲、消耗品、掉落物 |
| `scripts/skills/` | 642 | 特性、技能、状态效果 |
| `scripts/entity/` | 487 | 角色、生物、背景 |
| `scripts/events/` | 429 | 世界事件、遭遇、对话 |
| `scripts/mapgen/` | 148 | 地图生成、地点 |
| `scripts/factions/` | 113 | 阵营、外交、AI 策略 |
| `scripts/ai/` | 177 | 战术 AI、行为、代理 |
| `scripts/crafting/` | 63 | 制作配方、材料 |
| `scripts/ambitions/` | 63 | 野心系统 |
| `scripts/contracts/` | 54 | 任务、合同 |
| `scripts/ui/` | 54 | UI 界面和模块 |
| `scripts/scenarios/` | 38 | 开局场景 |
| 其他 | 72 | 配置、镜头、状态、工具 |

## 如何制作 Mod

1. 从 `scripts/` 中找到你要修改的脚本
2. 创建一个 zip 文件，保持相同的 `scripts/` 目录结构
3. 把 zip 放到 `<Battle Brothers>/data/` 目录下

例如，修改剑的伤害：

```
my_mod.zip
└── scripts/
    └── items/
        └── weapons/
            └── weapon.nut    ← 你编辑后的文件
```

游戏启动时会加载 `data/` 目录下所有 zip 文件。你的 Mod 脚本会按相同路径覆盖原版脚本。

## 说明

- 标有 `// Decompiled from Battle Brothers memory` 的脚本是从字节码反编译的，变量名基于寄存器（`r45`、`r46`）。
- 来自中文翻译 Mod 的脚本是原始源码，变量名可读。
- 所有脚本来自 Battle Brothers **v1.5.2.2** 版本（2025年6月最新版）。

## 验证工具

`tools/` 文件夹包含一个反编译器，用于从游戏内存重新生成脚本。**制作 Mod 不需要这个工具**，仅用于确认脚本与运行中的游戏一致。详见 [tools/README.md](tools/README.md)。

## 许可证

[MIT](LICENSE)
