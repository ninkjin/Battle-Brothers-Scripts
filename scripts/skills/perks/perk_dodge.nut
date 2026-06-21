// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_dodge.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.dodge";
    this.m.Name = this.Const.Strings.PerkName.Dodge;
    this.m.Description = this.Const.Strings.PerkDescription.Dodge;
    this.m.Icon = "ui/perks/perk_01.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onCombatStarted(this)
{
    this.getContainer().add(this.new("scripts/skills/effects/dodge_effect"));
    return;
}

function onRemoved(this)
{
    this.getContainer().removeByID("effects.dodge");
    return;
}
