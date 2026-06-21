// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_student.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.student";
    this.m.Name = this.Const.Strings.PerkName.Student;
    this.m.Description = this.Const.Strings.PerkDescription.Student;
    this.m.Icon = "ui/perks/perk_21.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    if (this.getContainer().getActor().getLevel() < 11)
    {
        _properties.XPGainMult = _properties.XPGainMult op42 1.2000000476837158;
    }
    return;
}
