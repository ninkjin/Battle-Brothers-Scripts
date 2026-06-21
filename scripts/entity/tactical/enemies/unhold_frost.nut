// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/unhold_frost.nut
// Functions: 4

function assignRandomEquipment(this)
{
    return;
}

function create(this)
{
    this.unhold.create();
    this.m.Type = this.Const.EntityType.UnholdFrost;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.UnholdFrost.XP;
    return;
}

function onFactionChanged(this)
{
    this.actor.onFactionChanged();
    this.getSprite("body").setHorizontalFlipping(this.isAlliedWithPlayer());
    this.getSprite("injury").setHorizontalFlipping(this.isAlliedWithPlayer());
    this.getSprite("armor").setHorizontalFlipping(this.isAlliedWithPlayer());
    this.getSprite("head").setHorizontalFlipping(this.isAlliedWithPlayer());
    this.getSprite("helmet").setHorizontalFlipping(this.isAlliedWithPlayer());
    return;
}

function onInit(this)
{
    this.actor.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.UnholdFrost);
    this.m.BaseProperties.DamageTotalMult = this.m.BaseProperties.DamageTotalMult op43 0.15000000596046448;
    this.m.BaseProperties.IsImmuneToDisarm = true;
    this.m.BaseProperties.IsImmuneToRotation = true;
    if ((this.World.Days >= this.Const.World.Scaling.Beasts.UnholdDamageIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Beasts.UnholdDamageIncreaseDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Beasts.UnholdDamageIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Beasts.UnholdDamageIncreaseDay));
        this.m.BaseProperties.DamageTotalMult = this.m.BaseProperties.DamageTotalMult op43 0.10000000149011612;
    }
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.m.Items.getAppearance().Body = "bust_unhold_body_01";
    this.addSprite("socket").setBrush("bust_base_beasts");
    this.addSprite("body").setBrush("bust_unhold_body_01");
    this.addSprite("body").varySaturation(0.10000000149011612);
    this.addSprite("body").varyColor(0.03999999910593033, 0.03999999910593033, 0.03999999910593033);
    this.addSprite("injury").Visible = false;
    this.addSprite("injury").setBrush("bust_unhold_01_injured");
    this.addSprite("armor");
    this.addSprite("head").setBrush("bust_unhold_head_01");
    this.addSprite("head").Saturation = this.addSprite("body").Saturation;
    this.addSprite("head").Color = this.addSprite("body").Color;
    this.addSprite("helmet");
    this.addDefaultStatusSprites();
    this.getSprite("status_rooted").Scale = 0.6499999761581421;
    this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/racial/unhold_racial"));
    this.m.Skills.add(this.new("scripts/skills/actives/sweep_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/sweep_zoc_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/fling_back_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/unstoppable_charge_skill"));
    return;
}
