// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_battering_ram.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.battering_ram";
    this.m.Name = this.Const.Strings.PerkName.BatteringRam;
    this.m.Description = this.Const.Strings.PerkDescription.BatteringRam;
    this.m.Icon = "skills/passive_03.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    _properties.IsImmuneToStun = true;
    return;
}
