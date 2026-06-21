// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/paint_black_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.paint_black";
    this.m.PreviewCraftable = this.new("scripts/items/misc/paint_black_item");
    this.m.Cost = 25;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/paint_black_item"));
    return;
}
