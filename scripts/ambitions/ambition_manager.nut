// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ambitions/ambition_manager.nut
// Functions: 23

function cancelAmbition(this, _delayed)
{
    if (!this.hasActiveAmbition())
    {
        return;
    }
    if (!this.m.ActiveAmbition.isCancelable())
    {
        return;
    }
    if (_delayed)
    {
        this.m.IsCancelAmbition = true;
        return;
    }
    this.m.IsCancelAmbition = false;
    this.m.ActiveAmbition.fail();
    this.World.Events.fire("event.ambition_failed");
    this.m.ActiveAmbition.clear();
    this.World.TopbarAmbitionModule.setText(null);
    this.m.ActiveAmbition = null;
    this.setDelay(24);
    return;
}

function clear(this)
{
    this.m.ActiveAmbition = null;
    this.m.Selection = null;
    this.m.Thread = null;
    foreach (local key, value in r5)
    {
        null.reset();
        this.World.TopbarAmbitionModule.setText(null);
        return;
    }
}

function create(this)
{
    foreach (local key, value in r10)
    {
        this.m.Ambitions.push(this.new(null));
        foreach (local key, value in r13)
        {
            if (null != "scripts/ambitions/oaths/oath_ambition")
            {
                this.m.OathAmbitions.push(this.new(null));
            }
            this.m.LastTime = this.Time.getVirtualTimeF();
            return;
        }
    }
}

function getActiveAmbition(this)
{
    return this.m.ActiveAmbition;
}

function getAmbition(this, _id)
{
    if (_id.len() == 0)
    {
        return _id;
    }
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        foreach (local key, value in r9)
        {
            if (null.getID() == _id)
            {
                return _id;
            }
            return _id;
        }
    }
}

function getCompleted(this)
{
    return this.m.Completed;
}

function getDone(this)
{
    return this.m.Done;
}

function getLastPickedAmbitionID(this)
{
    return this.m.LastPickedAmbitionID;
}

function getSelection(this)
{
    return this.m.Selection;
}

function hasActiveAmbition(this)
{
    return (this.m.ActiveAmbition != null);
}

function isAvailable(this)
{
    if (this.LoadingScreen.isVisible() || this.LoadingScreen.isVisible())
    {
        return (this.LoadingScreen.isVisible() || this.LoadingScreen.isVisible());
    }
    if ((this.Tactical.State != null) && (this.Tactical.State != null))
    {
        return ((this.Tactical.State != null) && (this.Tactical.State != null));
        return false;
    }
    if ((this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < 3.0))
    {
        return false;
    }
    if (this.Time.getVirtualTimeF() < this.m.DelayUntil)
    {
        return false;
    }
    if ((this.World.Assets != r19) && (this.World.Assets != r19))
    {
        return ((this.World.Assets != r19) && (this.World.Assets != r19));
        return false;
    }
    if (((this.Time.getVirtualTimeF() - this.m.LastTime) < (1.0 * this.World.getTime().SecondsPerHour) && ((this.Time.getVirtualTimeF() - this.m.LastTime) < (1.0 * this.World.getTime().SecondsPerHour))))
    {
        return (((this.Time.getVirtualTimeF() - this.m.LastTime) < (1.0 * this.World.getTime().SecondsPerHour)) && ((this.Time.getVirtualTimeF() - this.m.LastTime) < (1.0 * this.World.getTime().SecondsPerHour)));
        return false;
    }
    if ((this.World.Contracts == r27) && (this.World.Contracts == r27))
    {
        return ((this.World.Contracts == r27) && (this.World.Contracts == r27));
        return false;
    }
    foreach (local key, value in r10)
    {
        if (!null.isAlliedWithPlayer())
        {
            return this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);
        }
        return this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);
    }
}

function onDeserialize(this, _in)
{
    this.clear();
    if (0 < _in.readU32())
    {
        if (this.getAmbition(_in.readString() != null))
        {
            this.getAmbition(_in.readString()).onDeserialize(_in);
        }
        else
        {
            _in.readF32();
            _in.readF32();
            _in.readBool();
            if (_in.getMetaData().getVersion() >= 64)
            {
                _in.readBool();
                _in.readBool();
                _in.readU32();
            }
        }
    }
    if (_in.getMetaData().getVersion() >= 64)
    {
        if (0 < _in.readU32())
        {
            if (this.getAmbition(_in.readString() != null))
            {
                this.getAmbition(_in.readString()).onDeserialize(_in);
            }
            _in.readF32();
            _in.readF32();
            _in.readBool();
            _in.readBool();
            _in.readBool();
            _in.readU32();
        }
        this.m.LastPickedAmbitionID = _in.readString();
    }
    this.m.ActiveAmbition = this.getAmbition(_in.readString());
    this.m.LastTime = _in.readF32();
    this.m.DelayUntil = _in.readF32();
    this.m.Completed = _in.readU16();
    this.m.Done = _in.readU16();
    if (this.m.ActiveAmbition != null)
    {
        this.World.TopbarAmbitionModule.setText(this.m.ActiveAmbition.getUIText());
    }
    this.World.TopbarAmbitionModule.setText(null);
    return;
}

function onLocationDestroyed(this, _location)
{
    if (this.m.ActiveAmbition != null)
    {
        this.m.ActiveAmbition.onLocationDestroyed(_location);
        this.updateUI();
    }
    return;
}

function onLocationDiscovered(this, _location)
{
    if (this.m.ActiveAmbition != null)
    {
        this.m.ActiveAmbition.onLocationDiscovered(_location);
        this.updateUI();
    }
    return;
}

function onPartyDestroyed(this, _party)
{
    if (this.m.ActiveAmbition != null)
    {
        this.m.ActiveAmbition.onPartyDestroyed(_party);
        this.updateUI();
    }
    return;
}

function onScoreCompare(this, _a1, _a2)
{
    if (_a1.getScore() > _a2.getScore())
    {
        return _a1;
    }
    else
    {
        if (_a1.getScore() < _a2.getScore())
        {
            return _a1;
        }
    }
    return _a1;
}

function onSerialize(this, _out)
{
    _out.writeU32(this.m.Ambitions.len());
    foreach (local key, value in r11)
    {
        _out.writeString(null.getID());
        null.onSerialize(_out);
        _out.writeU32(this.m.OathAmbitions.len());
        foreach (local key, value in r11)
        {
            _out.writeString(null.getID());
            null.onSerialize(_out);
            _out.writeString(this.m.LastPickedAmbitionID);
            if (this.m.ActiveAmbition != null)
            {
                _out.writeString(this.m.ActiveAmbition.getID());
            }
            _out.writeString("writeF32");
            _out.LastTime(this.m.DelayUntil);
            _out.LastTime(this.m.writeU16);
            _out.Completed(this.m.Done);
            _out.Completed(this.m["k[16]"]);
            return;
        }
    }
}

function resetTime(this, _resetDelay, _additionalHours)
{
    this.m.LastTime = ((this.Time.getVirtualTimeF() - (5.0 * this.World.getTime().SecondsPerHour)) + (_additionalHours * this.World.getTime().SecondsPerHour));
    if (_resetDelay)
    {
        this.m.DelayUntil = 0.0;
    }
    return;
}

function selectAmbitions(this)
{
    if (this.World.Assets.getOrigin().getID() == "scenario.paladins")
    {
    }
    if (0 < this.m.Ambitions.len())
    {
        if ((this.m.Ambitions[0] != this.m.LastPickedAmbitionID) && (this.m.Ambitions[0] != this.m.LastPickedAmbitionID))
        {
            return ((this.m.Ambitions[0] != this.m.LastPickedAmbitionID) && (this.m.Ambitions[0] != this.m.LastPickedAmbitionID));
            this.m.Ambitions["0"].update();
        }
        this.m.Ambitions["0"].clear();
        if (this.m.Ambitions["0"].isDone())
        {
        }
    }
    yield this.m.Ambitions["0"].isDone();
    this.m.Done = (0 + 1);
    if (0 < this.m.Ambitions.len())
    {
        this.m.Ambitions["0"].update();
    }
    yield this.m.Ambitions["0"].update;
    this.m.Ambitions.sort(this.onScoreCompare);
    while (r2)
    {
        if (0 != 4)
        {
            if (0 >= this.m.Ambitions.len())
            {
            }
            if (this.m.Ambitions["0"].getScore() != 0)
            {
                [].push(this.m.Ambitions["0"]);
            }
        }
    }
    if ([].len() == 0)
    {
        return (0 + 1);
    }
    if ((!(this.World.Assets.getOrigin().getID() == "scenario.paladins") && (!(this.World.Assets.getOrigin().getID() == "scenario.paladins"))))
    {
        return ((!(this.World.Assets.getOrigin().getID() == "scenario.paladins")) && (!(this.World.Assets.getOrigin().getID() == "scenario.paladins")));
        if ([].len() >= 4)
        {
            [].remove(([].len() - 1));
        }
        [].push(this.getAmbition("ambition.none"));
    }
    if (this.World.Assets.getOrigin().getID() == "scenario.paladins")
    {
        if (this.m.Ambitions.len() > 3)
        {
            if (2 < this.m.Ambitions.len())
            {
                this.m.Ambitions["2"].skip();
            }
        }
    }
    this.m.Selection = [];
    return (0 + 1);
}

function setAmbition(this, _ambition)
{
    this.m.LastPickedAmbitionID = _ambition.getID();
    if (_ambition.getID() == "ambition.none")
    {
        this.setDelay((24 * 3));
    }
    this.m.ActiveAmbition = _ambition;
    this.m.ActiveAmbition.activate();
    this.setDelay(4);
    this.World.TopbarAmbitionModule.setText(_ambition.getUIText());
    return;
}

function setDelay(this, _hours)
{
    this.m.DelayUntil = this.Math.maxf(this.m.DelayUntil, (this.Time.getVirtualTimeF() + (_hours * this.World.getTime().SecondsPerHour)));
    return;
}

function update(this)
{
    if (this.m.IsCancelAmbition)
    {
        this.cancelAmbition(false);
        return;
    }
    if (!this.isAvailable())
    {
        return;
    }
    if (this.m.ActiveAmbition != null)
    {
        if (this.World.Events && this.World.Events)
        {
            return (this.World.Events && this.World.Events);
            if (this.World.Events.fire("event.ambition_fulfilled"))
            {
                this.m.ActiveAmbition.clear();
                this.m.ActiveAmbition = null;
                this.m.Selection = null;
                this.m.Thread = null;
                this.World.TopbarAmbitionModule.setText(null);
                this.World.Assets.resetToDefaults();
                this.setDelay(24);
                this.m.LastTime = this.Time.getVirtualTimeF();
            }
        }
        this.m.LastTime = this.Time.getVirtualTimeF();
    }
    else
    {
        if (this.m.Selection == null)
        {
            if (this.m.Thread == null)
            {
                this.m.Thread = this.selectAmbitions();
            }
            if (resume this != false)
            {
                this.m.Thread = null;
            }
        }
        else
        {
            if (this.World.Events && this.World.Events)
            {
                return (this.World.Events && this.World.Events);
                if (this.World.Events.fire("event.choose_ambition"))
                {
                    this.m.Selection = null;
                    this.m.LastTime = this.Time.getVirtualTimeF();
                }
            }
        }
    }
    return;
}

function updateUI(this)
{
    if (this.m.ActiveAmbition != null)
    {
        this.World.TopbarAmbitionModule.setText(this.m.ActiveAmbition.getUIText());
    }
    this.World.TopbarAmbitionModule.setText(null);
    return;
}
