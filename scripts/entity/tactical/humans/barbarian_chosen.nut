// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/barbarian_chosen.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new("scripts/items/armor_upgrades/barbarian_horn_upgrade"));
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
    this.m.Type = this.Const.EntityType.BarbarianChosen;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BarbarianChosen.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.WildMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Beards = this.Const.Beards.WildExtended;
    this.m.SoundPitch = 0.949999988079071;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
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
    this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedBarbarianWeapons["this.Math.rand(0, (this.Const.Items.NamedBarbarianWeapons.len() - 1))"])));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
    return this.Const.Items.NamedBarbarianWeapons;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("KingOfTheNorth", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BarbarianChosen);
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
    this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    return;
}
