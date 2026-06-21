// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_lich_mirror_image.nut
// Functions: 5

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonLichMirrorImage;
    this.m.BloodType = this.Const.BloodType.None;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.SkeletonLichMirrorImage.XP;
    this.m.IsEmittingMovementSounds = false;
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/ghost_death_01.wav", "sounds/enemies/ghost_death_02.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/geist_idle_13.wav", "sounds/enemies/geist_idle_14.wav", "sounds/enemies/geist_idle_15.wav", "sounds/enemies/geist_idle_16.wav", "sounds/enemies/geist_idle_17.wav"];
    this.m.SoundPitch = (this.Math.rand(90, 110) * 0.009999999776482582);
    this.getFlags().add("undead");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/mirror_image_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        {}.Stages <- [];
        this.Tactical.spawnParticleEffect(false, {}.Brushes, _tile, {}.Delay, {}.Quantity, {}.LifeTimeQuantity, {}.SpawnRate, {}.Stages, this.createVec(0, 40));
    }
    this.dropLoot(_tile, this.getLootForTile(_killer, []), false);
    this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.setRenderCallbackEnabled(true);
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonLichMirrorImage);
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToRoot = true;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToFire = true;
    this.m.BaseProperties.IsIgnoringArmorOnAttack = true;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.SameMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.MaxTraversibleLevels = 3;
    this.m.Items.getAppearance().Body = "bust_lich_aura_01";
    this.addSprite("socket").setBrush("bust_base_undead");
    this.addSprite("fog").setBrush("bust_ghost_fog_02");
    this.addSprite("body").setBrush("bust_lich_aura_01");
    this.addSprite("body").varySaturation(0.25);
    this.addSprite("body").varyColor(0.20000000298023224, 0.20000000298023224, 0.20000000298023224);
    this.addSprite("head").setBrush("bust_lich_aura_01");
    this.addSprite("head").varySaturation(0.25);
    this.addSprite("head").varyColor(0.20000000298023224, 0.20000000298023224, 0.20000000298023224);
    this.addSprite("blur_1").setBrush("bust_lich_aura_01");
    this.addSprite("blur_1").varySaturation(0.25);
    this.addSprite("blur_1").varyColor(0.20000000298023224, 0.20000000298023224, 0.20000000298023224);
    this.addSprite("blur_2").setBrush("bust_lich_aura_01");
    this.addSprite("blur_2").varySaturation(0.25);
    this.addSprite("blur_2").varyColor(0.20000000298023224, 0.20000000298023224, 0.20000000298023224);
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.550000011920929;
    this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
    this.m.Skills.add(this.new("scripts/skills/racial/ghost_racial"));
    this.m.Skills.add(this.new("scripts/skills/actives/ghastly_touch"));
    this.m.Skills.add(this.new("scripts/skills/actives/wither_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/raise_undead"));
    this.m.Skills.add(this.new("scripts/skills/actives/lightning_storm_skill"));
    return;
}

function onRender(this)
{
    this.actor.onRender();
    if (this.m.DistortTargetA == null)
    {
        this.m.DistortTargetA = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
    }
    if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.799999952316284, this.m.DistortAnimationStartTimeA))
    {
        this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
        this.m.DistortTargetPrevA = this.m.DistortTargetA;
        this.m.DistortTargetA = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
    }
    if (this.m.DistortTargetB == null)
    {
        this.m.DistortTargetB = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
    }
    if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.900000095367432, this.m.DistortAnimationStartTimeB))
    {
        this.m.DistortAnimationStartTimeB = this.Time.getVirtualTimeF();
        this.m.DistortTargetPrevB = this.m.DistortTargetB;
        this.m.DistortTargetB = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
    }
    if (this.m.DistortTargetC == null)
    {
        this.m.DistortTargetC = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
    }
    if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.300000190734863, this.m.DistortAnimationStartTimeC))
    {
        this.m.DistortAnimationStartTimeC = this.Time.getVirtualTimeF();
        this.m.DistortTargetPrevC = this.m.DistortTargetC;
        this.m.DistortTargetC = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
    }
    if (this.m.DistortTargetD == null)
    {
        this.m.DistortTargetD = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
        this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
    }
    if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 5.599999904632568, this.m.DistortAnimationStartTimeD))
    {
        this.m.DistortAnimationStartTimeD = this.Time.getVirtualTimeF();
        this.m.DistortTargetPrevD = this.m.DistortTargetD;
        this.m.DistortTargetD = this.createVec((this.Math.rand(0, 8) - 4), (this.Math.rand(0, 8) - 4));
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
