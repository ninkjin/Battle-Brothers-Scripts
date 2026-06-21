// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/bounty_hunter.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
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
        if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.dagger")
        {
            this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
        }
    }
    if ((!this.m.Skills) && (!this.m.Skills))
    {
        return ((!this.m.Skills) && (!this.m.Skills));
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
    if (this.Math.rand(1, 100) <= 50)
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
    if (this.Math.rand(2, 7) == 2)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
    }
    else
    {
        if (this.Math.rand(2, 7) == 3)
        {
            this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
        }
        else
        {
            if (this.Math.rand(2, 7) == 4)
            {
                this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
            }
            else
            {
                if (this.Math.rand(2, 7) == 5)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
                }
                else
                {
                    if (this.Math.rand(2, 7) == 6)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
                    }
                    else
                    {
                        if (this.Math.rand(2, 7) == 7)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 90)
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
    this.m.Type = this.Const.EntityType.BountyHunter;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BountyHunter.XP;
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
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BountyHunter);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.BaseProperties.IsSpecializedInDaggers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
