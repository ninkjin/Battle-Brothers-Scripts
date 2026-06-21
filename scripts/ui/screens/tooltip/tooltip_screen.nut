// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tooltip/tooltip_screen.nut
// Functions: 12

function clearEventListener(this)
{
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.JSHandle = this.UI.connect("TooltipScreen", this);
    this.m.Tooltip = this.new("scripts/ui/screens/tooltip/modules/tooltip");
    this.m.Tooltip.connectUI(this.m.JSHandle);
    this.m.TooltipEvents <- this.new("scripts/ui/screens/tooltip/tooltip_events");
    this.m.Tooltip.setOnQueryTileTooltipDataListener(this.m.TooltipEvents.onQueryTileTooltipData);
    this.m.Tooltip.setOnQueryEntityTooltipDataListener(this.m.TooltipEvents.onQueryEntityTooltipData);
    this.m.Tooltip.setOnQueryRosterEntityTooltipDataListener(this.m.TooltipEvents.onQueryRosterEntityTooltipData);
    this.m.Tooltip.setOnQuerySkillTooltipDataListener(this.m.TooltipEvents.onQuerySkillTooltipData);
    this.m.Tooltip.setOnQueryStatusEffectTooltipDataListener(this.m.TooltipEvents.onQueryStatusEffectTooltipData);
    this.m.Tooltip.setOnQuerySettlementStatusEffectTooltipDataListener(this.m.TooltipEvents.onQuerySettlementStatusEffectTooltipData);
    this.m.Tooltip.setOnQueryUIElementTooltipDataListener(this.m.TooltipEvents.onQueryUIElementTooltipData);
    this.m.Tooltip.setOnQueryUIItemTooltipDataListener(this.m.TooltipEvents.onQueryUIItemTooltipData);
    this.m.Tooltip.setOnQueryUIPerkTooltipDataListener(this.m.TooltipEvents.onQueryUIPerkTooltipData);
    this.m.Tooltip.setOnQueryFollowerTooltipDataListener(this.m.TooltipEvents.onQueryFollowerTooltipData);
    this.getroottable().Tooltip <- this.WeakTableRef(this.m.Tooltip);
    this.getroottable().TooltipEvents <- this.WeakTableRef(this.m.TooltipEvents);
    this.show();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.Tooltip.destroy();
    this.m.Tooltip = null;
    this.m.TooltipEvents.destroy();
    this.m.TooltipEvents = null;
    this.getroottable().Tooltip = null;
    this.getroottable().TooltipEvents = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getTooltip(this)
{
    return this.m.Tooltip;
}

function getTooltipEvents(this)
{
    return this.m.TooltipEvents;
}

function hide(this)
{
    if (null && null)
    {
        return (null && null);
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function isVisible(this)
{
    return;
}

function onScreenConnected(this)
{
    return;
}

function onScreenDisconnected(this)
{
    return;
}

function onScreenHidden(this)
{
    this.m.Visible = false;
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    return;
}

function show(this)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
