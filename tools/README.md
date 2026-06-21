# Decompiler Verification Tool

A Squirrel 3.0.4 bytecode decompiler for regenerating source scripts from Battle Brothers runtime memory.

## Requirements

- Battle Brothers running
- Python 3.8+
- Memory dump data (`final_dump/all_funcprotos_v2.json`)

## Usage

```bash
python decompiler_v3.py
```

Output goes to `decompiled_v3/scripts/`.

## What It Does

Reads `SQFunctionProto` bytecode objects directly from the game process memory (bypassing `.cnut` XOR encryption), then decompiles them into readable Squirrel source code with full control flow reconstruction.

## Stats

- 21,014 functions decompiled
- 3,071 source files reconstructed (v1.5.2.2)
- 0 goto statements, 0 brace mismatches
