// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/slave.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/knife"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
            }
        }
    }
    if (this.Math.rand(1, 100) <= 33)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Slave;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Slave.XP;
    this.human.create();
    if (this.Math.rand(1, 100) <= 90)
    {
        this.m.Bodies = this.Const.Bodies.SouthernSlave;
        this.m.Faces = this.Const.Faces.SouthernMale;
        this.m.Hairs = this.Const.Hair.SouthernMale;
        this.m.HairColors = this.Const.HairColors.Southern;
        this.m.Beards = this.Const.Beards.SouthernUntidy;
        this.m.BeardChance = 90;
        this.m.Ethnicity = 1;
    }
    this.m.Bodies = this.Const.Bodies.NorthernSlave;
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Untidy;
    this.m.Body = this.Math.rand(0, (this.m.Bodies.len() - 1));
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Slave);
    this.m.BaseProperties.TargetAttractionMult = 0.5;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_southern");
    if (this.Math.rand(1, 100) <= 50)
    {
        this.actor.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
        this.actor.getSprite("tattoo_head").Visible = true;
    }
    this.actor.getSprite("tattoo_head").setBrush("scar_02_head");
    this.actor.getSprite("tattoo_head").Visible = true;
    if (this.Math.rand(1, 100) <= 75)
    {
        this.getSprite("dirt").Visible = true;
    }
    if (this.Math.rand(1, 100) <= 75)
    {
        this.actor.getSprite("tattoo_body").setBrush(("scar_02_" + this.actor.getSprite("body").getBrush().Name));
        this.actor.getSprite("tattoo_body").Visible = true;
    }
    if (this.m.Ethnicity == 0)
    {
        this.getSprite("body").Color = this.createColor("#ffeaea");
        this.getSprite("body").varyColor(0.05000000074505806, 0.05000000074505806, 0.05000000074505806);
        this.getSprite("head").Color = this.getSprite("body").Color;
        this.getSprite("head").Saturation = this.getSprite("body").Saturation;
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    return;
}
