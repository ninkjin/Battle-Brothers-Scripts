// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_arbalester.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = this.getFaction();
    if (this.Math.rand(1, 100) <= 80)
    {
        if (this.getFaction() < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
        this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    }
    this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
        }
    }
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
        }
    }
    if (this.Math.rand(1, 5) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 5) == 2)
        {
        }
        else
        {
            if (this.Math.rand(1, 5) == 3)
            {
            }
            else
            {
                if (this.Math.rand(1, 5) == 4)
                {
                }
            }
        }
    }
    if (this.new("scripts/items/helmets/headscarf") != null)
    {
        this.new("scripts/items/helmets/headscarf").setPlainVariant();
        this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Arbalester;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.Young;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Arbalester);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.BaseProperties.IsSpecializedInCrossbows = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
