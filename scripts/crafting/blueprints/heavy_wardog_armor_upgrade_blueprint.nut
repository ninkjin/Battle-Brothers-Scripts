// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/heavy_wardog_armor_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.heavy_wardog_armor_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/misc/wardog_heavy_armor_upgrade_item");
    this.m.Cost = 150;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/wardog_heavy_armor_upgrade_item"));
    return;
}
