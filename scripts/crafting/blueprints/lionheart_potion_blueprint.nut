// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/lionheart_potion_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.lionheart_potion";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/lionheart_potion_item");
    this.m.Cost = 150;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/lionheart_potion_item"));
    return;
}
