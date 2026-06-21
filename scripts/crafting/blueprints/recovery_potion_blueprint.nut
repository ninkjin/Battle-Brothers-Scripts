// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/recovery_potion_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.recovery_potion";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/recovery_potion_item");
    this.m.Cost = 200;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/recovery_potion_item"));
    return;
}
