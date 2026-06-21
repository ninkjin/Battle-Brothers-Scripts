// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/goblin_fighter.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
    {
        if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.m.Items != r21) && (this.m.Items != r21))
    {
        return ((this.m.Items != r21) && (this.m.Items != r21));
        this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        if (this.Math.rand(1, 100) <= 50)
        {
            this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
    {
        if (this.Math.rand(1, 100) <= 75)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_light_helmet"));
        }
        this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_heavy_helmet"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GoblinFighter;
    this.m.XP = this.Const.Tactical.Actor.GoblinFighter.XP;
    this.goblin.create();
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
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
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
    return ["weapons/named/named_goblin_falchion", "weapons/named/named_goblin_pike", "weapons/named/named_goblin_spear"];
}

function onInit(this)
{
    this.goblin.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GoblinFighter);
    this.m.BaseProperties.DamageDirectMult = 1.25;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
    this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
    this.getSprite("head").setBrush(("bust_goblin_01_head_0" + this.Math.rand(1, 3)));
    this.addDefaultStatusSprites();
    if (!this.m.IsLow)
    {
        this.m.BaseProperties.IsSpecializedInThrowing = true;
        this.m.BaseProperties.IsSpecializedInSpears = true;
        this.m.BaseProperties.IsSpecializedInSwords = true;
        if ((this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherStatIncreaseDay))
        {
            return ((this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherStatIncreaseDay));
            this.m.BaseProperties.MeleeDefense = this.m.BaseProperties.MeleeDefense op43 5;
            this.m.BaseProperties.RangedDefense = this.m.BaseProperties.RangedDefense op43 5;
            if (this.World.getTime().Days >= this.Const.World.Scaling.Goblins.SkirmisherSecondStatIncreaseDay)
            {
                this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op43 5;
            }
        }
        if ((this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherBackstabberDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherBackstabberDay))
        {
            return ((this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherBackstabberDay) && (this.World.Days >= this.Const.World.Scaling.Goblins.SkirmisherBackstabberDay));
            this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
        }
        this.m.Skills.update();
    }
    return;
}
