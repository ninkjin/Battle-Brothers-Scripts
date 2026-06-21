// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/strategy.nut
// Functions: 24

function cleanUpKnownOpponents(this)
{
    foreach (local key, value in r66)
    {
        if (this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction() || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction())))
        {
            return (this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()) || this.World.FactionManager.isAllied(this.m.Faction, null.Actor.getFaction()));
            [].push(null);
        }
        [].reverse();
        foreach (local key, value in null)
        {
            this.m.KnownOpponents.remove(null);
            return;
        }
    }
}

function clear(this)
{
    this.m.IsDefending = false;
    return;
}

function compileKnownOpponents(this)
{
    if (0 != this.Tactical.Entities.getAllInstances().len())
    {
        if (this.Tactical.State.isScenarioMode())
        {
            if (this.Const.FactionAlliance["this.m.Faction"].find(0) != null)
            {
            }
            else
            {
                if (this.World.FactionManager.isAllied(this.m.Faction, 0))
                {
                }
                else
                {
                    if (0 != this.Tactical.Entities.getAllInstances()["0"].len())
                    {
                        if (!this.Tactical.Entities.getAllInstances()["0"]["0"].isAttackable())
                        {
                        }
                        else
                        {
                            if ((!this.Tactical.Entities.getAllInstances()[0][0]) && (!this.Tactical.Entities.getAllInstances()[0][0]))
                            {
                                return ((!this.Tactical.Entities.getAllInstances()[0][0]) && (!this.Tactical.Entities.getAllInstances()[0][0]));
                            }
                            this.onOpponentSighted(this.Tactical.Entities.getAllInstances()["0"]["0"]);
                        }
                    }
                }
            }
            return;
        }
    }
}

function create(this)
{
    return;
}

function getAlliesMelee(this)
{
    return this.m.AlliesMelee;
}

function getAlliesRanged(this)
{
    return this.m.AlliedRanged;
}

function getAllyVSEnemyRange(this)
{
    return this.m.AllyVSEnemyRange;
}

function getAveragePlayerArmor(this)
{
    return this.m.AveragePlayerArmor;
}

function getAveragePlayerLevel(this)
{
    return this.m.AveragePlayerLevel;
}

function getEnemiesMelee(this)
{
    return this.m.EnemiesMelee;
}

function getEnemiesRanged(this)
{
    return this.m.EnemiesRanged;
}

function getKnownOpponents(this)
{
    return this.m.KnownOpponents;
}

function getStats(this)
{
    return this.m.Stats;
}

function isAllottedTimeReached(this, _t)
{
    return;
}

function isDefending(this)
{
    return this.m.IsDefending;
}

function isDefendingCamp(this)
{
    return;
}

function isDefensive(this, _entity)
{
    return _entity.getItems().hasDefensiveItem();
    return _entity;
}

function isDelayedAttack(this)
{
    return this.m.IsDelayedAttack;
}

function isEscortedByPlayer(this)
{
    return this.m.IsEscortedByPlayer;
}

function onOpponentSighted(this, _entity)
{
    if ((!_entity) && (!_entity))
    {
        return ((!_entity) && (!_entity));
    }
    if (typeof(this) != "instance")
    {
    }
    foreach (local key, value in r30)
    {
        if ((null.Actor == r8) && (null.Actor == r8))
        {
            return ((null.Actor == r8) && (null.Actor == r8));
            null.Tile = this.WeakTableRef(_entity).getTile();
            null.TTL = this.Const.AI.Agent.DefaultOpponentTTL;
            return;
        }
        this.m.KnownOpponents.push({});
        return;
    }
}

function setFaction(this, _f)
{
    this.m.Faction = _f;
    return;
}

function setIsAttackingOnWorldmap(this, _f)
{
    this.m.IsAttackingOnWorldmap = _f;
    return;
}

function update(this)
{
    this.clear();
    this.m.Stats.IsOwnFactionEngaged = false;
    foreach (local key, value in r198)
    {
        foreach (local key, value in r193)
        {
            if (null.isDying() || null.isDying())
            {
                return (null.isDying() || null.isDying());
            }
            null.getRangedWeaponInfo().Entity <- null;
            if (null.isAlliedWith(this.m.Faction))
            {
                [].push(null.getRangedWeaponInfo());
                if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
                {
                }
                if (this.isDefensive(null))
                {
                }
                if (null.getRangedWeaponInfo().HasRangedWeapon)
                {
                    if (null.getSkills().hasSkill("perk.quickhands") && null.getSkills().hasSkill("perk.quickhands"))
                    {
                        return (null.getSkills().hasSkill("perk.quickhands") && null.getSkills().hasSkill("perk.quickhands"));
                    }
                }
            }
            else
            {
                [].push(null.getRangedWeaponInfo());
                if (null.getMoraleState() == this.Const.MoraleState.Fleeing)
                {
                }
                if (this.isDefensive(null))
                {
                }
                if (null.getRangedWeaponInfo().HasRangedWeapon)
                {
                    if (null.getSkills().hasSkill("perk.quickhands") && null.getSkills().hasSkill("perk.quickhands"))
                    {
                        return (null.getSkills().hasSkill("perk.quickhands") && null.getSkills().hasSkill("perk.quickhands"));
                    }
                }
            }
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            foreach (local key, value in r93)
            {
                if (!null.HasRangedWeapon)
                {
                }
                if (null.IsTrueRangedWeapon)
                {
                }
                foreach (local key, value in r51)
                {
                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() <= this.Math.min((null.Range + this.Math.max(0, (null.Entity.getTile().Level - null.Entity.getTile().Level))), null.RangeWithLevel)))
                    {
                    }
                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() <= this.Math.min((null.Range + this.Math.max(0, (null.Entity.getTile().Level - null.Entity.getTile().Level))), null.RangeWithLevel)))
                    {
                    }
                    if (true && true)
                    {
                        return (true && true);
                    }
                    if ((!true) && (!true))
                    {
                        return ((!true) && (!true));
                    }
                    if (true)
                    {
                        if (null.IsTrueRangedWeapon)
                        {
                        }
                    }
                    foreach (local key, value in r93)
                    {
                        if (!null.HasRangedWeapon)
                        {
                        }
                        if (null.IsTrueRangedWeapon)
                        {
                        }
                        foreach (local key, value in r51)
                        {
                            if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() <= this.Math.min((null.Range + this.Math.max(0, (null.Entity.getTile().Level - null.Entity.getTile().Level))), null.RangeWithLevel)))
                            {
                            }
                            if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() <= this.Math.min((null.Range + this.Math.max(0, (null.Entity.getTile().Level - null.Entity.getTile().Level))), null.RangeWithLevel)))
                            {
                            }
                            if (true && true)
                            {
                                return (true && true);
                            }
                            if ((!true) && (!true))
                            {
                                return ((!true) && (!true));
                            }
                            if (true)
                            {
                                if (null.IsTrueRangedWeapon)
                                {
                                }
                            }
                            if (this.isAllottedTimeReached(this.Time.getExactTime()))
                            {
                                yield this;
                            }
                            foreach (local key, value in r137)
                            {
                                if (null.Entity.getTile().hasZoneOfControlOtherThan(null.Entity.getAlliedFactions()))
                                {
                                    if (null.Entity.getFaction() == this.m.Faction)
                                    {
                                        this.m.Stats.IsOwnFactionEngaged = true;
                                    }
                                }
                                foreach (local key, value in r79)
                                {
                                    if ((null.Entity.getTile().getDistanceTo(null.Entity.getTile() <= this.Math.min(2, null.Entity.getIdealRange())) && (null.Entity.getTile().getDistanceTo(null.Entity.getTile()) <= this.Math.min(2, null.Entity.getIdealRange()))))
                                    {
                                        return ((null.Entity.getTile().getDistanceTo(null.Entity.getTile()) <= this.Math.min(2, null.Entity.getIdealRange())) && (null.Entity.getTile().getDistanceTo(null.Entity.getTile()) <= this.Math.min(2, null.Entity.getIdealRange())));
                                        if (null.Entity.getFaction() == this.m.Faction)
                                        {
                                            this.m.Stats.IsOwnFactionEngaged = true;
                                        }
                                    }
                                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() < 9999))
                                    {
                                    }
                                    if ((null.Entity == null.Entity) && (null.Entity == null.Entity))
                                    {
                                        return ((null.Entity == null.Entity) && (null.Entity == null.Entity));
                                    }
                                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() < 1))
                                    {
                                    }
                                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() < 1))
                                    {
                                    }
                                    if (null.Entity.getTile().getDistanceTo(null.Entity.getTile() > 1))
                                    {
                                    }
                                    this.m.Stats.AlliesVSEnemiesRatio = (this.Math.maxf(1.0, [].len()) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.EnemiesVSAlliesRatio = (this.Math.maxf(1.0, [].len()) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.RangedAlliedVSEnemies = ((((0.0 + (null.getRangedWeaponInfo().RangeWithLevel * null.getCurrentProperties().getRangedSkill())) / 7.0) + 0.5) / (((0.0 + (null.getRangedWeaponInfo().RangeWithLevel * null.getCurrentProperties().getRangedSkill())) / 7.0) + 0.5));
                                    this.m.Stats.EngagedAlliesRatio = (((0 + 3) + 3) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.FleeingAlliesRatio = ((0 + 4) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.FleeingEnemiesRatio = ((0 + 5) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.DefensiveAlliesRatio = (this.Math.max(1, (0 + 6)) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.DefensiveEnemiesRatio = ((0 + 7) / this.Math.maxf(1.0, [].len()));
                                    if (this.isDefendingCamp())
                                    {
                                    }
                                    this.m.Stats.DefensiveBiasAverage = (((0.0 + null.getAIAgent().getProperties().OverallDefensivenessMult) / this.Math.maxf(1.0, [].len())) * 1.0);
                                    this.m.Stats.EnemyRangedReadyRatio = ((0.0 + 1.0) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.AllyRangedReadyRatio = ((0.0 + 1.0) / this.Math.maxf(1.0, [].len()));
                                    this.m.Stats.AllyVSEnemyOutrange = (((0.0 + 1.0) + 2.0) / ((0.0 + 1.0) + 2.0));
                                    if ((0.0 + 0.5) > (0.0 + 0.5))
                                    {
                                        this.m.Stats["72"] = ((0.0 + 0.5) > (0.0 + 0.5));
                                    }
                                    foreach (local key, value in null.Entity.getTile().getDistanceTo(null.Entity.getTile()))
                                    {
                                        this.m.AveragePlayerLevel = ((0 + null.getLevel()) / (this.Tactical.Entities.len() * 1.0));
                                        this.m.AveragePlayerArmor = ((0 + (null.getArmorMax(this.Const.BodyPart.Body) + null.getArmorMax(this.Const.BodyPart.Head))) / (this.Tactical.Entities.len() * 1.0));
                                        this.m.IsEscortedByPlayer = false;
                                        this.m.IsDefending = this.updateDefending();
                                        this.m.Stats.IsBeingKited = false;
                                        if ((this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line) && (this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line) && (this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line))
                                        {
                                            return ((this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line) && (this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line) && (this.Tactical.State.getStrategicProperties().PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line));
                                            foreach (local key, value in (0.0 + 0.5))
                                            {
                                                if (null.getTile().SquareCoords.X >= 12)
                                                {
                                                }
                                                if (!true)
                                                {
                                                    this.m.Stats.IsBeingKited = true;
                                                }
                                                return (0.0 + (null.getRangedWeaponInfo().RangeWithLevel * null.getCurrentProperties().getRangedSkill()));
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

function updateDefending(this)
{
    if (this.Tactical.State.IsArenaMode && this.Tactical.State.IsArenaMode)
    {
        return (this.Tactical.State.IsArenaMode && this.Tactical.State.IsArenaMode);
        return false;
    }
    if ((this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction().getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement)))
    {
        return ((this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement) && (this.World.FactionManager.getFaction(this.World.State.getEscortedEntity().getFaction()).getType() == this.Const.FactionType.Settlement));
        this.m.IsEscortedByPlayer = true;
        return true;
    }
    if (this.m.Stats.EngagedAlliesRatio > this.Const.AI.Behavior.DefendMaxEngagedAlliesRatio)
    {
        this.m.IsOffensiveLastTurn = true;
        return false;
    }
    if (this.Tactical.State.isAutoRetreat())
    {
        return false;
    }
    if ((((1.0 + this.m.Stats.AllyOutranging) / (1.0 + this.m.Stats.EnemyOutranging) < 4.0) && (((1.0 + this.m.Stats.AllyOutranging) / (1.0 + this.m.Stats.EnemyOutranging)) < 4.0)))
    {
        return ((((1.0 + this.m.Stats.AllyOutranging) / (1.0 + this.m.Stats.EnemyOutranging)) < 4.0) && (((1.0 + this.m.Stats.AllyOutranging) / (1.0 + this.m.Stats.EnemyOutranging)) < 4.0));
        this.m.IsOffensiveLastTurn = true;
        return false;
    }
    if (this.m.Stats.AlliesVSEnemiesRatio >= (3.0 * this.m.Stats.DefensiveBiasAverage))
    {
        this.m.IsOffensiveLastTurn = true;
        return false;
    }
    if (this.m.Stats.DefensiveBiasAverage >= 1.0)
    {
    }
    if (this.m.Stats.IsOutrangedByEnemy)
    {
    }
    else
    {
        if ((this.m.Stats.DefensiveBiasAverage >= this.Math.maxf) && (this.m.Stats.DefensiveBiasAverage >= this.Math.maxf))
        {
            return ((this.m.Stats.DefensiveBiasAverage >= this.Math.maxf) && (this.m.Stats.DefensiveBiasAverage >= this.Math.maxf));
        }
    }
    if ((((((this.m.Stats.EnemiesVSAlliesRatio * (1.0 - this.m.Stats.EngagedAlliesRatio) * this.Math.minf(1.0, this.m.Stats.RangedAlliedVSEnemies)) * (this.m.Stats.DefensiveAlliesRatio * 4.0)) * (1.0 - this.m.Stats.FleeingEnemiesRatio)) * this.m.Stats.AllyVSEnemyOutrange) < (((3.0 * (1.0 / this.Math.maxf(0.10000000149011612, this.m.Stats.DefensiveBiasAverage))) * 10.0) * 0.5)))
    {
        this.m.IsOffensiveLastTurn = true;
        return this.m.Stats.EnemiesVSAlliesRatio;
    }
    if (this.m.IsOffensiveLastTurn)
    {
        this.m.IsOffensiveLastTurn = false;
        return this.m.Stats.EnemiesVSAlliesRatio;
    }
    return this.m.Stats.EnemiesVSAlliesRatio;
}
