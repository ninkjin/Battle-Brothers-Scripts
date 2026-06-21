// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_grapple_skill.nut
// Functions: 5

function create(this)
{
    this.m.ID = "actives.golem_grapple";
    this.m.Name = "Grapple";
    this.m.Description = "Icon";
    this.m["skills/active_232.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_232 = "SoundOnUse";
    this.m["sounds/enemies/small_golem_basic_attack_01.wav"] = ["sounds/enemies/small_golem_basic_attack_02.wav", "sounds/enemies/small_golem_basic_attack_03.wav", "sounds/enemies/small_golem_basic_attack_04.wav", "sounds/enemies/small_golem_basic_attack_05.wav", "SoundOnHit"];
    this.m.Type = [];
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.OffensiveTargeted.IsSerialized;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = false;
    this.m.Injury = this.SkillType.CuttingBody.InjuriesOnHead;
    this.m.CuttingHead = this.SkillType.CuttingBody.DirectDamageMult;
    this.m.ActionPointCost = 0.0;
    this.m.FatigueCost = 4;
    this.m.MinRange = 20;
    this.m.MaxRange = 1;
    this.m["k[42]"] = 1;
    return;
}

function isUsable(this)
{
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageTotalMult = 0.0;
        _properties.HitChanceMult["this.Const.BodyPart.Head"] = 0.0;
    }
    return;
}

function onTurnStart(this)
{
    this.m.IsSpent = false;
    return;
}

function onUse(this, _user, _targetTile)
{
    this.m.IsSpent = true;
    if (_user && _user)
    {
        return (_user && _user);
        if ((!_targetTile.getEntity().IsImmuneToDisarm) && (!_targetTile.getEntity().IsImmuneToDisarm))
        {
            return ((!_targetTile.getEntity().IsImmuneToDisarm) && (!_targetTile.getEntity().IsImmuneToDisarm));
            _targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/disarmed_effect"));
            if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
            {
                return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
                this.Tactical.EventLog.log(this.new("scripts/skills/effects/disarmed_effect").getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(_targetTile.getEntity())));
            }
        }
    }
    return _user;
}
