// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_hex.nut
// Functions: 6

function calculateDanger(this, _entity, _targets)
{
    foreach (local key, value in r91)
    {
        if (this.isAllottedTimeReached(this.Time.getExactTime()))
        {
            yield this;
        }
        if ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)))
        {
            return ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones));
            if ((_entity.getTile().getDistanceTo(null.Actor.getTile() <= (null.Actor + this.Math)) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) <= (null.Actor + this.Math))))
            {
                return ((_entity.getTile().getDistanceTo(null.Actor.getTile()) <= (null.Actor + this.Math)) && (_entity.getTile().getDistanceTo(null.Actor.getTile()) <= (null.Actor + this.Math)));
            }
            if (((0.0 + 3.0) + this.getDangerFromActor(null.Actor, _entity.getTile(), _entity) > 1.0))
            {
            }
        }
        this.m.Danger = ((0.0 + 3.0) + this.getDangerFromActor(null.Actor, _entity.getTile(), _entity));
        return _entity;
    }
}

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Hex;
    this.m.Order = this.Const.AI.Behavior.Order.Hex;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function findBestTarget(this, _entity, _targets)
{
    foreach (local key, value in null)
    {
        foreach (local key, value in r193)
        {
            if (!this.m.Skill.isUsableOn(null.Actor.getTile()))
            {
            }
            else
            {
                if (null.Actor.getSkills().hasSkill("effects.hex_slave"))
                {
                }
                if (null.Actor.getHitpoints() <= (0 + null.getDamage()))
                {
                }
                if (null.Actor.isPlayerControlled())
                {
                    if (((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645)) && ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645))))
                    {
                        return (((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645)) && ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645)));
                    }
                }
                if ((null == ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645))) && (null == ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645)))))
                {
                    return ((null == ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645))) && (null == ((null.Actor.getArmorMax(this.Const.BodyPart.Body) + null.Actor.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.4000000059604645))));
                }
                if (null.Actor.getSkills().hasSkill("actives.indomitable"))
                {
                }
                if (this.isKindOf(null.Actor, "envoy") || this.isKindOf(null.Actor, "envoy"))
                {
                    return (this.isKindOf(null.Actor, "envoy") || this.isKindOf(null.Actor, "envoy"));
                }
                if ((!null.Actor.getSkills().hasSkill) && (!null.Actor.getSkills().hasSkill))
                {
                    return ((!null.Actor.getSkills().hasSkill) && (!null.Actor.getSkills().hasSkill));
                }
                if ((((((((((10.0 * (null.Actor.getHitpointsPct() * (100.0 / null.Actor.getHitpoints())) * (1.0 + (null.Actor.getLevel() * this.Const.AI.Behavior.HexCharacterLevelMult))) * this.Const.AI.Behavior.HexDOTCanKillMult) * this.Const.AI.Behavior.LikelyPlayerBaitMult) * 100.0) * this.Const.AI.Behavior.HexAgainstIndomitable) * this.Const.AI.Behavior.HexPreferPlayerMult) * this.Const.AI.Behavior.HexNotAGoodTargetMult) * null.Actor.getCurrentProperties().TargetAttractionMult) > 0.0))
                {
                }
                return _entity;
            }
        }
    }
}

function getDangerFromActor(this, _actor, _target, _entity)
{
    if ((this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2) && (this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2))
    {
        return ((this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2) && (this.queryActorTurnsNearTarget(_actor, _target, _entity).InZonesOfControl < 2));
        if (0.IsRooted && 0.IsRooted)
        {
            return (0.IsRooted && 0.IsRooted);
            return _actor;
        }
        return _actor;
    }
    return _actor;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.Danger = 0.0;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasKnownOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (resume this == null)
    {
        yield null;
    }
    if (this.m.Danger <= 1.0)
    {
        return _entity;
    }
    if (this.findBestTarget(_entity, this.getAgent().getKnownOpponents().Target == null))
    {
        return _entity;
    }
    this.m.TargetTile = this.findBestTarget(_entity, this.getAgent().getKnownOpponents()).Target.getTile();
    if (_entity.getAttackedCount() == 0)
    {
    }
    if (_entity.getSkills().hasSkillOfType(this.Const.SkillType.DamageOverTime))
    {
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(this.m.TargetTile);
        this.m.IsFirstExecuted = false;
        if ("IsFirstExecuted" && "IsFirstExecuted")
        {
            return ("IsFirstExecuted" && "IsFirstExecuted");
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        return _entity;
    }
    this.m.Skill.use(this.m.TargetTile);
    this.getAgent().declareEvaluationDelay(500);
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}
