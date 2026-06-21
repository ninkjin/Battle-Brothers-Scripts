// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_mastery_spear.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.mastery.spear";
    this.m.Name = this.Const.Strings.PerkName.SpecSpear;
    this.m.Description = this.Const.Strings.PerkDescription.SpecSpear;
    this.m.Icon = "ui/perks/perk_10.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.IsSpecializedInSpears = true;
    return;
}
