// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/events/events/location/artifact_reliquary_enter_event.nut
// Functions: 20

function <anonymous>(this)
{
    if (outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/grand_diviner", outer[1], 16, 18, 10, 14, 0, true, []) != null)
    {
        [].push(outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/grand_diviner", outer[1], 16, 18, 10, 14, 0, true, []));
    }
    if (0 < 4)
    {
        if (outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/fault_finder", outer[1], 18, 21, 6, 24, 0, true, []) != null)
        {
            [].push(outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/fault_finder", outer[1], 18, 21, 6, 24, 0, true, []));
        }
    }
    if (0 < 4)
    {
        outer[0].spawnGuardEntity("scripts/entity/tactical/enemies/lesser_flesh_golem_unarmed_bodyguard", outer[1], []);
    }
    if (0 < 3)
    {
        if (outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/greater_flesh_golem", outer[1], 15, 17, 6, 24, (0 + 1), true, []) != null)
        {
            [].push(outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/greater_flesh_golem", outer[1], 15, 17, 6, 24, (0 + 1), true, []));
        }
    }
    return;
}

function <anonymous>(this)
{
    foreach (local key, value in r6)
    {
        [].push(null);
        if (0 < 10)
        {
            if (outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/flesh_cradle", outer[1], 4, 24, 4, 24, 0, true, []) != null)
            {
                [].push(outer[0].spawnEntityWithinBounds("scripts/entity/tactical/enemies/flesh_cradle", outer[1], 4, 24, 4, 24, 0, true, []));
            }
        }
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
}

function buildEventCombatProperties(this, _event, _location)
{
    this.Const.Tactical.CombatInfo.getClone().LocationTemplate = clone this;
    this.Const.Tactical.CombatInfo.getClone().CombatID = "ArtifactReliquary";
    this.Const.Tactical.CombatInfo.getClone().TerrainTemplate = "tactical.golems";
    this.Const.Tactical.CombatInfo.getClone().LocationTemplate.Template["0"] = "tactical.golems_lair";
    this.Const.Tactical.CombatInfo.getClone().Music = this.Const.Music.UndeadTracks;
    this.Const.Tactical.CombatInfo.getClone().PlayerDeploymentType = this.Const.Tactical.DeploymentType.Arena;
    this.Const.Tactical.CombatInfo.getClone().EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
    this.Const.Tactical.CombatInfo.getClone().IsFleeingProhibited = true;
    this.Const.Tactical.CombatInfo.getClone().IsWithoutAmbience = true;
    this.Const.Tactical.CombatInfo.getClone().IsFogOfWarVisible = false;
    this.Const.Tactical.CombatInfo.getClone().Parties.push(_location);
    this.Const.Tactical.CombatInfo.getClone().Entities = [];
    this.Const.Tactical.CombatInfo.getClone().BeforeDeploymentCallback = function() /* closure #0 */;
    this.Const.Tactical.CombatInfo.getClone().AfterDeploymentCallback = function() /* closure #1 */;
    return _event;
}

function create(this)
{
    this.m.ID = "event.location.artifact_reliquary_enter";
    this.m.Title = "As you approach...";
    this.m.Cooldown = (999999.0 * this.World.getTime().SecondsPerDay);
    this.m.IsSpecial = true;
    {}["Onward, men."] <- [];
    {}.B <- function() /* closure #2 */;
    this.m.Screens.push({});
    {}["Onward, men."] <- [];
    {}.B <- function() /* closure #4 */;
    this.m.Screens.push({});
    {}["Onward, men."] <- [];
    {}.B <- function() /* closure #6 */;
    this.m.Screens.push({});
    {}["Onward, men."] <- [];
    {}.B <- function() /* closure #8 */;
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
    return _event;
}

function getResult(this, _event)
{
    return _event;
}

function getResult(this, _event)
{
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().setVisited(false);
    }
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

function spawnEntityWithinBounds(this, _entity, _faction, _xLower, _xUpper, _yLower, _yUpper, _useVariant, _avoidEntities, _entitiesToAvoid, _maxAttempts)
{
    if (!this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper).IsEmpty))
    {
    }
    else
    {
        if (_avoidEntities)
        {
            foreach (local key, value in this.Math.rand(_xLower, _xUpper))
            {
                if (this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper).getDistanceTo(null.getTile()) < 3))
                {
                }
                if (true)
                {
                }
                else
                {
                    this.Tactical.spawnEntity(_entity, this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Coords).setFaction(_faction);
                    this.Tactical.spawnEntity(_entity, this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Coords).assignRandomEquipment();
                    if (_useVariant > 0)
                    {
                        this.Tactical.spawnEntity(_entity, this.Tactical.getTileSquare(this.Math.rand(_xLower, _xUpper), this.Math.rand(_yLower, _yUpper)).Coords).setVariant(_useVariant);
                    }
                }
                if ((0 <= _maxAttempts) && (0 <= _maxAttempts))
                {
                    return ((0 <= _maxAttempts) && (0 <= _maxAttempts));
                }
                return _entity;
            }
        }
    }
}

function spawnGuardEntity(this, _guardEntity, _guardFaction, _wards, _maxAttempts)
{
    foreach (local key, value in r66)
    {
        if (null.getType() != this.Const.EntityType.FaultFinder)
        {
        }
        if (0 < this.Const.Direction.COUNT)
        {
            if (!null.getTile().hasNextTile(0))
            {
            }
            else
            {
                if (null.getTile().getNextTile(0).IsEmpty)
                {
                }
                else
                {
                    if ((0 == this.Const.EntityType.LesserFleshGolem) && (0 == this.Const.EntityType.LesserFleshGolem))
                    {
                        return ((0 == this.Const.EntityType.LesserFleshGolem) && (0 == this.Const.EntityType.LesserFleshGolem));
                    }
                }
            }
        }
        if (true)
        {
        }
        if (null == null)
        {
        }
        if ((this.Const.Direction.COUNT - 1) >= 0)
        {
            if (!null.getTile().hasNextTile((this.Const.Direction.COUNT - 1)))
            {
            }
            else
            {
                if (null.getTile().getNextTile((this.Const.Direction.COUNT - 1)).IsEmpty)
                {
                }
            }
        }
        this.Tactical.spawnEntity(_guardEntity, null.getTile().getNextTile((this.Const.Direction.COUNT - 1)).Coords).setFaction(_guardFaction);
        this.Tactical.spawnEntity(_guardEntity, null.getTile().getNextTile((this.Const.Direction.COUNT - 1)).Coords).assignRandomEquipment();
        if ((0 <= _maxAttempts) && (0 <= _maxAttempts))
        {
            return ((0 <= _maxAttempts) && (0 <= _maxAttempts));
        }
        return _guardEntity;
    }
}

function start(this, _event)
{
    return;
}

function start(this, _event)
{
    if (this.World.Statistics.getFlags().get("ReliquaryFightDefeated"))
    {
        this.Text = "[img]gfx/ui/events/event_182.png[/img]{You venture into the bowled soil, and in turn the flesh golems predictably take to this 'venue' and settle about the rim of the escarpment. The Grand Diviner stands center, unusual staff in hand, and a grin on his face.%SPEECH_ON%Welcome back. Let the mothering continue.%SPEECH_OFF%}";
        this.Options = [{Text = "This motherfarker...", getResult = function() /* closure #0 */}];
    }
    return;
}

function start(this, _event)
{
    _event.m.Title = "After the battle...";
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().die();
    }
    this.World.Assets.getStash().makeEmptySlots(1);
    this.World.Assets.getStash().add(this.new("scripts/items/weapons/legendary/miasma_flail"));
    this.List.push({});
    return;
}

function start(this, _event)
{
    _event.m.Title = "After the battle...";
    this.World.Statistics.getFlags().set("ReliquaryFightDefeated", true);
    if (this.World.State.getLastLocation() != null)
    {
        this.World.State.getLastLocation().setVisited(false);
    }
    return;
}
