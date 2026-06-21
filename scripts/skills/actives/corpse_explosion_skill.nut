// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/corpse_explosion_skill.nut
// Functions: 9

function create(this)
{
    this.m.ID = "actives.corpse_explosion";
    this.m.Name = "Corpse Explosion";
    this.m.Description = "Icon";
    this.m["skills/active_234.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_234 = "SoundOnUse";
    this.m["sounds/enemies/corpse_explosion_01.wav"] = ["sounds/enemies/corpse_explosion_02.wav", "sounds/enemies/corpse_explosion_03.wav", "sounds/enemies/corpse_explosion_04.wav", "Type"];
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.UtilityTargeted.Delay;
    this.m.IsSerialized = 2000;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsTargetingActor = true;
    this.m.IsVisibleTileNeeded = false;
    this.m.IsStacking = false;
    this.m.IsAttack = false;
    this.m.IsIgnoredAsAOO = false;
    this.m.ActionPointCost = true;
    this.m.FatigueCost = 8;
    this.m.MinRange = 10;
    this.m.MaxRange = 1;
    this.m.MaxLevelDifference = 99;
    this.m["k[37]"] = 4;
    return;
}

function getTooltip(this)
{
    return this.getContainer().getActor().getCurrentProperties();
}

function isUsable(this)
{
    return this.skill.isUsable();
    return this.skill.isUsable;
}

function onApply(this, _data)
{
    this.spawnBloodbath(_data.TargetTile);
    if (_data.TargetTile.IsVisibleForPlayer && _data.TargetTile.IsVisibleForPlayer)
    {
        return (_data.TargetTile.IsVisibleForPlayer && _data.TargetTile.IsVisibleForPlayer);
        if (!_data.TargetTile.getEntity().getIsDestroyed())
        {
            this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(_data.User) + " causes a flesh cradle to explode!"));
        }
        this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(_data.User) + " causes a corpse to explode!"));
        if (this.m.SoundOnUse.len() != 0)
        {
            this.Sound.play(this.m.SoundOnUse["this.Math.rand(0, (this.m.SoundOnUse.len() - 1))"], (this.Const.Sound.Volume.Skill * 1.2000000476837158), _data.User.getPos());
        }
    }
    [].push(_data.TargetTile);
    if (0 != 6)
    {
        if (!_data.TargetTile.hasNextTile(0))
        {
        }
        [].push(_data.TargetTile.getNextTile(0));
    }
    foreach (local key, value in r156)
    {
        if (null.ID == _data.TargetTile.ID)
        {
            if (0 < this.Const.Tactical.CorpseExplosionParticles.len())
            {
                this.Tactical.spawnParticleEffect(false, this.Const.Tactical.CorpseExplosionParticles["0"].Brushes, null, this.Const.Tactical.CorpseExplosionParticles["0"].Delay, this.Const.Tactical.CorpseExplosionParticles["0"].Quantity, this.Const.Tactical.CorpseExplosionParticles["0"].LifeTimeQuantity, this.Const.Tactical.CorpseExplosionParticles["0"].SpawnRate, this.Const.Tactical.CorpseExplosionParticles["0"].Stages, this.createVec(0, 0));
            }
        }
        else
        {
            if (0 < this.Const.Tactical.CorpseExplosionOuterParticles.len())
            {
                this.Tactical.spawnParticleEffect(false, this.Const.Tactical.CorpseExplosionOuterParticles["0"].Brushes, null, this.Const.Tactical.CorpseExplosionOuterParticles["0"].Delay, this.Const.Tactical.CorpseExplosionOuterParticles["0"].Quantity, this.Const.Tactical.CorpseExplosionOuterParticles["0"].LifeTimeQuantity, this.Const.Tactical.CorpseExplosionOuterParticles["0"].SpawnRate, this.Const.Tactical.CorpseExplosionOuterParticles["0"].Stages, this.createVec(0, 0));
            }
        }
        if ((null.getEntity().getType() != this.Const.EntityType.FleshCradle) && (null.getEntity().getType() != this.Const.EntityType.FleshCradle))
        {
            return ((null.getEntity().getType() != this.Const.EntityType.FleshCradle) && (null.getEntity().getType() != this.Const.EntityType.FleshCradle));
            if (null.isSameTileAs(_data.TargetTile))
            {
            }
            clone this.DamageRegular = this.Math.rand(25, 50);
            clone this.DamageArmor = (clone this.DamageRegular * 0.75);
            clone this.DamageDirect = 0.20000000298023224;
            clone this.BodyPart = 0;
            clone this.FatalityChanceMult = 0.0;
            clone this.Injuries = this.Const.Injury.BurningAndPiercingBody;
            null.getEntity().onDamageReceived(null, this, clone this);
        }
        this.Tactical.State.spawnMiasmaOnTile(null);
        return;
    }
}

function onDestroyFleshCradle(this, _data)
{
    _data.FleshCradle.setDestroyed(true);
    return;
}

function onRemoveCorpse(this, _tile)
{
    this.Tactical.Entities.removeCorpse(_tile);
    _tile.clear(this.Const.Tactical.DetailFlag.Corpse);
    _tile.Properties.remove("Corpse");
    _tile.Properties.remove("IsSpawningFlies");
    return;
}

function onUse(this, _user, _targetTile)
{
    if (!_targetTile.getEntity().getIsDestroyed())
    {
        this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onDestroyFleshCradle.bindenv(this), {});
    }
    this.onRemoveCorpse(_targetTile);
    this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {});
    return _user;
}

function onVerifyTarget(this, _originTile, _targetTile)
{
    if (!this.skill.onVerifyTarget(_originTile, _targetTile))
    {
        return _originTile;
    }
    if ((!(!_targetTile.getEntity().getIsDestroyed()) && (!(!_targetTile.getEntity().getIsDestroyed())) && (!(!_targetTile.getEntity().getIsDestroyed()))))
    {
        return ((!(!_targetTile.getEntity().getIsDestroyed())) && (!(!_targetTile.getEntity().getIsDestroyed())) && (!(!_targetTile.getEntity().getIsDestroyed())));
        return _originTile;
    }
    return _originTile;
}

function spawnBloodbath(this, _targetTile)
{
    if (0 != this.Const.CorpsePart.len())
    {
        _targetTile.spawnDetail(this.Const.CorpsePart["0"]);
    }
    if (0 != 6)
    {
        if (!_targetTile.hasNextTile(0))
        {
        }
        else
        {
            if (this.Math.rand(0, 4) != 0)
            {
                _targetTile.getNextTile(0).spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Red"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Red"].len() - 1))"]);
            }
        }
    }
    if (2 != 0)
    {
        _targetTile.spawnDetail(this.Const.BloodDecals["this.Const.BloodType.Red"]["this.Math.rand(0, (this.Const.BloodDecals["this.Const.BloodType.Red"].len() - 1))"]);
    }
    return;
}
