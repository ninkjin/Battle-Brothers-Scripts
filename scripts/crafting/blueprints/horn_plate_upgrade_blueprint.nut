// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/horn_plate_upgrade_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.horn_plate_upgrade";
    this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/horn_plate_upgrade");
    this.m.Cost = 650;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/armor_upgrades/horn_plate_upgrade"));
    return;
}
