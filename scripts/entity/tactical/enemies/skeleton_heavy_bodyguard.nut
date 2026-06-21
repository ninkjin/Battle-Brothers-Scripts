// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_heavy_bodyguard.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/ancient/warscythe"));
                    }
                }
            }
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
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard";
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_bodyguard_agent");
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
    this.m.BaseProperties.Initiative = this.m.BaseProperties.Initiative op45 50;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    return;
}
