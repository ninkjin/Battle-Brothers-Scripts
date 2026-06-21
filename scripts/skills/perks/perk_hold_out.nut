// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_hold_out.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.hold_out";
    this.m.Name = this.Const.Strings.PerkName.HoldOut;
    this.m.Description = this.Const.Strings.PerkDescription.HoldOut;
    this.m.Icon = "ui/perks/perk_04.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.NegativeStatusEffectDuration = _properties.NegativeStatusEffectDuration op43 -5;
    return;
}
