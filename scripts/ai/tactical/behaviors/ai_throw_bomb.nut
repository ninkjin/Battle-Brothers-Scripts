// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_throw_bomb.nut
// Functions: 8

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.ThrowBomb;
    this.m.Order = this.Const.AI.Behavior.Order.ThrowBomb;
    this.behavior.create();
    return;
}

function evaluateBombs(this, _entity, _skill)
{
    this.Tactical.queryTilesInRange(_entity.getTile(), 2, 3, false, [], this.onQueryTile, []);
    if (_skill == null)
    {
        if (this.m.IsFireBombAvailable)
        {
            [].push(this.evaluateFireBomb(_entity, []));
        }
        if (this.m.IsDazeBombAvailable)
        {
            [].push(this.evaluateDazeBomb(_entity, []));
        }
        if (this.m.IsSmokeBombAvailable)
        {
            [].push(this.evaluateSmokeBomb(_entity, []));
        }
        [].sort(this.onSortByScore);
        if ([]["0"].Score > 0)
        {
            return _entity;
        }
        return _entity;
    }
    if ((null == r16) && (null == r16))
    {
        return ((null == r16) && (null == r16));
        return this.evaluateFireBomb(_entity, [], _skill);
        return _entity;
    }
    if ((this == r17) && (this == r17))
    {
        return ((this == r17) && (this == r17));
        return this.evaluateDazeBomb(_entity, [], _skill);
        return _entity;
    }
    if ((this == r18) && (this == r18))
    {
        return ((this == r18) && (this == r18));
        return this.evaluateSmokeBomb(_entity, [], _skill);
        return _entity;
    }
    return _entity;
}

function evaluateDazeBomb(this, _entity, _tiles, _skill)
{
    foreach (local key, value in r310)
    {
        if ((_entity.getTile().Level + 1) < null.Level)
        {
        }
        if ((!null.Level) && (!null.Level))
        {
            return ((!null.Level) && (!null.Level));
        }
        if (null.IsOccupiedByActor)
        {
            [].push(null.getEntity());
        }
        if (0 < 6)
        {
            if (!null.hasNextTile(0))
            {
            }
            else
            {
                if (null.getNextTile(0).IsOccupiedByActor)
                {
                    [].push(null.getNextTile(0).getEntity());
                }
            }
        }
        foreach (local key, value in r223)
        {
            if (null.getSkills().hasSkill("effects.dazed"))
            {
            }
            if (null.isAlliedWith(_entity))
            {
                if ((!null) && (!null))
                {
                    return ((!null) && (!null));
                    if (null.isPlayerControlled())
                    {
                    }
                }
            }
            if (null.IsRooted && null.IsRooted)
            {
                return (null.IsRooted && null.IsRooted);
            }
            if (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()))
            {
            }
            if (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon))
            {
                return (null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon) && null.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.MeleeWeapon));
            }
            if (null && null)
            {
                return (null && null);
            }
            if (0 < 6)
            {
                if (!null.getTile().hasNextTile(0))
                {
                }
                else
                {
                    if (0 && 0)
                    {
                        return (0 && 0);
                        if (null.getTile().getNextTile(0).getEntity().getCurrentProperties().TargetAttractionMult > 1.0)
                        {
                        }
                        if (null.getTile().getNextTile(0).getEntity().getSkills().hasSkill("actives.deathblow"))
                        {
                        }
                    }
                }
            }
            if (((0 + 12) > 1) && ((0 + 12) > 1))
            {
                return (((0 + 12) > 1) && ((0 + 12) > 1));
                {}.Score = ((((0.0 - (0.5 * null.getCurrentProperties().TargetAttractionMult)) * this.Const.AI.Behavior.ThrowBombPriorityTargetMult) * this.Const.AI.Behavior.ThrowBombPriorityTargetMult) + ((((this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.ThrowBombAlreadyOutMult) * (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) * this.Const.AI.Behavior.ThrowBombZOCMult)) * this.Const.AI.Behavior.ThrowBombPriorityTargetMult) * this.Const.AI.Behavior.ThrowBombPriorityTargetMult));
                {}.Target = null;
            }
            return _entity;
        }
    }
}

function evaluateFireBomb(this, _entity, _tiles, _skill)
{
    foreach (local key, value in r217)
    {
        if ((_entity.getTile().Level + 1) < null.Level)
        {
        }
        if ((!null.Level) && (!null.Level))
        {
            return ((!null.Level) && (!null.Level));
        }
        if (null.IsOccupiedByActor)
        {
            [].push(null.getEntity());
        }
        if (0 < 6)
        {
            if (!null.hasNextTile(0))
            {
            }
            else
            {
                if (null.getNextTile(0).IsOccupiedByActor)
                {
                    [].push(null.getNextTile(0).getEntity());
                }
            }
        }
        foreach (local key, value in r130)
        {
            if ((!null.getTile().Properties.Effect.IsPositive) && (!null.getTile().Properties.Effect.IsPositive))
            {
                return ((!null.getTile().Properties.Effect.IsPositive) && (!null.getTile().Properties.Effect.IsPositive));
            }
            else
            {
                if ((null.getTile().Type == this.Const.Tactical.TerrainType.DeepWater) && (null.getTile().Type == this.Const.Tactical.TerrainType.DeepWater))
                {
                    return ((null.getTile().Type == this.Const.Tactical.TerrainType.DeepWater) && (null.getTile().Type == this.Const.Tactical.TerrainType.DeepWater));
                }
                if (this.Tactical.Entities.getNonFlammableTileSubtypes().find(null.getTile().Subtype) != null)
                {
                }
                if (null.isAlliedWith(_entity))
                {
                    if (null.isPlayerControlled())
                    {
                    }
                }
                if (null.IsRooted && null.IsRooted)
                {
                    return (null.IsRooted && null.IsRooted);
                }
                if (null.getTile().hasZoneOfControlOtherThan(null.getAlliedFactions()))
                {
                }
                if ((null.getHitpoints() + null.getArmor(this.Const.BodyPart.Body) <= 20))
                {
                }
                if (((0 + 12) > 1) && ((0 + 12) > 1))
                {
                    return (((0 + 12) > 1) && ((0 + 12) > 1));
                    {}.Score = ((0.0 - (1.0 * null.getCurrentProperties().TargetAttractionMult)) + (((this.queryTargetValue(_entity, null, null) * this.Const.AI.Behavior.ThrowBombStunnedMult) * (null.getTile().getZoneOfControlCountOtherThan(null.getAlliedFactions()) * this.Const.AI.Behavior.ThrowBombZOCMult)) * this.Const.AI.Behavior.ThrowBombInstakillMult));
                    {}.Target = null;
                }
                return _entity;
            }
        }
    }
}

function onEvaluate(this, _entity)
{
    this.m.Selection = null;
    this.m.Skill = null;
    if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (!this.getAgent().hasVisibleOpponent())
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if ((null == this.Const.AI.Agent.ID.CharmedPlayer) && (null == this.Const.AI.Agent.ID.CharmedPlayer))
    {
        return ((null == this.Const.AI.Agent.ID.CharmedPlayer) && (null == this.Const.AI.Agent.ID.CharmedPlayer));
        return _entity;
    }
    if (_entity.getSkills().getAttackOfOpportunity() != null)
    {
    }
    if (this.m.Skill == null)
    {
        if ((!this.m.BombsMax) && (!this.m.BombsMax))
        {
            return ((!this.m.BombsMax) && (!this.m.BombsMax));
            return _entity;
        }
        if ((_entity.getActionPoints() >= 4) && (_entity.getActionPoints() >= 4))
        {
            return ((_entity.getActionPoints() >= 4) && (_entity.getActionPoints() >= 4));
            return _entity;
        }
        if (this.evaluateBombs(_entity) == null)
        {
            return _entity;
        }
        this.m.Selection = this.evaluateBombs(_entity);
        return _entity;
    }
    this.m.Selection = this.evaluateBombs(_entity, this.m.Skill);
    if ((this.m.Selection.Score == 0) && (this.m.Selection.Score == 0))
    {
        return ((this.m.Selection.Score == 0) && (this.m.Selection.Score == 0));
        return _entity;
    }
    return _entity;
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToTarget(_entity.getTile());
        this.m.IsFirstExecuted = false;
        return _entity;
    }
    if (this.m.Skill != null)
    {
        if (this.Const.AI.VerboseMode)
        {
            this.logInfo((((("* " + _entity.getName()) + ": Using ") + this.m.Skill.getName()) + "!"));
        }
        this.m.Skill.use(this.m.Selection.Target);
        if (this.m.Selection.Target.IsVisibleForPlayer && this.m.Selection.Target.IsVisibleForPlayer)
        {
            return (this.m.Selection.Target.IsVisibleForPlayer && this.m.Selection.Target.IsVisibleForPlayer);
            this.getAgent().declareAction();
            this.getAgent().declareEvaluationDelay();
        }
        this.m.Selection = null;
        this.m.Skill = null;
    }
    _entity.getItems().payForAction([]);
    _entity.getItems().equip(this.new(this.m.Selection.Item));
    return _entity;
}

function onQueryTile(this, _tile, _tag)
{
    _tag.push(_tile);
    return;
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
