// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/config/tactical_entity_common.nut
// Functions: 8

function checkDrugEffect(this, _actor)
{
    if ((this.World.State.getCombatStartTime() != 0) && (this.World.State.getCombatStartTime() != 0))
    {
        return ((this.World.State.getCombatStartTime() != 0) && (this.World.State.getCombatStartTime() != 0));
    }
    _actor.getFlags().set("PotionLastUsed", this.Time.getVirtualTimeF());
    _actor.getFlags().increment("PotionsUsed", 1);
    if ((null == r18) && (null == r18))
    {
        return ((null == r18) && (null == r18));
    }
    if (_actor.getSkills().hasSkill("trait.strong"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.tough"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.athletic"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.survivor"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.fragile"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.gluttonous"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.old"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.spartan"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.ailing"))
    {
    }
    if (_actor.getSkills().hasSkill("trait.tiny"))
    {
    }
    if (this.Math.rand(1, 100) <= (((((((((((((_actor.getSkills().getAllSkillsOfType(this.Const.SkillType.DrugEffect).len() - 1) * 50) - 10) - 10) - 10) - 10) - 10) + 10) + 10) + 10) + 10) + 10) + 10))
    {
        _actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
        this.Sound.play("sounds/vomit_01.wav", this.Const.Sound.Volume.Actor);
    }
    return;
}

function getBlockedTiles(this, _myTile, _targetTile, _myFaction, _visibleOnly)
{
    if (_targetTile.hasNextTile(_targetTile.getDirectionTo(_myTile)))
    {
        if (_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile).IsVisibleForPlayer && _targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)).IsVisibleForPlayer))
        {
            return (_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)).IsVisibleForPlayer && _targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)).IsVisibleForPlayer);
            if ((!_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)) && (!_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)))))
            {
                return ((!_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile))) && (!_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile))));
                [].push(_targetTile.getNextTile(_targetTile.getDirectionTo(_myTile)));
            }
        }
    }
    if (((_myTile.X - _myTile.Y) == (_targetTile.X - _targetTile.Y) && ((_myTile.X - _myTile.Y) == (_targetTile.X - _targetTile.Y))))
    {
        return (((_myTile.X - _myTile.Y) == (_targetTile.X - _targetTile.Y)) && ((_myTile.X - _myTile.Y) == (_targetTile.X - _targetTile.Y)));
        if ((_targetTile.getDirectionTo(_myTile) + 1) < this.Const.Direction.COUNT)
        {
        }
        if (_targetTile.hasNextTile(0))
        {
            if (_targetTile.getNextTile(0).IsVisibleForPlayer && _targetTile.getNextTile(0).IsVisibleForPlayer && _targetTile.getNextTile(0).IsVisibleForPlayer)
            {
                return (_targetTile.getNextTile(0).IsVisibleForPlayer && _targetTile.getNextTile(0).IsVisibleForPlayer && _targetTile.getNextTile(0).IsVisibleForPlayer);
                if ((!_targetTile.getNextTile(0) && (!_targetTile.getNextTile(0))))
                {
                    return ((!_targetTile.getNextTile(0)) && (!_targetTile.getNextTile(0)));
                    [].push(_targetTile.getNextTile(0));
                }
            }
        }
        if ((_targetTile.getDirectionTo(_myTile) - 1) >= 0)
        {
        }
        if (_targetTile.hasNextTile((this.Const.Direction.COUNT - 1)))
        {
            if (_targetTile.getNextTile((this.Const.Direction.COUNT - 1).IsVisibleForPlayer && _targetTile.getNextTile((this.Const.Direction.COUNT - 1)).IsVisibleForPlayer && _targetTile.getNextTile((this.Const.Direction.COUNT - 1)).IsVisibleForPlayer))
            {
                return (_targetTile.getNextTile((this.Const.Direction.COUNT - 1)).IsVisibleForPlayer && _targetTile.getNextTile((this.Const.Direction.COUNT - 1)).IsVisibleForPlayer && _targetTile.getNextTile((this.Const.Direction.COUNT - 1)).IsVisibleForPlayer);
                if ((!_targetTile.getNextTile((this.Const.Direction.COUNT - 1)) && (!_targetTile.getNextTile((this.Const.Direction.COUNT - 1)))))
                {
                    return ((!_targetTile.getNextTile((this.Const.Direction.COUNT - 1))) && (!_targetTile.getNextTile((this.Const.Direction.COUNT - 1))));
                    [].push(_targetTile.getNextTile((this.Const.Direction.COUNT - 1)));
                }
            }
        }
    }
    return _myTile;
}

function getRandomPlayerName(this)
{
    return this.Const.Strings.CharacterNames["this.Math.rand(0, (this.Const.Strings.CharacterNames.len() - 1))"];
}

function kill(this, _entity)
{
    _entity.die();
    return;
}

function onApplyFire(this, _tile, _entity)
{
    if (_entity.getCurrentProperties().IsImmuneToFire)
    {
        return;
    }
    this.Tactical.spawnIconEffect("status_effect_116", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
    this.Sound.play([]["this.Math.rand(0, ([].len() - 1))"], this.Const.Sound.Volume.Actor, _entity.getPos());
    clone this.DamageRegular = (this.Math.rand(15, 30) * _entity.getCurrentProperties().DamageReceivedFireMult);
    clone this.DamageArmor = this.Math.rand(15, 30);
    clone this.DamageDirect = 0.10000000149011612;
    clone this.BodyPart = this.Const.BodyPart.Body;
    clone this.BodyDamageMult = 1.0;
    clone this.FatalityChanceMult = 0.0;
    clone this.Injuries = this.Const.Injury.Burning;
    clone this.IsPlayingArmorSound = false;
    _entity.onDamageReceived(_entity, null, clone this);
    if (_tile.Properties.Effect.IsByPlayer && _tile.Properties.Effect.IsByPlayer)
    {
        return (_tile.Properties.Effect.IsByPlayer && _tile.Properties.Effect.IsByPlayer);
        this.updateAchievement("BurnThemAll", 1, 1);
    }
    return;
}

function onApplyMiasma(this, _tile, _entity)
{
    if (_entity.getFlags().has("undead"))
    {
        return;
    }
    if (_entity.getCurrentProperties().IsImmuneToPoison)
    {
        return;
    }
    this.Tactical.spawnIconEffect("status_effect_00", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
    if (_entity.getFlags().has("human"))
    {
    }
    this.Sound.play([]["this.Math.rand(0, ([].len() - 1))"], this.Const.Sound.Volume.Actor, _entity.getPos());
    clone this.DamageRegular = (this.Math.rand(5, 10) * _entity.getCurrentProperties().DamageReceivedMiasmaMult);
    clone this.DamageDirect = 1.0;
    clone this.BodyPart = this.Const.BodyPart.Body;
    clone this.BodyDamageMult = 1.0;
    clone this.FatalityChanceMult = 0.0;
    _tile.getEntity().onDamageReceived(_entity, null, clone this);
    return;
}

function onApplySmoke(this, _tile, _entity)
{
    if (_entity.isNonCombatant())
    {
        return;
    }
    if (_entity.getSkills().getSkillByID("effects.smoke") == null)
    {
        _entity.getSkills().add(this.new("scripts/skills/effects/smoke_effect"));
    }
    return;
}

function onSpawnFlies(this, _tile)
{
    if (_tile.Properties.has("IsSpawningFlies") && _tile.Properties.has("IsSpawningFlies"))
    {
        return (_tile.Properties.has("IsSpawningFlies") && _tile.Properties.has("IsSpawningFlies"));
        if (0 < this.Const.FliesDecals.len())
        {
            _tile.spawnDetail(this.Const.FliesDecals["0"], this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 1) == 0));
        }
    }
    return;
}
