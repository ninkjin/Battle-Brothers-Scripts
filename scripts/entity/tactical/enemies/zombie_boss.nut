// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_boss.nut
// Functions: 9

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/legendary/lightbringer_sword"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.ZombieBoss;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.ZombieBoss.XP;
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/ghost_death_01.wav", "sounds/enemies/ghost_death_02.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/geist_idle_01.wav", "sounds/enemies/geist_idle_02.wav", "sounds/enemies/geist_idle_03.wav", "sounds/enemies/geist_idle_04.wav", "sounds/enemies/geist_idle_05.wav", "sounds/enemies/geist_idle_06.wav", "sounds/enemies/geist_idle_07.wav", "sounds/enemies/geist_idle_08.wav", "sounds/enemies/geist_idle_09.wav", "sounds/enemies/geist_idle_10.wav", "sounds/enemies/geist_idle_11.wav", "sounds/enemies/geist_idle_12.wav", "sounds/enemies/geist_idle_13.wav", "sounds/enemies/geist_idle_14.wav", "sounds/enemies/geist_idle_15.wav", "sounds/enemies/geist_idle_16.wav", "sounds/enemies/geist_idle_17.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Other1"] = ["sounds/enemies/ghastly_touch_01.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Move"] = this.m.Sound["this.Const.Sound.ActorEvent.Idle"];
    this.m.SoundVolume["this.Const.Sound.ActorEvent.Move"] = 0.10000000149011612;
    this.m.SoundVolume["this.Const.Sound.ActorEvent.DamageReceived"] = 0.5;
    this.m.SoundPitch = (80 * 0.009999999776482582);
    this.getFlags().add("undead");
    this.getFlags().add("zombie_minion");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAfterDeath(this, _tile)
{
    if (!this.m.Info.Tile.IsEmpty)
    {
        if (0 != 6)
        {
            if (!this.m.Info.Tile.hasNextTile(0))
            {
            }
            else
            {
                if ((this.Math <= 1) && (this.Math <= 1))
                {
                    return ((this.Math <= 1) && (this.Math <= 1));
                    this.m.Info.Tile = this.m.Info.Tile.getNextTile(0);
                }
            }
        }
        if (!true)
        {
            return;
        }
    }
    this.spawnSpawnEffect(this.m.Info.Tile);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/ghost_knight", this.m.Info.Tile.Coords).setFaction(this.m.Info.Faction);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/ghost_knight", this.m.Info.Tile.Coords).assignRandomEquipment();
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        this.m.IsCorpseFlipped = (this.Math.rand(1, 100) < 50);
        _tile.spawnDetail("bust_ghost_knight_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail("bust_ghost_knight_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        _tile.spawnDetail("bust_ghost_knight_01_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail("bust_ghost_knight_01_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        this.spawnTerrainDropdownEffect(_tile);
        clone this.CorpseName = this.getName();
        clone this.Tile = _tile;
        clone this.IsResurrectable = false;
        clone this.IsConsumable = false;
        clone this.IsHeadAttached = (_fatalityType != this.Const.FatalityType.Decapitated);
        _tile.Properties.set("Corpse", clone this);
        this.Tactical.Entities.addCorpse(_tile);
    }
    this.m.Info = {Tile = this.getTile(), Faction = this.getFaction()};
    this.Sound.play("sounds/enemies/horrific_scream_01.wav", (this.Const.Sound.Volume.Skill * 2.25), this.m.Info.Tile.Pos);
    if (((this.Const.Sound.Volume.Skill * 2.25) + 7) < 250)
    {
        if (!this.Tactical.isValidTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5))))))
        {
        }
        else
        {
            if ((this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).ID == this.m.Info.Tile.ID) && (this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).ID == this.m.Info.Tile.ID)))
            {
                return ((this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).ID == this.m.Info.Tile.ID) && (this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).ID == this.m.Info.Tile.ID));
            }
            this.spawnSpawnEffect(this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))));
            this.Tactical.spawnEntity("scripts/entity/tactical/enemies/ghost", this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).Coords).setFaction(this.m.Info.Faction);
            this.Tactical.spawnEntity("scripts/entity/tactical/enemies/ghost", this.Tactical.getTileSquare(this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.X - 5)), this.Math.min((this.Tactical.getMapSize().X - 1), (this.m.Info.Tile.SquareCoords.X + 5))), this.Math.rand(this.Math.max(0, (this.m.Info.Tile.SquareCoords.Y - 5)), this.Math.min((this.Tactical.getMapSize().Y - 1), (this.m.Info.Tile.SquareCoords.Y + 5)))).Coords).assignRandomEquipment();
            if ((0 + 8) >= 11)
            {
            }
            this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
            return;
        }
    }
}

function onFactionChanged(this)
{
    this.actor.onFactionChanged();
    this.getSprite("body").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("head").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.ZombieBoss);
    this.m.BaseProperties.SurroundedBonus = 10;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.FatigueDealtPerHitMult = 2.0;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.addSprite("socket").setBrush("bust_base_undead");
    this.addSprite("body").setBrush("bust_ghost_knight_body_01");
    this.addSprite("head").setBrush("bust_ghost_knight_01_head_01");
    this.addDefaultStatusSprites();
    this.setSpriteOffset("status_stunned", this.createVec(0, 10));
    this.setSpriteOffset("arrow", this.createVec(0, 10));
    this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
    this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    return;
}

function onUpdateInjuryLayer(this)
{
    if ((this.m.Hitpoints / this.getHitpointsMax() > 0.5))
    {
        this.getSprite("body").setBrush("bust_ghost_knight_body_01");
        this.getSprite("head").setBrush("bust_ghost_knight_01_head_01");
    }
    this.getSprite("body").setBrush("bust_ghost_knight_body_01_damaged");
    this.getSprite("head").setBrush("bust_ghost_knight_01_head_01_damaged");
    this.setDirty(true);
    return;
}

function playSound(this, _type, _volume, _pitch)
{
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
    }
    this.actor.playSound(_type, _volume, _pitch);
    return;
}

function spawnSpawnEffect(this, _tile)
{
    {}.Stages <- [];
    this.Tactical.spawnParticleEffect(false, {}.Brushes, _tile, {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 40));
    return;
}
