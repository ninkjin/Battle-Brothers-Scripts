// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_brawny.nut
// Functions: 1

function create(this)
{
    this.m.ID = "perk.brawny";
    this.m.Name = this.Const.Strings.PerkName.Brawny;
    this.m.Description = this.Const.Strings.PerkDescription.Brawny;
    this.m.Icon = "ui/perks/perk_40.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}
