// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_fearsome.nut
// Functions: 5

function create(this)
{
    this.m.ID = "perk.fearsome";
    this.m.Name = this.Const.Strings.PerkName.Fearsome;
    this.m.Description = this.Const.Strings.PerkDescription.Fearsome;
    this.m.Icon = "ui/perks/perk_27.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAfterUpdate(this, _properties)
{
    _properties.ThreatOnHit = _properties.ThreatOnHit op43 this.Math.min(20, this.Math.max(0, (_properties.getBravery() * 0.15000000596046448)));
    return;
}

function onCombatFinished(this)
{
    this.skill.onCombatFinished();
    this.m.SkillCount = 0;
    this.m.LastEnemyAppliedTo = 0;
    this.m.LastFrameApplied = 0;
    return;
}

function onCombatStarted(this)
{
    this.m.SkillCount = 0;
    this.m.LastEnemyAppliedTo = 0;
    this.m.LastFrameApplied = 0;
    return;
}

function onTargetHit(this, _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
{
    if ((!r7) && (!r7))
    {
        return ((!r7) && (!r7));
    }
    if ((!this.Const.MoraleState.Ignore.IsAffectedByLosingHitpoints) && (!this.Const.MoraleState.Ignore.IsAffectedByLosingHitpoints))
    {
        return ((!this.Const.MoraleState.Ignore.IsAffectedByLosingHitpoints) && (!this.Const.MoraleState.Ignore.IsAffectedByLosingHitpoints));
    }
    if (((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo) && ((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo) && ((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo))
    {
        return (((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo) && ((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo) && ((this.m.SkillCount == this.Const.SkillCounter) == this.m.LastEnemyAppliedTo));
        if (_damageInflictedHitpoints >= this.Const.Morale.OnHitMinDamage)
        {
            this.spawnIcon("perk_27", _targetEntity.getTile());
        }
        return;
    }
    if (_damageInflictedHitpoints >= 1)
    {
        this.spawnIcon("perk_27", _targetEntity.getTile());
    }
    this.m.LastFrameApplied = this.Time.getFrame();
    this.m.LastEnemyAppliedTo = _targetEntity.getID();
    this.m.SkillCount = this.Const.SkillCounter;
    if ((_damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage) && (_damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage))
    {
        return ((_damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage) && (_damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage));
        _targetEntity.checkMorale(-1, ((this.Const.Morale.OnHitBaseDifficulty * (1.0 - (_targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()))) - this.getContainer().getActor().getCurrentProperties().ThreatOnHit));
    }
    return;
}
