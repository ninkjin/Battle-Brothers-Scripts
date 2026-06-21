// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_mastery_hammer.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.mastery.hammer";
    this.m.Name = this.Const.Strings.PerkName.SpecHammer;
    this.m.Description = this.Const.Strings.PerkDescription.SpecHammer;
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
    _properties.IsSpecializedInHammers = true;
    return;
}
