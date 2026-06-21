// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/gladiator.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
        {
            [].extend([]);
        }
        if (this.m.Items && this.m.Items)
        {
            return (this.m.Items && this.m.Items);
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        if (this.Const.DLC.Unhold)
        {
            [].push("weapons/throwing_spear");
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.Math.rand(1, 2) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
        }
    }
    this.new("scripts/items/armor/oriental/gladiator_harness").setUpgrade(this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade"));
    this.m.Items.equip(this.new("scripts/items/armor/oriental/gladiator_harness"));
    if (this.Math.rand(2, 3) == 2)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/gladiator_helmet"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Gladiator;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Gladiator.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.Gladiator;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 60;
    this.m.Ethnicity = 1;
    this.m.Body = this.Math.rand(0, (this.m.Bodies.len() - 1));
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
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
        if (this.Math.rand(0, 1) == 0)
        {
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons["this.Math.rand(0, (this.Const.Items.NamedSouthernMeleeWeapons.len() - 1))"])));
        }
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedMeleeWeapons["this.Math.rand(0, (this.Const.Items.NamedMeleeWeapons.len() - 1))"])));
    }
    if (this.Math.rand(1, 4) == 2)
    {
        if (this.Math.rand(0, 1) == 0)
        {
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernShields["this.Math.rand(0, (this.Const.Items.NamedSouthernShields.len() - 1))"])));
        }
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedShields["this.Math.rand(0, (this.Const.Items.NamedShields.len() - 1))"])));
    }
    if (this.Math.rand(1, 4) == 3)
    {
        if (this.Math.rand(0, 1) == 0)
        {
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernArmors["this.Math.rand(0, (this.Const.Items.NamedSouthernArmors.len() - 1))"])));
        }
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedArmors["this.Math.rand(0, (this.Const.Items.NamedArmors.len() - 1))"])));
    }
    if (this.Math.rand(0, 1) == 0)
    {
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernHelmets["this.Math.rand(0, (this.Const.Items.NamedSouthernHelmets.len() - 1))"])));
    }
    this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedHelmets["this.Math.rand(0, (this.Const.Items.NamedHelmets.len() - 1))"])));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
    return this.Math.rand(1, 4);
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Gladiator);
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
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
