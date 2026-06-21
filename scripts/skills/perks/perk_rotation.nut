// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_rotation.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.rotation";
    this.m.Name = this.Const.Strings.PerkName.Rotation;
    this.m.Description = this.Const.Strings.PerkDescription.Rotation;
    this.m.Icon = "ui/perks/perk_11.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.rotation"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/rotation"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.rotation");
    return;
}
