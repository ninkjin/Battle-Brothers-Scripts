// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/desert_stalker.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
        this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    }
    this.m.Items.addToBag(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.Math <= 75) && (this.Math <= 75))
    {
        return ((this.Math <= 75) && (this.Math <= 75));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.DesertStalker;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.DesertStalker.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMaleOnly;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.SouthernOnly;
    this.m.BeardChance = 100;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function makeMiniboss(this)
{
    this.actor.makeMiniboss();
    this.getSprite("miniboss").setBrush("bust_miniboss");
    [].push([]);
    if (this.Math.rand(1, 100) <= 70)
    {
        foreach (local key, value in r11)
        {
            this.m.Items.equip(this.new(("scripts/items/" + null)));
            this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
            this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
            return;
        }
    }
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.setDirty(true);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_skill.isRanged() && _skill.isRanged() && _skill.isRanged() && _skill.isRanged())
    {
        return (_skill.isRanged() && _skill.isRanged() && _skill.isRanged() && _skill.isRanged());
        this.updateAchievement("Bullseye", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.DesertStalker);
    this.m.BaseProperties.DamageDirectMult = 1.25;
    this.m.BaseProperties.IsSpecializedInBows = true;
    this.m.BaseProperties.Vision = 8;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_nomads");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
