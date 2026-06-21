// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_leader.nut
// Functions: 4

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
    this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
    this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_leader_armor"));
    this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_leader_helmet"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GoblinLeader;
    this.m.XP = this.Const.Tactical.Actor.GoblinLeader.XP;
    this.goblin.create();
    this.m.SoundPitch = (this.Math.rand(85, 95) * 0.009999999776482582);
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_leader_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_skill.isRanged() && _skill.isRanged() && _skill.isRanged() && _skill.isRanged())
    {
        return (_skill.isRanged() && _skill.isRanged() && _skill.isRanged() && _skill.isRanged());
        this.updateAchievement("Outgunned", 1, 1);
    }
    this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.goblin.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GoblinLeader);
    this.m.BaseProperties.TargetAttractionMult = 1.5;
    this.m.BaseProperties.DamageDirectMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.getSprite("head").setBrush("bust_goblin_03_head_01");
    this.addDefaultStatusSprites();
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInCrossbows = true;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/actives/goblin_whip"));
    return;
}
