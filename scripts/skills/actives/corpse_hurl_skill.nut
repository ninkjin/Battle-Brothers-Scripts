// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/corpse_hurl_skill.nut
// Functions: 6

function create(this)
{
    this.m.ID = "actives.corpse_hurl_skill";
    this.m.Name = "Corpse Hurl";
    this.m.Description = "KilledString";
    this.m.Crushed = "Icon";
    this.m["skills/active_233.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_233 = "SoundOnUse";
    this.m["sounds/enemies/big_golem_windup_01.wav"] = ["sounds/enemies/big_golem_windup_02.wav", "sounds/enemies/big_golem_windup_03.wav", "SoundOnHit"];
    this.m["sounds/enemies/corpse_throw_impact_01.wav"] = ["sounds/enemies/corpse_throw_impact_02.wav", "sounds/enemies/corpse_throw_impact_03.wav", "sounds/enemies/corpse_throw_impact_04.wav", "SoundOnHitDelay"];
    this.m.Type = 0;
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.OffensiveTargeted.Delay;
    this.m.IsSerialized = 600;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsTargetingActor = true;
    this.m.IsVisibleTileNeeded = false;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsRanged = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsAOE = true;
    this.m.IsUsingActorPitch = true;
    this.m.IsSpearwallRelevant = true;
    this.m.InjuriesOnBody = false;
    this.m.Injury = this.SkillType.BluntBody.InjuriesOnHead;
    this.m.BluntHead = this.SkillType.BluntBody.DirectDamageMult;
    this.m.ActionPointCost = 0.4000000059604645;
    this.m.FatigueCost = 8;
    this.m.MinRange = 30;
    this.m.MaxRange = 2;
    this.m.MaxLevelDifference = 4;
    this.m.IsShowingProjectile = 3;
    this.m.ProjectileType = true;
    this.m.Corpse = this.SkillType.Corpse.ProjectileTimeScale;
    this.m.IsProjectileRotated = 1.3300000429153442;
    this.m.ChanceDecapitate = true;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 0;
    this.m["k[62]"] = 66;
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
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 55;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 65;
        _properties.DamageArmorMult = _properties.DamageArmorMult op42 1.100000023841858;
    }
    return;
}

function onRelease(this, _data)
{
    this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(_data.Skill.getContainer().getActor()) + " hurls a corpse"));
    if (0 < 6)
    {
        if (!_data.TargetTile.hasNextTile(0))
        {
        }
        [].push(_data.TargetTile.getNextTile(0));
    }
    if (!_data.TargetTile.IsCorpseSpawned)
    {
    }
    foreach (local key, value in r70)
    {
        if (null.IsOccupiedByActor)
        {
            clone this.DamageRegular = this.Math.rand(20, 40);
            clone this.DamageArmor = (clone this.DamageRegular * 0.5);
            clone this.DamageDirect = 0.25;
            clone this.BodyPart = 0;
            clone this.FatalityChanceMult = 0.0;
            clone this.Injuries = this.Const.Injury.BluntBody;
            null.getEntity().onDamageReceived(null, this, clone this);
            this.Tactical.getShaker().shake(null.getEntity(), null, 7);
        }
        else
        {
            if ((!null.IsCorpseSpawned) && (!null.IsCorpseSpawned))
            {
                return ((!null.IsCorpseSpawned) && (!null.IsCorpseSpawned));
            }
        }
        if (null != null)
        {
            this.spawnCorpse(_data.Skill.getContainer().getActor(), null);
        }
        return;
    }
}

function onUse(this, _user, _targetTile)
{
    this.Sound.play(this.m.SoundOnHit["this.Math.rand(0, (this.m.SoundOnHit.len() - 1))"], 1.0, _targetTile.Pos);
    if (_targetTile.IsOccupiedByActor)
    {
        this.attackEntity(this.m.Container.getActor(), _targetTile.getEntity());
    }
    else
    {
        if ((this.m.ProjectileType != 0) && (this.m.ProjectileType != 0))
        {
            return ((this.m.ProjectileType != 0) && (this.m.ProjectileType != 0));
            if (_targetTile.Pos.X > this.m.Container.getActor().getPos().X)
            {
                if ((_targetTile.Pos.X > this.m.Container.getActor().getPos().X) >= this.Const.Combat.SpawnProjectileMinDist)
                {
                    this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite["this.m.ProjectileType"], this.m.Container.getActor().getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, (_targetTile.Pos.X > this.m.Container.getActor().getPos().X));
                }
            }
        }
    }
    this.Time.scheduleEvent(this.TimeUnit.Virtual, 350, this.onRelease.bindenv(this), {});
    return _user;
}

function spawnCorpse(this, _user, _tile)
{
    if (_tile == null)
    {
        return;
    }
    _tile.spawnDetail("bust_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
    _tile.spawnDetail("bust_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
    _tile.spawnDetail([]["this.Math.rand(0, ([].len() - 1))"], this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
    _tile.spawnDetail([]["this.Math.rand(0, ([].len() - 1))"], this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
    _user.spawnTerrainDropdownEffect(_tile);
    clone this.CorpseName = "A Fleshy Corpse";
    clone this.Tile = _tile;
    clone this.IsResurrectable = false;
    clone this.IsConsumable = true;
    clone this.IsHeadAttached = false;
    _tile.Properties.set("Corpse", clone this);
    this.Tactical.Entities.addCorpse(_tile);
    return;
}
