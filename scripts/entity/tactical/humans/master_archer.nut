// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/master_archer.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.Math.rand(1, 100) <= 66)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
            this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
        }
        this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
        this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    }
    this.m.Items.addToBag(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.MasterArcher;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.MasterArcher.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.SmartMale;
    this.m.Hairs = this.Const.Hair.TidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function makeMiniboss(this)
{
    this.actor.makeMiniboss();
    this.getSprite("miniboss").setBrush("bust_miniboss");
    [].push([]);
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.MasterArcher);
    this.m.BaseProperties.DamageDirectMult = 1.25;
    this.m.BaseProperties.IsSpecializedInBows = true;
    this.m.BaseProperties.Vision = 8;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
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
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
