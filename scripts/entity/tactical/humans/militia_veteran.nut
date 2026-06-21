// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/militia_veteran.nut
// Functions: 3

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
    }
    if (this.Math.rand(1, 100) <= 50)
    {
        this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
    }
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 6) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
        }
        else
        {
            if (this.Math.rand(1, 6) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
            }
            else
            {
                if (this.Math.rand(1, 6) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
                }
                else
                {
                    if (this.Math.rand(1, 6) == 5)
                    {
                        this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
                    }
                    else
                    {
                        if (this.Math.rand(1, 6) == 6)
                        {
                            this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
                        }
                    }
                }
            }
        }
    }
    if (this.Math.rand(1, 100) <= 75)
    {
        if (this.Math.rand(1, 3) == 1)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/hood"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 2)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
            }
            else
            {
                if (this.Math.rand(1, 3) == 3)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
                }
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.MilitiaVeteran;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.MilitiaVeteran.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Beards = this.Const.Beards.All;
    this.m.Flags.add("militia");
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.MilitiaVeteran);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_militia");
    this.getSprite("accessory_special").setBrush("bust_militia_band_01");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
