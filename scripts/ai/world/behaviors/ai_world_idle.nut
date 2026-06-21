// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/world/behaviors/ai_world_idle.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.World.AI.Behavior.ID.Idle;
    this.world_behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    return _entity;
}

function onExecute(this, _entity, _hasChanged)
{
    this.getController().setFinished(true);
    return _entity;
}
