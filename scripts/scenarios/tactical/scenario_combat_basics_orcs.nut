// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_combat_basics_orcs.nut
// Functions: 4

function generate(this)
{
    this.logDebug("ScenarioBasicCombat::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = "music/credits.music";
    this.Tactical.getWeather().createCloudSettings().MinClouds = 5;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 5;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 30.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 50.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.6600000262260437;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.8999999761581421;
    this.Tactical.getWeather().createCloudSettings().MinScale = 1.5;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(16, (15 - (16 / 2))), 0, null, null, 0, 2000);
    this.Sound.playAtmosphere("sounds/atmosphere/forest_01.wav", 0.75);
    return;
}

function initEntities(this)
{
    this.Tactical.getTileSquare(13, 15).removeObject();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).setName(this.getRandomPlayerName());
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.Tactical.getTileSquare(13, 16).removeObject();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).setName(this.getRandomPlayerName());
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.Tactical.getTileSquare(13, 14).removeObject();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).setName(this.getRandomPlayerName());
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/orc_berserker", 19, (15 - (19 / 2))).getItems().equip(this.new("scripts/items/weapons/greenskins/orc_flail_2h"));
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.combat_basics").getMinX(), this.MapGen.get("tactical.combat_basics").getMinY());
    this.MapGen.get("tactical.combat_basics").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.setLocked(true);
    return;
}
