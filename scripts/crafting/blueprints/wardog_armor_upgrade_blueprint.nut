// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/wardog_armor_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.wardog_armor_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/misc/wardog_armor_upgrade_item");
    this.m.Cost = 50;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/wardog_armor_upgrade_item"));
    return;
}
