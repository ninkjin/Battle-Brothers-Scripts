// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_underdog.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.underdog";
    this.m.Name = this.Const.Strings.PerkName.Underdog;
    this.m.Description = this.Const.Strings.PerkDescription.Underdog;
    this.m.Icon = "ui/perks/perk_21.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.SurroundedDefense = _properties.SurroundedDefense op43 5;
    return;
}
