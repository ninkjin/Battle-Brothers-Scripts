// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/censer_castigate_skill.nut
// Functions: 7

function create(this)
{
    this.m.ID = "actives.censer_castigate";
    this.m.Name = "Castigate";
    this.m.Description = "A sweeping strike in a wide arc that hits three adjacent tiles in counter-clockwise order over some distance that leaves a harmful miasma in its wake. Be careful around your own men unless you want to relieve your payroll!";
    this.m.Icon = "skills/active_231.png";
    this.m.IconDisabled = "skills/active_231_sw.png";
    this.m.Overlay = "active_231";
    this.m.SoundOnUse = ["sounds/combat/pound_01.wav", "sounds/combat/pound_02.wav", "sounds/combat/pound_03.wav"];
    this.m.SoundOnHit = ["sounds/combat/pound_hit_01.wav", "sounds/combat/pound_hit_02.wav", "sounds/combat/pound_hit_03.wav"];
    this.m.Type = this.Const.SkillType.Active;
    this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
    this.m.IsSerialized = false;
    this.m.IsActive = true;
    this.m.IsTargeted = true;
    this.m.IsStacking = false;
    this.m.IsAttack = true;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsAOE = true;
    this.m.IsTooCloseShown = true;
    this.m.IsWeaponSkill = true;
    this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
    this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
    this.m.DirectDamageMult = 0.30000001192092896;
    this.m.ActionPointCost = 6;
    this.m.FatigueCost = 30;
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
        if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
        {
            this.m.HitChanceBonus = this.m.HitChanceBonus op43 0;
        }
        this.m.IsShieldRelevant = false;
    }
    return;
}

function onQueryTilesHit(this, _tile, _result)
{
    _result.Tiles.push(_tile);
    return;
}

function onTargetSelected(this, _targetTile)
{
    this.Tactical.queryTilesInRange(this.m.Container.getActor().getTile(), this.m.Container.getActor().getTile().getDistanceTo(_targetTile), this.m.Container.getActor().getTile().getDistanceTo(_targetTile), false, [], this.onQueryTilesHit, {});
    if (0 != {}.Tiles.len())
    {
        if ({}.Tiles["0"].ID == _targetTile.ID)
        {
            [].push({}.Tiles["0"]);
            if ((0 - 1) < 0)
            {
            }
            [].push({}.Tiles["((0 - 1) + {}.Tiles.len())"]);
            if ((0 - 2) < 0)
            {
            }
            [].push({}.Tiles["((0 - 2) + {}.Tiles.len())"]);
        }
    }
    foreach (local key, value in r45)
    {
        if (!null.IsVisibleForEntity)
        {
        }
        else
        {
            if ((this.Math > 1) && (this.Math > 1))
            {
                return ((this.Math > 1) && (this.Math > 1));
            }
            this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, null, null.Pos.X, null.Pos.Y);
            return;
        }
    }
}

function onUse(this, _user, _targetTile)
{
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
    this.Tactical.queryTilesInRange(this.m.Container.getActor().getTile(), this.m.Container.getActor().getTile().getDistanceTo(_targetTile), this.m.Container.getActor().getTile().getDistanceTo(_targetTile), false, [], this.onQueryTilesHit, {});
    if (0 != {}.Tiles.len())
    {
        if ({}.Tiles["0"].ID == _targetTile.ID)
        {
            [].push({}.Tiles["0"]);
            if ((0 - 1) < 0)
            {
            }
            [].push({}.Tiles["((0 - 1) + {}.Tiles.len())"]);
            if ((0 - 2) < 0)
            {
            }
            [].push({}.Tiles["((0 - 2) + {}.Tiles.len())"]);
        }
    }
    foreach (local key, value in r66)
    {
        if (!null.IsVisibleForEntity)
        {
        }
        else
        {
            if ((this.Math > 1) && (this.Math > 1))
            {
                return ((this.Math > 1) && (this.Math > 1));
            }
            if ((this.Math > 1) && (this.Math > 1))
            {
                return ((this.Math > 1) && (this.Math > 1));
                if (false)
                {
                    if (this && this)
                    {
                        return (this && this);
                    }
                    return _user;
                }
            }
        }
    }
}
