// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behavior.nut
// Functions: 41

function clamp(this, _a, _min, _max)
{
    if (_a < _min)
    {
    }
    else
    {
        if (_min > _max)
        {
        }
    }
    return _max;
}

function create(this)
{
    return;
}

function evaluate(this, _entity)
{
    if (this.getProperties().BehaviorMult["this.m.ID"] == 0)
    {
        this.m.Score = 0;
        return _entity;
    }
    this.m.IsFirstExecuted = true;
    if (this.m.IsThreaded)
    {
        if (this.m.Thread == null)
        {
            this.m.Thread = this.onEvaluate(_entity);
        }
        if ((resume this < 10) && (resume this < 10))
        {
            return ((resume this < 10) && (resume this < 10));
        }
        if ((!(resume this < 10) && (!(resume this < 10))))
        {
            return ((!(resume this < 10)) && (!(resume this < 10)));
            this.logInfo(((((("[] Evaluating " + this.Const.AI.Behavior.Name["this.getID()"]) + " took ") + (this.Time.getExactTime() - this.Time.getExactTime())) + " seconds. Frame: ") + this.Time.getFrame()));
        }
        if (10 != null)
        {
            this.m.Thread = null;
            this.m.Score = 10;
            return _entity;
        }
    }
    this.m.Score = this.onEvaluate(_entity);
    if ((this.m.Score < 10) && (this.m.Score < 10))
    {
        return ((this.m.Score < 10) && (this.m.Score < 10));
        this.m.Score = 10;
    }
    if ((!"Score") && (!"Score"))
    {
        return ((!"Score") && (!"Score"));
        this.logInfo(((((("[] Evaluating " + this.Const.AI.Behavior.Name["this.getID()"]) + " took ") + (this.Time.getExactTime() - this.Time.getExactTime())) + " seconds. Frame: ") + this.Time.getFrame()));
    }
    return _entity;
    return _entity;
}

function execute(this, _entity)
{
    return this.onExecute(_entity);
    return _entity;
}

function getAgent(this)
{
    return this.m.Agent;
}

function getFatigueScoreMult(this, _skill)
{
    if (this.getAgent().getActor().getCurrentProperties().FatigueEffectMult == 0.0)
    {
        return _skill;
    }
    return _skill;
}

function getID(this)
{
    return this.m.ID;
}

function getName(this)
{
    return this.Const.AI.Behavior.Name["this.m.ID"];
}

function getOrder(this)
{
    return this.m.Order;
}

function getPotentialDanger(this, _includeRanged)
{
    foreach (local key, value in r88)
    {
        if ((!null.Actor) && (!null.Actor))
        {
            return ((!null.Actor) && (!null.Actor));
        }
        if ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones)))
        {
            return ((null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones) && (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) < this.Const.AI.Behavior.IgnoreDangerMinZones));
            [].push(null.Actor.get());
        }
        return _includeRanged;
    }
}

function getProperties(this)
{
    return this.m.Agent.getProperties();
    return this.m.Agent.getProperties;
}

function getScore(this)
{
    return this.m.Score;
}

function getStrategy(this)
{
    return this.Tactical.Entities.getStrategy(this.m.Agent.getActor().getFaction());
    return this.Tactical.Entities.getStrategy;
}

function hasNegativeTileEffect(this, _tile, _entity)
{
    return;
}

function interpolate(this, _a, _b, _f)
{
    return _a;
}

function isAllottedTimeReached(this, _t)
{
    return;
}

function isRangedUnit(this, _entity)
{
    if (_entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit)
    {
        return (_entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit && _entity.getAIAgent().getProperties().IsRangedUnit);
        return _entity;
    }
    return _entity;
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    return _entity;
}

function onExecute(this, _entity)
{
    return _entity;
}

function onQueryAllyInMeleeRange(this, _actor, _tag)
{
    if ((!_actor) && (!_actor))
    {
        return ((!_actor) && (!_actor));
    }
    if ((!_actor) && (!_actor))
    {
        return ((!_actor) && (!_actor));
    }
    if (this.Math.abs((_actor.getTile().Level - _tag.Actor.getTile().Level) > 1))
    {
        return;
    }
    _tag.Targets.push(_actor);
    return;
}

function onQueryDestinationInMeleeRange(this, _tile, _tag)
{
    if (this.Math.abs((_tile.Level - _tag.TargetTile.Level) > 1))
    {
        return;
    }
    _tag.Destinations.push(_tile);
    return;
}

function onQueryDestinationInRange(this, _tile, _tag)
{
    _tag.Destinations.push(_tile);
    return;
}

function onQueryEnemyInMeleeRange(this, _actor, _tag)
{
    if ((!_actor) && (!_actor))
    {
        return ((!_actor) && (!_actor));
    }
    if (_actor && _actor)
    {
        return (_actor && _actor);
    }
    if (this.Math.abs((_actor.getTile().Level - _tag.Actor.getTile().Level) > 1))
    {
        return;
    }
    _tag.Targets.push(_actor);
    return;
}

function onQueryTargetInMeleeRange(this, _actor, _tag)
{
    if ((!_actor) && (!_actor))
    {
        return ((!_actor) && (!_actor));
    }
    if (_actor && _actor)
    {
        return (_actor && _actor);
    }
    if (this.Math.abs((_actor.getTile().Level - _tag.Actor.getTile().Level) > _tag.LevelDifference))
    {
        return;
    }
    _tag.Targets.push(_actor);
    return;
}

function onReset(this)
{
    this.m.IsShieldwallAvailable = null;
    return;
}

function onTurnResumed(this)
{
    return;
}

function onTurnStarted(this)
{
    return;
}

function queryActorTurnsNearTarget(this, _actor, _target, _entity)
{
    if (_actor.isNonCombatant())
    {
        return _actor;
    }
    if (_actor.getTile().getDistanceTo(_target) <= 1)
    {
        {}.Turns = 0.0;
        {}.TurnsWithAttack = 0.0;
        return _actor;
    }
    else
    {
        if (_actor.getTile().getDistanceTo(_target) >= 10)
        {
            return _actor;
        }
    }
    this.Tactical.getNavigator().createSettings().ActionPointCosts = _actor.getActionPointCosts();
    this.Tactical.getNavigator().createSettings().ActionPointCostPerLevel = _actor.getLevelActionPointCost();
    this.Tactical.getNavigator().createSettings().FatigueCostFactor = 0.0;
    this.Tactical.getNavigator().createSettings().AllowZoneOfControlPassing = true;
    this.Tactical.getNavigator().createSettings().ZoneOfControlCost = 2;
    this.Tactical.getNavigator().createSettings().AlliedFactions = _actor.getAlliedFactions();
    this.Tactical.getNavigator().createSettings().Faction = _actor.getFaction();
    this.Tactical.getNavigator().createSettings().TileToConsiderEmpty = _entity.getTile();
    if (this.Tactical.getNavigator().findPath(_actor.getTile(), _target, this.Tactical.getNavigator().createSettings(), 1))
    {
        {}.Turns = this.Tactical.getNavigator().getTurnsRequiredForPath(_actor, this.Tactical.getNavigator().createSettings(), _actor.getActionPointsMax(), _entity.getTile(), _entity.getFaction());
        {}.TurnsWithAttack = ({}.Turns + ((1.0 / this.Math.maxf(1.0, _actor.getActionPointsMax())) * 4));
        return _actor;
    }
    return _actor;
}

function queryAlliesInMeleeRange(this, _minRange, _maxRange, _for)
{
    if (_for != null)
    {
    }
    this.Tactical.queryActorsInRange(this.getAgent().getActor().getTile(), _minRange, _maxRange, this.onQueryAllyInMeleeRange, {});
    return _minRange;
}

function queryAllyMagnitude(this, _tile, _maxDistance)
{
    foreach (local key, value in r69)
    {
        if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
        {
        }
        if (null.getTile().getDistanceTo(_tile) <= (_maxDistance * 1.0))
        {
            {}.Allies = {}.Allies op43 1.0;
            {}.AverageDistanceScore = {}.AverageDistanceScore op43 (1.0 - ((null.getTile().getDistanceTo(_tile) - 1) / (_maxDistance * 1.0)));
            {}.Magnetism = {}.Magnetism op43 (null.getAIAgent().getProperties().OverallMagnetismMult * null.getCurrentProperties().TargetAttractionMult);
            if (!null.isArmedWithRangedWeapon())
            {
                if (null.getAIAgent().getOrders && null.getAIAgent().getOrders)
                {
                    return (null.getAIAgent().getOrders && null.getAIAgent().getOrders);
                }
            }
        }
        if ({}.Allies != 0)
        {
            {}.AverageDistanceScore = {}.AverageDistanceScore op47 {}.Allies;
            {}.AverageEngaged = {}.AverageEngaged op47 this.Math.max(1, (0 + 4));
            {}.AverageMagnetism = ({}.Magnetism / {}.Allies);
        }
        return _tile;
    }
}

function queryBestMeleeTarget(this, _entity, _skill, _targets)
{
    foreach (local key, value in r26)
    {
        if ((!r11) && (!r11))
        {
            return ((!r11) && (!r11));
        }
        if (this.queryTargetValue(_entity, null, _skill) > -9000)
        {
        }
        if (null != null)
        {
            {}.Score = this.queryTargetValue(_entity, null, _skill);
            {}.Target = null;
        }
        return _entity;
    }
}

function queryBestRangedTarget(this, _entity, _skill, _targets, _maxRange)
{
    foreach (local key, value in r174)
    {
        if (_skill != null)
        {
            if (!_skill.isUsableOn(null.getTile()))
            {
            }
            else
            {
                if ((_skill > (_maxRange + this.Math) && (_skill > (_maxRange + this.Math))))
                {
                    return ((_skill > (_maxRange + this.Math)) && (_skill > (_maxRange + this.Math)));
                }
                foreach (local key, value in r21)
                {
                    if (_entity && _entity)
                    {
                        return (_entity && _entity);
                    }
                    if (0 < this.Const.Direction.COUNT)
                    {
                        if (!null.getTile().hasNextTile(0))
                        {
                        }
                        else
                        {
                            if (null.getTile().getNextTile(0).IsEmpty)
                            {
                            }
                            else
                            {
                                if (null.getTile().getNextTile(0).IsOccupiedByActor)
                                {
                                    if (null.getTile().getNextTile(0).getEntity().isAlliedWith(_entity))
                                    {
                                        if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
                                        {
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (((0 + 14) > this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent) && ((0 + 14) > this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent))
                    {
                        return (((0 + 14) > this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent) && ((0 + 14) > this.Const.AI.Behavior.AttackRangedMaxAlliesAdjacent));
                    }
                    if ((((this.queryTargetValue(_entity, null, _skill) * this.Const.AI.Behavior.AttackLineOfFireBlockedMult) - (((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) + (((1.0 / 6.0) * this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity(), null)) * this.Const.AI.Behavior.AttackRangedHitBystandersMult)) > -9000))
                    {
                    }
                    if (null != null)
                    {
                        {}.Score = (((this.queryTargetValue(_entity, null, _skill) * this.Const.AI.Behavior.AttackLineOfFireBlockedMult) - (((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult))) + (((1.0 / 6.0) * this.queryTargetValue(_entity, null.getTile().getNextTile(0).getEntity(), null)) * this.Const.AI.Behavior.AttackRangedHitBystandersMult));
                        {}.Target = null;
                    }
                    return _entity;
                }
            }
        }
    }
}

function queryDestinationsInRange(this, _targetTile, _minRange, _maxRange, _maxLevelDifference)
{
    if ((_maxRange == 1) && (_maxRange == 1))
    {
        return ((_maxRange == 1) && (_maxRange == 1));
        if (0 != this.Const.Direction.COUNT)
        {
            if (!_targetTile.hasNextTile(0))
            {
            }
            else
            {
                if ((this.Math <= 1) && (this.Math <= 1))
                {
                    return ((this.Math <= 1) && (this.Math <= 1));
                    [].push(_targetTile.getNextTile(0));
                }
            }
        }
        return _targetTile;
    }
    if (_maxLevelDifference == 1)
    {
    }
    this.Tactical.queryTilesInRange(_targetTile, _minRange, _maxRange, true, [], this.onQueryDestinationInRange, {});
    return _targetTile;
}

function queryEnemiesInMeleeRange(this, _minRange, _maxRange, _for)
{
    if (_for != null)
    {
    }
    this.Tactical.queryActorsInRange(this.getAgent().getActor().getTile(), _minRange, _maxRange, this.onQueryEnemyInMeleeRange, {});
    return _minRange;
}

function queryOpponentMagnitude(this, _tile, _maxDistance)
{
    foreach (local key, value in r67)
    {
        if (null.Actor.isNull())
        {
        }
        else
        {
            if (null.Actor.getMoraleState() == this.Const.MoraleState.Fleeing)
            {
            }
            if (null.Actor.getTile().getDistanceTo(_tile) <= (_maxDistance * 1.0))
            {
                {}.AverageDistanceScore = {}.AverageDistanceScore op43 ((null.Actor.getTile().getDistanceTo(_tile) - 1) / (_maxDistance * 1.0));
                if (!null.Actor.isArmedWithRangedWeapon())
                {
                    if (null.Actor && null.Actor)
                    {
                        return (null.Actor && null.Actor);
                    }
                }
            }
            if ({}.Opponents != 0)
            {
                {}.AverageDistanceScore = {}.AverageDistanceScore op47 {}.Opponents;
                {}.AverageEngaged = {}.AverageEngaged op47 this.Math.max(1, (0 + 4));
            }
            return _tile;
        }
    }
}

function querySpearwallValueForTile(this, _entity, _tile)
{
    if (this.getProperties().EngageAgainstSpearwallMult == 0.0)
    {
        return _entity;
    }
    if (0 < this.Const.Direction.COUNT)
    {
        if (!_tile.hasNextTile(0))
        {
        }
        else
        {
            if ((this.Math > 1) && (this.Math > 1))
            {
                return ((this.Math > 1) && (this.Math > 1));
            }
            else
            {
                if (_tile.getNextTile(0).getEntity().getCurrentProperties().IsAttackingOnZoneOfControlAlways && _tile.getNextTile(0).getEntity().getCurrentProperties().IsAttackingOnZoneOfControlAlways)
                {
                    return (_tile.getNextTile(0).getEntity().getCurrentProperties().IsAttackingOnZoneOfControlAlways && _tile.getNextTile(0).getEntity().getCurrentProperties().IsAttackingOnZoneOfControlAlways);
                }
            }
        }
    }
    if ((0 + 3) == 0)
    {
        return _entity;
    }
    if (this.m.IsShieldwallAvailable == null)
    {
        this.m.IsShieldwallAvailable = _entity.getSkills().hasSkill("effects.shieldwall");
    }
    if (this.m.IsShieldwallAvailable)
    {
    }
    return _entity;
}

function queryTargetValue(this, _entity, _target, _skill)
{
    if (_skill != null)
    {
    }
    else
    {
        if (_entity.getSkills().getAttackOfOpportunity() != null)
        {
        }
        if (_entity.getCurrentProperties().IsIgnoringArmorOnAttack)
        {
        }
        {}.DirectDamage = this.Math.max(0, (((_entity.getCurrentProperties().getRegularDamageAverage() * 0.25) * (1.0 + ((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) * (_entity.getCurrentProperties().DamageAgainstMult["this.Const.BodyPart.Head"] - 1.0)))) - (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) * this.Const.Combat.ArmorDirectDamageMitigationMult)));
        {}.HitpointDamage = ((_entity.getCurrentProperties().getRegularDamageAverage() * (1.0 + ((_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0) * (_entity.getCurrentProperties().DamageAgainstMult["this.Const.BodyPart.Head"] - 1.0)))) - {}.DirectDamage);
        {}.TotalDamage = (({}.ArmorDamage + {}.HitpointDamage) + {}.DirectDamage);
    }
    if (_skill != null)
    {
    }
    if (((({}.HitpointDamage + {}.DirectDamage) / _target.getHitpoints() < _target.getHitpoints()) && ((({}.HitpointDamage + {}.DirectDamage) / _target.getHitpoints()) < _target.getHitpoints())))
    {
        return (((({}.HitpointDamage + {}.DirectDamage) / _target.getHitpoints()) < _target.getHitpoints()) && ((({}.HitpointDamage + {}.DirectDamage) / _target.getHitpoints()) < _target.getHitpoints()));
        if ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) > 1.0) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) > 1.0)))
        {
            return ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) > 1.0) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) > 1.0));
        }
        else
        {
            if ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) < this.Math.minf) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) < this.Math.minf)))
            {
                return ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) < this.Math.minf) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) < this.Math.minf));
            }
            else
            {
                if ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) == this.Math.minf(1.0, (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) / _target.getHitpoints()))) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) == this.Math.minf(1.0, (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) / _target.getHitpoints())))))
                {
                    return ((((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) == this.Math.minf(1.0, (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) / _target.getHitpoints()))) && (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) == this.Math.minf(1.0, (((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))) / _target.getHitpoints()))));
                }
            }
        }
    }
    if ({}.TotalDamage > 0)
    {
    }
    if ((this < 100) && (this < 100))
    {
        return ((this < 100) && (this < 100));
        if ((this.getProperties().TargetPriorityArmorMult * (0.75 + (_entity.getCurrentProperties().getDamageArmorMult() * 0.25)) < 1.0))
        {
        }
        else
        {
            if ((this.getProperties().TargetPriorityArmorMult * (0.75 + (_entity.getCurrentProperties().getDamageArmorMult() * 0.25)) > 1.0))
            {
            }
        }
    }
    if (_target.getMoraleState() < this.Const.MoraleState.Confident)
    {
    }
    if (_skill == null)
    {
        if (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAgainstShields() && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAgainstShields())
        {
            return (_entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAgainstShields() && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAgainstShields());
        }
    }
    if ((!_target.getCurrentProperties().IsImmuneToStun) && (!_target.getCurrentProperties().IsImmuneToStun) && (!_target.getCurrentProperties().IsImmuneToStun))
    {
        return ((!_target.getCurrentProperties().IsImmuneToStun) && (!_target.getCurrentProperties().IsImmuneToStun) && (!_target.getCurrentProperties().IsImmuneToStun));
        if (_entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm"))
        {
            return (_entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm") || _entity.getSkills().hasSkill("actives.disarm"));
        }
    }
    if (this.getProperties().TargetPriorityDebilitatedMult != 1.0)
    {
        if (_entity.getSkills().hasSkill("effects.sleeping") || _entity.getSkills().hasSkill("effects.sleeping"))
        {
            return (_entity.getSkills().hasSkill("effects.sleeping") || _entity.getSkills().hasSkill("effects.sleeping"));
        }
    }
    if (_target.getSkills().hasSkill("effects.riposte") && _target.getSkills().hasSkill("effects.riposte"))
    {
        return (_target.getSkills().hasSkill("effects.riposte") && _target.getSkills().hasSkill("effects.riposte"));
    }
    if (!_target.isNonCombatant())
    {
        if ((({}.HitpointDamage + {}.DirectDamage) * this.getProperties().TargetPriorityFinishTreshhold) >= _target.getHitpoints())
        {
            if (_skill != null)
            {
            }
        }
        else
        {
            if ((0 == 0) && (0 == 0))
            {
                return ((0 == 0) && (0 == 0));
                if (_skill != null)
                {
                }
            }
        }
        if (({}.ArmorDamage * this.getProperties().TargetPriorityFinishTreshhold) >= ((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0)))))
        {
            if (_skill != null)
            {
            }
        }
    }
    if (_target.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
    }
    if (_skill.isRanged() && _skill.isRanged() && _skill.isRanged())
    {
        return (_skill.isRanged() && _skill.isRanged() && _skill.isRanged());
    }
    if ((null == _skill) && (null == _skill))
    {
        return ((null == _skill) && (null == _skill));
    }
    else
    {
        if (_target.isPlayerControlled())
        {
            if (((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185)) && ((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185)) && ((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185))))
            {
                return (((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185)) && ((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185)) && ((_target.getArmorMax(this.Const.BodyPart.Body) + _target.getArmorMax(this.Const.BodyPart.Head)) <= (this.getStrategy().getAveragePlayerArmor() * 0.33000001311302185)));
            }
        }
        else
        {
            if ((_skill != null) && (_skill != null) && (_skill != null))
            {
                return ((_skill != null) && (_skill != null) && (_skill != null));
            }
        }
    }
    if (20 && 20)
    {
        return (20 && 20);
    }
    return this.Math.maxf(0.009999999776482582, ((((((((((((((((((((((0.0 + ((((_entity.getCurrentProperties().getMeleeSkill() - _target.getCurrentProperties().getMeleeDefense()) / 100.0) * this.getProperties().TargetPriorityHitchanceMult) * this.Const.AI.Behavior.GlobalHitchanceValueMult)) + (({}.TotalDamage / this.Math.maxf(1, (_entity.getCurrentProperties().getRegularDamageAverage() + _entity.getCurrentProperties().getArmorDamageAverage()))) * this.getProperties().TargetPriorityDamageMult)) + (this.Math.minf(1.0, ((this.Math.minf(1.0, (({}.HitpointDamage + {}.DirectDamage) / _target.getHitpoints())) * 0.5) + (({}.ArmorDamage / this.Math.maxf(1.0, ((_target.getArmor(this.Const.BodyPart.Body) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Body) / 100.0)) + (_target.getArmor(this.Const.BodyPart.Head) * (_entity.getCurrentProperties().getHitchance(this.Const.BodyPart.Head) / 100.0))))) * (1.0 - 0.5)))) * this.getProperties().TargetPriorityHitpointsMult)) + ((1.0 - (_target.getCurrentProperties().Bravery / 100.0)) * this.getProperties().TargetPriorityBraveryMult)) + ((this.Math.rand(1, 100) * 0.009999999776482582) * this.getProperties().TargetPriorityRandomMult)) - ((((_target.getArmor(this.Const.BodyPart.Body) + _target.getArmor(this.Const.BodyPart.Head)) / 500.0) * (1.0 - (this.getProperties().TargetPriorityArmorMult * (0.75 + (_entity.getCurrentProperties().getDamageArmorMult() * 0.25))))) * 0.5)) + (this.Math.abs((1.0 - (((_target.getArmor(this.Const.BodyPart.Body) + _target.getArmor(this.Const.BodyPart.Head)) / 500.0) * (this.getProperties().TargetPriorityArmorMult * (0.75 + (_entity.getCurrentProperties().getDamageArmorMult() * 0.25)))))) * 0.5)) + ((0.10000000149011612 * (this.Const.MoraleState.Confident - _target.getMoraleState())) * this.getProperties().TargetPriorityMoraleMult)) + 0.10000000149011612) + 0.10000000149011612) * this.getProperties().TargetPriorityDebilitatedMult) * this.getProperties().TargetPriorityCounterSkillsMult) * this.Math.maxf(1.0, (this.getProperties().TargetPriorityFinishOpponentMult * 0.6600000262260437))) * this.Math.maxf(1.0, (this.getProperties().TargetPriorityFinishOpponentMult * 0.6600000262260437))) * this.Math.maxf(1.0, (this.getProperties().TargetPriorityFinishArmorMult * 0.6600000262260437))) * this.getProperties().TargetPriorityFleeingMult) * this.getProperties().EngageTargetArmedWithRangedWeaponMult) * _target.getCurrentProperties().TargetAttractionMult) * 1000.0) * this.Const.AI.Behavior.LikelyPlayerBaitMult) * this.Const.AI.Behavior.LikelyPlayerBaitMult) * this.Const.AI.Behavior.AttackWhenAlmostDeadMult));
    return _entity;
}

function queryTargetsInMeleeRange(this, _minRange, _maxRange, _maxLevelDifference, _origin)
{
    if (_origin == null)
    {
    }
    this.Tactical.queryActorsInRange(this.getAgent().getActor().getTile(), _minRange, _maxRange, this.onQueryTargetInMeleeRange, {});
    return _minRange;
}

function selectSkill(this, _potentialSkills)
{
    foreach (local key, value in r48)
    {
        if (this.getAgent().getActor().getSkills().getSkillByID(null).isAffordable() && this.getAgent().getActor().getSkills().getSkillByID(null).isAffordable())
        {
            return (this.getAgent().getActor().getSkills().getSkillByID(null).isAffordable() && this.getAgent().getActor().getSkills().getSkillByID(null).isAffordable());
            [].push(this.getAgent().getActor().getSkills().getSkillByID(null));
        }
        if ([].len() == 0)
        {
            return _potentialSkills;
        }
        else
        {
            if ([].len() == 1)
            {
                return _potentialSkills;
            }
        }
        foreach (local key, value in r30)
        {
            if (this.Math.rand(1, (0 + ((0 + (3 * (this.getAgent().getActor().getActionPoints() - this.getAgent().getActor().getSkills().getSkillByID(null).getActionPointCost())) + (this.getAgent().getActor().getFatigueMax() - (this.getAgent().getActor().getSkills().getSkillByID(null).getFatigueCost() * this.getAgent().getActor().getCurrentProperties().FatigueEffectMult))))) <= ((0 + (3 * (this.getAgent().getActor().getActionPoints() - null.getActionPointCost()))) + (this.getAgent().getActor().getFatigueMax() - (null.getFatigueCost() * this.getAgent().getActor().getCurrentProperties().FatigueEffectMult)))))
            {
                return _potentialSkills;
            }
            return _potentialSkills;
        }
    }
}

function setAgent(this, _a)
{
    if (typeof(this) == "instance")
    {
        this.m.Agent = _a;
    }
    this.m.Agent = this.WeakTableRef(_a);
    return;
}
