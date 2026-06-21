// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/happy_powder_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.happy_powder";
    this.m.PreviewCraftable = this.new("scripts/items/misc/happy_powder_item");
    this.m.Cost = 100;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/happy_powder_item"));
    return;
}
