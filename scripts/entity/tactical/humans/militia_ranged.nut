// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/militia_ranged.nut
// Functions: 3

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
                }
            }
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 4) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
                }
                else
                {
                    if (this.Math.rand(1, 4) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.MilitiaRanged;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.MilitiaRanged.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.Flags.add("militia");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.MilitiaRanged);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.getSprite("accessory_special").setBrush("bust_militia_band_01");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
