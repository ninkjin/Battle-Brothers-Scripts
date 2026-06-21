// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/mercenary.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
    {
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
        if (this.Const.DLC.Wildmen)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        if (this.Math.rand(1, 100) <= 75)
        {
            if (this.Math.rand(0, 2) == 0)
            {
                this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
            }
            else
            {
                if (this.Math.rand(0, 2) == 1)
                {
                    this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
                }
                else
                {
                    if (this.Math.rand(0, 2) == 2)
                    {
                        this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
                    }
                }
            }
        }
        this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
    }
    if ((this.Math <= 60) && (this.Math <= 60))
    {
        return ((this.Math <= 60) && (this.Math <= 60));
        if (this.Const.DLC.Unhold)
        {
            if (this.Math.rand(1, 3) == 1)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 2)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
                }
                else
                {
                    if (this.Math.rand(1, 3) == 3)
                    {
                        this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
                    }
                }
            }
        }
        else
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
                }
            }
        }
    }
    if (this.Const.DLC.Unhold)
    {
        if (this.Math.rand(1, 11) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/armor/sellsword_armor"));
        }
        else
        {
            if (this.Math.rand(1, 11) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
            }
            else
            {
                if (this.Math.rand(1, 11) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
                }
                else
                {
                    if (this.Math.rand(1, 11) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 11) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 11) == 6)
                            {
                                this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
                            }
                            else
                            {
                                if (this.Math.rand(1, 11) == 7)
                                {
                                    this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
                                }
                                else
                                {
                                    if (this.Math.rand(1, 11) == 8)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 11) == 9)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
                                        }
                                        else
                                        {
                                            if (this.Math.rand(1, 11) == 10)
                                            {
                                                this.m.Items.equip(this.new("scripts/items/armor/light_scale_armor"));
                                            }
                                            else
                                            {
                                                if (this.Math.rand(1, 11) == 11)
                                                {
                                                    this.m.Items.equip(this.new("scripts/items/armor/leather_scale_armor"));
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(2, 8) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(2, 8) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
            }
            else
            {
                if (this.Math.rand(2, 8) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                }
                else
                {
                    if (this.Math.rand(2, 8) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
                    }
                    else
                    {
                        if (this.Math.rand(2, 8) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
                        }
                        else
                        {
                            if (this.Math.rand(2, 8) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
                            }
                            else
                            {
                                if (this.Math.rand(2, 8) == 8)
                                {
                                    this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 95)
    {
        if (this.Const.DLC.Wildmen)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new([]["this.Math.rand(1, ([].len() - 1))"]));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Mercenary;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Mercenary.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.AllMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Mercenary);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
