// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/caravan_hand.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 8) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
    }
    else
    {
        if (this.Math.rand(1, 8) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/knife"));
        }
        else
        {
            if (this.Math.rand(1, 8) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
            }
            else
            {
                if (this.Math.rand(1, 8) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
                }
                else
                {
                    if (this.Math.rand(1, 8) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 8) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 8) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                            }
                            else
                            {
                                if (this.Math.rand(1, 8) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 33)
    {
        this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.new("scripts/items/armor/linen_tunic").setVariant(this.Math.rand(6, 7));
                    this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 33)
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.CaravanHand;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.CaravanHand.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/caravan_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.CaravanHand);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_caravan");
    this.getSprite("dirt").Visible = true;
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
