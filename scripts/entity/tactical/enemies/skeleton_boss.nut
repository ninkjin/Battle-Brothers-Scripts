// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/skeleton_boss.nut
// Functions: 3

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
    if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
    }
    this.m.Items.equip(this.new("scripts/items/armor/legendary/emperors_armor_fake"));
    this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_laurels"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.SkeletonBoss;
    this.m.XP = this.Const.Tactical.Actor.SkeletonBoss.XP;
    this.m.ResurrectionValue = 15.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/skeleton_boss";
    this.m.IsGeneratingKillName = false;
    this.skeleton.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.skeleton.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.SkeletonBoss);
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    return;
}
