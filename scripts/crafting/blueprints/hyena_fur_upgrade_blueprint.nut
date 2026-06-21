// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/hyena_fur_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.hyena_fur_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/hyena_fur_upgrade");
    this.m.Cost = 200;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/armor_upgrades/hyena_fur_upgrade"));
    return;
}
