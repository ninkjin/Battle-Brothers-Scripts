// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_swipe.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioSwipe::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.CreditsTracks;
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.Fog;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 20;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 20;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 3.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 9.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.3499999940395355;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.44999998807907104;
    this.Tactical.getWeather().createCloudSettings().MinScale = 2.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.getWeather().setAmbientLightingPreset(1);
    this.Tactical.getWeather().setAmbientLightingSaturation(0.8999999761581421);
    this.Tactical.CameraDirector.addJumpToTileEvent(0, this.Tactical.getTile(4, (14 - (4 / 2))), 1, null, null, 0, 0);
    return;
}

function initEntities(this)
{
    if (2 <= 6)
    {
        if (11 <= 16)
        {
            this.Tactical.getTile(2, (11 - (2 / 2))).removeObject();
        }
    }
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/shields/heater_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/weapons/arming_sword"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/helmets/full_aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/armor/gambeson"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/weapons/crossbow"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().addToBag(this.new("scripts/items/weapons/hatchet"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 2, 6, 11, 16).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").setFaction(this.Const.Faction.Beasts);
    this.spawnEntity("scripts/entity/tactical/enemies/direwolf").assignRandomEquipment();
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.forest").getMinX(), this.MapGen.get("tactical.forest").getMinY());
    this.MapGen.get("tactical.forest").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(117);
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/knife"));
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/rondel_dagger"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/pike"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/morning_star"));
    this.Stash.add(this.new("scripts/items/weapons/morning_star"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/helmets/hood"));
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/nasal_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/armor/leather_tunic"));
    this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
    this.Stash.add(this.new("scripts/items/armor/padded_leather"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    return;
}

function spawnEntity(this, _script, _minX, _maxX, _minY, _maxY)
{
    if (1)
    {
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).IsEmpty)
        {
        }
    }
    return this.Tactical.spawnEntity(_script, this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)));
    return _script;
}
