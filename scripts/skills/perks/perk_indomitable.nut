// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_indomitable.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.indomitable";
    this.m.Name = this.Const.Strings.PerkName.Indomitable;
    this.m.Description = this.Const.Strings.PerkDescription.Indomitable;
    this.m.Icon = "ui/perks/perk_30.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.indomitable"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/indomitable"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.indomitable");
    return;
}
