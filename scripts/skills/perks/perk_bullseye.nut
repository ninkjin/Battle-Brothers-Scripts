// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_bullseye.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.bullseye";
    this.m.Name = this.Const.Strings.PerkName.Bullseye;
    this.m.Description = this.Const.Strings.PerkDescription.Bullseye;
    this.m.Icon = "ui/perks/perk_17.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.RangedAttackBlockedChanceMult = _properties.RangedAttackBlockedChanceMult op42 0.6600000262260437;
    return;
}
