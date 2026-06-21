// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_footwork.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.footwork";
    this.m.Name = this.Const.Strings.PerkName.Footwork;
    this.m.Description = this.Const.Strings.PerkDescription.Footwork;
    this.m.Icon = "ui/perks/perk_25.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.footwork"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/footwork"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.footwork");
    return;
}
