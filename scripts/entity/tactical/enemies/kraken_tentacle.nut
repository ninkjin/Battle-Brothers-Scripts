// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/kraken_tentacle.nut
// Functions: 13

function create(this)
{
    this.m.Type = this.Const.EntityType.KrakenTentacle;
    this.m.XP = this.Const.Tactical.Actor.KrakenTentacle.XP;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.IsUsingZoneOfControl = false;
    this.m.ConfidentMoraleBrush = "icon_confident_orcs";
    this.actor.create();
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.m.DecapitateSplatterOffset = this.createVec(15, -26);
    this.m.DecapitateBloodAmount = 1.0;
    this.m.DeathBloodAmount = 0.0;
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/dlc2/tentacle_death_01.wav", "sounds/enemies/dlc2/tentacle_death_02.wav", "sounds/enemies/dlc2/tentacle_death_03.wav", "sounds/enemies/dlc2/tentacle_death_04.wav", "sounds/enemies/dlc2/tentacle_death_05.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/dlc2/tentacle_hurt_01.wav", "sounds/enemies/dlc2/tentacle_hurt_02.wav", "sounds/enemies/dlc2/tentacle_hurt_03.wav", "sounds/enemies/dlc2/tentacle_hurt_04.wav", "sounds/enemies/dlc2/tentacle_hurt_05.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Other1"] = ["sounds/enemies/dlc2/krake_choke_01.wav", "sounds/enemies/dlc2/krake_choke_02.wav", "sounds/enemies/dlc2/krake_choke_03.wav", "sounds/enemies/dlc2/krake_choke_04.wav", "sounds/enemies/dlc2/krake_choke_05.wav"];
    this.m.SoundVolume["this.Const.Sound.ActorEvent.DamageReceived"] = 2.0;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/kraken_tentacle_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function getImageOffsetY(this)
{
    return 20;
}

function getMode(this)
{
    return this.m.Mode;
}

function getParent(this)
{
    return this.m.Parent;
}

function onCorpseEffect(this, _data)
{
    if ((this.Time.getRealTimeF() - _data.Start) >= 0.75)
    {
        outer[0].clear(this.Const.Tactical.DetailFlag.Corpse);
        return;
    }
    _data.Body.setOffset(this.createVec(0.0, (0.0 + (_data.Vector.Y * ((this.Time.getRealTimeF() - _data.Start) / 0.75)))));
    this.Time.scheduleEvent(this.TimeUnit.Real, 10, _data.onCorpseEffect, _data);
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
    if (_tile != null)
    {
    }
    if (this.getMode() == 0)
    {
    }
    this.Time.scheduleEvent(this.TimeUnit.Real, 10, {}.onCorpseEffect, {});
    if (this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"].len() != 0)
    {
        if (0 < this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"].len())
        {
            if ((!this.Const.Tactical.TerrainDropdownParticles[this.getTile().Subtype][0].ApplyOnRain) && (!this.Const.Tactical.TerrainDropdownParticles[this.getTile().Subtype][0].ApplyOnRain))
            {
                return ((!this.Const.Tactical.TerrainDropdownParticles[this.getTile().Subtype][0].ApplyOnRain) && (!this.Const.Tactical.TerrainDropdownParticles[this.getTile().Subtype][0].ApplyOnRain));
            }
            this.Tactical.spawnParticleEffect(false, this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].Brushes, this.getTile(), this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].Delay, this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].Quantity, this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].LifeTimeQuantity, this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].SpawnRate, this.Const.Tactical.TerrainDropdownParticles["this.getTile().Subtype"]["0"].Stages);
        }
    }
    else
    {
        if (this.Const.Tactical.RaiseFromGroundParticles.len() != 0)
        {
            if (0 < this.Const.Tactical.RaiseFromGroundParticles.len())
            {
                this.Tactical.spawnParticleEffect(false, this.Const.Tactical.RaiseFromGroundParticles["0"].Brushes, this.getTile(), this.Const.Tactical.RaiseFromGroundParticles["0"].Delay, this.Const.Tactical.RaiseFromGroundParticles["0"].Quantity, this.Const.Tactical.RaiseFromGroundParticles["0"].LifeTimeQuantity, this.Const.Tactical.RaiseFromGroundParticles["0"].SpawnRate, this.Const.Tactical.RaiseFromGroundParticles["0"].Stages);
            }
        }
    }
    if ((!this.m.Parent.isDying() && (!this.m.Parent.isDying()) && (!this.m.Parent.isDying())))
    {
        return ((!this.m.Parent.isDying()) && (!this.m.Parent.isDying()) && (!this.m.Parent.isDying()));
        this.m.Parent.onTentacleDestroyed();
    }
    this.Tactical.getTemporaryRoster().remove(this);
    this.actor.onDeath(_killer, _skill, this.getTile(), _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.KrakenTentacle);
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToHeadshots = true;
    this.m.BaseProperties.IsMovable = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("socket").setBrush("bust_base_beasts");
    this.addSprite("body").setBrush("bust_kraken_tentacle_01");
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.6800000071525574;
    this.setSpriteOffset("status_rooted", this.createVec(5, 25));
    this.setSpriteOffset("arrow", this.createVec(0, 25));
    this.setSpriteOffset("status_stunned", this.createVec(0, 25));
    this.m.Skills.add(this.new("scripts/skills/actives/kraken_move_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/kraken_bite_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/kraken_ensnare_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.Tactical.getTemporaryRoster().add(this);
    return;
}

function onPlacedOnMap(this)
{
    this.actor.onPlacedOnMap();
    this.onUpdateInjuryLayer();
    return;
}

function onUpdateInjuryLayer(this)
{
    if (this.getHitpointsPct() > 0.5)
    {
        if (this.m.Mode == 0)
        {
            this.getSprite("body").setBrush("bust_kraken_tentacle_01");
        }
        this.getSprite("body").setBrush("bust_kraken_tentacle_02");
    }
    if (this.m.Mode == 0)
    {
        this.getSprite("body").setBrush("bust_kraken_tentacle_01_injured");
    }
    this.getSprite("body").setBrush("bust_kraken_tentacle_02_injured");
    this.setDirty(true);
    return;
}

function setMode(this, _m)
{
    this.m.Mode = _m;
    if (this.isPlacedOnMap())
    {
        if ((_m == 1) && (_m == 1))
        {
            return ((_m == 1) && (_m == 1));
            this.m.IsUsingZoneOfControl = true;
            this.setZoneOfControl(this.getTile(), true);
        }
        this.onUpdateInjuryLayer();
    }
    return;
}

function setParent(this, _p)
{
    if (_p == null)
    {
        this.m.Parent = null;
    }
    this.m.Parent = this.WeakTableRef(_p);
    return;
}

function spawnBloodPool(this, _a, _b)
{
    return;
}
