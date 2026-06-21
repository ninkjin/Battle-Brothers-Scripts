// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/desert_devil.nut
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
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
    {
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
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
    this.m.Type = this.Const.EntityType.DesertDevil;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.DesertDevil.XP;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.Ethnicity = 1;
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
    if (this.Math.rand(1, 100) <= 75)
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
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("DanceOff", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.DesertDevil);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_nomads");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/adrenaline_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
