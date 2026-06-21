// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/execute_skill.nut
// Functions: 5

function create(this)
{
    this.m.ID = "actives.execute";
    this.m.Name = "Execute";
    this.m.Description = "A wide, heavy swing aimed at the head.";
    this.m.Icon = "skills/active_239.png";
    this.m.IconDisabled = "skills/active_239_sw.png";
    this.m.Overlay = "active_239";
    this.m.SoundOnUse = ["sounds/combat/overhead_strike_01.wav", "sounds/combat/overhead_strike_02.wav", "sounds/combat/overhead_strike_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/execute_hit_01.wav", "sounds/combat/execute_hit_02.wav", "sounds/combat/execute_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsIgnoredAsAOO = false;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
    this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
    this.m.DirectDamageMult = 0.3499999940395355;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 15;
    this.m.MinRange = 1;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 99;
    this.m.ChanceDisembowel = 50;
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
    [].push({});
    return this.getContainer().buildPropertiesForUse(this, null);
}

function onAfterUpdate(this, _properties)
{
    if (_properties.IsSpecializedInSwords)
    {
    }
    this.m.FatigueCostMult = 1.0;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.HitChance["this.Const.BodyPart.Head"] = _properties.HitChance["this.Const.BodyPart.Head"] op43 15.0;
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
    if (_user && _user)
    {
        return (_user && _user);
        return _user;
    }
    return _user;
}
