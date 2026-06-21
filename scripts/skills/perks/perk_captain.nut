// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_captain.nut
// Functions: 1

function create(this)
{
    this.m.ID = "perk.captain";
    this.m.Name = this.Const.Strings.PerkName.Captain;
    this.m.Description = this.Const.Strings.PerkDescription.Captain;
    this.m.Icon = "ui/perks/perk_26.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}
