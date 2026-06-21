// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_coup_de_grace.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.coup_de_grace";
    this.m.Name = this.Const.Strings.PerkName.CoupDeGrace;
    this.m.Description = this.Const.Strings.PerkDescription.CoupDeGrace;
    this.m.Icon = "ui/perks/perk_16.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_targetEntity == null)
    {
        return;
    }
    if (_skill && _skill)
    {
        return (_skill && _skill);
        _properties.DamageTotalMult = _properties.DamageTotalMult op42 1.2000000476837158;
    }
    return;
}

function onBeforeTargetHit(this, _skill, _targetEntity, _hitInfo)
{
    if (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
    {
        return (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury));
        this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
    }
    return;
}
