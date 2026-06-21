// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/world/modules/world_town_screen/town_travel_dialog_module.nut
// Functions: 8

function clear(this)
{
    this.m.Data = null;
    return;
}

function create(this)
{
    this.m.ID = "TravelDialogModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.ui_module.destroy();
    return;
}

function fastTravelTo(this, _dest)
{
    this.m.Data = null;
    this.World.State.getPlayer().setPos(_dest.getTile().Pos);
    this.World.setPlayerPos(this.World.State.getPlayer().getPos());
    this.World.getCamera().moveTo(_dest);
    this.onLeaveButtonPressed();
    if (this.World.State.getCurrentTown().getMusic() != _dest.getMusic())
    {
        this.Music.setTrackList(_dest.getMusic(), this.Const.Music.CrossFadeTime);
    }
    this.World.State.setLastEnteredTown(_dest);
    _dest.onEnter();
    this.m.Parent.setTown(this.WeakTableRef(_dest));
    this.m.Parent.refresh();
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(0, this.World.State.getSurroundingAmbienceSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement), this.Const.Sound.AmbienceMinDelayAtNight);
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(1, _dest.getSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement), this.Const.Sound.AmbienceMinDelayAtNight);
    return;
}

function onLeaveButtonPressed(this)
{
    this.m.Parent.onModuleClosed();
    return;
}

function onTravel(this, _entryID)
{
    if (this.World.getEntityByID(this.m.Data.Roster["_entryID"].ID) == null)
    {
        return _entryID;
    }
    if ((this.World.Assets.getMoney() - this.m.Data.Roster["_entryID"].Cost) < 0)
    {
        return _entryID;
    }
    this.World.Assets.setMoney((this.World.Assets.getMoney() - this.m.Data.Roster["_entryID"].Cost));
    this.Sound.play(this.Const.Sound.FastTravelByShip["this.Math.rand(0, (this.Const.Sound.FastTravelByShip.len() - 1))"]);
    this.fastTravelTo(this.World.getEntityByID(this.m.Data.Roster["_entryID"].ID));
    return _entryID;
}

function queryTravelInformation(this)
{
    return {Data = this.m.Data, Assets = this.m.Parent.queryAssetsInformation()};
}

function setData(this, _r)
{
    this.m.Data = _r;
    return;
}
