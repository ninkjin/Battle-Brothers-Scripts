// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/iron_will_potion_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.iron_will_potion";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/iron_will_potion_item");
    this.m.Cost = 200;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/iron_will_potion_item"));
    return;
}
