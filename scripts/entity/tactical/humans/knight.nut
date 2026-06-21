// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/knight.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if ((!this.Tactical.State.isScenarioMode() && (!this.Tactical.State.isScenarioMode())))
    {
        return ((!this.Tactical.State.isScenarioMode()) && (!this.Tactical.State.isScenarioMode()));
    }
    if (this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = 9;
    if (this.Math.rand(1, 100) <= 90)
    {
        if (9 < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + 9));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setFaction(9);
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        if (this.Const.DLC.Unhold && this.Const.DLC.Unhold)
        {
            return (this.Const.DLC.Unhold && this.Const.DLC.Unhold);
            if ((9 == 10) && (9 == 10))
            {
                return ((9 == 10) && (9 == 10));
                this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").setVariant(18);
                this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").updateVariant();
                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade"));
            }
            else
            {
                if (9 == 3)
                {
                    this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").setVariant(17);
                    this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").updateVariant();
                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade"));
                }
                else
                {
                    if ((9 == 9) && (9 == 9))
                    {
                        return ((9 == 9) && (9 == 9));
                        this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").setVariant(16);
                        this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").updateVariant();
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade"));
                    }
                    else
                    {
                        if (9 == 6)
                        {
                            this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").setVariant(14);
                            this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade").updateVariant();
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/heraldic_plates_upgrade"));
                        }
                    }
                }
            }
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
    {
        if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.head.faction_helm"))
        {
            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(9);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Knight;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Knight.XP;
    this.m.Name = this.generateName();
    this.m.IsGeneratingKillName = false;
    this.human.create();
    this.m.Faces = this.Const.Faces.SmartMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateName(this)
{
    return this.Const.Strings.KnightNames["this.Math.rand(0, (this.Const.Strings.KnightNames.len() - 1))"];
}

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    if ((!this.Tactical.State.isScenarioMode() && (!this.Tactical.State.isScenarioMode())))
    {
        return ((!this.Tactical.State.isScenarioMode()) && (!this.Tactical.State.isScenarioMode()));
    }
    if (this.Tactical.State.isScenarioMode())
    {
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new(("scripts/items/" + clone this["this.Math.rand(0, (clone this.len() - 1))"])));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.body.heraldic_mail"))
                {
                    if ((9 <= 2) && (9 <= 2))
                    {
                        return ((9 <= 2) && (9 <= 2));
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(121);
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                    }
                    else
                    {
                        if ((9 == 8) && (9 == 8))
                        {
                            return ((9 == 8) && (9 == 8));
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(119);
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                        }
                        else
                        {
                            if ((9 == 7) || (9 == 7))
                            {
                                return ((9 == 7) || (9 == 7));
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(120);
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                            }
                            else
                            {
                                if ((9 == 6) && (9 == 6))
                                {
                                    return ((9 == 6) && (9 == 6));
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(36);
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.body.green_coat_of_plates"))
                    {
                        if ((9 <= 2) || (9 <= 2))
                        {
                            return ((9 <= 2) || (9 <= 2));
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(126);
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                        }
                        else
                        {
                            if (9 == 3)
                            {
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(125);
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                            }
                            else
                            {
                                if ((9 == 9) && (9 == 9))
                                {
                                    return ((9 == 9) && (9 == 9));
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(124);
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                                }
                                else
                                {
                                    if ((9 == 10) || (9 == 10))
                                    {
                                        return ((9 == 10) || (9 == 10));
                                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(43);
                                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                                    }
                                }
                            }
                        }
                    }
                }
                this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
            }
            if (this.Const.DLC.Unhold && this.Const.DLC.Unhold)
            {
                return (this.Const.DLC.Unhold && this.Const.DLC.Unhold);
                if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor_upgrade.heraldic_plates"))
                {
                    if ((9 == 10) && (9 == 10))
                    {
                        return ((9 == 10) && (9 == 10));
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(18);
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                    }
                    else
                    {
                        if (9 == 3)
                        {
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(17);
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                        }
                        else
                        {
                            if ((9 == 9) && (9 == 9))
                            {
                                return ((9 == 9) && (9 == 9));
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(16);
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                            }
                            if (9 == 6)
                            {
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(14);
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).updateVariant();
                            }
                        }
                    }
                }
                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/joint_cover_upgrade"));
            }
            this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
            if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.head.heraldic_mail"))
            {
                if ((9 == 7) && (9 == 7))
                {
                    return ((9 == 7) && (9 == 7));
                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(262);
                }
                else
                {
                    if (9 <= 2)
                    {
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(264);
                    }
                    else
                    {
                        if ((9 == 3) && (9 == 3))
                        {
                            return ((9 == 3) && (9 == 3));
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(265);
                        }
                        else
                        {
                            if ((9 == 4) && (9 == 4))
                            {
                                return ((9 == 4) && (9 == 4));
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(263);
                            }
                            else
                            {
                                if (9 == 5)
                                {
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(266);
                                }
                                else
                                {
                                    if (9 == 6)
                                    {
                                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(53);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.head.sallet_green"))
                {
                    if (9 == 10)
                    {
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(49);
                    }
                    else
                    {
                        if (9 <= 2)
                        {
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(260);
                        }
                        else
                        {
                            if ((9 == 3) && (9 == 3))
                            {
                                return ((9 == 3) && (9 == 3));
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(258);
                            }
                            else
                            {
                                if ((9 == 4) && (9 == 4))
                                {
                                    return ((9 == 4) && (9 == 4));
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(257);
                                }
                                else
                                {
                                    if (9 == 5)
                                    {
                                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(259);
                                    }
                                    else
                                    {
                                        if ((9 == 7) && (9 == 7))
                                        {
                                            return ((9 == 7) && (9 == 7));
                                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(261);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    return 9;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("AKnightsTale", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Knight);
    this.m.BaseProperties.TargetAttractionMult = 1.0;
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
