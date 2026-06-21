// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/assault_skill.nut
// Functions: 9

function <anonymous>(this, _skill)
{
    if ((outer[0].isAlive != null) && (outer[0].isAlive != null))
    {
        return ((outer[0].isAlive != null) && (outer[0].isAlive != null));
        _skill.m.IsDoingAttackMove = true;
        _skill.getContainer().setBusy(false);
        _skill.spawnAttackEffect(outer[1], this.Const.Tactical.AttackEffectChop);
        this.Sound.play(_skill.m.StrikeTwoSoundOnUse["this.Math.rand(0, (_skill.m.StrikeTwoSoundOnUse.len() - 1))"], this.Const.Sound.Volume.Skill, outer[2].getPos());
        _skill.attackEntity(outer[2], outer[0]);
        _skill.setImpaleInfo();
        this.m.IsSecondAttack = false;
    }
    return;
}

function create(this)
{
    this.m.ID = "actives.assault";
    this.m.Name = "Assault";
    this.m.Description = "A thrusting attack that is difficult to defend against. Followed up by a strike with the axehead if the target is staggered.";
    this.m.KilledString = "Assaulted";
    this.m.Icon = "skills/active_240.png";
    this.m.IconDisabled = "skills/active_240_sw.png";
    this.m.Overlay = "active_240";
    this.m.SoundOnUse = ["sounds/combat/impale_01.wav", "sounds/combat/impale_02.wav", "sounds/combat/impale_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/impale_hit_01.wav", "sounds/combat/impale_hit_02.wav", "sounds/combat/impale_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsRanged = false;
    this.m.IsTooCloseShown = false;
    this.m.IsWeaponSkill = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
    this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
    this.m.DirectDamageMult = 0.4000000059604645;
    this.m.HitChanceBonus = 0;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 15;
    this.m.MinRange = 1;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 0;
    this.m.ChanceDisembowel = 25;
    return;
}

function getHitChanceModifier(this)
{
    if (this.m.IsSecondAttack)
    {
        return 0;
    }
    return 10;
}

function getTooltip(this)
{
    this.getDefaultTooltip().push({});
    this.getDefaultTooltip().push({});
    return this.getDefaultTooltip();
}

function onAfterUpdate(this, _properties)
{
    if (_properties.IsSpecializedInPolearms)
    {
    }
    this.m.FatigueCostMult = 1.0;
    if (_properties.IsSpecializedInPolearms)
    {
    }
    this.m.ActionPointCost = 6;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        if (this.m.IsSecondAttack)
        {
            _properties.DamageTotalMult = _properties.DamageTotalMult op42 0.75;
            _properties.DamageArmorMult = _properties.DamageArmorMult op42 1.2000000476837158;
            _properties.DamageDirectAdd = _properties.DamageDirectAdd op43 0.20000000298023224;
        }
        _properties.MeleeSkill = _properties.MeleeSkill op43 10;
        this.m.HitChanceBonus = 10;
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
    this.setImpaleInfo();
    this.m.IsSecondAttack = false;
    if (_targetTile.getEntity().getSkills().hasSkill("effects.staggered"))
    {
        if (_targetTile.getEntity().isAlive())
        {
            this.setStrikeInfo();
            this.m.IsSecondAttack = true;
        }
        if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
        {
            return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
            this.m.IsDoingAttackMove = false;
            this.getContainer().setBusy(true);
            this.Time.scheduleEvent(this.TimeUnit.Virtual, 275, function() /* closure #0 */.bindenv(this), this);
            return _user;
        }
        if ((this._skill != null) && (this._skill != null))
        {
            return ((this._skill != null) && (this._skill != null));
            if (this.attackEntity(_user, _targetTile.getEntity()))
            {
            }
            return _user;
            this.setImpaleInfo();
            return _user;
        }
    }
}

function setImpaleInfo(this)
{
    this.m.SoundOnHit = clone this;
    this.m.SoundOnUse = clone this;
    this.m.InjuriesOnBody = clone this;
    this.m.InjuriesOnHead = clone this;
    this.m.ChanceDecapitate = 0;
    this.m.ChanceDisembowel = 25;
    this.m.Name = "Impale";
    return;
}

function setStrikeInfo(this)
{
    this.m.SoundOnHit = clone this;
    this.m.SoundOnUse = clone this;
    this.m.InjuriesOnBody = clone this;
    this.m.InjuriesOnHead = clone this;
    this.m.ChanceDecapitate = 50;
    this.m.ChanceDisembowel = 33;
    this.m.Name = "Strike";
    return;
}
