// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/perforate_skill.nut
// Functions: 5

function create(this)
{
    this.m.ID = "actives.perforate";
    this.m.Name = "Perforate";
    this.m.Description = "A series of two or more thrusts made in quick succession, depending on how many injuries the opponent has suffered.";
    this.m.KilledString = "Turned into a pincushion";
    this.m.Icon = "skills/active_237.png";
    this.m.IconDisabled = "skills/active_237_sw.png";
    this.m.Overlay = "active_237";
    this.m.SoundOnUse = ["sounds/combat/impale_01.wav", "sounds/combat/impale_02.wav", "sounds/combat/impale_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/dlc2/lunge_attack_hit_01.wav", "sounds/combat/dlc2/lunge_attack_hit_02.wav", "sounds/combat/dlc2/lunge_attack_hit_03.wav", "sounds/combat/dlc2/lunge_attack_hit_04.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsWeaponSkill = true;
    this.m.Delay = 250;
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

function onAdditionalAttack(this, _tag)
{
    if ((_tag.Target != null) && (_tag.Target != null))
    {
        return ((_tag.Target != null) && (_tag.Target != null));
        _tag.Skill.spawnAttackEffect(_tag.Target.getTile(), this.Const.Tactical.AttackEffectStab);
        this.Sound.play(_tag.Skill.m.SoundOnUse["this.Math.rand(0, (_tag.Skill.m.SoundOnUse.len() - 1))"], this.Const.Sound.Volume.Skill, _tag.User.getPos());
        _tag.Skill.attackEntity(_tag.User, _tag.Target);
    }
    if (_tag.IsLast)
    {
        _tag.Skill.m.IsDoingAttackMove = true;
        _tag.Skill.getContainer().setBusy(false);
    }
    return;
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

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectStab);
    if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
    {
        return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
        this.m.IsDoingAttackMove = false;
        this.getContainer().setBusy(true);
        this.Time.scheduleEvent(this.TimeUnit.Virtual, 150, this.onAdditionalAttack, {});
        if (0 < _targetTile.getEntity().getSkills().getAllSkillsOfType(this.Const.SkillType.TemporaryInjury).len())
        {
            this.Time.scheduleEvent(this.TimeUnit.Virtual, (200 + this.Math.rand(0, 55)), this.onAdditionalAttack, {});
        }
        return _user;
    }
    if (_targetTile.getEntity().isAlive())
    {
        this.Sound.play(this.m.SoundOnUse["this.Math.rand(0, (this.m.SoundOnUse.len() - 1))"], this.Const.Sound.Volume.Skill, _user.getPos());
        if (this.attackEntity(_user, _targetTile.getEntity()))
        {
        }
        return _user;
    }
}
