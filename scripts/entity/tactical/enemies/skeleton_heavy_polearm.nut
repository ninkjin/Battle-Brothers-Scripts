// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_heavy_polearm.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/ancient/warscythe"));
        }
    }
    if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_plated_scale_hauberk"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_scale_coat"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_plate_harness"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_plated_mail_hauberk"));
                }
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_honorguard_helmet"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonHeavy;
    this.m.XP = this.Const.Tactical.Actor.SkeletonHeavy.XP;
    this.m.ResurrectionValue = 5.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_heavy_polearm";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("WalkingStatue", 1, 1);
    }
    this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
    this.m.BaseProperties.Initiative = this.m.BaseProperties.Initiative op45 20;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    if ((this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay) && (this.World.Days >= this.Const.World.Scaling.AncientDead.HonorGuardPolearmSpecDay));
        this.m.BaseProperties.IsSpecializedInPolearms = true;
    }
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    return;
}
