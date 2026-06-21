// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_mastery_throwing.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.mastery.throwing";
    this.m.Name = this.Const.Strings.PerkName.SpecThrowing;
    this.m.Description = this.Const.Strings.PerkDescription.SpecThrowing;
    this.m.Icon = "ui/perks/perk_10.png";
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
    if ((r9 == (r6 == _properties) && (r9 == (r6 == _properties))))
    {
        return ((r9 == (r6 == _properties)) && (r9 == (r6 == _properties)));
        if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile() <= 2))
        {
            _properties.DamageTotalMult = _properties.DamageTotalMult op42 1.2999999523162842;
        }
        else
        {
            if (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile() <= 3))
            {
                _properties.DamageTotalMult = _properties.DamageTotalMult op42 1.2000000476837158;
            }
        }
    }
    return;
}

function onUpdate(this, _properties)
{
    _properties.IsSpecializedInThrowing = true;
    return;
}
