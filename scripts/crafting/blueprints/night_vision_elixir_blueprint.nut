// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/night_vision_elixir_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.night_vision_elixir";
    this.m.PreviewCraftable = this.new("scripts/items/accessory/night_vision_elixir_item");
    this.m.Cost = 350;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/accessory/night_vision_elixir_item"));
    return;
}
