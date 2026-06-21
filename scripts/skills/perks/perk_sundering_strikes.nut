// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_sundering_strikes.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.sundering_strikes";
    this.m.Name = this.Const.Strings.PerkName.SunderingStrikes;
    this.m.Description = this.Const.Strings.PerkDescription.SunderingStrikes;
    this.m.Icon = "ui/perks/perk_12.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.20000000298023224;
    return;
}
