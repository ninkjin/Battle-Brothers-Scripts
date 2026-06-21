// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_colossus.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.colossus";
    this.m.Name = this.Const.Strings.PerkName.Colossus;
    this.m.Description = this.Const.Strings.PerkDescription.Colossus;
    this.m.Icon = "ui/perks/perk_06.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (this.getContainer().getActor().getHitpoints() == this.getContainer().getActor().getHitpointsMax())
    {
        this.getContainer().getActor().setHitpoints(this.Math.floor((this.getContainer().getActor().getHitpoints() * 1.25)));
    }
    return;
}

function onUpdate(this, _properties)
{
    _properties.HitpointsMult = _properties.HitpointsMult op42 1.25;
    return;
}
