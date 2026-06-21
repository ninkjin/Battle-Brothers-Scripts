// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/barbarian_drummer.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/claw_club"));
        }
    }
    this.m.Items.equip(this.new("scripts/items/weapons/barbarians/drum_item"));
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/barbarians/animal_hide_armor"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/barbarians/reinforced_animal_hide_armor"));
            }
        }
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BarbarianDrummer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BarbarianDrummer.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.WildMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.WildExtended;
    this.m.SoundPitch = 0.949999988079071;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_drummer_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.actor.getSprite("tattoo_body").setBrush(((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_") + this.actor.getSprite("body").getBrush().Name));
    this.actor.getSprite("tattoo_body").Visible = true;
    this.actor.getSprite("tattoo_head").setBrush((("tattoo_0" + []["this.Math.rand(0, ([].len() - 1))"]) + "_head"));
    this.actor.getSprite("tattoo_head").Visible = true;
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BarbarianDrummer);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.Skills.update();
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_wildmen_01");
    this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Barbarians.DrummerDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.DrummerDodgeDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Barbarians.DrummerDodgeDay) && (this.World.Days >= this.Const.World.Scaling.Barbarians.DrummerDodgeDay));
        this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    }
    return;
}
