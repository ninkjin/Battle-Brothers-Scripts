// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_taunt.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.taunt";
    this.m.Name = this.Const.Strings.PerkName.Taunt;
    this.m.Description = this.Const.Strings.PerkDescription.Taunt;
    this.m.Icon = "ui/perks/perk_38.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.taunt"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/taunt"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.taunt");
    return;
}
