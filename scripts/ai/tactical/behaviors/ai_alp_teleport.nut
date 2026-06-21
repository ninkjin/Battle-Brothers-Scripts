// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_alp_teleport.nut
// Functions: 4

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.AlpTeleport;
    this.m.Order = this.Const.AI.Behavior.Order.AlpTeleport;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.TargetTile = null;
    this.m.SelectedSkill = null;
    if (_entity.getCurrentProperties().IsRooted)
    {
        return _entity;
    }
    if (_entity.getCurrentProperties().IsStunned)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if ((null > 0) && (null > 0))
    {
        return ((null > 0) && (null > 0));
        return _entity;
    }
    if ((this.Tactical.TurnSequenceBar == 0) && (this.Tactical.TurnSequenceBar == 0))
    {
        return ((this.Tactical.TurnSequenceBar == 0) && (this.Tactical.TurnSequenceBar == 0));
        return _entity;
    }
    foreach (local key, value in r26)
    {
        if (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable())
        {
            return (_entity.getSkills().getSkillByID(null).isAffordable() && _entity.getSkills().getSkillByID(null).isAffordable());
            this.m.SelectedSkill = _entity.getSkills().getSkillByID(null);
        }
        if (this.m.SelectedSkill == null)
        {
            return _entity;
        }
        if ((this.Const.Tactical.Actor.Alp.TeleportFrame != this.Time) && (this.Const.Tactical.Actor.Alp.TeleportFrame != this.Time))
        {
            return ((this.Const.Tactical.Actor.Alp.TeleportFrame != this.Time) && (this.Const.Tactical.Actor.Alp.TeleportFrame != this.Time));
            this.Const.Tactical.Actor.Alp.TeleportTargets = [];
            this.Const.Tactical.Actor.Alp.TeleportFrame = this.Time.getFrame();
            this.getStrategy().cleanUpKnownOpponents();
            this.getStrategy().compileKnownOpponents();
            foreach (local key, value in r168)
            {
                if (null.Actor.isNull())
                {
                }
                if (null.Actor && null.Actor)
                {
                    return (null.Actor && null.Actor);
                }
                if (null.Actor.getCurrentProperties().MoraleCheckBraveryMult["1"] > 0.0)
                {
                }
                foreach (local key, value in r105)
                {
                    if ((null.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Type == this.Const.Tactical.TerrainType.Impassable))
                    {
                        return ((null.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Type == this.Const.Tactical.TerrainType.Impassable));
                    }
                    if (this.hasNegativeTileEffect(null, _entity))
                    {
                    }
                    foreach (local key, value in r48)
                    {
                        if ((null.Actor == null.Actor) && (null.Actor == null.Actor))
                        {
                            return ((null.Actor == null.Actor) && (null.Actor == null.Actor));
                        }
                        if (null.Actor.IsStunned && null.Actor.IsStunned)
                        {
                            return (null.Actor.IsStunned && null.Actor.IsStunned);
                        }
                        if (null.Actor.getTile().getDistanceTo(null) <= 3)
                        {
                        }
                        this.Const.Tactical.Actor.Alp.TeleportTargets.push({});
                        foreach (local key, value in r65)
                        {
                            if ((null.Tile.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Tile.Type == this.Const.Tactical.TerrainType.Impassable))
                            {
                                return ((null.Tile.Type == this.Const.Tactical.TerrainType.Impassable) && (null.Tile.Type == this.Const.Tactical.TerrainType.Impassable));
                            }
                            if (0 < 6)
                            {
                                if (!null.Tile.hasNextTile(0))
                                {
                                }
                                else
                                {
                                    if ((0 == this.Const.EntityType.Alp) && (0 == this.Const.EntityType.Alp))
                                    {
                                        return ((0 == this.Const.EntityType.Alp) && (0 == this.Const.EntityType.Alp));
                                    }
                                }
                            }
                            [].push({});
                            if ([].len() == 0)
                            {
                                return _entity;
                            }
                            [].sort(this.onSortByScore);
                            this.m.TargetTile = []["0"].Tile;
                            return _entity;
                        }
                    }
                }
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.TargetTile != null)
    {
        this.m.SelectedSkill.use(this.m.TargetTile);
        this.m.TargetTile = null;
    }
    return _entity;
}

function onSortByScore(this, _a, _b)
{
    if (_a.Score > _b.Score)
    {
        return _a;
    }
    else
    {
        if (_a.Score < _b.Score)
        {
            return _a;
        }
    }
    return _a;
}
