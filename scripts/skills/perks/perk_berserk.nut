// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_berserk.nut
// Functions: 5

function create(this)
{
    this.m.ID = "perk.berserk";
    this.m.Name = this.Const.Strings.PerkName.Berserk;
    this.m.Description = this.Const.Strings.PerkDescription.Berserk;
    this.m.Icon = "ui/perks/perk_35.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onCombatStarted(this)
{
    this.m.IsSpent = false;
    return;
}

function onTargetKilled(this, _targetEntity, _skill)
{
    if (this.getContainer().getActor().isAlliedWith(_targetEntity))
    {
        return;
    }
    if ((this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID() && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())))
    {
        return ((this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()) && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()));
        this.m.IsSpent = true;
        this.getContainer().getActor().setActionPoints(this.Math.min(this.getContainer().getActor().getActionPointsMax(), (this.getContainer().getActor().getActionPoints() + 4)));
        this.getContainer().getActor().setDirty(true);
        this.spawnIcon("perk_35", this.m.Container.getActor().getTile());
    }
    return;
}

function onTurnStart(this)
{
    this.m.IsSpent = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.TargetAttractionMult = _properties.TargetAttractionMult op42 1.100000023841858;
    return;
}
