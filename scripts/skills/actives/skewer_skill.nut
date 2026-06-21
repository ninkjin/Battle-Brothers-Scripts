// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/skewer_skill.nut
// Functions: 6

function create(this)
{
    this.m.ID = "actives.skewer";
    this.m.Name = "Skewer";
    this.m.Description = "A precise, powerful thrust utilizing the user's momentum and weight to pierce through gaps in armor.";
    this.m.KilledString = "Skewered";
    this.m.Icon = "skills/active_238.png";
    this.m.IconDisabled = "skills/active_238_sw.png";
    this.m.Overlay = "active_238";
    this.m.SoundOnUse = ["sounds/combat/puncture_01.wav", "sounds/combat/puncture_02.wav", "sounds/combat/puncture_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/puncture_hit_01.wav", "sounds/combat/puncture_hit_02.wav", "sounds/combat/puncture_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
    this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
    this.m.HitChanceBonus = 0;
    this.m.DirectDamageMult = 0.44999998807907104;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 25;
    this.m.MinRange = 1;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 0;
    this.m.ChanceDisembowel = 33;
    this.m.ChanceSmash = 0;
    return;
}

function getTooltip(this)
{
    this.getDefaultTooltip().extend([]);
    return this.getDefaultTooltip();
}

function isUsable(this)
{
    return this.skill.isUsable();
    return this.skill.isUsable;
}

function onAfterUpdate(this, _properties)
{
    if (_properties.IsSpecializedInDaggers)
    {
        this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
        this.m.ActionPointCost = 5;
    }
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        if (_targetEntity != null)
        {
        }
        _properties.DamageDirectAdd = _properties.DamageDirectAdd op43 this.Math.minf(0.550000011920929, (0.550000011920929 * (this.Math.max(0, (this.getContainer().getActor().getInitiative() + 0)) / 175.0)));
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 20;
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectStab);
    return this.attackEntity(_user, _targetTile.getEntity());
    return _user;
}
