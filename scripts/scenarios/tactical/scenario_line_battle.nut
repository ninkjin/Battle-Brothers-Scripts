// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_line_battle.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioLineBattle::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.UndeadTracks;
    this.Tactical.Entities.makeEnemiesKnownToAI();
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
    this.Tactical.getWeather().createRainSettings().MinDrops = 300;
    this.Tactical.getWeather().createRainSettings().MaxDrops = 300;
    this.Tactical.getWeather().createRainSettings().NumSplats = 0;
    this.Tactical.getWeather().createRainSettings().MinVelocity = 900.0;
    this.Tactical.getWeather().createRainSettings().MaxVelocity = 1200.0;
    this.Tactical.getWeather().createRainSettings().MinAlpha = 0.5;
    this.Tactical.getWeather().createRainSettings().MaxAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MinScale = 0.5;
    this.Tactical.getWeather().createRainSettings().MaxScale = 1.0;
    this.Tactical.getWeather().createRainSettings().clearDropBrushes();
    this.Tactical.getWeather().createRainSettings().addDropBrush("rain_03");
    this.Tactical.getWeather().createRainSettings().Direction = this.createVec(-0.44999998807907104, -0.550000011920929);
    this.Tactical.getWeather().buildRain(this.Tactical.getWeather().createRainSettings());
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.Custom;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 150;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 150;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 400.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 500.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.6000000238418579;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 1.0;
    this.Tactical.getWeather().createCloudSettings().MinScale = 1.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 4.0;
    this.Tactical.getWeather().createCloudSettings().Sprite = "wind_01";
    this.Tactical.getWeather().createCloudSettings().RandomizeDirection = false;
    this.Tactical.getWeather().createCloudSettings().RandomizeRotation = false;
    this.Tactical.getWeather().createCloudSettings().Direction = this.createVec(-1.0, -0.699999988079071);
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Sound.setAmbience(0, this.Const.SoundAmbience.Blizzard, this.Const.Sound.Volume.Ambience, 0);
    this.Tactical.getCamera().Level = 1;
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (14 - (15 / 2))), 1, null, null, 0, 100);
    return;
}

function initEntities(this)
{
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17).getItems().equip(this.new("scripts/items/armor/leather_lamellar"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.new("scripts/items/tools/player_banner").setVariant(2);
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 17, 17).getItems().equip(this.new("scripts/items/tools/player_banner"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/weapons/billhook"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/weapons/longaxe"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).setFaction(this.Const.Faction.Player);
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/helmets/open_leather_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/weapons/short_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/helmets/full_aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/armor/gambeson"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/weapons/crossbow"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/armor/lamellar_harness"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/weapons/greataxe"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/shields/heater_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/helmets/named/norse_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).getItems().equip(this.new("scripts/items/helmets/bascinet_with_mail"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).getItems().equip(this.new("scripts/items/armor/mail_hauberk"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).getItems().equip(this.new("scripts/items/weapons/warhammer"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 15, 15).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/helmets/open_leather_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/armor/ragged_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 11, 11).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 11, 11).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 12, 12).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 13, 13).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 13, 13).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 19, 19, 14, 14).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 19, 19, 14, 14).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 19, 19, 15, 15).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium", 19, 19, 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 16, 16).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 17, 17).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", 19, 19, 17, 17).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 12, 12).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 13, 13).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 13, 13).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 14, 14).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 14, 14).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 15, 15).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 16, 16).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 17, 17).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_medium_polearm", 20, 20, 17, 17).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_priest", 21, 21, 15, 15).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_priest", 21, 21, 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy_bodyguard", 21, 21, 14, 14).setFaction(this.Const.Faction.Undead);
    this.spawnEntity("scripts/entity/tactical/enemies/skeleton_heavy_bodyguard", 21, 21, 14, 14).assignRandomEquipment();
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.snow").getMinX(), this.MapGen.get("tactical.snow").getMinY());
    this.MapGen.get("tactical.snow").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(117);
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/scramasax"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
    this.Stash.add(this.new("scripts/items/weapons/throwing_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/shortsword"));
    this.Stash.add(this.new("scripts/items/weapons/shortsword"));
    this.Stash.add(this.new("scripts/items/weapons/falchion"));
    this.Stash.add(this.new("scripts/items/weapons/falchion"));
    this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
    this.Stash.add(this.new("scripts/items/weapons/arming_sword"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
    this.Stash.add(this.new("scripts/items/weapons/militia_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/flail"));
    this.Stash.add(this.new("scripts/items/weapons/flail"));
    this.Stash.add(this.new("scripts/items/weapons/flail"));
    this.Stash.add(this.new("scripts/items/weapons/short_bow"));
    this.Stash.add(this.new("scripts/items/weapons/short_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/helmets/hood"));
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/full_aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/nasal_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/padded_nasal_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
    this.Stash.add(this.new("scripts/items/helmets/mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/closed_mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/reinforced_mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/padded_kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat_with_mail"));
    this.Stash.add(this.new("scripts/items/helmets/flat_top_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/flat_top_with_mail"));
    this.Stash.add(this.new("scripts/items/helmets/full_helm"));
    this.Stash.add(this.new("scripts/items/helmets/full_helm"));
    this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
    this.Stash.add(this.new("scripts/items/armor/gambeson"));
    this.Stash.add(this.new("scripts/items/armor/gambeson"));
    this.Stash.add(this.new("scripts/items/armor/padded_leather"));
    this.Stash.add(this.new("scripts/items/armor/padded_leather"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
    this.Stash.add(this.new("scripts/items/armor/coat_of_plates"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    return;
}

function spawnEntity(this, _script, _minX, _maxX, _minY, _maxY)
{
    if (1)
    {
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).IsOccupiedByActor)
        {
        }
        this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).removeObject();
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
