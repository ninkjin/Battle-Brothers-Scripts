// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_attack_handgonne.nut
// Functions: 6

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.AttackHandgonne;
    this.m.Order = this.Const.AI.Behavior.Order.AttackHandgonne;
    this.behavior.create();
    return;
}

function onBeforeExecute(this, _entity)
{
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    if (this.m.TargetTile == null)
    {
        return _entity;
    }
    if (this.getAgent().getIntentions().IsChangingWeapons)
    {
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        if (_entity.isHiddenToPlayer() && _entity.isHiddenToPlayer())
        {
            return (_entity.isHiddenToPlayer() && _entity.isHiddenToPlayer());
            _entity.setDiscovered(true);
            _entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
        }
        this.getAgent().adjustCameraToTarget(this.m.TargetTile, this.m.Skill.getDelay());
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.TargetTile != null)
    {
        if (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor)
        {
            return (this.m.TargetTile.IsOccupiedByActor && this.m.TargetTile.IsOccupiedByActor);
            this.logInfo((((((("* " + _entity.getName()) + ": Using ") + this.m.Skill.getName()) + " against ") + this.m.TargetTile.getEntity().getName()) + "!"));
        }
        this.m.Skill.use(this.m.TargetTile);
        if (_entity.isAlive())
        {
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
        }
        this.m.TargetTile = null;
        this.m.Skill = null;
    }
    return _entity;
}

function onQueryTargetTile(this, _tile, _tag)
{
    _tag.push(_tile);
    return;
}

function selectBestTarget(this, _myTile, _entity, _skill)
{
    this.Tactical.queryTilesInRange(_myTile, _skill.getMinRange(), (_skill.getMaxRange() + this.Math.min(_myTile.Level, _skill.getMaxRangeBonus())), false, [], this.onQueryTargetTile, []);
    foreach (local key, value in r174)
    {
        if (this.m.Skill != null)
        {
            if (!_skill.isUsableOn(null, _myTile))
            {
            }
            else
            {
                if ((!_myTile.hasLineOfSightTo(null, _entity.getCurrentProperties().getVision()) || (!_myTile.hasLineOfSightTo(null, _entity.getCurrentProperties().getVision()))))
                {
                    return ((!_myTile.hasLineOfSightTo(null, _entity.getCurrentProperties().getVision())) || (!_myTile.hasLineOfSightTo(null, _entity.getCurrentProperties().getVision())));
                }
                foreach (local key, value in r88)
                {
                    if (!null.IsOccupiedByActor)
                    {
                    }
                    else
                    {
                        if (null.getEntity().getID() == _entity.getID())
                        {
                        }
                        if (_entity.isAlliedWith(null.getEntity()))
                        {
                            if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
                            {
                            }
                            if (null.getEntity().isPlayerControlled())
                            {
                            }
                        }
                        if (null.getZoneOfControlCount(_entity.getFaction() < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones))
                        {
                        }
                        if ((0 + 11) > 1)
                        {
                        }
                        if (((0 + 12) + 12) > 0)
                        {
                        }
                        if ((((((0.0 - ((((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.getEntity(), _myTile, _entity).Turns))) * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneOpponentsHitMult, (0 + 11))) * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneAlliesHitMult, ((0 + 12) + 12))) > 0.0))
                        {
                        }
                        if (null != null)
                        {
                            this.m.TargetTile = null;
                            return this.Math.maxf(0.10000000149011612, (((((0.0 - ((((1.0 / 6.0) * 4.0) * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult)) * null.getEntity().getCurrentProperties().TargetAttractionMult)) + this.queryTargetValue(_entity, null.getEntity(), _skill)) + (1.0 - this.Math.minf(1.0, this.queryActorTurnsNearTarget(null.getEntity(), _myTile, _entity).Turns))) * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneOpponentsHitMult, (0 + 11))) * this.Math.pow(this.Const.AI.Behavior.AttackHandgoneAlliesHitMult, ((0 + 12) + 12))));
                            return _myTile;
                        }
                        return _myTile;
                    }
                }
            }
        }
    }
}
