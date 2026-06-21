// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/officer.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/armor/oriental/padded_mail_and_lamellar_hauberk"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/oriental/southern_long_mail_with_padding"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/oriental/mail_and_lamellar_plating"));
                }
            }
        }
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/oriental/turban_helmet"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/oriental/heavy_lamellar_helmet"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_helmet_with_coif"));
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Officer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Officer.XP;
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

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernShields["this.Math.rand(0, (this.Const.Items.NamedSouthernShields.len() - 1))"])));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernArmors["this.Math.rand(0, (this.Const.Items.NamedSouthernArmors.len() - 1))"])));
            }
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernHelmets["this.Math.rand(0, (this.Const.Items.NamedSouthernHelmets.len() - 1))"])));
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
    return ["weapons/named/named_mace", "weapons/named/named_two_handed_scimitar", "weapons/named/named_spear", "weapons/named/named_shamshir", "weapons/named/named_swordlance", "weapons/named/named_polemace"];
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Officer);
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
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
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
