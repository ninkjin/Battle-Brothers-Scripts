// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_canyon.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioLineBattle::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = "music/undead_01.music";
    if (0 != 9)
    {
        this.spawnEntity("scripts/entity/tactical/player").assignRandomEquipment();
        this.spawnEntity("scripts/entity/tactical/player").kill();
    }
    this.Tactical.getWeather().createCloudSettings().Type = this.getconsttable().CloudType.StaticFog;
    this.Tactical.getWeather().createCloudSettings().MinClouds = 12;
    this.Tactical.getWeather().createCloudSettings().MaxClouds = 18;
    this.Tactical.getWeather().createCloudSettings().MinAlpha = 0.25;
    this.Tactical.getWeather().createCloudSettings().MaxAlpha = 0.5;
    this.Tactical.getWeather().createCloudSettings().MinScale = 2.0;
    this.Tactical.getWeather().createCloudSettings().MaxScale = 3.0;
    this.Tactical.getWeather().createCloudSettings().Color = this.createColor("#cfb693");
    this.Tactical.getWeather().buildCloudCover(this.Tactical.getWeather().createCloudSettings());
    this.Tactical.getCamera().Level = 3;
    return;
}

function initEntities(this)
{
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/falchion"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/helmet_with_neckguard"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/military_cleaver"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 3, 7, 3, 7).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.canyon").getMinX(), this.MapGen.get("tactical.canyon").getMinY());
    this.MapGen.get("tactical.canyon").fill({}, null);
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
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/shields/kite_shield"));
    this.Stash.add(this.new("scripts/items/helmets/hood"));
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
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)).Level > 1))
        {
        }
        if (this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).IsEmpty)
        {
        }
    }
    return this.Tactical.spawnEntity(_script, this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)));
    return _script;
}
