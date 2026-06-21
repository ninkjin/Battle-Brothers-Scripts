// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/potion_of_knowledge_blueprint.nut
// Functions: 2

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.potion_of_knowledge";
    this.m.PreviewCraftable = this.new("scripts/items/misc/potion_of_knowledge_item");
    this.m.Cost = 300;
    this.init([]);
    return;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/potion_of_knowledge_item"));
    return;
}
