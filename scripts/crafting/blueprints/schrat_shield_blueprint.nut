// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/schrat_shield_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.schrat_shield";
    this.m.PreviewCraftable = this.new("scripts/items/shields/special/craftable_schrat_shield");
    this.m.Cost = 450;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/shields/special/craftable_schrat_shield"));
    return;
}
