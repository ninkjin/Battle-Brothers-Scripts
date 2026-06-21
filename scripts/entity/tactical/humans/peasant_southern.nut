// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/peasant_southern.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 10) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/knife"));
    }
    else
    {
        if (this.Math.rand(1, 10) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
        }
        else
        {
            if (this.Math.rand(1, 10) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
            }
            else
            {
                if (this.Math.rand(1, 10) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
                }
                else
                {
                    if (this.Math.rand(1, 10) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 10) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 10) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
    }
    else
    {
        if (this.Math.rand(1, 10) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/apron"));
        }
        else
        {
            if (this.Math.rand(1, 10) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
            }
            this.m.Items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 3) <= 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
        }
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/nomad_head_wrap"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.PeasantSouthern;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.getFlags().add("peasant");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Peasant);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(0, 255);
    this.getSprite("socket").setBrush("bust_base_southern");
    return;
}
