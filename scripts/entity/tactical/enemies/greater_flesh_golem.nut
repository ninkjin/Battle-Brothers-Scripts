// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/greater_flesh_golem.nut
// Functions: 7

function assignEquipment(this, variant)
{
    this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
    this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
    this.m.Items.equip(this.new(("scripts/items/helmets/golems/greater_flesh_golem_helmet_0" + variant)));
    this.m.Items.equip(this.new(("scripts/items/armor/golems/greater_flesh_golem_armor_0" + variant)));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GreaterFleshGolem;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.GreaterFleshGolem.XP;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.m.DecapitateSplatterOffset = this.createVec(40, -20);
    this.m.DecapitateBloodAmount = 3.0;
    this.m.ExcludedInjuries = ["injury.sprained_ankle", "injury.injured_knee_cap", "injury.inhaled_flames", "injury.dislocated_shoulder", "injury.cut_achilles_tendon", "injury.burnt_legs", "injury.bruised_leg", "injury.broken_leg"];
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/big_golem_death_01.wav", "sounds/enemies/big_golem_death_02.wav", "sounds/enemies/big_golem_death_03.wav", "sounds/enemies/big_golem_death_04.wav", "sounds/enemies/big_golem_death_05.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/big_golem_hurt_01.wav", "sounds/enemies/big_golem_hurt_02.wav", "sounds/enemies/big_golem_hurt_03.wav", "sounds/enemies/big_golem_hurt_04.wav", "sounds/enemies/big_golem_hurt_05.wav", "sounds/enemies/big_golem_hurt_06.wav", "sounds/enemies/big_golem_hurt_07.wav", "sounds/enemies/big_golem_hurt_08.wav", "sounds/enemies/big_golem_hurt_09.wav", "sounds/enemies/big_golem_hurt_10.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/big_golem_idle_01.wav", "sounds/enemies/big_golem_idle_02.wav", "sounds/enemies/big_golem_idle_03.wav", "sounds/enemies/big_golem_idle_04.wav", "sounds/enemies/big_golem_idle_05.wav", "sounds/enemies/big_golem_idle_06.wav"];
    this.m.SoundPitch = this.Math.rand(0.8999999761581421, 1.100000023841858);
    this.m.SoundVolumeOverall = 1.25;
    this.getFlags().add("undead");
    this.getFlags().add("flesh_golem");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/greater_flesh_golem_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateCorpse(this, _tile, _fatalityType, _killer)
{
    clone this.CorpseName = "A Greater Flesh Golem";
    clone this.Tile = _tile;
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

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_tile != null)
    {
        this.m.IsCorpseFlipped = (this.Math.rand(1, 100) < 50);
        this.spawnBloodPool(_tile, 1);
        _tile.spawnDetail("bust_greater_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("body").Color;
        _tile.spawnDetail("bust_greater_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("body").Saturation;
        _tile.spawnDetail("bust_greater_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
        _tile.spawnDetail("bust_greater_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        if (this.getItems().getAppearance().CorpseArmor != "FatalityType")
        {
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
        }
        if (_fatalityType != this.Const.Decapitated.HideCorpseHead)
        {
            if (!this.getItems().getAppearance().getBrush)
            {
                _tile.spawnDetail((this.getSprite("head").Name()["_dead"] + "HelmetCorpse"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Color = this.getSprite("head").Color;
                _tile.spawnDetail((this.getSprite("head").Name()["_dead"] + "HelmetCorpse"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Saturation = this.getSprite("head").Saturation;
                _tile.spawnDetail((this.getSprite("head").Name()["_dead"] + "HelmetCorpse"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
                _tile.spawnDetail((this.getSprite("head").Name()["_dead"] + "HelmetCorpse"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).setBrightness(0.8999999761581421);
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
                if (!this.getItems().getAppearance().getBrush)
                {
                    [].spawnHeadEffect((this.getSprite("head").Name()["_dead"] + "HelmetCorpse"));
                }
                if (this.getItems().getAppearance().len.push() != 0)
                {
                    [].spawnHeadEffect(this.getItems().getAppearance().len);
                }
                if (!this.getItems().getAppearance().getBrush)
                {
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["0"].Color = this.getSprite("head").Color;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["0"].Saturation = this.getSprite("head").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["0"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["0"].setBrightness(0.8999999761581421);
                }
                if (this.getItems().getAppearance().len.push() != 0)
                {
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["(0 + 12)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this["_dead_bloodpool"](-75, 50), 90.0, (this.getSprite("head").Name()["_dead"] + "Disemboweled"))["(0 + 12)"].setBrightness(0.8999999761581421);
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
                _tile.spawnDetail((this.getSprite("body").Name()["_dead"] + "Javelin"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
            }
            else
            {
                if ((0.8999999761581421 == this.Const.Arrow._dead_javelin) && (0.8999999761581421 == this.Const.Arrow._dead_javelin))
                {
                    return ((0.8999999761581421 == this.Const.Arrow._dead_javelin) && (0.8999999761581421 == this.Const.Arrow._dead_javelin));
                    _tile.spawnDetail((this.getSprite("body").Name()["_dead"] + "spawnTerrainDropdownEffect"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(1, 100) < 50)).Scale = 0.8999999761581421;
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
    this.onDeath["k[54]"](_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GreaterFleshGolem);
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToRotation = true;
    this.m.BaseProperties.IsImmuneToStun = true;
    this.m.BaseProperties.IsImmuneToKnockBackAndGrab = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.addSprite("socket").setBrush("bust_base_undead");
    this.addSprite("body");
    this.addSprite("injury");
    this.addSprite("armor");
    this.addSprite("head");
    this.addSprite("helmet");
    this.setVariant(this.Math.rand(1, 3));
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.6499999761581421;
    this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
    this.setSpriteOffset("status_stunned", this.createVec(0, 10));
    this.setSpriteOffset("arrow", this.createVec(0, 10));
    this.m.Skills.add(this.new("scripts/skills/racial/flesh_golem_racial"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
    this.m.Skills.add(this.new("scripts/skills/actives/greater_flesh_golem_attack_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/flurry_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/spike_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/corpse_hurl_skill"));
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

function setVariant(this, variant)
{
    this.assignEquipment(variant);
    this.m.Items.getAppearance().Body = ("bust_greater_flesh_golem_body_0" + variant);
    this.getSprite("body").setBrush(("bust_greater_flesh_golem_body_0" + variant));
    this.getSprite("body").varySaturation(0.10000000149011612);
    this.getSprite("body").varyColor(0.09000000357627869, 0.09000000357627869, 0.09000000357627869);
    this.getSprite("injury").Visible = false;
    this.getSprite("injury").setBrush((("bust_greater_flesh_golem_body_0" + variant) + "_injured"));
    this.getSprite("head").setBrush(("bust_greater_flesh_golem_head_0" + variant));
    this.getSprite("head").Saturation = this.getSprite("body").Saturation;
    this.getSprite("head").Color = this.getSprite("body").Color;
    this.setDirty(true);
    return;
}
