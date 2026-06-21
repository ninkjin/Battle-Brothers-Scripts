// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/racial/serpent_racial.nut
// Functions: 4

function create(this)
{
    this.m.ID = "racial.serpent";
    this.m.Name = "Description";
    this.m.Icon = "Description";
    this.m.Type = "Description";
    this.m.Const = ((this.SkillType.Racial.Perk | this.SkillType.Racial.StatusEffect) | this.SkillType.Racial.Order);
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    this.m["k[18]"] = true;
    return;
}

function onBeforeDamageReceived(this, _attacker, _skill, _hitInfo, _properties)
{
    if (_skill == null)
    {
        return;
    }
    if ((_skill == _skill) && (_skill == _skill))
    {
        return ((_skill == _skill) && (_skill == _skill));
        _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.6600000262260437;
    }
    return;
}

function onRoundEnd(this)
{
    this.getContainer().update();
    return;
}

function onUpdate(this, _properties)
{
    _properties.DamageReceivedFireMult = _properties.DamageReceivedFireMult op42 0.6600000262260437;
    if (this.getContainer().getActor().getTile().hasZoneOfOccupationOtherThan(this.getContainer().getActor().getAlliedFactions()))
    {
        return;
    }
    if (this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Idle).queryTargetsInMeleeRange(2, 3).len() == 0)
    {
        return;
    }
    foreach (local key, value in r15)
    {
        if (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions() <= 1))
        {
        }
        if (!true)
        {
            return;
        }
        _properties.InitiativeForTurnOrderAdditional = _properties.InitiativeForTurnOrderAdditional op43 15;
        return;
    }
}
