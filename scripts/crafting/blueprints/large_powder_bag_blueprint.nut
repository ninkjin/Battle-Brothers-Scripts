// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/large_powder_bag_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.large_powder_bag";
    this.m.PreviewCraftable = this.new("scripts/items/ammo/large_powder_bag");
    this.m.Cost = 300;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/ammo/large_powder_bag"));
    return;
}
