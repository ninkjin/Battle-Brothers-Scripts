// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/bounty_hunter_ranged.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 2) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
        this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
            this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/scramasax"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
                }
            }
        }
    }
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.Math.rand(1, 5) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 5) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
            }
            else
            {
                if (this.Math.rand(1, 5) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
                }
                else
                {
                    if (this.Math.rand(1, 5) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 5) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
                        }
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BountyHunter;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BountyHunterRanged.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BountyHunterRanged);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.BaseProperties.Vision = 8;
    this.m.BaseProperties.IsSpecializedInCrossbows = true;
    this.m.BaseProperties.IsSpecializedInBows = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
