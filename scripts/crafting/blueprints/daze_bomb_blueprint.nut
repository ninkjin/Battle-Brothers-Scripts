// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/daze_bomb_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.daze_bomb";
    this.m.PreviewCraftable = this.new("scripts/items/tools/daze_bomb_item");
    this.m.Cost = 70;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/tools/daze_bomb_item"));
    return;
}
