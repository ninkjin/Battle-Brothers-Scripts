// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/estoc_stab_skill.nut
// Functions: 6

function create(this)
{
    this.m.ID = "actives.estoc_stab";
    this.m.Name = "Stab";
    this.m.Description = "A quick and fast stab.";
    this.m.KilledString = "Stabbed";
    this.m.Icon = "skills/active_236.png";
    this.m.IconDisabled = "skills/active_236_sw.png";
    this.m.Overlay = "active_236";
    this.m.SoundOnUse = ["sounds/combat/stab_01.wav", "sounds/combat/stab_02.wav", "sounds/combat/stab_03.wav"];
    this.m.SoundOnHitHitpoints = ["sounds/combat/stab_hit_01.wav", "sounds/combat/stab_hit_02.wav", "sounds/combat/stab_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
    this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
    this.m.DirectDamageMult = 0.44999998807907104;
    this.m.HitChanceBonus = 0;
    this.m.ActionPointCost = 5;
    this.m.FatigueCost = 11;
    this.m.MinRange = 1;
    this.m.MaxRange = 1;
    return;
}

function getHitChanceModifier(this)
{
    return 5;
}

function getTooltip(this)
{
    this.getDefaultTooltip().push({});
    return this.getDefaultTooltip();
}

function onAfterUpdate(this, _properties)
{
    if (_properties.IsSpecializedInDaggers)
    {
        this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
        this.m.ActionPointCost = 4;
    }
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.MeleeSkill = _properties.MeleeSkill op43 this.getHitChanceModifier();
        this.m.HitChanceBonus = this.m.HitChanceBonus op43 this.getHitChanceModifier();
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    return this.attackEntity(_user, _targetTile.getEntity());
    return _user;
}
