// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/conscript.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    if (this.Math.rand(1, 5) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/oriental/saif"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/scimitar"));
            }
            this.m.Items.equip(this.new("scripts/items/weapons/oriental/firelance"));
        }
    }
    if (this.Math.rand(1, 100) <= 90)
    {
        this.m.Items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
    }
    if (this.Math.rand(1, 3) <= 2)
    {
        if (13 == 12)
        {
            this.new("scripts/items/armor/oriental/linothorax").setVariant(9);
        }
        else
        {
            if (13 == 13)
            {
                this.new("scripts/items/armor/oriental/linothorax").setVariant(10);
            }
            else
            {
                if (13 == 14)
                {
                    this.new("scripts/items/armor/oriental/linothorax").setVariant(8);
                }
            }
        }
        this.m.Items.equip(this.new("scripts/items/armor/oriental/linothorax"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/armor/oriental/southern_mail_shirt"));
        }
    }
    if (this.Math.rand(1, 3) == 1)
    {
        if (13 == 12)
        {
            this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(12);
        }
        else
        {
            if (13 == 13)
            {
                this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(8);
            }
            else
            {
                if (13 == 14)
                {
                    this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(7);
                }
            }
        }
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/oriental/wrapped_southern_helmet"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/oriental/spiked_skull_cap_with_mail"));
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Conscript;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Conscript.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Conscript);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_southern");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}

function onOtherActorDeath(this, _killer, _victim, _skill)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorDeath(_killer, _victim, _skill);
    return;
}

function onOtherActorFleeing(this, _actor)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorFleeing(_actor);
    return;
}
