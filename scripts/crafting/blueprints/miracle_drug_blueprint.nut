// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/miracle_drug_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.miracle_drug";
    this.m.PreviewCraftable = this.new("scripts/items/misc/miracle_drug_item");
    this.m.Cost = 250;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/miracle_drug_item"));
    return;
}
