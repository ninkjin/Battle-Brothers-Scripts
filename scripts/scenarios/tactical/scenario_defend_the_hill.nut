// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_defend_the_hill.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioDefendTheHill::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.UndeadTracks;
    this.Tactical.Entities.makeEnemiesKnownToAI();
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.StaticFog;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 12;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 18;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.25;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.5;
    this.Tactical.getWeather().createCloudSettings().MinScale = 2.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.getWeather().createRainSettings().MinDrops = 150;
    this.Tactical.getWeather().createRainSettings().MaxDrops = 150;
    this.Tactical.getWeather().createRainSettings().NumSplats = 50;
    this.Tactical.getWeather().createRainSettings().MinVelocity = 400.0;
    this.Tactical.getWeather().createRainSettings().MaxVelocity = 500.0;
    this.Tactical.getWeather().createRainSettings().MinAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MaxAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MinScale = 0.75;
    this.Tactical.getWeather().createRainSettings().MaxScale = 1.0;
    this.Tactical.getWeather().buildRain(this.Tactical.getWeather().createRainSettings());
    this.Tactical.getWeather().setAmbientLightingPreset(6);
    this.Tactical.getWeather().setAmbientLightingSaturation(0.8999999761581421);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (15 - (15 / 2))), 3, null, null, 0, 2000);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(9, (15 - (9 / 2))), -1, null, null, 0, 1800);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (8 - (15 / 2))), -1, null, null, 0, 1800);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(21, (15 - (21 / 2))), -1, null, null, 0, 1800);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (21 - (15 / 2))), -1, null, null, 0, 1800);
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (15 - (15 / 2))), -1, null, null, 0, 500);
    this.Sound.setAmbience(0, this.Const.SoundAmbience.Rain, this.Const.Sound.Volume.Ambience, 0);
    return;
}

function initEntities(this)
{
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/full_helm"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/shields/kite_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/gambeson"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/crossbow"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().addToBag(this.new("scripts/items/weapons/hatchet"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 16, 14, 16).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 12, 18, 7, 10).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 12, 18, 7, 10).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 12, 18, 7, 10).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 12, 18, 7, 10).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 12, 18, 7, 10).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 20, 22, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy", 21, 22, 16, 20).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy", 21, 22, 16, 20).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 7, 10, 12, 18).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie", 13, 17, 21, 23).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 13, 17, 21, 23).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/zombie_yeoman", 13, 17, 21, 23).assignRandomEquipment();
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.defend_the_hill").getMinX(), this.MapGen.get("tactical.defend_the_hill").getMinY());
    this.MapGen.get("tactical.defend_the_hill").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(117);
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/falchion"));
    this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
    this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/flail"));
    this.Stash.add(this.new("scripts/items/weapons/flail"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/helmets/hood"));
    this.Stash.add(this.new("scripts/items/helmets/full_aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/padded_nasal_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/flat_top_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/full_helm"));
    this.Stash.add(this.new("scripts/items/armor/gambeson"));
    this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
    this.Stash.add(this.new("scripts/items/armor/padded_leather"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
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
