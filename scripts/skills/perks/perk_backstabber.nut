// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_backstabber.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.backstabber";
    this.m.Name = this.Const.Strings.PerkName.Backstabber;
    this.m.Description = this.Const.Strings.PerkDescription.Backstabber;
    this.m.Icon = "ui/perks/perk_40.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.SurroundedBonusMult = 2.0;
    return;
}
