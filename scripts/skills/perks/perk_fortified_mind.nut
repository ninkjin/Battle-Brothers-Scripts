// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_fortified_mind.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.fortified_mind";
    this.m.Name = this.Const.Strings.PerkName.FortifiedMind;
    this.m.Description = this.Const.Strings.PerkDescription.FortifiedMind;
    this.m.Icon = "ui/perks/perk_08.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.BraveryMult = _properties.BraveryMult op42 1.25;
    return;
}
