// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_mirror_image.nut
// Functions: 5

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.MirrorImage;
    this.m.Order = this.Const.AI.Behavior.Order.MirrorImage;
    this.m.IsThreaded = true;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    this.m.Tiles = [];
    this.m.Skill = null;
    this.m.WaitUntil = 0.0;
    if (this.m.IsSpent)
    {
        return _entity;
    }
    this.m.Skill = this.selectSkill(this.m.PossibleSkills);
    if (this.m.Skill == null)
    {
        return _entity;
    }
    foreach (local key, value in r23)
    {
        if (null.getType() == this.Const.EntityType.SkeletonLichMirrorImage)
        {
        }
        else
        {
            if (null.getType() == this.Const.EntityType.SkeletonPhylactery)
            {
            }
        }
        if ((0 + 6) >= 4)
        {
            return _entity;
        }
        this.m.Images = this.Math.min((2 + this.Math.max(0, (6 - this.Math.max(0, ((0 + 5) - (this.Time.getRound() / 9)))))), (4 - (0 + 6)));
        if (1 < (this.Tactical.getMapSize().X - 1))
        {
            if (1 < (this.Tactical.getMapSize().Y - 1))
            {
                if (!this.Tactical.getTileSquare(1, 1).IsEmpty)
                {
                }
                [].push({});
            }
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        foreach (local key, value in r55)
        {
            if (this.isAllottedTimeReached(this.Time.getExactTime()))
            {
                yield this;
            }
            foreach (local key, value in r21)
            {
                if (null.Tile.getDistanceTo(null.Actor.getTile() <= 4))
                {
                }
                if (null.Tile.getDistanceTo(null.Actor.getTile() < 9000))
                {
                }
                if (null.Tile.getDistanceTo(null.Actor.getTile() > 5))
                {
                }
                null.Score = {Tile = this.Tactical.getTileSquare(1, 1), Score = 0.0};
                [].sort(this.onSortByScore);
                this.m.Tiles = [];
                return _entity;
            }
        }
    }
}

function onExecute(this, _entity)
{
    if (this.m.IsFirstExecuted)
    {
        this.getAgent().adjustCameraToDestination(this.m.Tiles["0"].Tile);
        this.m.IsFirstExecuted = false;
        this.m.Skill.use(_entity.getTile());
        this.m.WaitUntil = (this.Time.getRealTimeF() + 1.4500000476837158);
        return _entity;
    }
    else
    {
        if (this.Time.getRealTimeF() >= this.m.WaitUntil)
        {
            if (0 < this.m.Tiles.len())
            {
                this.m.Tiles.remove(0);
                this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_lich_mirror_image", this.m.Tiles["0"].Tile.Coords.X, this.m.Tiles["0"].Tile.Coords.Y).setFaction(_entity.getFaction());
                this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_lich_mirror_image", this.m.Tiles["0"].Tile.Coords.X, this.m.Tiles["0"].Tile.Coords.Y).spawnEffect();
                if ((this.m.Images + 2) <= 0)
                {
                }
            }
            this.m.Tiles = [];
            this.m.IsSpent = true;
            this.getAgent().declareEvaluationDelay(1000);
            return _entity;
        }
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

function onTurnStarted(this)
{
    this.m.IsSpent = false;
    return;
}
