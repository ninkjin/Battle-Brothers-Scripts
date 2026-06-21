// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/old_paladin_background.nut
// Functions: 2

function create(this)
{
    this.paladin_background.create();
    this.m.HairColors = this.Const.HairColors.Old;
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
