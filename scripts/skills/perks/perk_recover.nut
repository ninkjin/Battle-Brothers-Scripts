// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_recover.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.recover";
    this.m.Name = this.Const.Strings.PerkName.Recover;
    this.m.Description = this.Const.Strings.PerkDescription.Recover;
    this.m.Icon = "ui/perks/perk_21.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.recover"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/recover_skill"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.recover");
    return;
}
