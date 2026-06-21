// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/camera/tactical_camera_director.nut
// Functions: 17

function addDelay(this, _d)
{
    if (this.isDelayed())
    {
        this.m.DelayUntil = this.m.DelayUntil op43 _d;
    }
    this.m.DelayUntil = (this.Time.getVirtualTimeF() + _d);
    return;
}

function addIdleEvent(this, _delay, _callback, _tag, _callbackDelay, _finalDelay)
{
    this.m.Events.push({});
    return;
}

function addJumpToTileEvent(this, _delay, _targetTile, _targetLevel, _callback, _tag, _callbackDelay, _finalDelay)
{
    if (_targetLevel == -1)
    {
    }
    this.m.Events.push({});
    return;
}

function addMoveSlowlyToTileEvent(this, _delay, _targetTile, _targetLevel, _callback, _tag, _callbackDelay, _finalDelay)
{
    if (_targetLevel == -1)
    {
    }
    this.m.Events.push({});
    return;
}

function addMoveToTileEvent(this, _delay, _targetTile, _targetLevel, _callback, _tag, _callbackDelay, _finalDelay)
{
    if (_targetLevel == -1)
    {
    }
    this.m.Events.push({});
    return;
}

function addMoveToTileEventIfNotVisible(this, _delay, _targetTile, _targetLevel, _callback, _tag, _callbackDelay, _finalDelay)
{
    if (_targetLevel == -1)
    {
    }
    this.m.Events.push({});
    return;
}

function clear(this)
{
    this.m.Events = [];
    this.Tactical.getCamera().cancelMovement();
    return;
}

function create(this)
{
    return;
}

function isDelayed(this)
{
    return (this.Time.getVirtualTimeF() < this.m.DelayUntil);
}

function isIdle(this)
{
    return (this.m.Events.len() == 0);
}

function isInputAllowed(this)
{
    return;
}

function isMoving(this)
{
    return;
}

function isPaused(this)
{
    return this.m.IsPaused;
}

function pushIdleEvent(this, _delay, _callback, _tag, _callbackDelay, _finalDelay)
{
    this.m.Events.insert(0, {});
    return;
}

function pushMoveToTileEvent(this, _delay, _targetTile, _targetLevel, _callback, _tag, _callbackDelay, _finalDelay)
{
    if (_targetLevel == -1)
    {
    }
    this.m.Events.insert(0, {});
    return;
}

function setPaused(this, _p)
{
    this.m.IsPaused = _p;
    return;
}

function update(this)
{
    if (this.m.IsPaused)
    {
        return;
    }
    if (this.m.Events.len() == 0)
    {
        return;
    }
    if (this.m.Events["0"].State == this.Const.Tactical.CameraEventState.Queued)
    {
        if (this.m.Events["0"].Time <= this.Time.getVirtualTime())
        {
            if (this.m.Events["0"].Type != this.Const.Tactical.CameraEventType.Idle)
            {
                if (this.m.Events["0"].Type == this.Const.Tactical.CameraEventType.MoveToIfNotVisible)
                {
                    if (this.Tactical.getCamera().isInsideScreen(this.m.Events["0"].TargetTile.Pos))
                    {
                        this.m.Events["0"].State = this.Const.Tactical.CameraEventState.WaitOnCallback;
                        this.m.Events["0"].Time = (this.Time.getVirtualTime() + this.m.Events["0"].CallbackDelay);
                    }
                    else
                    {
                        this.m.Events["0"].Type = this.Const.Tactical.CameraEventType.MoveTo;
                        this.m.Events["0"].State = this.Const.Tactical.CameraEventState.Focus;
                        this.Tactical.getCamera().cancelMovement();
                        this.m.Events["0"].State = this.Const.Tactical.CameraEventState.WaitOnCallback;
                        this.m.Events["0"].Time = (this.Time.getVirtualTime() + this.m.Events["0"].CallbackDelay);
                        if (this.m.Events["0"].State == this.Const.Tactical.CameraEventState.Focus)
                        {
                            if ((!this.Tactical.getCamera().isMovingToTile(this.m.Events["0"].TargetTile) && (!this.Tactical.getCamera().isMovingToTile(this.m.Events["0"].TargetTile))))
                            {
                                return ((!this.Tactical.getCamera().isMovingToTile(this.m.Events["0"].TargetTile)) && (!this.Tactical.getCamera().isMovingToTile(this.m.Events["0"].TargetTile)));
                                if (this.m.Events["0"].Type == this.Const.Tactical.CameraEventType.MoveToSlowly)
                                {
                                    this.Tactical.getCamera().moveToTileSlowly(this.m.Events["0"].TargetTile);
                                }
                                else
                                {
                                    if (this.m.Events["0"].Type == this.Const.Tactical.CameraEventType.MoveTo)
                                    {
                                        this.Tactical.getCamera().moveToTile(this.m.Events["0"].TargetTile);
                                    }
                                    this.Tactical.getCamera().setPos(this.m.Events["0"].TargetTile.Pos);
                                }
                                this.Tactical.getCamera().Level = this.m.Events["0"].TargetLevel;
                            }
                            this.m.Events["0"].State = this.Const.Tactical.CameraEventState.WaitOnCallback;
                            this.m.Events["0"].Time = (this.Time.getVirtualTime() + this.m.Events["0"].CallbackDelay);
                        }
                        else
                        {
                            if (this.m.Events["0"].State == this.Const.Tactical.CameraEventState.WaitOnCallback)
                            {
                                if (this.m.Events["0"].Time <= this.Time.getVirtualTime())
                                {
                                    if (this.m.Events["0"].Callback != null)
                                    {
                                        this.m.Events["0"].Callback(this.m.Events["0"].Tag);
                                    }
                                    this.m.Events["0"].State = this.Const.Tactical.CameraEventState.WaitOnFinalization;
                                    this.m.Events["0"].Time = (this.Time.getVirtualTime() + this.m.Events["0"].FinalDelay);
                                }
                            }
                            else
                            {
                                if (this.m.Events["0"].State == this.Const.Tactical.CameraEventState.WaitOnFinalization)
                                {
                                    if (this.m.Events["0"].Time <= this.Time.getVirtualTime())
                                    {
                                        this.m.Events.remove(0);
                                    }
                                }
                            }
                        }
                    }
                    return;
                }
            }
        }
    }
}
