// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/idle_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "idle_action";
    this.faction_action.create();
    return;
}

function onClear(this)
{
    return;
}

function onExecute(this, _faction)
{
    return;
}

function onUpdate(this, _faction)
{
    this.m.Score = 10;
    return;
}
