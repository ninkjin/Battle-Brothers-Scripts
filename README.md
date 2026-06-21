# Battle Brothers Source Scripts

[中文说明](README_zh.md)

Complete Squirrel script source code for **Battle Brothers**, ready for modding.

## What's Included

**3,084 script files** covering the entire game logic:

| Directory | Files | Content |
|-----------|-------|---------|
| `scripts/items/` | 743 | Weapons, armor, consumables, loot |
| `scripts/skills/` | 642 | Perks, abilities, status effects |
| `scripts/entity/` | 487 | Characters, creatures, backgrounds |
| `scripts/events/` | 429 | World events, encounters, dialogues |
| `scripts/mapgen/` | 148 | Map generation, locations |
| `scripts/factions/` | 113 | Factions, diplomacy, AI strategy |
| `scripts/ai/` | 177 | Tactical AI, behaviors, agents |
| `scripts/crafting/` | 63 | Crafting recipes, materials |
| `scripts/ambitions/` | 63 | Ambition system |
| `scripts/contracts/` | 54 | Quests, contracts |
| `scripts/ui/` | 54 | UI screens and modules |
| `scripts/scenarios/` | 38 | Starting scenarios |
| Other | 72 | Config, camera, states, tools |

## How to Make a Mod

1. Pick the script(s) you want to modify from `scripts/`
2. Create a zip file with the same `scripts/` folder structure
3. Place the zip in `<Battle Brothers>/data/`

Example — to modify sword damage:

```
my_mod.zip
└── scripts/
    └── items/
        └── weapons/
            └── weapon.nut    ← your edited file
```

The game loads all zip files from `data/` on startup. Your mod's scripts override the originals at the same path.

## Notes

- Scripts marked `// Decompiled from Battle Brothers memory` were reverse-engineered from bytecode. Variable names are register-based (`r45`, `r46`).
- Scripts from the Chinese translation mod are original source code with readable variable names.
- All scripts are from Battle Brothers **v1.5.2.2** (latest as of June 2025).

## Verification Tool

The `tools/` folder contains a decompiler for regenerating the scripts from game memory. **Not needed for modding** — only for verifying scripts match the running game. See [tools/README.md](tools/README.md).
