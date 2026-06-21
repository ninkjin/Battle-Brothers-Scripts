// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/screens/menu/modules/options_menu_module.nut
// Functions: 26

function clearEventListener(this)
{
    this.m.OnOkButtonPressedListener = null;
    this.m.OnCancelButtonPressedListener = null;
    return;
}

function create(this)
{
    this.m.ID = "OptionsMenuModule";
    this.ui_module.create();
    return;
}

function destroy(this)
{
    this.clearEventListener();
    this.ui_module.destroy();
    return;
}

function helper_addAudioOptionsToUIData(this, _target)
{
    _target.master <- (this.Settings.getSoundVolume(this.Const.Sound.Channel.Master) * 100);
    _target.music <- (this.Settings.getSoundVolume(this.Const.Sound.Channel.Music) * 100);
    _target.effects <- (this.Settings.getSoundVolume(this.Const.Sound.Channel.Effects) * 100);
    _target.ambience <- (this.Settings.getSoundVolume(this.Const.Sound.Channel.Ambience) * 100);
    _target.hardwareSound <- this.Settings.isHardwareSound();
    return;
}

function helper_addControlsOptionsToUIData(this, _target)
{
    if (this.Settings.getControlSettings().UseDragStyleScrolling == true)
    {
    }
    _target.scrollMode <- "edgeOfScreen";
    _target.hardwareMouse <- this.Settings.getControlSettings().UseHardwareCursor;
    return;
}

function helper_addGameplayOptionsToUIData(this, _target)
{
    _target.cameraFollowMode <- this.Settings.getGameplaySettings().AlwaysFocusCamera;
    _target.cameraAdjustLevel <- this.Settings.getGameplaySettings().AdjustCameraLevel;
    _target.alwaysHideTrees <- this.Settings.getGameplaySettings().AlwaysHideTrees;
    _target.statsOverlays <- this.Settings.getGameplaySettings().ShowOverlayStats;
    _target.orientationOverlays <- this.Settings.getGameplaySettings().ShowOrientationOverlays;
    _target.movementPlayer <- this.Settings.getGameplaySettings().FasterPlayerMovement;
    _target.movementAI <- this.Settings.getGameplaySettings().FasterAIMovement;
    _target.autoEndTurn <- (!this.Settings.getGameplaySettings().DontAutoEndTurns);
    _target.autoLoot <- this.Settings.getGameplaySettings().AutoLoot;
    _target.restoreEquipment <- this.Settings.getGameplaySettings().RestoreEquipment;
    _target.autoPauseAfterCity <- this.Settings.getGameplaySettings().AutoPauseAfterCity;
    return;
}

function helper_addVideoDisplayToUIData(this, _currentMode, _target)
{
    if (_currentMode.Fullscreen == true)
    {
        _target.windowMode <- "fullscreen";
    }
    else
    {
        if (_currentMode.Borderless == true)
        {
            _target.windowMode <- "Borderless";
        }
        _target.windowMode <- "window";
    }
    _target.vsync <- _currentMode.VSync;
    _target.depthOfField <- _currentMode.DepthOfField;
    _target.uiScale <- (_currentMode.UIScale * 100.0);
    _target.spriteScale <- (_currentMode.SceneScale * 100.0);
    return;
}

function helper_addVideoOptionsToUIData(this, _target)
{
    this.helper_addVideoResolutionsToUIData(_target);
    this.helper_addVideoResolutionToUIData(this.Settings.getVideoMode(), _target);
    this.helper_addVideoDisplayToUIData(this.Settings.getVideoMode(), _target);
    return;
}

function helper_addVideoResolutionToUIData(this, _currentMode, _target)
{
    _target.resolution <- this.Settings.queryResolutionIndexByVideoMode(_currentMode, this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp);
    return;
}

function helper_addVideoResolutionsToUIData(this, _target)
{
    if ((this.Const.Options.Video.MinResolution.Width == 0) && (this.Const.Options.Video.MinResolution.Width == 0))
    {
        return ((this.Const.Options.Video.MinResolution.Width == 0) && (this.Const.Options.Video.MinResolution.Width == 0));
    }
    if (0 < this.Settings.queryResolutions(this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp).len())
    {
        [].push({});
    }
    _target.resolutions <- [];
    return;
}

function helper_applyAudioOptions(this, _data)
{
    this.Settings.setSoundVolume(this.Const.Sound.Channel.Master, (_data["0"] / 100.0));
    this.Settings.setSoundVolume(this.Const.Sound.Channel.Music, (_data["1"] / 100.0));
    this.Settings.setSoundVolume(this.Const.Sound.Channel.Effects, (_data["2"] / 100.0));
    this.Settings.setSoundVolume(this.Const.Sound.Channel.Ambience, (_data["3"] / 100.0));
    this.Settings.setHardwareSound(_data["4"]);
    this.Sound.update();
    this.Settings.save();
    return;
}

function helper_applyControlsOptions(this, _data)
{
    this.Settings.getControlSettings().UseDragStyleScrolling = (_data["0"] == "dragWithMouse");
    this.Settings.getControlSettings().UseHardwareCursor = _data["1"];
    this.Settings.save();
    this.Cursor.setHardwareCursor(this.Settings.getControlSettings().UseHardwareCursor, true);
    return;
}

function helper_applyGameplayOptions(this, _data)
{
    this.Settings.getGameplaySettings().AlwaysFocusCamera = _data["0"];
    this.Settings.getGameplaySettings().AdjustCameraLevel = _data["1"];
    this.Settings.getGameplaySettings().AlwaysHideTrees = _data["2"];
    this.Settings.getGameplaySettings().ShowOverlayStats = _data["3"];
    this.Settings.getGameplaySettings().ShowOrientationOverlays = _data["4"];
    this.Settings.getGameplaySettings().FasterPlayerMovement = _data["5"];
    this.Settings.getGameplaySettings().FasterAIMovement = _data["6"];
    this.Settings.getGameplaySettings().DontAutoEndTurns = (!_data["7"]);
    this.Settings.getGameplaySettings().AutoLoot = _data["8"];
    this.Settings.getGameplaySettings().RestoreEquipment = _data["9"];
    this.Settings.getGameplaySettings().AutoPauseAfterCity = _data["10"];
    this.Settings.save();
    this.Settings.getTempGameplaySettings().ShowOverlayStats = _data["1"];
    this.Settings.getTempGameplaySettings().HideTrees = _data["2"];
    return;
}

function helper_applyVideoOptions(this, _data)
{
    if (this.Settings.queryResolutionByIndex(_data["0"], this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp) == null)
    {
        this.logError("Failed to query current resolution. Reason: Invalid index.");
        return;
    }
    this.Settings.getVideoMode().Width = this.Settings.queryResolutionByIndex(_data["0"], this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp).Width;
    this.Settings.getVideoMode().Height = this.Settings.queryResolutionByIndex(_data["0"], this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp).Height;
    this.Settings.getVideoMode().ColorBits = this.Settings.queryResolutionByIndex(_data["0"], this.Const.Options.Video.MinResolution.Width, this.Const.Options.Video.MinResolution.Height, this.Const.Options.Video.MinResolution.Bpp).ColorBits;
    if (_data["1"] == "fullscreen")
    {
        this.Settings.getVideoMode().Fullscreen = true;
        this.Settings.getVideoMode().Borderless = false;
    }
    else
    {
        if (_data["1"] == "window")
        {
            this.Settings.getVideoMode().Fullscreen = false;
            this.Settings.getVideoMode().Borderless = false;
        }
        else
        {
            if (_data["1"] == "borderless")
            {
                this.Settings.getVideoMode().Fullscreen = false;
                this.Settings.getVideoMode().Borderless = true;
            }
        }
    }
    this.Settings.getVideoMode().VSync = _data["2"];
    this.Settings.getVideoMode().DepthOfField = _data["3"];
    this.Settings.getVideoMode().UIScale = (_data["4"] * 0.009999999776482582);
    this.Settings.getVideoMode().SceneScale = (_data["5"] * 0.009999999776482582);
    this.Settings.setVideoMode(this.Settings.getVideoMode());
    this.Settings.saveWithCustomVideoMode(this.Settings.getVideoMode());
    return;
}

function helper_checkVideoOptionsNeedUpdate(this, _data, _currentMode, _currentResolution)
{
    if ((_currentMode.ColorBits != _currentResolution.ColorBits) || (_currentMode.ColorBits != _currentResolution.ColorBits))
    {
        return ((_currentMode.ColorBits != _currentResolution.ColorBits) || (_currentMode.ColorBits != _currentResolution.ColorBits));
        return _data;
    }
    if (_data["1"] == "fullscreen")
    {
        if (_currentMode.Fullscreen != true)
        {
            return _data;
        }
    }
    else
    {
        if (_data["1"] == "window")
        {
            if ((_currentMode.Borderless == true) && (_currentMode.Borderless == true))
            {
                return ((_currentMode.Borderless == true) && (_currentMode.Borderless == true));
                return _data;
            }
        }
        else
        {
            if (_data["1"] == "borderless")
            {
                if ((_currentMode.Borderless == true) && (_currentMode.Borderless == true))
                {
                    return ((_currentMode.Borderless == true) && (_currentMode.Borderless == true));
                    return _data;
                }
            }
        }
    }
    if (_currentMode.VSync != _data["2"])
    {
        return _data;
    }
    if (_currentMode.DepthOfField != _data["3"])
    {
        return _data;
    }
    return _data;
}

function hide(this)
{
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        this.m.JSHandle.asyncCall("hide", null);
    }
    return;
}

function onApplyAudioOptions(this, _data)
{
    this.helper_applyAudioOptions(_data);
    return;
}

function onApplyControlsOptions(this, _data)
{
    this.helper_applyControlsOptions(_data);
    return;
}

function onApplyGameplayOptions(this, _data)
{
    this.helper_applyGameplayOptions(_data);
    return;
}

function onApplyVideoOptions(this, _data)
{
    this.helper_applyVideoOptions(_data);
    return;
}

function onCancelButtonPressed(this)
{
    if (this.m.OnCancelButtonPressedListener != null)
    {
        this.m.OnCancelButtonPressedListener();
    }
    return;
}

function onOkButtonPressed(this)
{
    if (this.m.OnOkButtonPressedListener != null)
    {
        this.m.OnOkButtonPressedListener();
    }
    return;
}

function onQueryData(this)
{
    {}.video <- {};
    {}.audio <- {};
    {}.controls <- {};
    {}.gameplay <- {};
    {}.current <- {};
    this.helper_addVideoOptionsToUIData({}.current.video);
    this.helper_addAudioOptionsToUIData({}.current.audio);
    this.helper_addControlsOptionsToUIData({}.current.controls);
    this.helper_addGameplayOptionsToUIData({}.current.gameplay);
    return {};
}

function setOnCancelButtonPressedListener(this, _listener)
{
    this.m.OnCancelButtonPressedListener = _listener;
    return;
}

function setOnOkButtonPressedListener(this, _listener)
{
    this.m.OnOkButtonPressedListener = _listener;
    return;
}

function show(this)
{
    if ((!this) && (!this))
    {
        return ((!this) && (!this));
        this.m.JSHandle.asyncCall("show", null);
    }
    return;
}
