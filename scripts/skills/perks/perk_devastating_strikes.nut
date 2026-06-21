// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_devastating_strikes.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.devastating_strikes";
    this.m.Name = this.Const.Strings.PerkName.DevastatingStrikes;
    this.m.Description = this.Const.Strings.PerkDescription.DevastatingStrikes;
    this.m.Icon = "skills/passive_03.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.DamageTotalMult = _properties.DamageTotalMult op42 1.2000000476837158;
    return;
}
