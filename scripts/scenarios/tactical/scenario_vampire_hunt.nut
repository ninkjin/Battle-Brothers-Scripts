// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_vampire_hunt.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioLineBattle::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
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
    this.Tactical.getWeather().createRainSettings().MinAlpha = 0.75;
    this.Tactical.getWeather().createRainSettings().MaxAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MinScale = 0.75;
    this.Tactical.getWeather().createRainSettings().MaxScale = 1.0;
    this.Tactical.getWeather().buildRain(this.Tactical.getWeather().createRainSettings());
    this.Tactical.getWeather().setAmbientLightingPreset(6);
    this.Tactical.getCamera().Level = 3;
    return;
}

function initEntities(this)
{
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 14, 14).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 14, 14).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 14, 14).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 14, 14).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 12, 12).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 13, 13).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 13, 13).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 13, 13).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 13, 13).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 13, 13).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 14, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 14, 14, 15, 15).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 14, 15, 15).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 14, 14, 15, 15).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 16, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 16, 16).getItems().equip(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 16, 16).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 16, 16).getItems().equip(this.new("scripts/items/weapons/warhammer"));
    this.spawnEntity("scripts/entity/tactical/player", 16, 16, 16, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.test_hunting_grounds").getMinX(), this.MapGen.get("tactical.test_hunting_grounds").getMinY());
    this.MapGen.get("tactical.test_hunting_grounds").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/scramasax"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hatchet"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
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
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/bludgeon"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
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
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/aketon_cap"));
    this.Stash.add(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.Stash.add(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.Stash.add(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.Stash.add(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.Stash.add(this.new("scripts/items/helmets/mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/mail_coif"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/kettle_hat"));
    this.Stash.add(this.new("scripts/items/helmets/flat_top_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/flat_top_helmet"));
    this.Stash.add(this.new("scripts/items/helmets/full_helm"));
    this.Stash.add(this.new("scripts/items/helmets/full_helm"));
    this.Stash.add(this.new("scripts/items/armor/padded_surcoat"));
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
