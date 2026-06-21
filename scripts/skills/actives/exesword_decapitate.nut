// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/exesword_decapitate.nut
// Functions: 9

function <anonymous>(this, _skill)
{
    if ((outer[0].getEntity().isAlive != null) && (outer[0].getEntity().isAlive != null))
    {
        return ((outer[0].getEntity().isAlive != null) && (outer[0].getEntity().isAlive != null));
        _skill.getContainer().setBusy(false);
        _skill.spawnAttackEffect(outer[0], this.Const.Tactical.AttackEffectSlash);
        if (_skill.attackEntity(outer[1], outer[0].getEntity()))
        {
            this.Sound.play(_skill.m.DecapSound["this.Math.rand(0, (_skill.m.DecapSound.len() - 1))"], this.Const.Sound.Volume.Skill, outer[1].getPos());
        }
    }
    return;
}

function addResources(this)
{
    this.skill.addResources();
    foreach (local key, value in r7)
    {
        this.Tactical.addResource(null);
        return;
    }
}

function create(this)
{
    this.m.ID = "actives.exesword_decapitate";
    this.m.Name = "Decapitate";
    this.m.Description = "A devastating blow aimed to decapitate the target on the spot. Does more damage to hitpoints, the more the target is already wounded. Killing the target will always decapitate it, if at all possible.";
    this.m.Icon = "skills/active_34.png";
    this.m.IconDisabled = "skills/active_34_sw.png";
    this.m.Overlay = "active_34";
    this.m.SoundOnUse = ["sounds/combat/split_01.wav", "sounds/combat/split_02.wav", "sounds/combat/split_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/overhead_strike_hit_01.wav", "sounds/combat/overhead_strike_hit_02.wav", "sounds/combat/overhead_strike_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
    this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
    this.m.DirectDamageMult = 0.3499999940395355;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 20;
    this.m.MinRange = 1;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 100;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 0;
    return;
}

function getTooltip(this)
{
    [].push({});
    if (this.Math.floor((((this.getContainer().buildPropertiesForUse(this, null).DamageRegularMax * this.getContainer().buildPropertiesForUse(this, null).DamageArmorMult) * this.getContainer().buildPropertiesForUse(this, null).DamageTotalMult) * this.getContainer().buildPropertiesForUse(this, null).MeleeDamageMult) > 0))
    {
        [].push({});
    }
    return this.getContainer().buildPropertiesForUse(this, null);
}

function isSwordMasteryApplied(this)
{
    return this.m.ApplySwordMastery;
}

function onAfterUpdate(this, _properties)
{
    if (this.m.ApplySwordMastery)
    {
        if (_properties.IsSpecializedInSwords)
        {
        }
        this.m.FatigueCostMult = 1.0;
    }
    if (_properties.IsSpecializedInCleavers)
    {
    }
    this.m.FatigueCostMult = 1.0;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_targetEntity == null)
    {
        return;
    }
    if (_skill == this)
    {
        _properties.DamageRegularMult = _properties.DamageRegularMult op43 (1.0 - (_targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0)));
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function() /* closure #0 */, this);
    return _user;
}

function setApplySwordMastery(this, _f)
{
    this.m.ApplySwordMastery = _f;
    return;
}
