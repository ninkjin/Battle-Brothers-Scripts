// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agent.nut
// Functions: 54

function addBehavior(this, _behavior)
{
    _behavior.setAgent(this);
    this.m.Behaviors.push(_behavior);
    this.m.SortedBehaviors.push(_behavior);
    return;
}

function adjustCameraToDestination(this, _dest)
{
    if (_dest.IsVisibleForPlayer && _dest.IsVisibleForPlayer)
    {
        return (_dest.IsVisibleForPlayer && _dest.IsVisibleForPlayer);
        this.m.IsCameraReady = false;
        this.Tactical.CameraDirector.addMoveToTileEvent(0, _dest, -1, this.onCameraReady, {});
    }
    else
    {
        if (_dest.IsVisibleForPlayer && _dest.IsVisibleForPlayer)
        {
            return (_dest.IsVisibleForPlayer && _dest.IsVisibleForPlayer);
            if ((!this.Tactical.getCamera() && (!this.Tactical.getCamera())))
            {
                return ((!this.Tactical.getCamera()) && (!this.Tactical.getCamera()));
                this.adjustCameraToTarget(_dest);
            }
            if ((!_dest.IsVisibleForPlayer) && (!_dest.IsVisibleForPlayer))
            {
                return ((!_dest.IsVisibleForPlayer) && (!_dest.IsVisibleForPlayer));
                this.Tactical.getCamera().Level = this.Tactical.getCamera().getBestLevelForTile(this.m.Actor.getTile());
            }
            this.Tactical.getCamera().Level = this.Tactical.getCamera().getBestLevelForTile(_dest);
        }
    }
    return;
}

function adjustCameraToTarget(this, _targetTile, _additionalDelay)
{
    if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
    {
        return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
        this.m.IsCameraReady = false;
        if (this.Tactical.getCamera() && this.Tactical.getCamera())
        {
            return (this.Tactical.getCamera() && this.Tactical.getCamera());
            this.Tactical.getCamera().Level = this.Math.max(this.Tactical.getCamera().getBestLevelForTile(this.m.Actor.getTile()), this.Tactical.getCamera().getBestLevelForTile(_targetTile));
            if (this.Settings.getGameplaySettings().AlwaysFocusCamera)
            {
            }
            this.Tactical.CameraDirector.addIdleEvent(0, this.onCameraReady, {}, 0, (_additionalDelay + (this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay)));
            return;
        }
        if ((!_targetTile.getEntity().isPlayerControlled() && (!_targetTile.getEntity().isPlayerControlled())))
        {
            return ((!_targetTile.getEntity().isPlayerControlled()) && (!_targetTile.getEntity().isPlayerControlled()));
            if (this.Settings.getGameplaySettings && this.Settings.getGameplaySettings)
            {
                return (this.Settings.getGameplaySettings && this.Settings.getGameplaySettings);
                this.Tactical.CameraDirector.addIdleEvent(0, this.onCameraReady, {}, 0, (_additionalDelay + (this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay)));
                return;
            }
        }
        this.Tactical.CameraDirector.addMoveToTileEvent(0, this.m.Actor.getTile().getTileBetweenThisAnd(_targetTile), this.Math.max(this.Tactical.getCamera().getBestLevelForTile(this.m.Actor.getTile()), this.Tactical.getCamera().getBestLevelForTile(_targetTile)), this.onCameraReady, {}, this.Const.Tactical.Settings.CameraWaitForEventDelay, ((this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay) + (_additionalDelay + (this.Const.AI.Agent.ActionDelay + this.Const.AI.Agent.CameraAdditionalDelay))));
    }
    return;
}

function clearBehaviors(this)
{
    foreach (local key, value in r6)
    {
        null.setAgent(null);
        this.m.Behaviors = [];
        this.m.SortedBehaviors = [];
        return;
    }
}

function compileKnownAllies(this)
{
    if (this.m.Actor.getFaction() == this.Const.Faction.Player)
    {
        return;
    }
    this.m.KnownAllies = [];
    foreach (local key, value in r49)
    {
        if ((!this.m.Actor) && (!this.m.Actor))
        {
            return ((!this.m.Actor) && (!this.m.Actor));
        }
        foreach (local key, value in r21)
        {
            if (null.isPlacedOnMap() && null.isPlacedOnMap())
            {
                return (null.isPlacedOnMap() && null.isPlacedOnMap());
                this.m.KnownAllies.push(null);
            }
            return;
        }
    }
}

function create(this)
{
    this.m.Properties = clone this;
    this.m.Properties.BehaviorMult = [];
    this.m.Properties.BehaviorMult.resize(this.Const.AI.Behavior.ID.COUNT);
    if (0 != this.Const.AI.Behavior.ID.COUNT)
    {
        this.m.Properties.BehaviorMult["0"] = 1.0;
    }
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_idle"));
    this.onAddBehaviors();
    this.finalizeBehaviors();
    return;
}

function declareAction(this, _delay)
{
    this.m.NextActionTime = (this.Time.getVirtualTime() + this.Math.maxf(this.Const.AI.Agent.ActionDelay, _delay));
    return;
}

function declareEngagement(this, _actor)
{
    if (this.m.EngagementsDeclared.find(_actor.getID() == null))
    {
        this.m.EngagementsDeclared.push(_actor.getID());
    }
    return;
}

function declareEvaluationDelay(this, _add)
{
    this.m.NextEvaluationTime = (this.Time.getVirtualTime() + this.Math.maxf(this.Const.AI.Agent.NewEvaluationDelay, _add));
    return;
}

function declareMinorAction(this)
{
    this.m.NextActionTime = (this.Time.getVirtualTime() + this.Const.AI.Agent.MinorActionDelay);
    return;
}

function evaluate(this, _entity)
{
    this.m.ActiveBehavior = null;
    if (this.m.NextBehaviorToEvaluate == -3)
    {
        this.getStrategy().cleanUpKnownOpponents();
        if ((!this.m.ForcedOpponent) && (!this.m.ForcedOpponent))
        {
            return ((!this.m.ForcedOpponent) && (!this.m.ForcedOpponent));
            this.m.ForcedOpponent = null;
        }
        if ((!this.m.Intentions.Target.isAlive() && (!this.m.Intentions.Target.isAlive())))
        {
            return ((!this.m.Intentions.Target.isAlive()) && (!this.m.Intentions.Target.isAlive()));
            this.m.Intentions = clone this;
        }
        this.compileKnownAllies();
        if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
        {
            this.m.NextBehaviorToEvaluate = 0;
        }
    }
    else
    {
        if (this.m.NextBehaviorToEvaluate == -2)
        {
            if (this.m.Actor.getFaction() == this.Const.Faction.Player)
            {
                this.onUpdate();
            }
            else
            {
                if (this.m.StrategyGenerator == null)
                {
                    this.m.StrategyGenerator = this.getStrategy().update();
                }
                if (resume this)
                {
                    this.m.StrategyGenerator = null;
                    this.onUpdate();
                }
            }
        }
        else
        {
            if (this.m.NextBehaviorToEvaluate == -1)
            {
                if (this.m.IsUsingHeat)
                {
                    this.Tactical.clearHeat();
                    foreach (local key, value in r30)
                    {
                        if (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions() >= 2))
                        {
                        }
                        this.Tactical.fillHeat(null.Actor.getTile(), (this.Const.AI.HeatRange - (null.Actor.getTile().getZoneOfControlCountOtherThan(null.Actor.getAlliedFactions()) * 2)), 1.0);
                        if ((this.m.NextBehaviorToEvaluate < this.m.Behaviors) && (this.m.NextBehaviorToEvaluate < this.m.Behaviors))
                        {
                            return ((this.m.NextBehaviorToEvaluate < this.m.Behaviors) && (this.m.NextBehaviorToEvaluate < this.m.Behaviors));
                            if (this.m.Behaviors["this.m.NextBehaviorToEvaluate"].evaluate(_entity))
                            {
                                if (this.m.Behaviors["(this.m.NextBehaviorToEvaluate - 1)"].getScore() != 0)
                                {
                                }
                            }
                        }
                        if (this.m.NextBehaviorToEvaluate >= this.m.Behaviors.len())
                        {
                            this.m.IsEvaluating = false;
                            this.m.NextBehaviorToEvaluate = -3;
                            this.sortBehaviors();
                            this.m.ActiveBehavior = this.pickBehavior();
                            this.m.ActiveBehavior.onBeforeExecute(this.m.Actor);
                            foreach (local key, value in null)
                            {
                                null.onReset();
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
}

function execute(this, _entity)
{
    if (this.m.ActiveBehavior != null)
    {
        if (this.m.ActiveBehavior.getID() != this.Const.AI.Behavior.ID.Idle)
        {
            this.Const.Tactical.Common.LastAIBehaviorID = this.m.ActiveBehavior.getID();
        }
        return this.m.ActiveBehavior.execute(_entity);
        return _entity;
    }
}

function finalizeBehaviors(this)
{
    if (this.m.Behaviors.len() > 1)
    {
        this.m.Behaviors.sort(this.onOrderCompare);
    }
    return;
}

function findBehavior(this, _behaviorId)
{
    foreach (local key, value in r9)
    {
        if (null.getID() == _behaviorId)
        {
            return _behaviorId;
        }
    }
}

function getActor(this)
{
    return this.m.Actor;
}

function getBehavior(this, _id)
{
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        return _id;
    }
}

function getEngagementsDeclared(this, _actor)
{
    if (this.m.EngagementsDeclared.find(_actor.getID() == null))
    {
        return this.m.EngagementsDeclared.len();
        return _actor;
    }
    return _actor;
}

function getForcedOpponent(this)
{
    return this.m.ForcedOpponent;
}

function getID(this)
{
    return this.m.ID;
}

function getIntentions(this)
{
    return this.m.Intentions;
}

function getKnownAllies(this)
{
    return this.m.KnownAllies;
}

function getKnownOpponents(this)
{
    return this.getStrategy().getKnownOpponents();
    return this.getStrategy().getKnownOpponents;
}

function getOrders(this)
{
    return this.m.Orders;
}

function getProperties(this)
{
    return this.m.Properties;
}

function getStrategy(this)
{
    return this.Tactical.Entities.getStrategy(this.getActor().getFaction());
    return this.Tactical.Entities.getStrategy;
}

function hasKnownAllies(this)
{
    return (this.m.KnownAllies.len() != 0);
}

function hasKnownOpponent(this)
{
    return (this.getKnownOpponents().len() != 0);
}

function hasVisibleOpponent(this)
{
    if (this.getKnownOpponents().len() == 0)
    {
        return this.getKnownOpponents();
    }
    foreach (local key, value in r25)
    {
        if (null.Actor.isPlacedOnMap() && null.Actor.isPlacedOnMap() && null.Actor.isPlacedOnMap())
        {
            return (null.Actor.isPlacedOnMap() && null.Actor.isPlacedOnMap() && null.Actor.isPlacedOnMap());
            return this.getKnownOpponents();
        }
        return this.getKnownOpponents();
    }
}

function isEvaluating(this)
{
    return this.m.IsEvaluating;
}

function isFinished(this)
{
    return this.m.IsFinished;
}

function isReady(this)
{
    if (this.m.IsEvaluating)
    {
        return false;
    }
    if (this.Time.getVirtualTime() < this.m.NextActionTime)
    {
        return false;
    }
    if (this.Tactical.CameraDirector && this.Tactical.CameraDirector)
    {
        return (this.Tactical.CameraDirector && this.Tactical.CameraDirector);
        if ((!this.Tactical.getCamera().isMoving() && (!this.Tactical.getCamera().isMoving())))
        {
            return ((!this.Tactical.getCamera().isMoving()) && (!this.Tactical.getCamera().isMoving()));
            return true;
        }
    }
}

function isTurnStarted(this)
{
    return this.m.IsTurnStarted;
}

function isUsingHeat(this)
{
    return this.m.IsUsingHeat;
}

function onAddBehaviors(this)
{
    return;
}

function onAllySighted(this, _entity)
{
    return;
}

function onCameraReady(this, _tag)
{
    _tag.Agent.m.IsCameraReady = true;
    return;
}

function onOpponentSighted(this, _entity)
{
    this.getStrategy().onOpponentSighted(_entity);
    return;
}

function onOrderCompare(this, _behavior1, _behavior2)
{
    if (_behavior1.getOrder() > _behavior2.getOrder())
    {
        return _behavior1;
    }
    else
    {
        if (_behavior1.getOrder() < _behavior2.getOrder())
        {
            return _behavior1;
        }
    }
    return _behavior1;
}

function onRoundStarted(this)
{
    this.m.EngagementsDeclared = [];
    return;
}

function onScoreCompare(this, _behavior1, _behavior2)
{
    if (_behavior1.getScore() > _behavior2.getScore())
    {
        return _behavior1;
    }
    else
    {
        if (_behavior1.getScore() < _behavior2.getScore())
        {
            return _behavior1;
        }
    }
    return _behavior1;
}

function onTurnEnd(this)
{
    this.m.IsTurnStarted = false;
    this.m.Intentions = clone this;
    this.m.KnownAllies = [];
    this.m.ForcedOpponent = null;
    return;
}

function onTurnResumed(this)
{
    this.m.NextActionTime = 0;
    this.m.NextEvaluationTime = 0;
    this.m.IsFinished = false;
    if ((!this.m.Actor) && (!this.m.Actor))
    {
        return ((!this.m.Actor) && (!this.m.Actor));
        if (this.Settings.getGameplaySettings().FasterAIMovement)
        {
            this.declareAction(this.Const.AI.Agent.NewTurnDelayWithFasterMovement);
        }
        this.declareAction(this.Const.AI.Agent.NewTurnDelay);
    }
    this.getStrategy().cleanUpKnownOpponents();
    this.getStrategy().compileKnownOpponents();
    if (0 < this.m.Behaviors.len())
    {
        this.m.Behaviors["0"].onTurnResumed();
    }
    if ((!this.m.Actor) && (!this.m.Actor))
    {
        return ((!this.m.Actor) && (!this.m.Actor));
        this.logInfo("* ");
        this.logInfo((("* " + this.m.Actor.getName()) + ": Resuming turn."));
    }
    return;
}

function onTurnStarted(this)
{
    this.m.IsTurnStarted = true;
    this.m.IsEvaluating = true;
    this.m.IsCameraReady = false;
    this.m.IsFinished = false;
    this.m.NextActionTime = 0;
    this.m.NextEvaluationTime = 0;
    if ((!this.m.Actor) && (!this.m.Actor))
    {
        return ((!this.m.Actor) && (!this.m.Actor));
        if (this.Settings.getGameplaySettings().FasterAIMovement)
        {
            this.declareAction(this.Const.AI.Agent.NewTurnDelayWithFasterMovement);
        }
        this.declareAction(this.Const.AI.Agent.NewTurnDelay);
    }
    if (this.m.IsSharingKnowledge)
    {
    }
    foreach (local key, value in r50)
    {
        if ((!this.m.Actor) && (!this.m.Actor))
        {
            return ((!this.m.Actor) && (!this.m.Actor));
        }
        foreach (local key, value in r22)
        {
            if ((null == this.m.Actor) && (null == this.m.Actor))
            {
                return ((null == this.m.Actor) && (null == this.m.Actor));
            }
            this.onAllySighted(null);
            this.getStrategy().cleanUpKnownOpponents();
            this.getStrategy().compileKnownOpponents();
            if (0 < this.m.Behaviors.len())
            {
                this.m.Behaviors["0"].onTurnStarted();
            }
            if ((!this.m.Actor) && (!this.m.Actor))
            {
                return ((!this.m.Actor) && (!this.m.Actor));
                this.logInfo("* ");
                this.logInfo((("* " + this.m.Actor.getName()) + ": Starting turn."));
            }
            return;
        }
    }
}

function onUpdate(this)
{
    return;
}

function pickBehavior(this)
{
    if (this.m.SortedBehaviors.len() == 0)
    {
        return null;
    }
    if ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled))
    {
        return ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled));
        if (0 < this.m.SortedBehaviors.len())
        {
            if ("VerboseMode".len() != 0)
            {
            }
            if (this.m.SortedBehaviors["0"].getScore() >= (this.m.SortedBehaviors["0"].getScore() * this.Const.AI.Agent.ConsiderBehaviorsCutoff))
            {
            }
        }
    }
    if (0 < this.m.SortedBehaviors.len())
    {
        if (this.m.SortedBehaviors["0"].getScore() < (this.m.SortedBehaviors["0"].getScore() * this.Const.AI.Agent.ConsiderBehaviorsCutoff))
        {
        }
    }
    if ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled))
    {
        return ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled));
        this["-> Behaviors to pick from:
"](("Math" + ((("VerboseMode" + "getName") + (((this.m.SortedBehaviors["0"][" ("]() + ")") + this.m.SortedBehaviors["0"].getScore()) + "(*)")) + "logInfo")));
    }
    if (0 < this.m.SortedBehaviors.len())
    {
        if (this.rand["-> Behavior picked: "](1, (0 + this.m.SortedBehaviors["0"].getScore()) <= this.m.SortedBehaviors["0"].getScore()))
        {
            if ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled))
            {
                return ((!this.m.isPlayerControlled) && (!this.m.isPlayerControlled));
                this["-> Behaviors to pick from:
"]((((("getBehavior" + this.m.SortedBehaviors["0"][" ("]()) + ")") + this.m.SortedBehaviors["0"].getScore()) + "(*)"));
            }
            return (this.m.SortedBehaviors["0"].getScore() * this.Const.AI.Agent.ConsiderBehaviorsCutoff);
        }
    }
    return this.Behavior(this.Const.AI.ID.Idle["k[25]"]);
    return (this.m.SortedBehaviors["0"].getScore() * this.Const.AI.Agent.ConsiderBehaviorsCutoff);
}

function removeBehavior(this, _id)
{
    foreach (local key, value in r19)
    {
        if (null.getID() == _id)
        {
            null.setAgent(null);
            this.m.Behaviors.remove(null);
        }
        foreach (local key, value in r19)
        {
            if (null.getID() == _id)
            {
                null.setAgent(null);
                this.m.SortedBehaviors.remove(null);
            }
            return;
        }
    }
}

function setActor(this, _a)
{
    if (typeof(this) == "instance")
    {
        this.m.Actor = _a;
    }
    this.m.Actor = this.WeakTableRef(_a);
    return;
}

function setEngageRangeBasedOnWeapon(this)
{
    if (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand)
    {
        return (this.Const.ItemSlot.Mainhand && this.Const.ItemSlot.Mainhand);
        this.m.Properties.EngageRangeMin = this.Math.min(this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMin(), this.m.Actor.getCurrentProperties().getVision());
        this.m.Properties.EngageRangeMax = this.Math.min(this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax(), this.m.Actor.getCurrentProperties().getVision());
        this.m.Properties.EngageRangeIdeal = this.Math.min(this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeIdeal(), this.m.Actor.getCurrentProperties().getVision());
    }
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 1;
    this.m.Properties.EngageRangeIdeal = 1;
    if ((this.m.Actor.getSkills().getSkillByID("actives.ignite_firelance").getAmmo() > 0) || (this.m.Actor.getSkills().getSkillByID("actives.ignite_firelance").getAmmo() > 0))
    {
        return ((this.m.Actor.getSkills().getSkillByID("actives.ignite_firelance").getAmmo() > 0) || (this.m.Actor.getSkills().getSkillByID("actives.ignite_firelance").getAmmo() > 0));
        this.m.Properties.EngageEnemiesInLinePreference = 2;
    }
    this.m.Properties.EngageEnemiesInLinePreference = 1;
    return;
}

function setFinished(this, _f)
{
    this.m.IsFinished = _f;
    return;
}

function setForcedOpponent(this, _o)
{
    if (typeof(this) == "instance")
    {
        this.m.ForcedOpponent = _o;
    }
    this.m.ForcedOpponent = this.WeakTableRef(_o);
    return;
}

function setRangedAtDayOnly(this)
{
    if (this.m.Actor.getCurrentProperties().getVision() <= 4)
    {
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 0.5;
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageRanged"] = 0.0;
        this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.SwitchToRanged"] = 0.0;
        if (this.Time.getRound() <= 2)
        {
            this.m.Properties.PreferWait = true;
        }
        this.m.Properties.PreferWait = false;
    }
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.Defend"] = 1.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 0.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageRanged"] = 1.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.SwitchToRanged"] = 1.0;
    this.m.Properties.PreferWait = false;
    return;
}

function setUseHeat(this, _f)
{
    this.m.IsUsingHeat = _f;
    return;
}

function sortBehaviors(this)
{
    if (this.m.SortedBehaviors.len() > 1)
    {
        this.m.SortedBehaviors.sort(this.onScoreCompare);
    }
    return;
}

function think(this, _evaluateOnly)
{
    if (this.Tactical.CameraDirector.isDelayed() || this.Tactical.CameraDirector.isDelayed() || this.Tactical.CameraDirector.isDelayed())
    {
        return (this.Tactical.CameraDirector.isDelayed() || this.Tactical.CameraDirector.isDelayed() || this.Tactical.CameraDirector.isDelayed());
    }
    if ((!this.m.Actor.isHiddenToPlayer() && (!this.m.Actor.isHiddenToPlayer())))
    {
        return ((!this.m.Actor.isHiddenToPlayer()) && (!this.m.Actor.isHiddenToPlayer()));
        this.Tactical.getCamera().moveToExactly(this.m.Actor);
    }
    if (this.m.IsEvaluating)
    {
        if (this.Tactical.getNavigator().IsTravelling)
        {
            return;
        }
        if (this.Const.AI.PathfindingDebugMode)
        {
            this.Tactical.getNavigator().clearPath();
        }
        if (this.m.NextEvaluationTime <= this.Time.getVirtualTime())
        {
            if (this.m.IsUpdatingAlliesBeforeEvaluation)
            {
                this.compileKnownAllies();
            }
            this.evaluate(this.m.Actor);
        }
    }
    if ((this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged))
    {
        return ((this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged) && (this.Const.Tactical.Common.LastAIBehaviorID == this.Const.AI.Behavior.ID.EngageRanged));
        this.m.IsEvaluating = this.execute(this.m.Actor);
        if (this.m.IsEvaluating)
        {
            this.m.ActiveBehavior = null;
        }
    }
    if (!this.m.Actor.isAlive())
    {
        this.setFinished(true);
    }
    return;
}
