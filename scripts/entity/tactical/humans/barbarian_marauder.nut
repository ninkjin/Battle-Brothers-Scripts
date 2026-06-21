// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/barbarian_marauder.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/barbarians/skull_hammer"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/barbarians/two_handed_spiked_mace"));
                    }
                }
            }
        }
    }
    if ((this.Math <= 40) && (this.Math <= 40))
    {
        return ((this.Math <= 40) && (this.Math <= 40));
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(1, 3) == 1)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 2)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
                }
                else
                {
                    if (this.Math.rand(1, 3) == 3)
                    {
                        this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
                }
            }
        }
    }
    if ((this.Math <= 20) && (this.Math <= 20))
    {
        return ((this.Math <= 20) && (this.Math <= 20));
        this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
    }
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/barbarians/scrap_metal_armor"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/barbarians/hide_and_bone_armor"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/barbarians/reinforced_animal_hide_armor"));
            }
        }
    }
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/barbarians/leather_helmet"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/barbarians/crude_metal_helmet"));
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BarbarianMarauder;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BarbarianMarauder.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.WildMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.WildExtended;
    this.m.SoundPitch = 0.949999988079071;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    if (this.Math.rand(1, 100) <= 66)
    {
        this.actor.getSprite("tattoo_body").setBrush(((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_") + this.actor.getSprite("body").getBrush().Name));
        this.actor.getSprite("tattoo_body").Visible = true;
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.actor.getSprite("tattoo_head").setBrush((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_head"));
        this.actor.getSprite("tattoo_head").Visible = true;
    }
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BarbarianMarauder);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.Skills.update();
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_wildmen_01");
    this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Barbarians.ReaverRelentlessDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.ReaverRelentlessDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Barbarians.ReaverRelentlessDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.ReaverRelentlessDay));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    }
    return;
}
