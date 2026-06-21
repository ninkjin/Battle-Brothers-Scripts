// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_adrenalin.nut
// Functions: 4

function create(this)
{
    this.m.ID = "perk.adrenaline";
    this.m.Name = this.Const.Strings.PerkName.Adrenaline;
    this.m.Description = this.Const.Strings.PerkDescription.Adrenaline;
    this.m.Icon = "ui/perks/perk_37.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.Container.hasSkill("actives.adrenaline"))
    {
        this.m.Container.add(this.new("scripts/skills/actives/adrenaline_skill"));
    }
    return;
}

function onRemoved(this)
{
    this.m.Container.removeByID("actives.adrenaline");
    return;
}

function onUpdate(this, _properties)
{
    _properties.TargetAttractionMult = _properties.TargetAttractionMult op42 1.100000023841858;
    return;
}
