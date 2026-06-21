// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/antidote_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.antidote";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/antidote_item");
    this.m.Cost = 50;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/antidote_item"));
    return;
}
