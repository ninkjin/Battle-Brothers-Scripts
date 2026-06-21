// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/tactical/modules/orientation_overlay/orientation_overlay.nut
// Functions: 9

function addOverlay(this, _entity)
{
    this.m.Overlays.push({});
    this.Tactical.getCamera().addEntityOverlay({});
    this.m.JSHandle.asyncCall("addOverlay", {});
    this.m.CameraHasStopped = true;
    return;
}

function create(this)
{
    this.m.ID = "OrientationOverlayModule";
    this.ui_module.create();
    this.m.Overlays = [];
    this.m.IsDirty = true;
    this.m.CameraHasMoved = true;
    this.m.CameraHasStopped = true;
    this.m.LastCameraZoom = this.Tactical.getCamera().Zoom;
    this.m.LastCameraPos = {X = this.Tactical.getCamera().getPos().X, Y = this.Tactical.getCamera().getPos().Y};
    return;
}

function destroy(this)
{
    this.removeOverlays();
    this.ui_module.destroy();
    return;
}

function helper_findOverlayByEntity(this, _entity)
{
    foreach (local key, value in r10)
    {
        if (null.entity.getID() == _entity.getID())
        {
            return _entity;
        }
        return _entity;
    }
}

function onOverlayClicked(this, _entityId)
{
    this.Tactical.TurnSequenceBar.focusEntityById(_entityId);
    return;
}

function removeOverlay(this, _entity)
{
    if (this.helper_findOverlayByEntity(_entity) != null)
    {
        this.m.JSHandle.asyncCall("removeOverlay", {});
        this.Tactical.getCamera().removeEntityOverlay(_entity);
        this.m.Overlays.remove(this.helper_findOverlayByEntity(_entity));
    }
    return;
}

function removeOverlays(this)
{
    this.m.JSHandle.asyncCall("removeOverlays", null);
    this.Tactical.getCamera().removeEntityOverlays();
    this.m.Overlays = [];
    return;
}

function render(this)
{
    this.Tactical.getCamera().render();
    return;
}

function update(this)
{
    if ((this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y))
    {
        return ((this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y) || (this.m.LastCameraPos.Y != this.Tactical.getCamera().getPos().Y));
        this.m.LastCameraLevel = this.Tactical.getCamera().Level;
        this.m.LastCameraZoom = this.Tactical.getCamera().Zoom;
        this.m.LastCameraPos.X = this.Tactical.getCamera().getPos().X;
        this.m.LastCameraPos.Y = this.Tactical.getCamera().getPos().Y;
        this.Tactical.getCamera().updateEntityOverlays();
        if (this.m.CameraHasMoved == false)
        {
            this.m.CameraHasMoved = true;
            this.m.JSHandle.asyncCall("disableOverlays", null);
        }
        this.m.IsDirty = false;
    }
    else
    {
        if (this.m.CameraHasMoved)
        {
            this.m.CameraHasStopped = true;
        }
    }
    if (this.m.CameraHasStopped == true)
    {
        if ((true > 0) && (true > 0))
        {
            return ((true > 0) && (true > 0));
            this.m.JSHandle.asyncCall("updateOverlays", this.Tactical.getCamera().queryEntityOverlays());
        }
        this.m.CameraHasMoved = false;
        this.m.CameraHasStopped = false;
    }
    return;
}
