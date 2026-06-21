// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/barbarian_thrall.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/barbarians/claw_club"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
            }
        }
    }
    if ((this.Math <= 40) && (this.Math <= 40))
    {
        return ((this.Math <= 40) && (this.Math <= 40));
        if (this.Math.rand(1, 3) == 1)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 20)
    {
        this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
    }
    if (this.Math.rand(1, 100) <= 60)
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/barbarians/animal_hide_armor"));
            }
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BarbarianThrall;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BarbarianThrall.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.WildMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.Young;
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
        this.actor.getSprite("tattoo_body").setBrush(((("warpaint_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_") + this.actor.getSprite("body").getBrush().Name));
        this.actor.getSprite("tattoo_body").Visible = true;
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.actor.getSprite("tattoo_head").setBrush((("warpaint_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_head"));
        this.actor.getSprite("tattoo_head").Visible = true;
    }
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BarbarianThrall);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_wildmen_01");
    this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Barbarians.ThrallRelentlessDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.ThrallRelentlessDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Barbarians.ThrallRelentlessDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.ThrallRelentlessDay));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    }
    return;
}
