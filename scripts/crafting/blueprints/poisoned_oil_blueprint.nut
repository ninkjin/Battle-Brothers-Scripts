// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/poisoned_oil_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.poisoned_oil";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/spider_poison_item");
    this.m.Cost = 75;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/spider_poison_item"));
    return;
}
