// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/barbarian_beastmaster.nut
// Functions: 3

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/barbarians/thorned_whip"));
    this.m.Items.equip(this.new("scripts/items/armor/barbarians/hide_and_bone_armor"));
    this.m.Items.equip(this.new("scripts/items/helmets/barbarians/beastmasters_headpiece"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BarbarianBeastmaster;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BarbarianBeastmaster.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.WildMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.WildExtended;
    this.m.SoundPitch = 0.949999988079071;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_beastmaster_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    if (this.Math.rand(1, 100) <= 66)
    {
        this.actor.getSprite("tattoo_body").setBrush(((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_") + this.actor.getSprite("body").getBrush().Name));
        this.actor.getSprite("tattoo_body").Visible = true;
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.actor.getSprite("tattoo_head").setBrush((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_head"));
        this.actor.getSprite("tattoo_head").Visible = true;
    }
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BarbarianBeastmaster);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.Skills.update();
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_wildmen_01");
    this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/actives/crack_the_whip_skill"));
    if ((this.World.Days >= this.Const.World.Scaling.Barbarians.BeastmasterDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.BeastmasterDodgeDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Barbarians.BeastmasterDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.BeastmasterDodgeDay));
        this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    }
    return;
}
