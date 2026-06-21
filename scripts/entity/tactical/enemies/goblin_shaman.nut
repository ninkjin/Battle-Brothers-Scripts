// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_shaman.nut
// Functions: 4

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_staff"));
    this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_shaman_armor"));
    this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_shaman_helmet"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GoblinShaman;
    this.m.XP = this.Const.Tactical.Actor.GoblinShaman.XP;
    this.goblin.create();
    this.m.SoundPitch = (this.Math.rand(90, 100) * 0.009999999776482582);
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_shaman_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("Wildgrowth", 1, 1);
    }
    this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.goblin.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GoblinShaman);
    this.m.BaseProperties.Vision = 8;
    this.m.BaseProperties.TargetAttractionMult = 2.0;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.getSprite("head").setBrush("bust_goblin_02_head_01");
    this.addDefaultStatusSprites();
    this.m.Skills.add(this.new("scripts/skills/racial/goblin_shaman_racial"));
    this.m.Skills.add(this.new("scripts/skills/actives/root_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/grant_night_vision_skill"));
    return;
}
