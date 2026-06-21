// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_crippling_strikes.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.crippling_strikes";
    this.m.Name = this.Const.Strings.PerkName.CripplingStrikes;
    this.m.Description = this.Const.Strings.PerkDescription.CripplingStrikes;
    this.m.Icon = "ui/perks/perk_16.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.ThresholdToInflictInjuryMult = _properties.ThresholdToInflictInjuryMult op42 0.6600000262260437;
    return;
}
