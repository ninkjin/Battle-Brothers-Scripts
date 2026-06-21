// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_light.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/ancient/falx"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
            }
        }
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.m.Items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_ripped_cloth"));
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_household_helmet"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonLight;
    this.m.XP = this.Const.Tactical.Actor.SkeletonLight.XP;
    this.m.ResurrectionValue = 3.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_light";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonLight);
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
