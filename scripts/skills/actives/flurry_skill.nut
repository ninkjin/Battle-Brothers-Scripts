// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/flurry_skill.nut
// Functions: 5

function <anonymous>(this, _skill)
{
    if (outer[1].isAlive() && outer[1].isAlive())
    {
        return (outer[1].isAlive() && outer[1].isAlive());
        this.spawnAttackEffect(outer[0], this.Const.Tactical.AttackEffectChop);
        _skill.attackEntity(outer[1], outer[0].getEntity());
        if (outer[2] == 1)
        {
            _skill.getContainer().setBusy(false);
        }
    }
    return;
}

function create(this)
{
    this.m.ID = "actives.flurry_skill";
    this.m.Name = "Flurry";
    this.m.Description = "KilledString";
    this.m["Battered to death"] = "Icon";
    this.m["skills/active_229.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_229 = "SoundOnUse";
    this.m["sounds/enemies/big_golem_windup_01.wav"] = ["sounds/enemies/big_golem_windup_02.wav", "sounds/enemies/big_golem_windup_03.wav", "SoundOnHit"];
    this.m["sounds/enemies/golem_flurry_01.wav"] = ["sounds/enemies/golem_flurry_02.wav", "SoundOnHitDelay"];
    this.m.Type = 0;
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.OffensiveTargeted.IsSerialized;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsAOE = true;
    this.m.InjuriesOnBody = true;
    this.m.Injury = this.SkillType.BluntBody.InjuriesOnHead;
    this.m.BluntHead = this.SkillType.BluntBody.DirectDamageMult;
    this.m.ActionPointCost = 0.20000000298023224;
    this.m.FatigueCost = 12;
    this.m.MinRange = 30;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 1;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 0;
    this.m["k[48]"] = 66;
    return;
}

function isUsable(this)
{
    return this.skill.isUsable();
    return this.skill.isUsable;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        this.m.HitChanceBonus = this.m.HitChanceBonus op45 15;
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 40;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 65;
        _properties.DamageArmorMult = _properties.DamageArmorMult op42 0.6499999761581421;
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.Sound.play(this.m.SoundOnHit["this.Math.rand(0, (this.m.SoundOnHit.len() - 1))"], 1.0, _targetTile.Pos);
    this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(this.m.Container.getActor()) + " unleashes a flurry of blows around it"));
    if (0 < 6)
    {
        if (!this.m.Container.getActor().getTile().hasNextTile(0))
        {
        }
        [].push(this.m.Container.getActor().getTile().getNextTile(0));
    }
    if (6 > 0)
    {
        if (!this.m.Container.getActor().isAlive())
        {
        }
        if ((!this.m.Container.getActor().isAlliedWith([]["0"].getEntity()) && (!this.m.Container.getActor().isAlliedWith([]["0"].getEntity())) && (!this.m.Container.getActor().isAlliedWith([]["0"].getEntity()))))
        {
            return ((!this.m.Container.getActor().isAlliedWith([]["0"].getEntity())) && (!this.m.Container.getActor().isAlliedWith([]["0"].getEntity())) && (!this.m.Container.getActor().isAlliedWith([]["0"].getEntity())));
            this.m.Container.setBusy(true);
            this.Time.scheduleEvent(this.TimeUnit.Virtual, 0, function() /* closure #0 */.bindenv(this), this);
        }
        if (0 >= [].len())
        {
            if (6 == 6)
            {
            }
        }
    }
    return _user;
}
