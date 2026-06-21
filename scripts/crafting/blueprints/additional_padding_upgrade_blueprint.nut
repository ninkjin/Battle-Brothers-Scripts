// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/additional_padding_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.additional_padding_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/additional_padding_upgrade");
    this.m.Cost = 400;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/armor_upgrades/additional_padding_upgrade"));
    return;
}
