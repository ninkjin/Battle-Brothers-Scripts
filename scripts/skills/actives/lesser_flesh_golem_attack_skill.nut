// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/lesser_flesh_golem_attack_skill.nut
// Functions: 4

function create(this)
{
    this.m.ID = "actives.lesser_flesh_golem_attack";
    this.m.Name = "Smack";
    this.m.Description = "KilledString";
    this.m.Smacked = "Icon";
    this.m["skills/active_227.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_227 = "SoundOnUse";
    this.m["sounds/enemies/small_golem_basic_attack_01.wav"] = ["sounds/enemies/small_golem_basic_attack_02.wav", "sounds/enemies/small_golem_basic_attack_03.wav", "sounds/enemies/small_golem_basic_attack_04.wav", "sounds/enemies/small_golem_basic_attack_05.wav", "SoundOnHit"];
    this.m["sounds/combat/bash_hit_01.wav"] = ["sounds/combat/bash_hit_02.wav", "sounds/combat/bash_hit_03.wav", "Type"];
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.OffensiveTargeted.IsSerialized;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = false;
    this.m.Injury = this.SkillType.BluntBody.InjuriesOnHead;
    this.m.BluntHead = this.SkillType.BluntBody.DirectDamageMult;
    this.m.ActionPointCost = 0.20000000298023224;
    this.m.FatigueCost = 4;
    this.m.MinRange = 20;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 1;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 0;
    this.m["k[49]"] = 50;
    return;
}

function isUsable(this)
{
    return;
}

function onUpdate(this, _properties)
{
    if (this.isUsable())
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 40;
        _properties.DamageArmorMult = _properties.DamageArmorMult op42 0.6499999761581421;
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
    if (_user && _user)
    {
        return (_user && _user);
        if ((!_targetTile.getEntity() && (!_targetTile.getEntity())))
        {
            return ((!_targetTile.getEntity()) && (!_targetTile.getEntity()));
            _targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
            if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
            {
                return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
                this.Tactical.EventLog.log(this.new("scripts/skills/effects/dazed_effect").getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(_targetTile.getEntity())));
            }
        }
    }
    return _user;
}
