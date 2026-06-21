// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/reinforced_throwing_net_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.reinforced_net";
    this.m.PreviewCraftable = this.new("scripts/items/tools/reinforced_throwing_net");
    this.m.Cost = 50;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/tools/reinforced_throwing_net"));
    return;
}
