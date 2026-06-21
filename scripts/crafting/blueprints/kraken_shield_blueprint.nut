// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/kraken_shield_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.kraken_shield";
    this.m.PreviewCraftable = this.new("scripts/items/shields/special/craftable_kraken_shield");
    this.m.Cost = 1000;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/shields/special/craftable_kraken_shield"));
    return;
}
