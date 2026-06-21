// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_marksman.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
        this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
            this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
                this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
                    this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
                }
            }
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
            this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
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
    if (this.Math.rand(1, 4) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                }
            }
        }
    }
    this.m.Items.equip(this.new("scripts/items/armor/blotched_gambeson"));
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
                this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
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
                            this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
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
    this.m.Type = this.Const.EntityType.BanditMarksman;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditMarksman.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
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
        this.updateAchievement("TasteYourOwnMedicine", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditMarksman);
    this.m.BaseProperties.TargetAttractionMult = 1.100000023841858;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    if (this.Math.rand(1, 100) <= 20)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
    }
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.getSprite("armor").Saturation = 0.8500000238418579;
    this.getSprite("helmet").Saturation = 0.8500000238418579;
    this.getSprite("helmet_damage").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").setBrightness(0.8500000238418579);
    if (!this.m.IsLow)
    {
        this.m.BaseProperties.IsSpecializedInBows = true;
        this.m.BaseProperties.IsSpecializedInCrossbows = true;
        this.m.BaseProperties.Vision = 8;
    }
    if ((this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanStatIncreaseDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanStatIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanStatIncreaseDay));
        this.m.BaseProperties.RangedDefense = this.m.BaseProperties.RangedDefense op43 5;
    }
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    if ((this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanBullseyeDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanBullseyeDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanBullseyeDay) && (this.World.Days >= this.Const.World.Scaling.Brigands.MarksmanBullseyeDay));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    }
    return;
}
