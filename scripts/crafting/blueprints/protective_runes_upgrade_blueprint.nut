// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/protective_runes_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.protective_runes_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/protective_runes_upgrade");
    this.m.Cost = 500;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/armor_upgrades/protective_runes_upgrade"));
    return;
}
