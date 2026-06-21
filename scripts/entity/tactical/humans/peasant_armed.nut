// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/peasant_armed.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/knife"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
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
            this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
        }
        else
        {
            if (this.Math.rand(1, 10) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/apron"));
            }
            else
            {
                if (this.Math.rand(1, 10) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
                }
                this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
            }
        }
    }
    if (this.Math.rand(1, 100) <= 33)
    {
        if (this.Math.rand(1, 4) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/straw_hat"));
                }
                else
                {
                    if (this.Math.rand(1, 4) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Peasant;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
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
    this.getSprite("socket").setBrush("bust_base_militia");
    return;
}
