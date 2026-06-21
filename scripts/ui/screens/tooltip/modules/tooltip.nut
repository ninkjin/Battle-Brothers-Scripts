// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tooltip/modules/tooltip.nut
// Functions: 34

function clearEventListener(this)
{
    this.m.OnQueryTileTooltipDataListener = null;
    this.m.OnQueryRosterEntityTooltipDataListener = null;
    this.m.OnQueryEntityTooltipDataListener = null;
    this.m.OnQuerySkillTooltipDataListener = null;
    this.m.OnQuerySettlementStatusEffectTooltipDataListener = null;
    this.m.OnQueryStatusEffectTooltipDataListener = null;
    this.m.OnQueryUIElementTooltipDataListener = null;
    this.m.OnQueryUIItemTooltipDataListener = null;
    this.m.OnQueryUIPerkTooltipDataListener = null;
    this.m.OnQueryFollowerTooltipDataListener = null;
    return;
}

function connectUI(this, _host)
{
    this.m.JSHandle = _host.connectToModule("TooltipModule", this);
    return;
}

function create(this)
{
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.CurrentHoveredEntityId = null;
    this.m.JSHandle = null;
    return;
}

function getDelay(this)
{
    return this.m.Delay;
}

function hide(this)
{
    this.m.JSHandle.asyncCall("hideTooltip", null);
    return;
}

function mouseEnterTile(this, _x, _y, _entityId)
{
    if (_entityId != null)
    {
        this.m.JSHandle.asyncCall("mouseEnterTile", {});
    }
    this.m.JSHandle.asyncCall("mouseEnterTile", {});
    this.m.CurrentHoveredEntityId = _entityId;
    return;
}

function mouseHoverTile(this, _x, _y)
{
    this.m.JSHandle.asyncCall("mouseHoverTile", {});
    return;
}

function mouseLeaveTile(this)
{
    this.m.JSHandle.asyncCall("mouseLeaveTile", null);
    return;
}

function onQueryEntityTooltipData(this, _data)
{
    if (this.m.OnQueryEntityTooltipDataListener != null)
    {
        return this.m.OnQueryEntityTooltipDataListener(_data["0"], _data["1"]);
        return _data;
    }
    return _data;
}

function onQueryFollowerTooltipData(this, _data)
{
    if (this.m.OnQueryFollowerTooltipDataListener != null)
    {
        return this.m.OnQueryFollowerTooltipDataListener(_data);
        return _data;
    }
    return _data;
}

function onQueryRosterEntityTooltipData(this, _data)
{
    if (this.m.OnQueryRosterEntityTooltipDataListener != null)
    {
        return this.m.OnQueryRosterEntityTooltipDataListener(_data);
        return _data;
    }
    return _data;
}

function onQuerySettlementStatusEffectTooltipData(this, _data)
{
    if (this.m.OnQuerySettlementStatusEffectTooltipDataListener != null)
    {
        return this.m.OnQuerySettlementStatusEffectTooltipDataListener(_data["0"]);
        return _data;
    }
    return _data;
}

function onQuerySkillTooltipData(this, _data)
{
    if (this.m.OnQuerySkillTooltipDataListener != null)
    {
        return this.m.OnQuerySkillTooltipDataListener(_data["0"], _data["1"]);
        return _data;
    }
    return _data;
}

function onQueryStatusEffectTooltipData(this, _data)
{
    if (this.m.OnQueryStatusEffectTooltipDataListener != null)
    {
        return this.m.OnQueryStatusEffectTooltipDataListener(_data["0"], _data["1"]);
        return _data;
    }
    return _data;
}

function onQueryTileTooltipData(this)
{
    if (this.m.OnQueryTileTooltipDataListener != null)
    {
        return this.m.OnQueryTileTooltipDataListener();
        return this.m.OnQueryTileTooltipDataListener;
    }
    return null;
}

function onQueryUIElementTooltipData(this, _data)
{
    if (this.m.OnQueryUIElementTooltipDataListener != null)
    {
        return this.m.OnQueryUIElementTooltipDataListener(_data["0"], _data["1"], _data["2"]);
        return _data;
    }
    return _data;
}

function onQueryUIItemTooltipData(this, _data)
{
    if (this.m.OnQueryUIItemTooltipDataListener != null)
    {
        return this.m.OnQueryUIItemTooltipDataListener(_data["0"], _data["1"], _data["2"]);
        return _data;
    }
    return _data;
}

function onQueryUIPerkTooltipData(this, _data)
{
    if (this.m.OnQueryUIPerkTooltipDataListener != null)
    {
        return this.m.OnQueryUIPerkTooltipDataListener(_data["0"], _data["1"]);
        return _data;
    }
    return _data;
}

function reload(this)
{
    this.m.JSHandle.asyncCall("reloadTooltip", null);
    return;
}

function reloadDataIfEqual(this, _entityId)
{
    if (_entityId != null)
    {
        if (this.m.CurrentHoveredEntityId == _entityId)
        {
            this.reload();
        }
    }
    return;
}

function setCurrentHoveredEntity(this, _entityId)
{
    if (_entityId != null)
    {
        this.m.CurrentHoveredEntityId = _entityId;
    }
    this.m.CurrentHoveredEntityId = null;
    return;
}

function setCursorOffsets(this, _offsets)
{
    this.m.JSHandle.asyncCall("setCursorOffsets", _offsets);
    return;
}

function setDelay(this, _delay)
{
    this.m.Delay = _delay;
    this.m.JSHandle.asyncCall("setDelay", _delay);
    return;
}

function setOnQueryEntityTooltipDataListener(this, _listener)
{
    this.m.OnQueryEntityTooltipDataListener = _listener;
    return;
}

function setOnQueryFollowerTooltipDataListener(this, _listener)
{
    this.m.OnQueryFollowerTooltipDataListener = _listener;
    return;
}

function setOnQueryRosterEntityTooltipDataListener(this, _listener)
{
    this.m.OnQueryRosterEntityTooltipDataListener = _listener;
    return;
}

function setOnQuerySettlementStatusEffectTooltipDataListener(this, _listener)
{
    this.m.OnQuerySettlementStatusEffectTooltipDataListener = _listener;
    return;
}

function setOnQuerySkillTooltipDataListener(this, _listener)
{
    this.m.OnQuerySkillTooltipDataListener = _listener;
    return;
}

function setOnQueryStatusEffectTooltipDataListener(this, _listener)
{
    this.m.OnQueryStatusEffectTooltipDataListener = _listener;
    return;
}

function setOnQueryTileTooltipDataListener(this, _listener)
{
    this.m.OnQueryTileTooltipDataListener = _listener;
    return;
}

function setOnQueryUIElementTooltipDataListener(this, _listener)
{
    this.m.OnQueryUIElementTooltipDataListener = _listener;
    return;
}

function setOnQueryUIItemTooltipDataListener(this, _listener)
{
    this.m.OnQueryUIItemTooltipDataListener = _listener;
    return;
}

function setOnQueryUIPerkTooltipDataListener(this, _listener)
{
    this.m.OnQueryUIPerkTooltipDataListener = _listener;
    return;
}
