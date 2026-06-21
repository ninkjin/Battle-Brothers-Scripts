// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_advanced_combat.nut
// Functions: 6

function generate(this)
{
    this.logDebug("ScenarioAdvancedCombat::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.m.Music = this.Const.Music.BeastsTracks;
    this.Tactical.getWeather().createRainSettings().MinDrops = 20;
    this.Tactical.getWeather().createRainSettings().MaxDrops = 20;
    this.Tactical.getWeather().createRainSettings().DropLifetime = 7000;
    this.Tactical.getWeather().createRainSettings().NumSplats = 0;
    this.Tactical.getWeather().createRainSettings().MinVelocity = 50.0;
    this.Tactical.getWeather().createRainSettings().MaxVelocity = 100.0;
    this.Tactical.getWeather().createRainSettings().MinAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MaxAlpha = 1.0;
    this.Tactical.getWeather().createRainSettings().MinScale = 0.30000001192092896;
    this.Tactical.getWeather().createRainSettings().MaxScale = 0.5;
    this.Tactical.getWeather().createRainSettings().ScaleDropsWithTime = true;
    this.Tactical.getWeather().createRainSettings().clearDropBrushes();
    this.Tactical.getWeather().createRainSettings().addDropBrush("leaf_01");
    this.Tactical.getWeather().createRainSettings().addDropBrush("leaf_02");
    this.Tactical.getWeather().createRainSettings().addDropBrush("leaf_03");
    this.Tactical.getWeather().createRainSettings().addDropBrush("leaf_04");
    this.Tactical.getWeather().buildRain(this.Tactical.getWeather().createRainSettings());
    this.Tactical.getWeather().setAmbientLightingPreset(2);
    this.Tactical.CameraDirector.addJumpToTileEvent(0, this.Tactical.getTile(14, (12 - (5 / 2))), 1, null, null, 0, 0);
    return;
}

function initEntities(this)
{
    if (12 <= 16)
    {
        if (13 <= 18)
        {
            this.Tactical.getTileSquare(12, 13).removeObject();
        }
    }
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/helmets/full_helm"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/helmets/flat_top_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/lamellar_harness"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/shields/kite_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/helmets/nasal_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/noble_sword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/mail_shirt"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/named/golden_scale_armor"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/helmets/named/wolf_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/named/black_leather_armor"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/crossbow"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/weapons/war_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 15, 14, 17).getItems().addToBag(this.new("scripts/items/weapons/hatchet"));
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire").setFaction(this.Const.Faction.Undead);
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire").assignRandomEquipment();
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire").setFaction(this.Const.Faction.Undead);
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire").assignRandomEquipment();
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire_low").setFaction(this.Const.Faction.Undead);
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire_low").assignRandomEquipment();
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire_low").setFaction(this.Const.Faction.Undead);
    this.spawnEnemy("scripts/entity/tactical/enemies/vampire_low").assignRandomEquipment();
    return;
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.autumn").getMinX(), this.MapGen.get("tactical.autumn").getMinY());
    this.MapGen.get("tactical.autumn").fill({}, null);
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(117);
    this.Stash.setLocked(false);
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/dagger"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/javelin"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/hand_axe"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/warhammer"));
    this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
    this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
    this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
    this.Stash.add(this.new("scripts/items/weapons/noble_sword"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/military_cleaver"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greatsword"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/greataxe"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/billhook"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/boar_spear"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/weapons/winged_mace"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/tools/throwing_net"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/hunting_bow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/weapons/crossbow"));
    this.Stash.add(this.new("scripts/items/shields/wooden_shield"));
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
    this.Stash.add(this.new("scripts/items/armor/padded_leather"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/mail_shirt"));
    this.Stash.add(this.new("scripts/items/armor/lamellar_harness"));
    this.Stash.add(this.new("scripts/items/armor/coat_of_plates"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.Stash.add(this.new("scripts/items/ammo/quiver_of_bolts"));
    return;
}

function spawnEnemy(this, _script, _minX, _maxX, _minY, _maxY)
{
    if (1)
    {
        if ((this.Math.rand(_minY, _maxY) < 20) && (this.Math.rand(_minY, _maxY) < 20) && (this.Math.rand(_minY, _maxY) < 20))
        {
            return ((this.Math.rand(_minY, _maxY) < 20) && (this.Math.rand(_minY, _maxY) < 20) && (this.Math.rand(_minY, _maxY) < 20));
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
