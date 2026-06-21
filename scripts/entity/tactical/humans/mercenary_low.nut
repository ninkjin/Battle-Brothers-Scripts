// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/mercenary_low.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(0, 7) <= 1)
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/pike"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
                }
            }
        }
    }
    if (this.Math.rand(1, 3) == 2)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 4)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 5)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
                }
                else
                {
                    if (this.Math.rand(1, 3) == 6)
                    {
                        this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 3) == 7)
                        {
                            this.m.Items.equip(this.new("scripts/items/weapons/flail"));
                        }
                    }
                }
            }
        }
    }
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
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
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
    if (this.Math.rand(1, 7) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
    }
    else
    {
        if (this.Math.rand(1, 7) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(1, 7) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
            }
            else
            {
                if (this.Math.rand(1, 7) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
                }
                else
                {
                    if (this.Math.rand(1, 7) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 7) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 7) == 7)
                            {
                                this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
                            }
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 90)
    {
        if (this.Math.rand(1, 10) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
        }
        else
        {
            if (this.Math.rand(1, 10) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
            }
            else
            {
                if (this.Math.rand(1, 10) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
                }
                else
                {
                    if (this.Math.rand(1, 10) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 10) == 5)
                        {
                            this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                        }
                        else
                        {
                            if (this.Math.rand(1, 10) == 6)
                            {
                                this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat"));
                            }
                            else
                            {
                                if (this.Math.rand(1, 10) == 7)
                                {
                                    this.m.Items.equip(this.new("scripts/items/helmets/padded_kettle_hat"));
                                }
                                else
                                {
                                    if (this.Math.rand(1, 10) == 8)
                                    {
                                        this.m.Items.equip(this.new("scripts/items/helmets/flat_top_helmet"));
                                    }
                                    else
                                    {
                                        if (this.Math.rand(1, 10) == 9)
                                        {
                                            this.m.Items.equip(this.new("scripts/items/helmets/padded_flat_top_helmet"));
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
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Mercenary;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditRaider.XP;
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditRaider);
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
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
