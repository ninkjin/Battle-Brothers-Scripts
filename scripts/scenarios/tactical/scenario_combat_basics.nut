// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_combat_basics.nut
// Functions: 4

function generate(this)
{
    this.logDebug("ScenarioBasicCombat::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.CreditsTracks;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 5;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 5;
    this.Tactical.getWeather().createCloudSettings().MinVelocity = 30.0;
    this.Tactical.getWeather().createCloudSettings().MaxVelocity = 50.0;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.25;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.5;
    this.Tactical.getWeather().createCloudSettings().MinScale = 1.5;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(16, (15 - (16 / 2))), 0, null, null, 0, 0);
    return;
}

function initEntities(this)
{
    this.Tactical.getTileSquare(13, 15).removeObject();
    this.World.getPlayerRoster().add(this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).setFaction(this.Const.Faction.Player);
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/sackcloth"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (15 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.Tactical.getTileSquare(13, 16).removeObject();
    this.World.getPlayerRoster().add(this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).setFaction(this.Const.Faction.Player);
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (16 - (13 / 2))).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.Tactical.getTileSquare(13, 14).removeObject();
    this.World.getPlayerRoster().add(this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).setFaction(this.Const.Faction.Player);
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).setScenarioValues();
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.Tactical.spawnEntity("scripts/entity/tactical/player", 13, (14 - (13 / 2))).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.Tactical.getTileSquare(19, 16).removeObject();
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (16 - (19 / 2))).getAIAgent().getProperties().OverallDefensivenessMult = 0.25;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (16 - (19 / 2))).getAIAgent().getProperties().BehaviorMult["this.Const.AI.Behavior.ID.Roam"] = 0.0;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (16 - (19 / 2))).setFaction(this.Const.Faction.Bandits);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (16 - (19 / 2))).getBaseProperties().Initiative = 60;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (16 - (19 / 2))).assignRandomEquipment();
    this.Tactical.getTileSquare(19, 14).removeObject();
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).getAIAgent().getProperties().OverallDefensivenessMult = 0.25;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).getAIAgent().getProperties().BehaviorMult["this.Const.AI.Behavior.ID.Roam"] = 0.0;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).setFaction(this.Const.Faction.Bandits);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).getBaseProperties().Initiative = 60;
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).getItems().equip(this.new("scripts/items/weapons/shortsword"));
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_thug", 19, (14 - (19 / 2))).getItems().equip(this.new("scripts/items/shields/wooden_shield_old"));
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
    this.Stash.resize(63);
    this.Stash.setLocked(true);
    return;
}
