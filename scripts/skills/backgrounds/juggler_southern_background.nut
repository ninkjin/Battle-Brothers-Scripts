// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/juggler_southern_background.nut
// Functions: 3

function create(this)
{
    this.juggler_background.create();
    this.m.Bodies = this.Const.Bodies.SouthernSkinny;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.Ethnicity = 1;
    this.m.BeardChance = 60;
    this.m.Names = this.Const.Strings.SouthernNames;
    this.m.LastNames = this.Const.Strings.SouthernNamesLast;
    return;
}

function onAddEquipment(this)
{
    this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/cloth_sash"));
    return;
}

function onBuildDescription(this)
{
    return "k[0]";
}
