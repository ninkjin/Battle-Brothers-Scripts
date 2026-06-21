// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/paint_white_green_yellow_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.paint_white_green_yellow";
    this.m.PreviewCraftable = this.new("scripts/items/misc/paint_white_green_yellow_item");
    this.m.Cost = 25;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/paint_white_green_yellow_item"));
    return;
}
