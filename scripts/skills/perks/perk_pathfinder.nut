// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_pathfinder.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.pathfinder";
    this.m.Name = this.Const.Strings.PerkName.Pathfinder;
    this.m.Description = this.Const.Strings.PerkDescription.Pathfinder;
    this.m.Icon = "ui/perks/perk_23.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    this.getContainer().getActor().m.ActionPointCosts = this.Const.PathfinderMovementAPCost;
    this.getContainer().getActor().m.FatigueCosts = clone this;
    this.getContainer().getActor().m.LevelActionPointCost = 0;
    return;
}
