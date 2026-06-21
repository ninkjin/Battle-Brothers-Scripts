// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/!mods_preload/mod_save.nut
// Functions: 13

function <anonymous>(this)
{
    this.mods_hookNewObject("states/world_state", function() /* closure #0 */);
    return;
}

function <anonymous>(this, _pos)
{
    if (this.getLocalCombatProperties(_pos).Entities.len() == 0)
    {
        return _pos;
    }
    if (!this.World.Assets.isIronman())
    {
        this.autosave("Combat_Start");
    }
    outer[0](_pos);
    return;
}

function <anonymous>(this, _campaignFileName, _campaignLabel)
{
    if (this.mods_getRegisteredMod("mod_legends") != null)
    {
        if ((8 == 8) && (8 == 8))
        {
            return ((8 == 8) && (8 == 8));
        }
        if (_campaignLabel == null)
        {
        }
        else
        {
            if ((8 != 8) && (8 != 8))
            {
                return ((8 != 8) && (8 != 8));
            }
        }
    }
    outer[0]((_campaignFileName.slice(0, (_campaignFileName.len() - 8)) + "_Legend"), ((_campaignFileName.slice(0, (_campaignFileName.len() - 8)) + "(Legend)") + "(Legend)"));
    return;
}

function <anonymous>(this, obj)
{
    obj.m.asn <- 0;
    obj.m.osn <- 0;
    obj.autosave <- function() /* closure #0 */;
    obj.exitGame <- function() /* closure #1 */;
    obj.onCombatFinished <- function() /* closure #2 */;
    obj.showTownScreen <- function() /* closure #3 */;
    if (this.mods_getRegisteredMod("mod_legends") != null)
    {
        obj.showCampScreen <- function() /* closure #4 */;
    }
    obj.startCombat <- function() /* closure #5 */;
    obj.saveCampaign <- function() /* closure #6 */;
    return;
}

function <anonymous>(this)
{
    if ((this.World > 0) && (this.World > 0))
    {
        return ((this.World > 0) && (this.World > 0));
        this.autosave("ExitGame");
    }
    outer[0]();
    return;
}

function <anonymous>(this)
{
    return (!this.m.CampScreen.isAnimating());
}

function <anonymous>(this)
{
    return (!this.m.WorldTownScreen.isAnimating());
}

function <anonymous>(this)
{
    outer[0](this);
    if (!this.World.Assets.isIronman())
    {
        this.autosave("Combat_End");
    }
    return;
}

function <anonymous>(this)
{
    if (this.m.LastEnteredTown != null)
    {
        this.m.LastEnteredTown.onLeave();
        this.m.LastEnteredTown = null;
    }
    if (this.m.CombatStartTime == 0)
    {
        if (this.World.getTime().IsDaytime)
        {
        }
        this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain), this.Const.Sound.AmbienceMinDelayAtNight);
        this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement), this.Const.Sound.AmbienceOutsideDelay);
    }
    this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
    this.World.Assets.consumeItems();
    this.World.Assets.refillAmmo();
    this.World.Assets.updateAchievements();
    this.World.Assets.checkAmbitionItems();
    this.World.Ambitions.updateUI();
    this.World.Ambitions.resetTime(false, 3.0);
    this.updateTopbarAssets();
    this.World.State.getPlayer().updateStrength();
    this.m.WorldTownScreen.clear();
    this.m.WorldTownScreen.hide();
    this.m.WorldScreen.show();
    this.setWorldmapMusic(false);
    if ((this.m.CombatStartTime == 0) && (this.m.CombatStartTime == 0))
    {
        return ((this.m.CombatStartTime == 0) && (this.m.CombatStartTime == 0));
        this.autosave();
    }
    if ((this.m.CombatStartTime == 0) && (this.m.CombatStartTime == 0))
    {
        return ((this.m.CombatStartTime == 0) && (this.m.CombatStartTime == 0));
        this.autosave("ExitTown");
    }
    this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
    this.m.IsForcingAttack = false;
    this.setAutoPause(true);
    this.m.AutoUnpauseFrame = (this.Time.getFrame() + 1);
    return;
}

function <anonymous>(this)
{
    if (this.m.MenuStack.hasBacksteps())
    {
        return;
    }
    if (this.m.LastEnteredTown == null)
    {
        return;
    }
    this.m.CustomZoom = this.World.getCamera().Zoom;
    this.World.getCamera().zoomTo(1.0, 4.0);
    this.World.getCamera().moveTo(this.m.LastEnteredTown);
    this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), this.Const.Music.CrossFadeTime);
    this.setAutoPause(true);
    this.Tooltip.hide();
    this.m.WorldScreen.hide();
    this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
    this.m.WorldTownScreen.show();
    this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement), this.Const.Sound.AmbienceMinDelayAtNight);
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement), this.Const.Sound.AmbienceMinDelayAtNight);
    if (this.World.Assets.isIronman())
    {
        this.World.presave();
    }
    this.m.MenuStack.push(function() /* closure #0 */, function() /* closure #1 */);
    return;
}

function <anonymous>(this)
{
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain), this.Const.Sound.AmbienceMinDelayAtNight);
    this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement), this.Const.Sound.AmbienceOutsideDelay);
    this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
    this.m.CampScreen.clear();
    this.m.CampScreen.hide();
    this.m.WorldScreen.show();
    if (this.World.FactionManager.isGreaterEvil())
    {
    }
    this.Music.setTrackList(this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime);
    if (this.World.Assets.isIronman())
    {
        this.autosave();
    }
    this.autosave("ExitCamp");
    this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
    this.setAutoPause(false);
    this.setPause(true);
    return;
}

function <anonymous>(this, _campaignLabel)
{
    if (!this.m.IsAutosaving)
    {
        return;
    }
    if (!this.m.IsGameAutoPaused)
    {
        this.setAutoPause(true);
    }
    if (this.World.Assets.isIronman())
    {
        this.saveCampaign(((this.World.Assets.getName() + "_") + this.World.Assets.getCampaignID()), this.World.Assets.getName());
    }
    else
    {
        if (_campaignLabel != null)
        {
            if ((this.m.osn >= 2) && (this.m.osn >= 2))
            {
                return ((this.m.osn >= 2) && (this.m.osn >= 2));
                this.m.osn <- 1;
            }
            this.m.osn = (this.m.osn + 1);
            this.saveCampaign(((_campaignLabel + "_0") + this.m.osn));
        }
        if ((this.m.asn >= 4) && (this.m.asn >= 4))
        {
            return ((this.m.asn >= 4) && (this.m.asn >= 4));
            this.m.asn <- 1;
        }
        this.m.asn = (this.m.asn + 1);
        this.saveCampaign(("autosave_0" + this.m.asn));
    }
    if (!this.m.IsGameAutoPaused)
    {
        this.setAutoPause(false);
    }
    return;
}

function <anonymous>(this)
{
    if (!this.isCampingAllowed())
    {
        return;
    }
    if (this.World.Camp.isCamping())
    {
        this.onCamp();
        return;
    }
    this.setPause(true);
    this.setAutoPause(true);
    this.Tooltip.hide();
    this.m.WorldScreen.hide();
    this.m.CampScreen.show();
    this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
    if (this.World.getTime().IsDaytime)
    {
    }
    this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), (this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement), this.Const.Sound.AmbienceMinDelayAtNight);
    this.m.MenuStack.push(function() /* closure #0 */, function() /* closure #1 */);
    return;
}
