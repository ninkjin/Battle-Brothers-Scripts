// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/fire_bomb_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.fire_bomb";
    this.m.PreviewCraftable = this.new("scripts/items/tools/fire_bomb_item");
    this.m.Cost = 100;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/tools/fire_bomb_item"));
    return;
}
