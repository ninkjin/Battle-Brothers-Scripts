// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_horror.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.Horror;
    this.m.Order = this.Const.AI.Behavior.Order.Horror;
    this.m.IsThreaded = false;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Skill = null;
    this.m.TargetTile = null;
    this.m.TargetScore = 0;
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
    this.selectBestTarget(_entity.getTile(), _entity, this.m.Skill);
    if (this.m.TargetTile == null)
    {
        return _entity;
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
    if (!_entity.isHiddenToPlayer())
    {
        this.getAgent().declareAction();
    }
    this.m.Skill = null;
    this.m.TargetTile = null;
    return _entity;
}

function selectBestTarget(this, _myTile, _entity, _skill)
{
    foreach (local key, value in r76)
    {
        if (_myTile.getDistanceTo(null.Actor.getTile() > (_skill.getMaxRange() + 1)))
        {
        }
        if ([].find(null.Actor.getTile().ID) == null)
        {
            [].push(null.Actor.getTile());
            [].push(null.Actor.getTile().ID);
        }
        if (0 < 6)
        {
            if (!null.Actor.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (_myTile.getDistanceTo(null.Actor.getTile() > (_skill.getMaxRange() + 1)))
                {
                }
                else
                {
                    if ([].find(null.Actor.getTile().ID) == null)
                    {
                        [].push(null.Actor.getTile().getNextTile(0));
                        [].push(null.Actor.getTile().getNextTile(0).ID);
                    }
                }
            }
        }
        if ([].len() == 0)
        {
            return _myTile;
        }
        foreach (local key, value in r262)
        {
            if ((!_skill) && (!_skill))
            {
                return ((!_skill) && (!_skill));
            }
            if (null.IsOccupiedByActor)
            {
                [].push(null.getEntity());
            }
            if (0 < 6)
            {
                if (!null.hasNextTile(0))
                {
                }
                else
                {
                    if (null.Properties.Effect != null)
                    {
                    }
                    else
                    {
                        if (null.getNextTile(0).IsOccupiedByActor)
                        {
                            [].push(null.getNextTile(0).getEntity());
                        }
                    }
                }
            }
            if ([].len() == 0)
            {
            }
            foreach (local key, value in r165)
            {
                if (_entity.isAlliedWith(null))
                {
                }
                else
                {
                    if ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing))
                    {
                        return ((this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing) && (this.Const.MoraleState.Ignore == this.Const.MoraleState.Fleeing));
                    }
                    if (_myTile.getDistanceTo(null.getTile() <= null.getIdealRange()))
                    {
                    }
                    if (null.getMoraleState() == this.Const.MoraleState.Breaking)
                    {
                    }
                    if (null.getTile().Properties.Effect.Applicable(null) && null.getTile().Properties.Effect.Applicable(null))
                    {
                        return (null.getTile().Properties.Effect.Applicable(null) && null.getTile().Properties.Effect.Applicable(null));
                    }
                    if (null && null)
                    {
                        return (null && null);
                    }
                    if (!null.isTurnDone())
                    {
                    }
                    if ((0 + 14) > 1)
                    {
                    }
                    if (((0.0 + ((((((((((this.m.Skill.getMaxRange() - _myTile.getDistanceTo(null.getTile()) + this.Const.AI.Behavior.HorrorAttackingMeBonus) + (this.Const.AI.Behavior.HorrorZOCBonus * null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()))) + this.Const.AI.Behavior.HorrorAlmostFleeingBonus) + this.Const.AI.Behavior.HorrorNegativeTileEffectBonus) * (1.0 - this.Math.minf(1.0, (null.getCurrentProperties().getBravery() * 0.009999999776482582)))) * (1.0 / null.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"])) + this.Const.AI.Behavior.HorrorAdrenalineBonus) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.HorrorStillToActMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 14) - 1))) > -9000.0))
                    {
                    }
                    if (null != null)
                    {
                        this.m.TargetTile = null;
                        this.m.TargetScore = ((0.0 + ((((((((((this.m.Skill.getMaxRange() - _myTile.getDistanceTo(null.getTile())) + this.Const.AI.Behavior.HorrorAttackingMeBonus) + (this.Const.AI.Behavior.HorrorZOCBonus * null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()))) + this.Const.AI.Behavior.HorrorAlmostFleeingBonus) + this.Const.AI.Behavior.HorrorNegativeTileEffectBonus) * (1.0 - this.Math.minf(1.0, (null.getCurrentProperties().getBravery() * 0.009999999776482582)))) * (1.0 / null.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"])) + this.Const.AI.Behavior.HorrorAdrenalineBonus) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.HorrorStillToActMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 14) - 1)));
                        return this.Math.maxf(0.10000000149011612, (((0.0 + ((((((((((this.m.Skill.getMaxRange() - _myTile.getDistanceTo(null.getTile())) + this.Const.AI.Behavior.HorrorAttackingMeBonus) + (this.Const.AI.Behavior.HorrorZOCBonus * null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()))) + this.Const.AI.Behavior.HorrorAlmostFleeingBonus) + this.Const.AI.Behavior.HorrorNegativeTileEffectBonus) * (1.0 - this.Math.minf(1.0, (null.getCurrentProperties().getBravery() * 0.009999999776482582)))) * (1.0 / null.getCurrentProperties().MoraleCheckBraveryMult["this.Const.MoraleCheckType.MentalAttack"])) + this.Const.AI.Behavior.HorrorAdrenalineBonus) * null.getCurrentProperties().TargetAttractionMult) * this.Const.AI.Behavior.HorrorStillToActMult)) * this.Math.pow(this.Const.AI.Behavior.RootNumAffectedPOW, ((0 + 14) - 1))) * 0.10000000149011612));
                        return _myTile;
                    }
                    return _myTile;
                }
            }
        }
    }
}
