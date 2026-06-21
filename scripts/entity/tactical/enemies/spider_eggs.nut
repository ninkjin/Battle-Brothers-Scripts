// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/spider_eggs.nut
// Functions: 7

function create(this)
{
    this.m.IsActingEachTurn = false;
    this.m.IsNonCombatant = true;
    this.m.IsShakingOnHit = false;
    this.m.Type = this.Const.EntityType.SpiderEggs;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.SpiderEggs.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/dlc2/giant_spider_egg_spawn_01.wav", "sounds/enemies/dlc2/giant_spider_egg_spawn_02.wav", "sounds/enemies/dlc2/giant_spider_egg_spawn_03.wav", "sounds/enemies/dlc2/giant_spider_egg_spawn_04.wav"];
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDamageReceived(this, _attacker, _skill, _hitInfo)
{
    _hitInfo.BodyPart = this.Const.BodyPart.Body;
    return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
    return _attacker;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("ScrambledEggs", 1, 1);
    }
    if (_tile != null)
    {
        _tile.spawnDetail("nest_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50));
        this.spawnTerrainDropdownEffect(_tile);
    }
    this.dropLoot(_tile, this.getLootForTile(_killer, []), (!(this.Math.rand(0, 100) < 50)));
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SpiderEggs);
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToHeadshots = true;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsMovable = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.TargetAttractionMult = 1.0;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("body").setBrush("nest_01");
    this.addSprite("body").setHorizontalFlipping((this.Math.rand(0, 1) == 1));
    this.addDefaultStatusSprites();
    this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
    this.m.Skills.update();
    return;
}

function onPlacedOnMap(this)
{
    this.actor.onPlacedOnMap();
    this.registerSpawnEvent();
    return;
}

function onSpawn(this, _tile)
{
    if (_tile.IsEmpty)
    {
        return;
    }
    if ((r3 != this.Const.EntityType.SpiderEggs) && (r3 != this.Const.EntityType.SpiderEggs))
    {
        return ((r3 != this.Const.EntityType.SpiderEggs) && (r3 != this.Const.EntityType.SpiderEggs));
    }
    if (this.Tactical.Entities.isEnemyRetreating())
    {
        return;
    }
    if (0 < 6)
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
        }
    }
    if (_tile.getNextTile(0) != null)
    {
        this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", _tile.getNextTile(0).Coords).setSize((this.Math.rand(60, 75) * 0.009999999776482582));
        this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", _tile.getNextTile(0).Coords).setFaction(this.getFaction());
        this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", _tile.getNextTile(0).Coords).m.XP = (this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", _tile.getNextTile(0).Coords).m.XP / 2);
        foreach (local key, value in r20)
        {
            if (null.getType() == this.Const.EntityType.Hexe)
            {
                this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", _tile.getNextTile(0).Coords).getSkills().add(this.new("scripts/skills/effects/fake_charmed_effect"));
            }
            if (this.m.Count < 4)
            {
                this.registerSpawnEvent();
            }
            this.killSilently();
            return;
        }
    }
}

function registerSpawnEvent(this)
{
    this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 2), this.onSpawn.bindenv(this), this.getTile());
    return;
}
