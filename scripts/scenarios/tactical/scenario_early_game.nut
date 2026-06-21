// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_early_game.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioEarlyGame::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.UndeadTracks;
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.Fog;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 16;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 16;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 3.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 9.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.30000001192092896;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.4000000059604645;
    this.Tactical.getWeather().createCloudSettings().MinScale = 2.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.CameraDirector.addJumpToTileEvent(0, this.Tactical.getTile(6, (6 - (6 / 2))), 1, null, null, 0, 100);
    return;
}

function initEntities(this)
{
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 3, 4, 7).getItems().equip(this.new("scripts/items/weapons/bludgeon"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/billhook"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/shortsword"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/scramasax"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/short_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/helmets/straw_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/weapons/short_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 4, 7).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    if (0 < 10)
    {
        this.spawnEntity("scripts/entity/tactical/enemies/zombie").setFaction(this.Const.Faction.Undead);
        this.spawnEntity("scripts/entity/tactical/enemies/zombie").assignRandomEquipment();
    }
    if (0 < 4)
    {
        this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman").setFaction(this.Const.Faction.Undead);
        this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman").assignRandomEquipment();
    }
    this.spawnEntity("scripts/entity/tactical/enemies/necromancer", 15, 23, 15, 23).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/necromancer", 15, 23, 15, 23).assignRandomEquipment();
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.swamp").getMinX(), this.MapGen.get("tactical.swamp").getMinY());
    this.MapGen.get("tactical.swamp").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(63);
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/knife"));
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/scramasax"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/wooden_stick"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
    this.Stash.add(this.new("scripts/items/weapons/reinforced_wooden_flail"));
    this.Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/butchers_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/pitchfork"));
    this.Stash.add(this.new("scripts/items/weapons/short_bow"));
    this.Stash.add(this.new("scripts/items/weapons/short_bow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/buckler_shield"));
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/hood"));
    this.Stash.add(this.new("scripts/items/armor/sackcloth"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    return;
}

function spawnEntity(this, _script, _minX, _maxX, _minY, _maxY)
{
    if (1)
    {
        if (((this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2) < (_minY - (this.Math.rand(_minX, _maxX) / 2))) && ((this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)) < (_minY - (this.Math.rand(_minX, _maxX) / 2)))))
        {
            return (((this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)) < (_minY - (this.Math.rand(_minX, _maxX) / 2))) && ((this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)) < (_minY - (this.Math.rand(_minX, _maxX) / 2))));
        }
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)).Level == 3))
        {
        }
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).IsEmpty)
        {
        }
    }
    else
    {
        return this.Tactical.spawnEntity(_script, this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)));
        return _script;
    }
}
