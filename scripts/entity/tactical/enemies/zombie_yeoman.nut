// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_yeoman.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
                        }
                    }
                }
            }
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
                else
                {
                    if (this.Math.rand(1, 5) == 5)
                    {
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.new("scripts/items/armor/basic_mail_shirt").setArmor((this.Math.round(((this.new("scripts/items/armor/basic_mail_shirt").getArmorMax() / 2) - 1)) / 1.0));
    }
    this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
    if (this.Math.rand(1, 100) <= 75)
    {
        if (this.Math.rand(1, 7) == 1)
        {
        }
        else
        {
            if (this.Math.rand(1, 7) == 2)
            {
            }
            else
            {
                if (this.Math.rand(1, 7) == 3)
                {
                }
                else
                {
                    if (this.Math.rand(1, 7) == 4)
                    {
                    }
                    else
                    {
                        if (this.Math.rand(1, 7) == 5)
                        {
                        }
                        else
                        {
                            if (this.Math.rand(1, 7) == 6)
                            {
                            }
                            else
                            {
                                if (this.Math.rand(1, 7) == 7)
                                {
                                }
                            }
                        }
                    }
                }
            }
        }
        if (this.Math.rand(1, 100) <= 66)
        {
            this.new("scripts/items/helmets/full_leather_cap").setArmor((this.Math.round(((this.new("scripts/items/helmets/full_leather_cap").getArmorMax() / 2) - 1)) / 1.0));
        }
        this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
    }
    return;
}

function create(this)
{
    this.zombie.create();
    this.m.Type = this.Const.EntityType.ZombieYeoman;
    this.m.BloodType = this.Const.BloodType.Dark;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.ZombieYeoman.XP;
    this.m.ResurrectionValue = 3.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_yeoman";
    return;
}

function onInit(this)
{
    this.zombie.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.ZombieYeoman);
    this.m.BaseProperties.SurroundedBonus = 10;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    if ((this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerFatigueMultDay) && (this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerFatigueMultDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerFatigueMultDay) && (this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerFatigueMultDay));
        this.m.BaseProperties.FatigueDealtPerHitMult = 2.0;
    }
    if ((this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerDamageIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerDamageIncreaseDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerDamageIncreaseDay) && (this.World.Days >= this.Const.World.Scaling.Undead.WiedergangerDamageIncreaseDay));
        this.m.BaseProperties.DamageTotalMult = this.m.BaseProperties.DamageTotalMult op43 0.10000000149011612;
    }
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.Skills.update();
    return;
}
