// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/large_quiver_of_arrows_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.large_quiver_of_arrows";
    this.m.PreviewCraftable = this.new("scripts/items/ammo/large_quiver_of_arrows");
    this.m.Cost = 350;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/ammo/large_quiver_of_arrows"));
    return;
}
