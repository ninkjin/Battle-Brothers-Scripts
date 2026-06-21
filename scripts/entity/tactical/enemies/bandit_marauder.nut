// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_marauder.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 100) <= 55)
    {
        [].extend([]);
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
    }
    [].extend([]);
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.Const.DLC.Unhold)
    {
        [].push("weapons/throwing_spear");
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.m.Items.addToBag(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.World.Days >= 60) && (this.World.Days >= 60))
    {
        return ((this.World.Days >= 60) && (this.World.Days >= 60));
        [].push("armor/pillaged_heavy_lamellar_armor");
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.Const.DLC.Unhold && this.Const.DLC.Unhold)
    {
        return (this.Const.DLC.Unhold && this.Const.DLC.Unhold);
        [].push("armor_upgrades/metal_plating_upgrade");
    }
    if (this.Math.rand(1, 100) <= 33)
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setUpgrade(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.Math.rand(1, 100) <= 90)
    {
        if ((this.World.Days >= 60) && (this.World.Days >= 60))
        {
            return ((this.World.Days >= 60) && (this.World.Days >= 60));
            [].push("helmets/marauder_helmet_with_closed_mail");
            [].push("helmets/marauder_helmet_with_closed_mail");
            [].push("helmets/flat_top_with_rusty_mail");
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BanditMarauder;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditMarauder.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.setDirty(true);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditMarauder);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.getSprite("armor").Saturation = 0.8500000238418579;
    this.getSprite("helmet").Saturation = 0.8500000238418579;
    this.getSprite("helmet_damage").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").setBrightness(0.8500000238418579);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    return;
}
