// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/companion_2h_southern_background.nut
// Functions: 2

function create(this)
{
    this.companion_2h_background.create();
    this.m.Bodies = this.Const.Bodies.Gladiator;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.Excluded = ["trait.superstitious", "trait.hate_undead", "trait.hate_beasts", "trait.hate_greenskins", "trait.weasel", "trait.fear_undead", "trait.fear_beasts", "trait.fear_greenskins", "trait.paranoid", "trait.night_blind", "trait.ailing", "trait.impatient", "trait.asthmatic", "trait.greedy", "trait.clubfooted", "trait.drunkard", "trait.disloyal", "trait.tiny", "trait.fragile", "trait.clumsy", "trait.fainthearted", "trait.craven", "trait.bleeder", "trait.dastard", "trait.insecure", "trait.dexterous"];
    this.m.Names = this.Const.Strings.SouthernNames;
    this.m.LastNames = this.Const.Strings.SouthernNamesLast;
    return;
}

function onAddEquipment(this)
{
    this.getContainer().getActor().getTalents().resize(this.Const.Attributes.COUNT, 0);
    this.getContainer().getActor().getTalents()["this.Const.Attributes.MeleeSkill"] = 2;
    this.getContainer().getActor().getTalents()["this.Const.Attributes.MeleeDefense"] = 1;
    this.getContainer().getActor().getTalents()["this.Const.Attributes.Bravery"] = 1;
    if (this.Math.rand(0, 0) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
    }
    if (this.Math.rand(0, 2) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/thick_nomad_robe"));
    }
    else
    {
        if (this.Math.rand(0, 2) == 1)
        {
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/padded_vest"));
        }
        else
        {
            if (this.Math.rand(0, 2) == 2)
            {
                this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/leather_nomad_robe"));
            }
        }
    }
    if (this.Math.rand(0, 2) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/leather_head_wrap"));
    }
    else
    {
        if (this.Math.rand(0, 2) == 1)
        {
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/leather_head_wrap"));
        }
        else
        {
            if (this.Math.rand(0, 2) == 2)
            {
                if (this.Math.rand(0, 1) == 1)
                {
                }
                this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(8);
                this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
            }
        }
    }
    return;
}
