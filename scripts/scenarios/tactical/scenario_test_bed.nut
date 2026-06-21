// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_test_bed.nut
// Functions: 5

function generate(this)
{
    this.logDebug("ScenarioTestBed::generate()");
    this.createStash();
    this.initMap();
    this.initEntities(6, 1);
    this.initStash();
    this.Tactical.getCamera().Level = 0;
    return;
}

function initEntities(this, _numPlayer, _numEnemy)
{
    if (0 < _numPlayer)
    {
        if (1)
        {
            if (this.Tactical.getTile(this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2)).Level == 3))
            {
            }
            if (this.Tactical.getTile(this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).IsEmpty)
            {
            }
        }
        else
        {
            this.spawnEntity("scripts/entity/tactical/player", this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).setName(this.getRandomPlayerName());
            this.spawnEntity("scripts/entity/tactical/player", this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).setScenarioValues();
            this.spawnEntity("scripts/entity/tactical/player", this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).getItems().equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
            if (this.Math.rand(1, 2) == 1)
            {
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                }
            }
            this.new("scripts/items/armor/oriental/gladiator_harness").setUpgrade(this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade"));
            this.spawnEntity("scripts/entity/tactical/player", this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).getItems().equip(this.new("scripts/items/armor/oriental/gladiator_harness"));
            this.spawnEntity("scripts/entity/tactical/player", this.Math.rand(2, 6), (this.Math.rand(2, 6) - (this.Math.rand(2, 6) / 2))).getItems().equip(this.new("scripts/items/weapons/oriental/firelance"));
            this.spawnEntity("scripts/entity/tactical/enemies/orc_berserker").setFaction(this.Const.Faction.Orcs);
            this.spawnEntity("scripts/entity/tactical/enemies/orc_berserker").assignRandomEquipment();
            return;
        }
    }
}

function initMap(this)
{
    this.Tactical.resizeScene(this.MapGen.get("tactical.desert").getMinX(), this.MapGen.get("tactical.desert").getMinY());
    this.MapGen.get("tactical.desert").fill({}, null);
    clone this.Template["0"] = "tactical.barbarian_camp";
    clone this.Fortification = this.Const.Tactical.FortificationType.Palisade;
    clone this.CutDownTrees = true;
    clone this.ShiftX = 0;
    return;
}

function initStash(this)
{
    this.Stash.clear();
    this.Stash.resize(63);
    this.Stash.setLocked(true);
    return;
}

function spawnEntity(this, _script, _minX, _maxX, _minY, _maxY)
{
    if (1)
    {
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
