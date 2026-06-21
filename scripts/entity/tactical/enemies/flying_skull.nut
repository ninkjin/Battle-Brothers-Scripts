// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/flying_skull.nut
// Functions: 8

function create(this)
{
    this.m.Type = this.Const.EntityType.FlyingSkull;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.XP = this.Const.Tactical.Actor.FlyingSkull.XP;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.IsUsingZoneOfControl = false;
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/skeleton_hurt_01.wav", "sounds/enemies/skeleton_hurt_02.wav", "sounds/enemies/skeleton_hurt_03.wav", "sounds/enemies/skeleton_hurt_04.wav", "sounds/enemies/skeleton_hurt_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/skeleton_death_04.wav", "sounds/enemies/skeleton_death_05.wav", "sounds/enemies/skeleton_death_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/skeleton_idle_01.wav", "sounds/enemies/skeleton_idle_02.wav", "sounds/enemies/skeleton_idle_03.wav", "sounds/enemies/skeleton_idle_04.wav", "sounds/enemies/skeleton_idle_05.wav", "sounds/enemies/skeleton_idle_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Move"] = ["sounds/enemies/dlc6/skull_move_01.wav", "sounds/enemies/dlc6/skull_move_02.wav", "sounds/enemies/dlc6/skull_move_03.wav", "sounds/enemies/dlc6/skull_move_04.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Other1"] = ["sounds/combat/shieldwall_01.wav", "sounds/combat/shieldwall_03.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Other2"] = ["sounds/enemies/dlc6/skull_bang_01.wav", "sounds/enemies/dlc6/skull_bang_02.wav", "sounds/enemies/dlc6/skull_bang_03.wav", "sounds/enemies/dlc6/skull_bang_04.wav"];
    this.m.SoundPitch = (this.Math.rand(70, 110) * 0.009999999776482582);
    this.m.SoundVolume["this.Const.Sound.ActorEvent.Move"] = (this.Math.rand(60, 100) * 0.009999999776482582);
    this.getFlags().add("undead");
    this.getFlags().add("skeleton");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/flying_skull_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAfterDeath(this, _tile)
{
    if ((this.Tactical.Entities.getHostilesNum() != 0) && (this.Tactical.Entities.getHostilesNum() != 0) && (this.Tactical.Entities.getHostilesNum() != 0))
    {
        return ((this.Tactical.Entities.getHostilesNum() != 0) && (this.Tactical.Entities.getHostilesNum() != 0) && (this.Tactical.Entities.getHostilesNum() != 0));
        this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerDestroyed);
    }
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (!this.m.IsExploded)
    {
        this.m.IsExploded = true;
        {}.Stages <- [];
        this.Tactical.spawnParticleEffect(false, {}.Brushes, this.getTile(), {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 50));
        if (0 < 6)
        {
            if (!this.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (this.getTile().getNextTile(0).IsOccupiedByActor && this.getTile().getNextTile(0).IsOccupiedByActor)
                {
                    return (this.getTile().getNextTile(0).IsOccupiedByActor && this.getTile().getNextTile(0).IsOccupiedByActor);
                    if (this.getTile().getNextTile(0).getEntity() && this.getTile().getNextTile(0).getEntity())
                    {
                        return (this.getTile().getNextTile(0).getEntity() && this.getTile().getNextTile(0).getEntity());
                    }
                    if (this.isAlliedWith(this.getTile().getNextTile(0).getEntity()))
                    {
                    }
                    clone this.DamageRegular = (this.Math.rand(20, 40) * 1.0);
                    clone this.DamageArmor = (clone this.DamageRegular * 0.75);
                    clone this.DamageDirect = 0.30000001192092896;
                    clone this.BodyPart = 0;
                    clone this.FatalityChanceMult = 0.0;
                    clone this.Injuries = this.Const.Injury.PiercingBody;
                    this.getTile().getNextTile(0).getEntity().onDamageReceived(this, null, clone this);
                }
            }
        }
        this.Sound.play(this.m.Sound["this.Const.Sound.ActorEvent.Other1"]["this.Math.rand(0, (this.m.Sound["this.Const.Sound.ActorEvent.Other1"].len() - 1))"], this.Const.Sound.Volume.Actor, this.getPos());
        this.Sound.play(this.m.Sound["this.Const.Sound.ActorEvent.Other2"]["this.Math.rand(0, (this.m.Sound["this.Const.Sound.ActorEvent.Other2"].len() - 1))"], this.Const.Sound.Volume.Actor, this.getPos());
    }
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onFactionChanged(this)
{
    this.actor.onFactionChanged();
    this.getSprite("body").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("glow").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("flames1").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("flames2").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.setRenderCallbackEnabled(true);
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.FlyingSkull);
    this.m.BaseProperties.TargetAttractionMult = 0.5;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToFire = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    if ((this.World.Days >= this.Const.World.Scaling.AncientDead.SkullStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.SkullStatIncreaseDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.AncientDead.SkullStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.SkullStatIncreaseDay));
        this.m.BaseProperties.DamageDirectAdd = this.m.BaseProperties.DamageDirectAdd op43 0.05000000074505806;
        if (this.World.getTime().Days >= this.Const.World.Scaling.AncientDead.SkullSecondStatIncreaseDay)
        {
            this.m.BaseProperties.DamageDirectAdd = this.m.BaseProperties.DamageDirectAdd op43 0.05000000074505806;
        }
    }
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.SameMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.MaxTraversibleLevels = 3;
    this.addSprite("socket").setBrush("bust_base_undead");
    this.addSprite("body").setBrush(("bust_skeleton_flying_head_0" + this.Math.rand(1, 2)));
    if (this.Math.rand(0, 100) < 90)
    {
        this.addSprite("body").varySaturation(0.10000000149011612);
    }
    if (this.Math.rand(0, 100) < 90)
    {
        this.addSprite("body").varyColor(0.10000000149011612, 0.10000000149011612, 0.10000000149011612);
    }
    if (this.Math.rand(0, 100) < 90)
    {
        this.addSprite("body").varyBrightness(0.10000000149011612);
    }
    this.addSprite("flames1").setBrush("bust_skeleton_flying_head_flames1");
    this.addSprite("flames1").varyColor(0.10000000149011612, 0.10000000149011612, 0.10000000149011612);
    this.addSprite("flames2").setBrush("bust_skeleton_flying_head_flames3");
    this.addSprite("flames2").varyColor(0.10000000149011612, 0.10000000149011612, 0.10000000149011612);
    this.addSprite("glow").setBrush("bust_skeleton_flying_head_glow");
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.6499999761581421;
    this.setSpriteOffset("status_rooted", this.createVec(7, 10));
    this.setSpriteOffset("status_stunned", this.createVec(0, -20));
    this.setSpriteOffset("arrow", this.createVec(0, -20));
    this.m.Skills.add(this.new("scripts/skills/actives/explode_skill"));
    this.spawnEffect();
    return;
}

function onMovementStep(this, _tile, _levelDifference)
{
    if (0 < this.Const.Tactical.DustParticles.len())
    {
        this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles["0"].Brushes, _tile, this.Const.Tactical.DustParticles["0"].Delay, (this.Const.Tactical.DustParticles["0"].Quantity * 0.15000000596046448), (this.Const.Tactical.DustParticles["0"].LifeTimeQuantity * 0.15000000596046448), this.Const.Tactical.DustParticles["0"].SpawnRate, this.Const.Tactical.DustParticles["0"].Stages);
    }
    return this.actor.onMovementStep(_tile, _levelDifference);
    return _tile;
}

function onRender(this)
{
    this.actor.onRender();
    if (this.m.DistortTargetA == null)
    {
        if (this.m.IsFlippingA)
        {
        }
        this.m.DistortTargetA = this.createVec(0, -2.0);
        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
    }
    this.moveSpriteOffset("glow", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);
    this.moveSpriteOffset("flames1", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);
    this.moveSpriteOffset("flames2", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);
    if (this.moveSpriteOffset("body", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA))
    {
        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
        this.m.DistortTargetPrevA = this.m.DistortTargetA;
        if (this.m.IsFlippingA)
        {
        }
        this.m.DistortTargetA = this.createVec(0, -2.0);
        this.m.IsFlippingA = (!this.m.IsFlippingA);
    }
    if (this.m.DistortAnimationStartTimeB == 0)
    {
        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
    }
    if (!this.m.IsFlippingB)
    {
        this.getSprite("flames1").Scale = this.Math.minf(1.0499999523162842, (0.949999988079071 + (0.10000000149011612 * ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeB) / this.m.DurationB))));
    }
    this.getSprite("flames1").Scale = this.Math.maxf(0.949999988079071, (1.0499999523162842 - (0.10000000149011612 * ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeB) / this.m.DurationB))));
    if ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeB) >= this.m.DurationB)
    {
        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
        this.m.IsFlippingB = (!this.m.IsFlippingB);
        this.m.DurationB = (this.Math.rand(25, 60) * 0.009999999776482582);
        if (this.m.IsFlippingB)
        {
            this.getSprite("flames1").fadeToAlpha(this.Math.rand(50, 255), (this.m.DurationB * 1000));
        }
    }
    if (this.m.DistortAnimationStartTimeC == 0)
    {
        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
    }
    if (!this.m.IsFlippingC)
    {
        this.getSprite("flames2").Scale = this.Math.minf(1.0399999618530273, (0.9599999785423279 + (0.07999999821186066 * ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeC) / this.m.DurationC))));
    }
    this.getSprite("flames2").Scale = this.Math.maxf(0.9599999785423279, (1.0399999618530273 - (0.07999999821186066 * ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeC) / this.m.DurationC))));
    if ((this.Time.getVirtualTimeF() - this.m.DistortAnimationStartTimeC) >= this.m.DurationC)
    {
        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
        this.m.IsFlippingC = (!this.m.IsFlippingC);
        this.m.DurationC = (this.Math.rand(25, 40) * 0.009999999776482582);
        if (this.m.IsFlippingC)
        {
            this.getSprite("flames2").fadeToAlpha(this.Math.rand(50, 255), (this.m.DurationC * 1000));
        }
    }
    return;
}

function spawnEffect(this)
{
    if (this.isHiddenToPlayer())
    {
        return;
    }
    {}.Stages <- [];
    this.Tactical.spawnParticleEffect(false, {}.Brushes, this.getTile(), {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 40));
    return;
}
