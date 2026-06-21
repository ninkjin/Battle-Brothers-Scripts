// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/lesser_flesh_golem.nut
// Functions: 7

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/helmets/golems/flesh_golem_facewrap"));
    this.m.Items.equip(this.new("scripts/items/armor/golems/flesh_golem_robes"));
    if (this.Math.rand(0, 3) == 0)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/golems/golem_mace_hammer"));
    }
    else
    {
        if (this.Math.rand(0, 3) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/golems/golem_cleaver_hammer"));
        }
        else
        {
            if (this.Math.rand(0, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/golems/golem_mace_flail"));
            }
            else
            {
                if (this.Math.rand(0, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/golems/golem_spear_sword"));
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.LesserFleshGolem;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.LesserFleshGolem.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.m.DecapitateSplatterOffset = this.createVec(33, -26);
    this.m.DecapitateBloodAmount = 0.800000011920929;
    this.m.BloodPoolScale = 0.800000011920929;
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/small_golem_death_01.wav", "sounds/enemies/small_golem_death_02.wav", "sounds/enemies/small_golem_death_03.wav", "sounds/enemies/small_golem_death_04.wav", "sounds/enemies/small_golem_death_05.wav", "sounds/enemies/small_golem_death_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/small_golem_hurt_01.wav", "sounds/enemies/small_golem_hurt_02.wav", "sounds/enemies/small_golem_hurt_03.wav", "sounds/enemies/small_golem_hurt_04.wav", "sounds/enemies/small_golem_hurt_05.wav", "sounds/enemies/small_golem_hurt_06.wav", "sounds/enemies/small_golem_hurt_07.wav", "sounds/enemies/small_golem_hurt_08.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/small_golem_idle_01.wav", "sounds/enemies/small_golem_idle_02.wav", "sounds/enemies/small_golem_idle_03.wav", "sounds/enemies/small_golem_idle_04.wav", "sounds/enemies/small_golem_idle_05.wav", "sounds/enemies/small_golem_idle_06.wav", "sounds/enemies/small_golem_idle_07.wav", "sounds/enemies/small_golem_idle_08.wav", "sounds/enemies/small_golem_idle_09.wav", "sounds/enemies/small_golem_idle_10.wav"];
    this.m.SoundPitch = this.Math.rand(0.8999999761581421, 1.100000023841858);
    this.m.SoundVolumeOverall = 1.25;
    this.getFlags().add("undead");
    this.getFlags().add("flesh_golem");
    if (this.m.IsCreatingAgent)
    {
        this.m.AIAgent = this.new("scripts/ai/tactical/agents/lesser_flesh_golem_agent");
        this.m.AIAgent.setActor(this);
    }
    return;
}

function generateCorpse(this, _tile, _fatalityType, _killer)
{
    clone this.CorpseName = "A Flesh Golem";
    clone this.IsResurrectable = false;
    clone this.IsConsumable = true;
    clone this.Items = this.getItems().prepareItemsForCorpse(_killer);
    clone this.IsHeadAttached = (_fatalityType != this.Const.FatalityType.Decapitated);
    if (_tile != null)
    {
        clone this.Tile = _tile;
    }
    return _tile;
}

function getLootForTile(this, _killer, _loot)
{
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
    {
        if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.golem_cleaver_hammer")
        {
            [].push("butchers_cleaver");
            [].push("pickaxe");
        }
        else
        {
            if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.golem_mace_flail")
            {
                [].push("bludgeon");
                [].push("reinforced_wooden_flail");
            }
            else
            {
                if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.golem_mace_hammer")
                {
                    [].push("bludgeon");
                    [].push("pickaxe");
                }
                else
                {
                    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.golem_spear_sword")
                    {
                        [].push("militia_spear");
                        [].push("shortsword");
                    }
                }
            }
        }
    }
    foreach (local key, value in r41)
    {
        if (this.Math.rand(1, 100) <= 80)
        {
            this.new(("scripts/items/weapons/" + null)).setCondition((this.Math.rand(1, this.Math.max(1, (this.new(("scripts/items/weapons/" + null)).getConditionMax() - 2))) * 1.0));
            if (this.new(("scripts/items/weapons/" + null)).isDroppedAsLoot())
            {
                _loot.push(this.new(("scripts/items/weapons/" + null)));
            }
        }
        return this.actor.getLootForTile(_killer, _loot);
        return _killer;
    }
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        this.m.IsCorpseFlipped = (this.Math.rand(1, 100) < 50);
        this.spawnBloodPool(_tile, 1);
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("body").Color;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("body").Saturation;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        if (this.getItems().getAppearance().CorpseArmor != "FatalityType")
        {
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        }
        if (_fatalityType != this.Const.Decapitated.HideCorpseHead)
        {
            if (!this.getItems().getAppearance().HelmetCorpse)
            {
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("head").Color;
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("head").Saturation;
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
            }
            if (this.getItems().getAppearance().len.push() != 0)
            {
                _tile.spawnDetail(this.getItems().getAppearance().len, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
                _tile.spawnDetail(this.getItems().getAppearance().len, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
            }
        }
        else
        {
            if (_fatalityType == this.Const.Decapitated.HideCorpseHead)
            {
                if (!this.getItems().getAppearance().HelmetCorpse)
                {
                    [].spawnHeadEffect((this.getSprite("head").getBrush().Name + "_dead"));
                }
                if (this.getItems().getAppearance().len.push() != 0)
                {
                    [].spawnHeadEffect(this.getItems().getAppearance().len);
                }
                if (!this.getItems().getAppearance().HelmetCorpse)
                {
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["0"].Color = this.getSprite("head").Color;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["0"].Saturation = this.getSprite("head").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["0"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["0"].setBrightness(0.8999999761581421);
                }
                if (this.getItems().getAppearance().len.push() != 0)
                {
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["(0 + 12)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").getBrush().Name + "Disemboweled"))["(0 + 12)"].setBrightness(0.8999999761581421);
                }
            }
        }
        if (_fatalityType == this.Const.Decapitated.guts_flesh_golem_body_02_dead)
        {
            _tile.spawnDetail("getProjectileType", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        }
        else
        {
            if ((0.8999999761581421 == this.Const.Arrow._dead_arrows) && (0.8999999761581421 == this.Const.Arrow._dead_arrows))
            {
                return ((0.8999999761581421 == this.Const.Arrow._dead_arrows) && (0.8999999761581421 == this.Const.Arrow._dead_arrows));
                _tile.spawnDetail((this.getSprite("body").getBrush().Name + "Javelin"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
            }
            else
            {
                if ((0.8999999761581421 == this.Const.Arrow._dead_javelin) && (0.8999999761581421 == this.Const.Arrow._dead_javelin))
                {
                    return ((0.8999999761581421 == this.Const.Arrow._dead_javelin) && (0.8999999761581421 == this.Const.Arrow._dead_javelin));
                    _tile.spawnDetail((this.getSprite("body").getBrush().Name + "spawnTerrainDropdownEffect"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
                }
            }
        }
        this.getDroppableLoot(_tile);
    }
    this.generateCorpse(_tile, this.dropLoot(_killer, this.getItems().getLootForTile(_killer)), (!(this.Math.rand(1, 100) < 50)));
    if (_tile == null)
    {
        this.Tactical.addUnplacedCorpse.Properties(this.Entities(_tile, _fatalityType, _killer));
    }
    _tile.set.addCorpse("Corpse", this.Entities(_tile, _fatalityType, _killer));
    this.Tactical.addUnplacedCorpse.actor(_tile);
    this.onDeath["k[53]"](_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.LesserFleshGolem);
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Items.getAppearance().Body = "bust_flesh_golem_body_01";
    this.addSprite("socket").setBrush("bust_base_undead");
    this.addSprite("body").setBrush("bust_flesh_golem_body_01");
    this.addSprite("body").varySaturation(0.10000000149011612);
    this.addSprite("body").varyColor(0.09000000357627869, 0.09000000357627869, 0.09000000357627869);
    this.addSprite("injury").Visible = false;
    this.addSprite("injury").setBrush("bust_flesh_golem_body_01_injured");
    this.addSprite("armor");
    this.addSprite("head").setBrush(("bust_flesh_golem_head_0" + this.Math.rand(1, 3)));
    this.addSprite("head").Saturation = this.addSprite("body").Saturation;
    this.addSprite("head").Color = this.addSprite("body").Color;
    this.addSprite("helmet");
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.44999998807907104;
    this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
    this.m.Skills.add(this.new("scripts/skills/racial/flesh_golem_racial"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    return;
}

function playSound(this, _type, _volume, _pitch)
{
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
    }
    this.actor.playSound(_type, _volume, _pitch);
    return;
}
