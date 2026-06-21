// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/old_gladiator_background.nut
// Functions: 3

function create(this)
{
    this.gladiator_background.create();
    this.m.HairColors = this.Const.HairColors.Old;
    this.m.Level = 3;
    return;
}

function onAddEquipment(this)
{
    if (this.Math.rand(1, 2) == 1)
    {
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
        }
    }
    this.new("scripts/items/armor/oriental/gladiator_harness").setUpgrade(this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade"));
    this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/gladiator_harness"));
    return;
}

function onSetAppearance(this)
{
    this.getContainer().getActor().getSprite("tattoo_body").setBrush(("scar_02_" + this.getContainer().getActor().getSprite("body").getBrush().Name));
    this.getContainer().getActor().getSprite("tattoo_body").Visible = true;
    this.getContainer().getActor().getSprite("tattoo_head").setBrush("scar_02_head");
    this.getContainer().getActor().getSprite("tattoo_head").Visible = true;
    return;
}
