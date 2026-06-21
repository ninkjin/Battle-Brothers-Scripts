// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_line_battle_nobles.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioLineBattle::generate()");
    this.createStash();
    this.initMap();
    this.initEntities();
    this.initStash();
    this.Tactical.Entities.makeEnemiesKnownToAI();
    this.m.Music = this.Const.Music.NobleTracks;
    this.Tactical.getCamera().Level = 1;
    this.Tactical.CameraDirector.addMoveToTileEvent(0, this.Tactical.getTile(15, (14 - (15 / 2))), 1, null, null, 0, 100);
    return;
}

function initEntities(this)
{
    if (10 < 20)
    {
        if (10 < 20)
        {
            this.Tactical.getTile(10, 10).removeObject();
        }
    }
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/helmets/kettle_hat"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/armor/padded_leather"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getItems().equip(this.new("scripts/items/weapons/billhook"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 15, 15).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/armor/leather_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/weapons/billhook"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().equip(this.new("scripts/items/helmets/hood"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.spawnEntity("scripts/entity/tactical/player", 12, 12, 13, 13).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/armor/thick_tunic"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/weapons/hunting_bow"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 14, 14).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/helmets/aketon_cap"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/armor/gambeson"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/weapons/crossbow"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getItems().addToBag(this.new("scripts/items/weapons/dagger"));
    this.spawnEntity("scripts/entity/tactical/player", 11, 11, 15, 15).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/helmets/named/sallet_green_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/armor/lamellar_harness"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 11, 11).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/weapons/hand_axe"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 13, 13).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/helmets/named/wolf_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/armor/named/black_leather_armor"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/weapons/boar_spear"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 14, 14).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/helmets/named/norse_helmet"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/armor/padded_surcoat"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/weapons/winged_mace"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getItems().equip(this.new("scripts/items/shields/wooden_shield"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 16, 16).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.World.getPlayerRoster().add(this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).setName(this.getRandomPlayerName());
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).setScenarioValues();
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/helmets/mail_coif"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/armor/coat_of_plates"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getItems().equip(this.new("scripts/items/weapons/greatsword"));
    this.spawnEntity("scripts/entity/tactical/player", 13, 13, 17, 17).getSkills().add(this.new("scripts/skills/actives/rally_the_troops"));
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", 12, 12, 16, 16).setFaction(this.Const.Faction.NobleHouse);
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", 12, 12, 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 12, 12, 12, 12).setFaction(this.Const.Faction.NobleHouse);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 12, 12, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/knight", 11, 11, 12, 12).setFaction(this.Const.Faction.NobleHouse);
    this.spawnEntity("scripts/entity/tactical/humans/knight", 11, 11, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 13, 13, 15, 15).setFaction(this.Const.Faction.NobleHouse);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 13, 13, 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 13, 13, 12, 12).setFaction(this.Const.Faction.NobleHouse);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 13, 13, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 11, 11).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 11, 11).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 12, 12).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 13, 13).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 13, 13).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/knight", 19, 19, 14, 14).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/knight", 19, 19, 14, 14).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 15, 15).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 16, 16).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 17, 17).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", 19, 19, 17, 17).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 12, 12).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 12, 12).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", (19 + 1), (19 + 1), 13, 13).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", (19 + 1), (19 + 1), 13, 13).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 15, 15).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 15, 15).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/footman", (19 + 1), (19 + 1), 16, 16).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/footman", (19 + 1), (19 + 1), 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 17, 17).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", (19 + 1), (19 + 1), 17, 17).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", ((19 + 1) + 1), ((19 + 1) + 1), 16, 16).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/standard_bearer", ((19 + 1) + 1), ((19 + 1) + 1), 16, 16).assignRandomEquipment();
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", ((19 + 1) + 1), ((19 + 1) + 1), 14, 14).setFaction(this.Const.Faction.Orcs);
    this.spawnEntity("scripts/entity/tactical/humans/arbalester", ((19 + 1) + 1), ((19 + 1) + 1), 14, 14).assignRandomEquipment();
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
        if (!this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2)).IsEmpty))
        {
            this.Tactical.getTile(this.Math.rand(_minX, _maxX), (this.Math.rand(_minY, _maxY) - (this.Math.rand(_minX, _maxX) / 2))).removeObject();
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
