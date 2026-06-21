// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_man_at_arms.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
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
    if (this.Math.rand(1, 100) <= 60)
    {
        [].extend([]);
        if (this.Const.DLC.Unhold)
        {
            [].push("weapons/polehammer");
            [].push("weapons/longsword");
        }
    }
    [].extend([]);
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setFaction(9);
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.Const.DLC.Unhold)
    {
        [].push("armor/footman_armor");
        if ((9 == 10) || (9 == 10))
        {
            return ((9 == 10) || (9 == 10));
            [].push("armor/light_scale_armor");
        }
    }
    if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.body.mail_hauberk"))
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setVariant(28);
    }
    if (this.Const.DLC.Unhold)
    {
        if (this.Math.rand(1, 100) <= 75)
        {
            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
        }
        else
        {
            if (this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1)"])).getID() == "armor.body.mail_hauberk"))
            {
                if (9 < 10)
                {
                }
                this.getSprite("surcoat").setBrush(("surcoat_" + 9));
            }
        }
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.Math.rand(1, 100) <= 67)
    {
        if (this.Const.DLC.Unhold)
        {
            [].push("helmets/barbute_helmet");
        }
        if (9 <= 4)
        {
            [].extend([]);
        }
        if (9 <= 7)
        {
            [].extend([]);
        }
        if (9 == 10)
        {
            [].extend([]);
        }
        [].extend([]);
        if (this.Math.rand(1, 100) <= 25)
        {
            if ((25 == r63) && (25 == r63))
            {
                return ((25 == r63) && (25 == r63));
                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.WhiteGreenYellow);
            }
            else
            {
                if (9 == 10)
                {
                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setPlainVariant();
                }
                else
                {
                    if (9 <= 2)
                    {
                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.Red);
                    }
                    else
                    {
                        if ((9 == 3) && (9 == 3))
                        {
                            return ((9 == 3) && (9 == 3));
                            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.Black);
                        }
                        else
                        {
                            if ((9 == 4) && (9 == 4))
                            {
                                return ((9 == 4) && (9 == 4));
                                this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.OrangeRed);
                            }
                            else
                            {
                                if (9 == 5)
                                {
                                    this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.WhiteGreenYellow);
                                }
                                else
                                {
                                    if (9 == 6)
                                    {
                                        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).onPaint(this.Const.Items.Paint.WhiteBlue);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setPlainVariant();
    }
    this.new("scripts/items/helmets/bascinet_faction_helmet").setVariant(9);
    this.m.Items.equip(this.new("scripts/items/helmets/bascinet_faction_helmet"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.ManAtArms;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.ManAtArms.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.ManAtArms);
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
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
