// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/fermented_unhold_heart_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.fermented_unhold_heart";
    this.m.PreviewCraftable = this.new("scripts/items/supplies/fermented_unhold_heart_item");
    this.m.Cost = 40;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/supplies/fermented_unhold_heart_item"));
    return;
}
