// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/censer_strike.nut
// Functions: 5

function create(this)
{
    this.m.ID = "actives.censer_strike";
    this.m.Name = "Censer Strike";
    this.m.Description = "Strike a target with a weaponized censer and leave a harmful miasma in the attack's wake. Somewhat unpredictable, but able to strike at a distance of 2 tiles and over or around shield cover with a bit of luck and skill.";
    this.m.KilledString = "Pounded to death";
    this.m.Icon = "skills/active_228.png";
    this.m.IconDisabled = "skills/active_228_sw.png";
    this.m.Overlay = "active_228";
    this.m.SoundOnUse = ["sounds/combat/pound_01.wav", "sounds/combat/pound_02.wav", "sounds/combat/pound_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/pound_hit_01.wav", "sounds/combat/pound_hit_02.wav", "sounds/combat/pound_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsRanged = false;
    this.m.IsTooCloseShown = true;
    this.m.IsShieldRelevant = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
    this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
    this.m.DirectDamageMult = 0.30000001192092896;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 15;
    this.m.MinRange = 1;
    this.m.MaxRange = 2;
    this.m.ChanceDecapitate = 0;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 66;
    return;
}

function getTooltip(this)
{
    this.getDefaultTooltip().push({});
    if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
    {
        this.getDefaultTooltip().push({});
    }
    this.getDefaultTooltip().push({});
    this.getDefaultTooltip().push({});
    return this.getDefaultTooltip();
}

function onAfterUpdate(this, _properties)
{
    if (_properties.IsSpecializedInFlails)
    {
    }
    this.m.FatigueCostMult = 1.0;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        if ((this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile() == 1) && (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)))
        {
            return ((this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1) && (this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1));
            _properties.MeleeSkill = _properties.MeleeSkill op43 -15;
            this.m.HitChanceBonus = this.m.HitChanceBonus op43 -15;
        }
        if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
        {
            this.m.IsShieldRelevant = false;
        }
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
    this.Tactical.State.spawnMiasmaOnTile(_targetTile);
    if (_user && _user)
    {
        return (_user && _user);
        return _user;
    }
    return _user;
}
