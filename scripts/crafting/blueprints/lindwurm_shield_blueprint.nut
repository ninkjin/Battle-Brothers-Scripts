// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/lindwurm_shield_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.lindwurm_shield";
    this.m.PreviewCraftable = this.new("scripts/items/shields/special/craftable_lindwurm_shield");
    this.m.Cost = 500;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/shields/special/craftable_lindwurm_shield"));
    return;
}
