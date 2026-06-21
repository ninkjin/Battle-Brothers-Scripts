// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/wolf.nut
// Functions: 5

function create(this)
{
    this.m.Type = this.Const.EntityType.Wolf;
    this.m.XP = this.Const.Tactical.Actor.Wolf.XP;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.ExcludedInjuries = ["injury.fractured_hand", "injury.crushed_finger", "injury.fractured_elbow", "injury.smashed_hand", "injury.broken_arm", "injury.cut_arm_sinew", "injury.cut_arm", "injury.split_hand", "injury.pierced_hand", "injury.pierced_arm_muscles", "injury.burnt_hands"];
    this.actor.create();
    this.m.IsActingImmediately = true;
    this.m.BloodSplatterOffset = this.createVec(0, 0);
    this.m.DecapitateSplatterOffset = this.createVec(-4, -25);
    this.m.DecapitateBloodAmount = 0.5;
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/wolf_death_00.wav", "sounds/enemies/wolf_death_01.wav", "sounds/enemies/wolf_death_02.wav", "sounds/enemies/wolf_death_03.wav", "sounds/enemies/wolf_death_04.wav", "sounds/enemies/wolf_death_05.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Flee"] = ["sounds/enemies/wolf_flee_00.wav", "sounds/enemies/wolf_flee_01.wav", "sounds/enemies/wolf_flee_02.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/wolf_hurt_00.wav", "sounds/enemies/wolf_hurt_01.wav", "sounds/enemies/wolf_hurt_02.wav", "sounds/enemies/wolf_hurt_03.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/wolf_idle_00.wav", "sounds/enemies/wolf_idle_01.wav", "sounds/enemies/wolf_idle_02.wav", "sounds/enemies/wolf_idle_03.wav", "sounds/enemies/wolf_idle_04.wav", "sounds/enemies/wolf_idle_06.wav", "sounds/enemies/wolf_idle_07.wav", "sounds/enemies/wolf_idle_08.wav", "sounds/enemies/wolf_idle_09.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Move"] = this.m.Sound["this.Const.Sound.ActorEvent.Idle"];
    this.m.SoundVolume["this.Const.Sound.ActorEvent.Death"] = 0.699999988079071;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/wardog_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateCorpse(this, _tile, _fatalityType, _killer)
{
    clone this.CorpseName = this.getName();
    clone this.Items = this.getItems().prepareItemsForCorpse(_killer);
    clone this.IsHeadAttached = (_fatalityType != this.Const.FatalityType.Decapitated);
    clone this.IsResurrectable = false;
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
        this.m.IsCorpseFlipped = (this.Math.rand(0, 100) < 50);
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).setBrightness(0.8999999761581421);
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).Scale = 0.949999988079071;
        if (this.getItems().getAppearance().CorpseArmor != "FatalityType")
        {
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).setBrightness(0.8999999761581421);
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).Scale = 0.949999988079071;
        }
        if (_fatalityType != this.Const.Decapitated.head)
        {
            _tile.spawnDetail((this.getSprite("spawnHeadEffect").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).setBrightness(0.8999999761581421);
            _tile.spawnDetail((this.getSprite("spawnHeadEffect").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).Scale = 0.949999988079071;
        }
        else
        {
            if (_fatalityType == this.Const.Decapitated.head)
            {
                this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType")["0"].setBrightness(0.8999999761581421);
                this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType")["0"].Scale = 0.949999988079071;
            }
            else
            {
                if ((this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType") == this.Const.Arrow._dead_arrows) && (this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType") == this.Const.Arrow._dead_arrows))
                {
                    return ((this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType") == this.Const.Arrow._dead_arrows) && (this.Tactical.getTile(this.createVec(), [], this.bust_wolf_head_bloodpool(-20, 15), 0.0, "getProjectileType") == this.Const.Arrow._dead_arrows));
                    _tile.spawnDetail((this.getSprite("body").getBrush().Name + "Javelin"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).Scale = 0.949999988079071;
                }
                else
                {
                    if ((0.949999988079071 == this.Const.Arrow._dead_javelin) && (0.949999988079071 == this.Const.Arrow._dead_javelin))
                    {
                        return ((0.949999988079071 == this.Const.Arrow._dead_javelin) && (0.949999988079071 == this.Const.Arrow._dead_javelin));
                        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "spawnTerrainDropdownEffect"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50)).Scale = 0.949999988079071;
                    }
                }
            }
        }
        this.generateCorpse(_tile);
    }
    if (_tile == null)
    {
        this.Tactical.addUnplacedCorpse.Properties(this.Entities(_tile, _fatalityType, _killer));
    }
    _tile.set.addCorpse("Corpse", this.Entities(_tile, _fatalityType, _killer));
    this.Tactical.addUnplacedCorpse.actor(_tile);
    this.onDeath["k[41]"](_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Wolf);
    this.m.BaseProperties.TargetAttractionMult = 0.5;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Items.getAppearance().Body = ("bust_wolf_0" + this.Math.rand(1, 2));
    this.addSprite("socket").setBrush("bust_base_goblins");
    this.addSprite("body").setBrush((("bust_wolf_0" + this.Math.rand(1, 2)) + "_body"));
    this.addSprite("body").varySaturation(0.15000000596046448);
    this.addSprite("body").varyColor(0.07000000029802322, 0.07000000029802322, 0.07000000029802322);
    this.addSprite("head").setBrush((("bust_wolf_0" + this.Math.rand(1, 2)) + "_head"));
    this.addSprite("head").Color = this.addSprite("body").Color;
    this.addSprite("head").Saturation = this.addSprite("body").Saturation;
    this.addSprite("injury").Visible = false;
    this.addSprite("injury").setBrush("bust_wolf_01_injured");
    this.addSprite("armor").setBrush("bust_wolf_02_armor_01");
    this.addSprite("armor").Visible = false;
    this.setAlwaysApplySpriteOffset(false);
    this.setSpriteOffset("body", this.createVec(0, -20));
    this.setSpriteOffset("head", this.createVec(0, -20));
    this.setSpriteOffset("injury", this.createVec(0, -20));
    this.setSpriteOffset("armor", this.createVec(0, -20));
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.5799999833106995;
    this.setSpriteOffset("status_rooted", this.createVec(-6, -39));
    this.setSpriteOffset("status_stunned", this.createVec(-10, -40));
    this.setSpriteOffset("arrow", this.createVec(-10, -40));
    this.m.Skills.add(this.new("scripts/skills/actives/wolf_bite"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    return;
}

function setVariant(this, _v, _c, _s, _hp)
{
    this.m.Items.getAppearance().Body = ("bust_wolf_0" + _v);
    this.m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";
    this.getSprite("body").setBrush((("bust_wolf_0" + _v) + "_body"));
    this.getSprite("body").Color = _c;
    this.getSprite("body").Saturation = _s;
    this.getSprite("head").setBrush((("bust_wolf_0" + _v) + "_head"));
    this.getSprite("head").Color = _c;
    this.getSprite("head").Saturation = _s;
    this.getSprite("armor").Visible = true;
    if (_hp != 1.0)
    {
        this.m.Hitpoints = (this.getHitpointsMax() * _hp);
        this.onUpdateInjuryLayer();
    }
    this.setDirty(true);
    return;
}
