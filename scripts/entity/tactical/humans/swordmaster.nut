// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/swordmaster.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.Const.DLC.Desert && this.Const.DLC.Desert)
        {
            return (this.Const.DLC.Desert && this.Const.DLC.Desert);
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.Math <= 90) && (this.Math <= 90))
    {
        return ((this.Math <= 90) && (this.Math <= 90));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Swordmaster;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Swordmaster.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.SmartMale;
    this.m.Hairs = this.Const.Hair.TidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
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
    if (this.Const.DLC.Desert && this.Const.DLC.Desert)
    {
        return (this.Const.DLC.Desert && this.Const.DLC.Desert);
        [].extend([]);
    }
    if (this.Const.DLC.Wildmen)
    {
        [].extend([]);
    }
    if (this.Math.rand(1, 100) <= 70)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    this.m.BaseProperties.DamageDirectMult = this.m.BaseProperties.DamageDirectMult op42 1.25;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    return [];
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.setDirty(true);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if ((!_skill.isRanged() && (!_skill.isRanged()) && (!_skill.isRanged()) && (!_skill.isRanged())))
    {
        return ((!_skill.isRanged()) && (!_skill.isRanged()) && (!_skill.isRanged()) && (!_skill.isRanged()));
        this.updateAchievement("ThereCanBeOnlyOne", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Swordmaster);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
