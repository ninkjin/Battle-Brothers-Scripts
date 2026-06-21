// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/skeleton.nut
// Functions: 7

function create(this)
{
    this.m.BloodType = this.Const.BloodType.Bones;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.actor.create();
    this.m.Sound["this.Const.Sound.ActorEvent.DamageReceived"] = ["sounds/enemies/skeleton_hurt_01.wav", "sounds/enemies/skeleton_hurt_02.wav", "sounds/enemies/skeleton_hurt_03.wav", "sounds/enemies/skeleton_hurt_04.wav", "sounds/enemies/skeleton_hurt_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Death"] = ["sounds/enemies/skeleton_death_01.wav", "sounds/enemies/skeleton_death_02.wav", "sounds/enemies/skeleton_death_03.wav", "sounds/enemies/skeleton_death_04.wav", "sounds/enemies/skeleton_death_05.wav", "sounds/enemies/skeleton_death_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Resurrect"] = ["sounds/enemies/skeleton_rise_01.wav", "sounds/enemies/skeleton_rise_02.wav", "sounds/enemies/skeleton_rise_03.wav", "sounds/enemies/skeleton_rise_04.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Idle"] = ["sounds/enemies/skeleton_idle_01.wav", "sounds/enemies/skeleton_idle_02.wav", "sounds/enemies/skeleton_idle_03.wav", "sounds/enemies/skeleton_idle_04.wav", "sounds/enemies/skeleton_idle_05.wav", "sounds/enemies/skeleton_idle_06.wav"];
    this.m.Sound["this.Const.Sound.ActorEvent.Move"] = ["sounds/enemies/skeleton_idle_01.wav", "sounds/enemies/skeleton_idle_02.wav", "sounds/enemies/skeleton_idle_03.wav", "sounds/enemies/skeleton_idle_04.wav", "sounds/enemies/skeleton_idle_05.wav", "sounds/enemies/skeleton_idle_06.wav"];
    this.getFlags().add("undead");
    this.getFlags().add("skeleton");
    return;
}

function generateCorpse(this, _tile, _fatalityType, _killer)
{
    if (this.m.IsResurrectable)
    {
        if (6[r11.Name.Name])
        {
        }
    }
    8["9"] <- null;
    8.HairColor <- 6.Color;
    8.HairSaturation <- 6.Saturation;
    if (7.HasBrush)
    {
    }
    8.Beard <- null;
    8.BodyColor <- this.m.IsResurrectable.Color;
    8.BodySaturation <- this.m.IsResurrectable.Saturation;
    clone this.Type = this.m.ResurrectWithScript;
    clone this.Faction = this.getFaction();
    if (this.m.IsGeneratingKillName)
    {
    }
    clone this.CorpseName = ("Tile" + this.getName());
    clone this.Value = _tile;
    clone this.ResurrectionValue = this.m.Armor;
    clone this.BaseProperties = this.m.Items.BaseProperties;
    clone this.getItems = this.prepareItemsForCorpse().Custom(_killer);
    clone this.Color = this.m.IsResurrectable.Color;
    clone this.Saturation = this.m.IsResurrectable.Saturation;
    clone this.IsHeadAttached = 8;
    clone this.IsConsumable = (_fatalityType != this.Const.FatalityType.Decapitated);
    clone this["k[44]"] = false;
    if (this.m.IsResurrectable)
    {
        clone this.IsResurrectable = true;
    }
    if (_tile != null)
    {
        clone this.Value = _tile;
    }
    return _tile;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    this.m.IsCorpseFlipped = (this.Math.rand(0, 100) < 50);
    if (_tile != null)
    {
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("body").Color;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("body").Saturation;
        _tile.spawnDetail((this.getSprite("body").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
        if (this.getItems().getAppearance().CorpseArmor != "doesBrushExist")
        {
            if (this["_skeleton"]((this.getItems().getAppearance().CorpseArmor + "FatalityType")))
            {
            }
            _tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
        }
        if (_fatalityType != this.Const.Decapitated.HideCorpseHead)
        {
            if (!this.getItems().getAppearance().HideBeard)
            {
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("head").Color;
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("head").Saturation;
                _tile.spawnDetail((this.getSprite("head").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
            }
            if (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair)
            {
                return (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair);
                _tile.spawnDetail((this.getSprite("beard").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("beard").Color;
                _tile.spawnDetail((this.getSprite("beard").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("beard").Saturation;
                _tile.spawnDetail((this.getSprite("beard").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
                if (this.getSprite("beard_top").HideHair)
                {
                    _tile.spawnDetail((this.getSprite("beard_top").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("beard").Color;
                    _tile.spawnDetail((this.getSprite("beard_top").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("beard").Saturation;
                    _tile.spawnDetail((this.getSprite("beard_top").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
                }
            }
            if (!this.getItems().getAppearance().HideBeard)
            {
                _tile.spawnDetail((this.getSprite("face").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("face").Color;
                _tile.spawnDetail((this.getSprite("face").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("face").Saturation;
                _tile.spawnDetail((this.getSprite("face").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
            }
            if (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair)
            {
                return (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair);
                _tile.spawnDetail((this.getSprite("hair").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Color = this.getSprite("hair").Color;
                _tile.spawnDetail((this.getSprite("hair").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = this.getSprite("hair").Saturation;
                _tile.spawnDetail((this.getSprite("hair").getBrush().Name + "_dead"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
            }
            if (this.getItems().getAppearance().push != "doesBrushExist")
            {
                _tile.spawnDetail(this.getItems().getAppearance().push, this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Scale = 0.8999999761581421;
            }
        }
        else
        {
            if (_fatalityType == this.Const.Decapitated.HideCorpseHead)
            {
                if (!this.getItems().getAppearance().HideBeard)
                {
                    [].len((this.getSprite("head").getBrush().Name + "_dead"));
                }
                if (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair)
                {
                    return (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair);
                    [].len((this.getSprite("beard").getBrush().Name + "_dead"));
                }
                if (!this.getItems().getAppearance().HideBeard)
                {
                    [].len((this.getSprite("face").getBrush().Name + "_dead"));
                }
                if (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair)
                {
                    return (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair);
                    [].len((this.getSprite("hair").getBrush().Name + "_dead"));
                }
                if (this.getItems().getAppearance().push.spawnHeadEffect() != 0)
                {
                    [].len(this.getItems().getAppearance().push);
                }
                if (this.getSprite("beard_top").HideHair && this.getSprite("beard_top").HideHair)
                {
                    return (this.getSprite("beard_top").HideHair && this.getSprite("beard_top").HideHair);
                    [].len((this.getSprite("beard_top").getBrush().Name + "_dead"));
                }
                if (!this.getItems().getAppearance().HideBeard)
                {
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["0"].Color = this.getSprite("head").Color;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["0"].Saturation = this.getSprite("head").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["0"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["0"].getProjectileType(true);
                }
                if (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair)
                {
                    return (this.getSprite("beard").HideHair && this.getSprite("beard").HideHair);
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(0 + 16)"].Color = this.getSprite("beard").Color;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(0 + 16)"].Saturation = this.getSprite("beard").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(0 + 16)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(0 + 16)"].getProjectileType(true);
                }
                if (!this.getItems().getAppearance().HideBeard)
                {
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["((0 + 16) + 16)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["((0 + 16) + 16)"].getProjectileType(true);
                }
                if (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair)
                {
                    return (this.getSprite("hair").HideHair && this.getSprite("hair").HideHair);
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((0 + 16) + 16) + 16)"].Color = this.getSprite("hair").Color;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((0 + 16) + 16) + 16)"].Saturation = this.getSprite("hair").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((0 + 16) + 16) + 16)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((0 + 16) + 16) + 16)"].getProjectileType(true);
                }
                if (this.getItems().getAppearance().push.spawnHeadEffect() != 0)
                {
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["((((0 + 16) + 16) + 16) + 16)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["((((0 + 16) + 16) + 16) + 16)"].getProjectileType(true);
                }
                if (this.getSprite("beard_top").HideHair && this.getSprite("beard_top").HideHair)
                {
                    return (this.getSprite("beard_top").HideHair && this.getSprite("beard_top").HideHair);
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((((0 + 16) + 16) + 16) + 16) + 16)"].Color = this.getSprite("beard").Color;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((((0 + 16) + 16) + 16) + 16) + 16)"].Saturation = this.getSprite("beard").Saturation;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((((0 + 16) + 16) + 16) + 16) + 16)"].Scale = 0.8999999761581421;
                    this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist")["(((((0 + 16) + 16) + 16) + 16) + 16)"].getProjectileType(true);
                }
            }
        }
        if ((this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist") == this.Const.Arrow._skeleton_arrows) && (this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist") == this.Const.Arrow._skeleton_arrows))
        {
            return ((this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist") == this.Const.Arrow._skeleton_arrows) && (this.Tactical.getTile(this.createVec(), [], this.setHorizontalFlipping(-20, 15), -90.0, "doesBrushExist") == this.Const.Arrow._skeleton_arrows));
            if (this.Const.Arrow._skeleton_arrows && this.Const.Arrow._skeleton_arrows)
            {
                return (this.Const.Arrow._skeleton_arrows && this.Const.Arrow._skeleton_arrows);
            }
            if (this.getItems().getAppearance().CorpseArmor != "doesBrushExist")
            {
            }
            if (this["_skeleton"]((this.getItems().getAppearance().Corpse + "Javelin")))
            {
                _tile.spawnDetail((this.getItems().getAppearance().Corpse + "Javelin"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = 0.8500000238418579;
            }
        }
        else
        {
            if (("Saturation" == this.Const.Arrow._skeleton_javelin) && ("Saturation" == this.Const.Arrow._skeleton_javelin))
            {
                return (("Saturation" == this.Const.Arrow._skeleton_javelin) && ("Saturation" == this.Const.Arrow._skeleton_javelin));
                if (this.Const.Arrow._skeleton_javelin && this.Const.Arrow._skeleton_javelin)
                {
                    return (this.Const.Arrow._skeleton_javelin && this.Const.Arrow._skeleton_javelin);
                }
                if (this.getItems().getAppearance().CorpseArmor != "doesBrushExist")
                {
                }
                if (this["_skeleton"]((this.getItems().getAppearance().Corpse + "spawnTerrainDropdownEffect")))
                {
                    _tile.spawnDetail((this.getItems().getAppearance().Corpse + "spawnTerrainDropdownEffect"), this.Const.Tactical.DetailFlag.Corpse, (this.Math.rand(0, 100) < 50), false, this.Const.Combat.HumanCorpseOffset).Saturation = 0.8500000238418579;
                }
            }
        }
        this.getDroppableLoot(_tile);
    }
    this.generateCorpse(_tile, this.dropLoot(_killer, this.getItems().getLootForTile(_killer)), (!(this.Math.rand(0, 100) < 50)));
    if (_tile == null)
    {
        this.Tactical.addUnplacedCorpse.Properties(this.Entities(_tile, _fatalityType, _killer));
    }
    _tile.set.addCorpse("Corpse", this.Entities(_tile, _fatalityType, _killer));
    this.Tactical.addUnplacedCorpse.actor(_tile);
    this.onDeath["k[62]"](_killer, _skill, _tile, _fatalityType);
    return;
}

function onFactionChanged(this)
{
    this.actor.onFactionChanged();
    this.getSprite("body").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("armor").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("head").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("face").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("injury").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("beard").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("hair").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("helmet").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("helmet_damage").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("beard_top").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("body_blood").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    this.getSprite("dirt").setHorizontalFlipping((!this.isAlliedWithPlayer()));
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.addSprite("socket").setBrush("bust_base_undead");
    if (this.Math.rand(1, 2) == 1)
    {
        this.addSprite("body").setBrush(("bust_skeleton_body_0" + this.Math.rand(1, 2)));
    }
    this.addSprite("body").setBrush("bust_skeleton_body_01");
    this.addSprite("body").setHorizontalFlipping(true);
    this.addSprite("body").Saturation = 0.800000011920929;
    if (this.Math.rand(0, 100) < 75)
    {
        this.addSprite("body").varySaturation(0.20000000298023224);
    }
    if (this.Math.rand(0, 100) < 90)
    {
        this.addSprite("body").varyColor(0.02500000037252903, 0.02500000037252903, 0.02500000037252903);
    }
    this.m.BloodColor = this.addSprite("body").Color;
    this.m.BloodSaturation = this.addSprite("body").Saturation;
    this.addSprite("body_injury").setBrush("bust_skeleton_body_injured");
    this.addSprite("armor");
    this.addSprite("head").setBrush("bust_skeleton_head");
    this.addSprite("head").Color = this.addSprite("body").Color;
    this.addSprite("head").Saturation = this.addSprite("body").Saturation;
    this.addSprite("injury").setBrush("bust_skeleton_head_injured");
    this.addSprite("beard").varyColor(0.019999999552965164, 0.019999999552965164, 0.019999999552965164);
    if (this.Math.rand(1, 100) <= 25)
    {
        this.addSprite("beard").setBrush(((("beard_" + this.Const.HairColors.Zombie["this.Math.rand(0, (this.Const.HairColors.Zombie.len() - 1))"]) + "_") + this.Const.Beards.ZombieOnly["this.Math.rand(0, (this.Const.Beards.ZombieOnly.len() - 1))"]));
    }
    this.addSprite("face").setBrush(("bust_skeleton_face_0" + this.Math.rand(1, 6)));
    this.addSprite("hair").setHorizontalFlipping(true);
    this.addSprite("hair").Color = this.addSprite("beard").Color;
    if (this.Math.rand(1, 100) <= 50)
    {
        this.addSprite("hair").setBrush(((("hair_" + this.Const.HairColors.Zombie["this.Math.rand(0, (this.Const.HairColors.Zombie.len() - 1))"]) + "_") + this.Const.Hair.ZombieOnly["this.Math.rand(0, (this.Const.Hair.ZombieOnly.len() - 1))"]));
    }
    this.setSpriteOffset("hair", this.createVec(0, -3));
    this.addSprite("helmet");
    this.addSprite("helmet_damage");
    if ("beard_top" && "beard_top")
    {
        return ("beard_top" && "beard_top");
        this.addSprite("beard_top").setBrush((this.addSprite("beard").getBrush().Name + "_top"));
        this.addSprite("beard_top").Color = this.addSprite("beard").Color;
    }
    this.addSprite("body_blood").setBrush("bust_body_bloodied_02");
    this.addSprite("body_blood").setHorizontalFlipping(true);
    this.addSprite("body_blood").Visible = false;
    this.addSprite("dirt").setBrush("bust_body_dirt_02");
    this.addSprite("dirt").setHorizontalFlipping(true);
    this.addSprite("dirt").Visible = (this.Math.rand(1, 100) <= 33);
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.550000011920929;
    this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
    this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
    this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    return;
}

function onResurrected(this, _info)
{
    if (_info.Custom != null)
    {
        this.getSprite("face").setBrush(_info.Custom.Face);
        this.getSprite("body").setBrush(_info.Custom.Body);
        this.getSprite("body").Color = _info.Custom.BodyColor;
        this.getSprite("body").Saturation = _info.Custom.BodySaturation;
        if (_info.Custom.Hair != null)
        {
            this.getSprite("hair").setBrush(_info.Custom.Hair);
            this.getSprite("hair").Color = _info.Custom.HairColor;
            this.getSprite("hair").Saturation = _info.Custom.HairSaturation;
        }
        this.getSprite("hair").resetBrush();
        if (_info.Custom.Beard != null)
        {
            this.getSprite("beard").setBrush(_info.Custom.Beard);
            this.getSprite("beard").Color = _info.Custom.HairColor;
            this.getSprite("beard").Saturation = _info.Custom.HairSaturation;
            this.getSprite("beard").setBrightness(0.8999999761581421);
            if (this.doesBrushExist((_info.Custom.Beard + "_top")))
            {
                this.getSprite("beard_top").setBrush((_info.Custom.Beard + "_top"));
                this.getSprite("beard_top").Color = _info.Custom.HairColor;
                this.getSprite("beard_top").Saturation = _info.Custom.HairSaturation;
                this.getSprite("beard_top").setBrightness(0.8999999761581421);
            }
        }
        this.getSprite("beard").resetBrush();
        this.getSprite("beard_top").resetBrush();
    }
    this.actor.onResurrected(_info);
    this.m.IsResurrected = true;
    this.pickupMeleeWeaponAndShield(this.getTile());
    this.getSkills().update();
    this.m.XP = this.m.XP op47 4;
    if (0 != 6)
    {
        if (!this.getTile().hasNextTile(0))
        {
        }
        else
        {
            if (!this.getTile().getNextTile(0).IsOccupiedByActor)
            {
            }
            else
            {
                if ((!this.getTile().getNextTile(0).getEntity().getAlliedFactions() && (!this.getTile().getNextTile(0).getEntity().getAlliedFactions())))
                {
                    return ((!this.getTile().getNextTile(0).getEntity().getAlliedFactions()) && (!this.getTile().getNextTile(0).getEntity().getAlliedFactions()));
                    this.getTile().getNextTile(0).getEntity().checkMorale(-1, this.Math.maxf(10.0, (50.0 - (this.getXPValue() * 0.10000000149011612))));
                    this.getTile().getNextTile(0).getEntity().m.MaxEnemiesThisTurn = this.getTile().getNextTile(0).getZoneOfControlCountOtherThan(this.getTile().getNextTile(0).getEntity().getAlliedFactions());
                }
            }
        }
    }
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
