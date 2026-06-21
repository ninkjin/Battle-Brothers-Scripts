// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/events/events/location/abandoned_village_enter_event.nut
// Functions: 17

function <anonymous>(this)
{
    this.Tactical.getWeather().setAmbientLightingPreset(5);
    this.Tactical.getWeather().setAmbientLightingSaturation(0.8999999761581421);
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.Fog;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 20;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 24;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 3.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 16.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.3499999940395355;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.44999998807907104;
    this.Tactical.getWeather().createCloudSettings().MinScale = 2.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    return;
}

function <anonymous>(this)
{
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/fault_finder", outer[1], 7, 8, 7, 8, true);
    if (0 < 2)
    {
        outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem", outer[1], 6, 9, 6, 9, false);
    }
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed", outer[1], 6, 9, 6, 9, false);
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/fault_finder", outer[1], 7, 8, 25, 26, true);
    if (0 < 2)
    {
        outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem", outer[1], 6, 9, 24, 27, false);
    }
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed", outer[1], 6, 9, 24, 27, false);
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/fault_finder", outer[1], 24, 25, 15, 16, true);
    if (0 < 2)
    {
        outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem", outer[1], 23, 26, 14, 17, false);
    }
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed", outer[1], 23, 26, 14, 17, false);
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed", outer[1], 13, 15, 3, 5, false);
    outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed", outer[1], 13, 15, 26, 28, false);
    return;
}

function buildEventCombatProperties(this, _event, _location)
{
    this.Const.Tactical.CombatInfo.getClone().TerrainTemplate = this.Const.World.TerrainTacticalTemplate["_location.getTile().TacticalType"];
    this.Const.Tactical.CombatInfo.getClone().LocationTemplate = clone this;
    this.Const.Tactical.CombatInfo.getClone().CombatID = "AbandonedVillage";
    this.Const.Tactical.CombatInfo.getClone().Music = this.Const.Music.UndeadTracks;
    this.Const.Tactical.CombatInfo.getClone().LocationTemplate.Template["0"] = "tactical.golems_village";
    this.Const.Tactical.CombatInfo.getClone().PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineCenter;
    this.Const.Tactical.CombatInfo.getClone().EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
    this.Const.Tactical.CombatInfo.getClone().IsWithoutAmbience = true;
    this.Const.Tactical.CombatInfo.getClone().Parties.push(_location);
    this.Const.Tactical.CombatInfo.getClone().Entities = [];
    this.Const.Tactical.CombatInfo.getClone().BeforeDeploymentCallback = function() /* closure #0 */;
    this.Const.Tactical.CombatInfo.getClone().AfterDeploymentCallback = function() /* closure #1 */;
    return _event;
}

function create(this)
{
    this.m.ID = "event.location.abandoned_village_enter";
    this.m.Title = "As you approach...";
    this.m.Cooldown = (999999.0 * this.World.getTime().SecondsPerDay);
    this.m.IsSpecial = true;
    {}["To battle!"] <- [];
    {}.Victory <- function() /* closure #2 */;
    this.m.Screens.push({});
    {}["To battle!"] <- [];
    {}.Victory <- function() /* closure #4 */;
    this.m.Screens.push({});
    {}["To battle!"] <- [];
    {}.Victory <- function() /* closure #6 */;
    this.m.Screens.push({});
    return;
}

function getResult(this, _event)
{
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().setVisited(false);
        this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
        _event.registerToShowAfterCombat("Victory", "Defeat");
        this.World.State.startScriptedCombat(_event.buildEventCombatProperties(_event, this.World.State.getLastLocation()), false, false, false);
    }
    return _event;
}

function getResult(this, _event)
{
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().setVisited(false);
        this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
        _event.registerToShowAfterCombat("Victory", "Defeat");
        this.World.State.startScriptedCombat(_event.buildEventCombatProperties(_event, this.World.State.getLastLocation()), false, false, false);
    }
    return;
}

function getResult(this, _event)
{
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().setVisited(false);
    }
    return _event;
}

function getResult(this, _event)
{
    return _event;
}

function getResult(this, _event)
{
    return _event;
}

function onClear(this)
{
    return;
}

function onPrepare(this)
{
    return;
}

function onPrepareVariables(this, _vars)
{
    return;
}

function onUpdateScore(this)
{
    return;
}

function spawnEntityWithinBounds(this, _entity, _faction, _xLower, _xUpper, _yLower, _yUpper, _raiseTile, _maxAttempts)
{
    if (!this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper).IsEmpty))
    {
    }
    if (_raiseTile)
    {
        this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Level = 1;
    }
    if (0 != 6)
    {
        if (!this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper).hasNextTile(0)))
        {
        }
        else
        {
            if (this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper).getNextTile(0).Level == 1))
            {
                this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Level = 2;
            }
        }
    }
    this.Tactical.spawnEntity(_entity, this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Coords).setFaction(_faction);
    this.Tactical.spawnEntity(_entity, this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Coords).assignRandomEquipment();
    if ((0 <= _maxAttempts) && (0 <= _maxAttempts))
    {
        return ((0 <= _maxAttempts) && (0 <= _maxAttempts));
    }
    return _entity;
}

function start(this, _event)
{
    _event.m.Title = "After the battle...";
    this.World.Assets.getStash().makeEmptySlots(1);
    this.World.Assets.getStash().add(this.new("scripts/items/ammo/legendary/quiver_of_coated_arrows"));
    this.List.push({});
    foreach (local key, value in r35)
    {
        if (null.getTypeID() == "location.artifact_reliquary")
        {
            null.setVisibilityMult(1.0);
            this.World.uncoverFogOfWar(null.getTile().Pos, 700.0);
            null.setDiscovered(true);
            this.World.getCamera().moveTo(null);
            null.onUpdate();
        }
        if (this.World.State.getLastLocation() != null)
        {
            this.World.State.getLastLocation().die();
        }
        return;
    }
}

function start(this, _event)
{
    if (this.World.Statistics.getFlags().get("AbandonedVillageFightDefeated"))
    {
        this.Text = "[img]gfx/ui/events/event_178.png[/img]{As expected, the Flesh Golems are still meandering around the town's faceless statue. Judging by the range of freshness and decay, it seems they have had some new members added to the roster, while the older ones are falling apart. But they are all one-minded when their gooey eyes clap down on you and the company. You draw your sword and order in the formations. If this town has a secret, you are going to find it!}";
        this.Options = [{Text = "To battle!", getResult = function() /* closure #0 */}];
    }
    return;
}

function start(this, _event)
{
    _event.m.Title = "After the battle...";
    this.World.Statistics.getFlags().set("AbandonedVillageFightDefeated", true);
    return;
}
