// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_medium.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
    }
    this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
    if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        if (this.Math.rand(1, 100) <= 66)
        {
            this.m.Items.equip(this.new("scripts/items/shields/ancient/coffin_shield"));
        }
        this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_scale_harness"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_breastplate"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_mail"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_double_layer_mail"));
                }
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonMedium;
    this.m.XP = this.Const.Tactical.Actor.SkeletonMedium.XP;
    this.m.ResurrectionValue = 4.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_medium";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonMedium);
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    return;
}
