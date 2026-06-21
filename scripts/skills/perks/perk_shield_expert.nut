// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_shield_expert.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.shield_expert";
    this.m.Name = this.Const.Strings.PerkName.ShieldExpert;
    this.m.Description = this.Const.Strings.PerkDescription.ShieldExpert;
    this.m.Icon = "ui/perks/perk_05.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.IsSpecializedInShields = true;
    return;
}
