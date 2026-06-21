// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/executioner.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
        if (this.Const.DLC.Wildmen)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Executioner;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Executioner.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.Gladiator;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
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
    if (this.Const.DLC.Unhold)
    {
        [].extend([]);
    }
    if (this.Const.DLC.Wildmen)
    {
        [].extend([]);
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernArmors["this.Math.rand(0, (this.Const.Items.NamedSouthernArmors.len() - 1))"])));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    return [];
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Executioner);
    this.m.BaseProperties.TargetAttractionMult = 1.0;
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
    this.getSprite("socket").setBrush("bust_base_nomads");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
