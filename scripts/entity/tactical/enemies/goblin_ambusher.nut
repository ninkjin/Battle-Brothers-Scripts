// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_ambusher.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
    {
        if ((this.World.Days >= 60) && (this.World.Days >= 60))
        {
            return ((this.World.Days >= 60) && (this.World.Days >= 60));
            this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_heavy_bow"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
    {
        this.m.Items.equip(this.new("scripts/items/armor/greenskins/goblin_skirmisher_armor"));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_skirmisher_helmet"));
    }
    if (this.Math.rand(1, 100) <= 10)
    {
        this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GoblinAmbusher;
    this.m.XP = this.Const.Tactical.Actor.GoblinAmbusher.XP;
    this.goblin.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_ranged_agent");
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
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    return ["weapons/named/named_goblin_heavy_bow"];
}

function onInit(this)
{
    this.goblin.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
    this.m.BaseProperties.DamageDirectMult = 1.25;
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.getSprite("head").setBrush(("bust_goblin_01_head_0" + this.Math.rand(1, 3)));
    this.getSprite("quiver").Visible = true;
    this.addDefaultStatusSprites();
    if (!this.m.IsLow)
    {
        this.m.BaseProperties.IsSpecializedInBows = true;
        this.m.BaseProperties.Vision = 8;
        if ((this.World.Days >= this.Const.World.Scaling.Goblins.AmbusherExtraDamageDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.AmbusherExtraDamageDay))
        {
            return ((this.World.Days >= this.Const.World.Scaling.Goblins.AmbusherExtraDamageDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.AmbusherExtraDamageDay));
            this.m.BaseProperties.DamageDirectMult = 1.350000023841858;
        }
    }
    this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));
    return;
}
