// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/acid_flask_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.acid_flask";
    this.m.PreviewCraftable = this.new("scripts/items/tools/acid_flask_item");
    this.m.Cost = 50;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/tools/acid_flask_item"));
    return;
}
