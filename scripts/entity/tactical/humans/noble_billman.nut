// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble_billman.nut
// Functions: 3

function assignRandomEquipment(this)
{
    if (!this.Tactical.State.isScenarioMode())
    {
    }
    this.m.Surcoat = this.getFaction();
    if (this.Math.rand(1, 100) <= 90)
    {
        if (this.getFaction() < 10)
        {
        }
        this.getSprite("surcoat").setBrush(("surcoat_" + this.getFaction()));
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        if (this.Math.rand(0, 3) <= 1)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
        }
        else
        {
            if (this.Math.rand(0, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/pike"));
            }
            else
            {
                if (this.Math.rand(0, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/polehammer"));
                }
            }
        }
    }
    else
    {
        if (this.Math.rand(1, 2) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
        }
        else
        {
            if (this.Math.rand(1, 2) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/pike"));
            }
        }
    }
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        if (this.getFaction() <= 4)
        {
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
                }
            }
        }
        else
        {
            if (this.getFaction() <= 7)
            {
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
                    }
                }
            }
            else
            {
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
                    }
                }
            }
        }
        this.new("scripts/items/helmets/mail_coif").setPlainVariant();
        this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
    }
    else
    {
        if (this.Math.rand(1, 4) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
        }
        else
        {
            if (this.Math.rand(1, 4) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
            }
            else
            {
                if (this.Math.rand(1, 4) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
                }
                else
                {
                    if (this.Math.rand(1, 4) == 4)
                    {
                        this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
                    }
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Billman;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Billman.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Billman);
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
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
