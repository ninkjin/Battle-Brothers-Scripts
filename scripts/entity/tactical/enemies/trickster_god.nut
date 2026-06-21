// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/trickster_god.nut
// Functions: 5

function assignRandomEquipment(this)
{
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.TricksterGod;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.TricksterGod.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.m.DecapitateSplatterOffset = this.createVec(40, -20);
    this.m.DecapitateBloodAmount = 3.0;
    this.m.ConfidentMoraleBrush = "icon_confident_orcs";
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/dlc4/thing_death_01.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/dlc4/thing_hurt_01.wav", "sounds/enemies/dlc4/thing_hurt_02.wav", "sounds/enemies/dlc4/thing_hurt_03.wav", "sounds/enemies/dlc4/thing_hurt_04.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/dlc4/thing_idle_01.wav", "sounds/enemies/dlc4/thing_idle_02.wav", "sounds/enemies/dlc4/thing_idle_03.wav", "sounds/enemies/dlc4/thing_idle_04.wav", "sounds/enemies/dlc4/thing_idle_05.wav", "sounds/enemies/dlc4/thing_idle_06.wav", "sounds/enemies/dlc4/thing_idle_07.wav"];
    this.m.SoundPitch = 1.0;
    this.m.SoundVolumeOverall = 1.0;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/trickster_god_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateCorpse(this, _tile, _fatalityType, _killer)
{
    clone this.CorpseName = this.getName();
    clone this.IsResurrectable = false;
    clone this.IsConsumable = true;
    clone this.Items = this.getItems().prepareItemsForCorpse(_killer);
    clone this.IsHeadAttached = (_fatalityType != this.Const.FatalityType.Decapitated);
    if (_tile != null)
    {
        clone this.Tile = _tile;
    }
    return _tile;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (!this.Tactical.State.isScenarioMode())
    {
        this.updateAchievement("PuttingDownAGod", 1, 1);
    }
    if (_tile != null)
    {
        this.m.IsCorpseFlipped = (this.Math.rand(1, 100) < 50);
        this.spawnBloodPool(_tile, 1);
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("body").Color;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("body").Saturation;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        _tile.spawnDetail("bust_trickster_god_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("head").Color;
        _tile.spawnDetail("bust_trickster_god_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("head").Saturation;
        _tile.spawnDetail("bust_trickster_god_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail("bust_trickster_god_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        this.spawnTerrainDropdownEffect(_tile);
        {}.Stages <- [];
        this.Tactical.spawnParticleEffect(false, {}.Brushes, _tile, {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 40));
    }
    this.dropLoot(_tile, this.getLootForTile(_killer, []), (!(this.Math.rand(1, 100) < 50)));
    if (_tile == null)
    {
        this.Tactical.Entities.addUnplacedCorpse(this.generateCorpse(_tile, _fatalityType, _killer));
    }
    _tile.Properties.set("Corpse", this.generateCorpse(_tile, _fatalityType, _killer));
    this.Tactical.Entities.addCorpse(_tile);
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.TricksterGod);
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.ImmobileMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("socket").setBrush("bust_base_beasts");
    this.addSprite("body").setBrush("bust_trickster_god_body_01");
    this.addSprite("injury").Visible = false;
    this.addSprite("injury").setBrush("bust_trickster_god_01_injured");
    this.addSprite("head").setBrush("bust_trickster_god_head_01");
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.6499999761581421;
    this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
    this.setSpriteOffset("status_stunned", this.createVec(-32, 30));
    this.setSpriteOffset("arrow", this.createVec(0, 10));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/racial/trickster_god_racial"));
    this.m.Skills.add(this.new("scripts/skills/actives/teleport_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/gore_skill"));
    return;
}
