// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/tactical_screen.nut
// Functions: 21

function clearEventListener(this)
{
    this.m.OnConnectedListener = null;
    this.m.OnDisconnectedListener = null;
    return;
}

function connect(this)
{
    this.m.JSHandle = this.UI.connect("TacticalScreen", this);
    this.m.TurnSequenceBar.connectUI(this.m.JSHandle);
    this.m.OrientationOverlay.connectUI(this.m.JSHandle);
    this.m.TopbarRoundInformation.connectUI(this.m.JSHandle);
    this.m.TopbarEventLog.connectUI(this.m.JSHandle);
    this.m.TopbarOptions.connectUI(this.m.JSHandle);
    return;
}

function create(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    this.m.TurnSequenceBar = this.new("scripts/ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar");
    this.m.TurnSequenceBar.setParent(this);
    this.Tactical.TurnSequenceBar <- this.WeakTableRef(this.m.TurnSequenceBar);
    this.m.OrientationOverlay = this.new("scripts/ui/screens/tactical/modules/orientation_overlay/orientation_overlay");
    this.m.OrientationOverlay.setParent(this);
    this.Tactical.OrientationOverlay <- this.WeakTableRef(this.m.OrientationOverlay);
    this.m.TopbarRoundInformation = this.new("scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_round_information");
    this.m.TopbarRoundInformation.setParent(this);
    this.Tactical.TopbarRoundInformation <- this.WeakTableRef(this.m.TopbarRoundInformation);
    this.m.TopbarEventLog = this.new("scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_event_log");
    this.m.TopbarEventLog.setParent(this);
    this.Tactical.EventLog <- this.WeakTableRef(this.m.TopbarEventLog);
    this.m.TopbarOptions = this.new("scripts/ui/screens/tactical/modules/topbar/tactical_screen_topbar_options");
    this.m.TopbarOptions.setParent(this);
    this.Tactical.TopbarOptions <- this.WeakTableRef(this.m.TopbarOptions);
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.m.TurnSequenceBar.destroy();
    this.m.TopbarRoundInformation.destroy();
    this.m.TopbarEventLog.destroy();
    this.m.TopbarOptions.destroy();
    this.m.OrientationOverlay.destroy();
    this.m.TurnSequenceBar = null;
    this.Tactical.TurnSequenceBar = null;
    this.m.TopbarRoundInformation = null;
    this.Tactical.TopbarRoundInformation = null;
    this.m.TopbarEventLog = null;
    this.Tactical.EventLog = null;
    this.m.TopbarOptions = null;
    this.Tactical.TopbarOptions = null;
    this.m.OrientationOverlay = null;
    this.Tactical.OrientationOverlay = null;
    this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
    return;
}

function getEventLogModule(this)
{
    return this.m.TopbarEventLog;
}

function getOrientationOverlayModule(this)
{
    return this.m.OrientationOverlay;
}

function getTopbarOptionsModule(this)
{
    return this.m.TopbarOptions;
}

function getTopbarRoundInformationModule(this)
{
    return this.m.TopbarRoundInformation;
}

function getTurnSequenceBarModule(this)
{
    return this.m.TurnSequenceBar;
}

function hide(this)
{
    if (null && null)
    {
        return (null && null);
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function isAnimating(this)
{
    return;
}

function isVisible(this)
{
    return;
}

function onModuleConnected(this, _module)
{
    if (this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected())
    {
        return (this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected() && this.m.TopbarOptions.isConnected());
        if (this.m.OnConnectedListener != null)
        {
            this.m.OnConnectedListener();
        }
    }
    return;
}

function onScreenAnimating(this)
{
    this.m.Animating = true;
    return;
}

function onScreenConnected(this)
{
    return;
}

function onScreenDisconnected(this)
{
    if (this.m.OnDisconnectedListener != null)
    {
        this.m.OnDisconnectedListener();
    }
    return;
}

function onScreenHidden(this)
{
    this.m.Visible = false;
    this.m.Animating = false;
    return;
}

function onScreenShown(this)
{
    this.m.Visible = true;
    this.m.Animating = false;
    return;
}

function setOnConnectedListener(this, _listener)
{
    this.m.OnConnectedListener = _listener;
    return;
}

function setOnDisconnectedListener(this, _listener)
{
    this.m.OnDisconnectedListener = _listener;
    return;
}

function show(this)
{
    if ((!null) && (!null))
    {
        return ((!null) && (!null));
        this.Tooltip.hide();
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
