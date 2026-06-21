// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/alp_trophy_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.alp_trophy";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/alp_trophy_item");
    this.m.Cost = 300;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/alp_trophy_item"));
    return;
}
