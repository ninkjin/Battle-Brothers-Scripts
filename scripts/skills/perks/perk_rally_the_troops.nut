// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_rally_the_troops.nut
// Functions: 4

function create(this)
{
    this.m.ID = "perk.rally_the_troops";
    this.m.Name = this.Const.Strings.PerkName.RallyTheTroops;
    this.m.Description = this.Const.Strings.PerkDescription.RallyTheTroops;
    this.m.Icon = "ui/perks/perk_42.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.rally_the_troops"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/rally_the_troops"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.rally_the_troops");
    return;
}

function onUpdate(this, _properties)
{
    _properties.TargetAttractionMult = _properties.TargetAttractionMult op42 1.3300000429153442;
    return;
}
