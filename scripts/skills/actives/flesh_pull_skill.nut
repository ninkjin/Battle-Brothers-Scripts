// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/flesh_pull_skill.nut
// Functions: 8

function create(this)
{
    this.m.ID = "actives.flesh_pull";
    this.m.Name = "Flesh Pull";
    this.m.Description = "Icon";
    this.m["skills/active_235.png"] = "Overlay";
    this.m.active_235 = "SoundOnUse";
    this.m["sounds/enemies/faultfinder_pull_01.wav"] = ["sounds/enemies/faultfinder_pull_02.wav", "Delay"];
    this.m.Type = 1000;
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.UtilityTargeted.IsSerialized;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsWeaponSkill = true;
    this.m.IsVisibleTileNeeded = true;
    this.m.IsUsingHitchance = false;
    this.m.IsTargetingCorpses = false;
    this.m.IsTargetingDangerTiles = true;
    this.m.ActionPointCost = true;
    this.m.FatigueCost = 6;
    this.m.MinRange = 20;
    this.m.MaxRange = 1;
    this.m.MaxLevelDifference = 99;
    this.m["k[37]"] = 4;
    return;
}

function getPulledToTiles(this, _userTile, _targetTile)
{
    foreach (local key, value in r54)
    {
        if (null.IsCorpseSpawned)
        {
            if ((r10 <= this.m.PullRange) && (r10 <= this.m.PullRange))
            {
                return ((r10 <= this.m.PullRange) && (r10 <= this.m.PullRange));
                [].push(null);
            }
            if (0 != 6)
            {
                if (!null.hasNextTile(0))
                {
                }
                else
                {
                    if ((0 <= this.m.PullRange) && (0 <= this.m.PullRange))
                    {
                        return ((0 <= this.m.PullRange) && (0 <= this.m.PullRange));
                        [].push(null.getNextTile(0));
                    }
                }
            }
        }
        foreach (local key, value in r18)
        {
            if (this && this)
            {
                return (this && this);
                [].push(null);
            }
            foreach (local key, value in r48)
            {
                if (null.getTile().getDistanceTo(_targetTile) <= (this.m.PullRange + 1))
                {
                }
                if (0 != 6)
                {
                    if (!null.getTile().hasNextTile(0))
                    {
                    }
                    else
                    {
                        if ((0 <= this.m.PullRange) && (0 <= this.m.PullRange))
                        {
                            return ((0 <= this.m.PullRange) && (0 <= this.m.PullRange));
                            [].push(null.getTile().getNextTile(0));
                        }
                    }
                }
                return _userTile;
            }
        }
    }
}

function isUsable(this)
{
    return;
}

function onAfterDone(this, _data)
{
    _data.Target.setDirty(true);
    return;
}

function onDone(this, _data)
{
    _data.Target.getSprite("status_rooted").fadeOutAndHide(50);
    _data.Target.getSprite("status_rooted").Scale = _data.ScaleBackup;
    _data.Target.getSprite("status_rooted_back").fadeOutAndHide(50);
    _data.Target.getSprite("status_rooted_back").Scale = _data.ScaleBackup;
    this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, _data.Skill.onAfterDone, _data);
    return;
}

function onUse(this, _user, _targetTile)
{
    if (this.m.DestinationTile == null)
    {
        return _user;
    }
    if (_targetTile.getEntity().IsImmuneToKnockBackAndGrab && _targetTile.getEntity().IsImmuneToKnockBackAndGrab)
    {
        return (_targetTile.getEntity().IsImmuneToKnockBackAndGrab && _targetTile.getEntity().IsImmuneToKnockBackAndGrab);
        return _user;
    }
    if (this.m.DestinationTile.IsVisibleForPlayer && this.m.DestinationTile.IsVisibleForPlayer)
    {
        return (this.m.DestinationTile.IsVisibleForPlayer && this.m.DestinationTile.IsVisibleForPlayer);
        this.Tactical.EventLog.log((("Fleshy tentacles appear and drag in " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity())) + "!"));
    }
    if ((!_user) && (!_user))
    {
        return ((!_user) && (!_user));
        _targetTile.getEntity().getSprite("status_rooted").Scale = 1.0;
        _targetTile.getEntity().getSprite("status_rooted").setBrush("golem_ensnare_front");
        _targetTile.getEntity().getSprite("status_rooted").Visible = true;
        _targetTile.getEntity().getSprite("status_rooted").Alpha = 0;
        _targetTile.getEntity().getSprite("status_rooted").fadeIn(50);
        _targetTile.getEntity().getSprite("status_rooted_back").Scale = 1.0;
        _targetTile.getEntity().getSprite("status_rooted_back").setBrush("golem_ensnare_back");
        _targetTile.getEntity().getSprite("status_rooted_back").Visible = true;
        _targetTile.getEntity().getSprite("status_rooted_back").Alpha = 0;
        _targetTile.getEntity().getSprite("status_rooted_back").fadeIn(50);
        this.Time.scheduleEvent(this.TimeUnit.Virtual, 900, this.onDone, {});
    }
    _targetTile.getEntity().getSkills().removeByID("effects.shieldwall");
    _targetTile.getEntity().getSkills().removeByID("effects.spearwall");
    _targetTile.getEntity().getSkills().removeByID("effects.riposte");
    this.Tactical.State.handleInvoluntaryMovement(_targetTile.getEntity(), _user, _targetTile, this.m.DestinationTile, this, null, null);
    _targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
    if (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer)
    {
        return (_targetTile.IsVisibleForPlayer && _targetTile.IsVisibleForPlayer);
        this.Tactical.EventLog.log(this.new("scripts/skills/effects/staggered_effect").getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(_targetTile.getEntity())));
    }
    return _user;
}

function onVerifyTarget(this, _originTile, _targetTile)
{
    if (!this.skill.onVerifyTarget(_originTile, _targetTile))
    {
        return _originTile;
    }
    if (_targetTile.getEntity().getCurrentProperties.IsImmuneToKnockBackAndGrab && _targetTile.getEntity().getCurrentProperties.IsImmuneToKnockBackAndGrab)
    {
        return (_targetTile.getEntity().getCurrentProperties.IsImmuneToKnockBackAndGrab && _targetTile.getEntity().getCurrentProperties.IsImmuneToKnockBackAndGrab);
        return _originTile;
    }
    return _originTile;
}

function setDestinationTile(this, _t)
{
    this.m.DestinationTile = _t;
    return;
}
