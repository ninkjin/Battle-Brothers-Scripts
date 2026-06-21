// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/companion_ranged_southern_background.nut
// Functions: 2

function create(this)
{
    this.companion_ranged_background.create();
    this.m.Bodies = this.Const.Bodies.Gladiator;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.Excluded = ["trait.superstitious", "trait.hate_undead", "trait.hate_beasts", "trait.hate_greenskins", "trait.huge", "trait.weasel", "trait.fear_undead", "trait.fear_beasts", "trait.fear_greenskins", "trait.paranoid", "trait.night_blind", "trait.impatient", "trait.asthmatic", "trait.greedy", "trait.clubfooted", "trait.dumb", "trait.fragile", "trait.short_sighted", "trait.disloyal", "trait.drunkard", "trait.clumsy", "trait.fainthearted", "trait.craven", "trait.dastard", "trait.insecure", "trait.hesitant"];
    this.m.Names = this.Const.Strings.SouthernNames;
    this.m.LastNames = this.Const.Strings.SouthernNamesLast;
    return;
}

function onAddEquipment(this)
{
    this.getContainer().getActor().getTalents().resize(this.Const.Attributes.COUNT, 0);
    this.getContainer().getActor().getTalents()["this.Const.Attributes.RangedSkill"] = 2;
    this.getContainer().getActor().getTalents()["this.Const.Attributes.RangedDefense"] = 1;
    this.getContainer().getActor().getTalents()["this.Const.Attributes.Initiative"] = 1;
    this.getContainer().getActor().getItems().equip(this.new("scripts/items/weapons/oriental/composite_bow"));
    this.getContainer().getActor().getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
    this.getContainer().getActor().getItems().addToBag(this.new("scripts/items/weapons/knife"));
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
    if (this.Math.rand(0, 1) == 1)
    {
    }
    this.new("scripts/items/helmets/oriental/southern_head_wrap").setVariant(8);
    this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
    return;
}
