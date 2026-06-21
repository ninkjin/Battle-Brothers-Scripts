// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprints/snake_oil_07_blueprint.nut
// Functions: 4

function create(this)
{
    this.blueprint.create();
    this.m.ID = "blueprint.snake_oil_07";
    this.m.PreviewCraftable = this.new("scripts/items/misc/snake_oil_item");
    this.m.Cost = 50;
    this.init([]);
    return;
}

function isCraftable(this)
{
    if (!this.World.Retinue.hasFollower("follower.alchemist"))
    {
        return false;
    }
    return this.blueprint.isCraftable();
    return this.blueprint.isCraftable;
}

function isQualified(this)
{
    if (!this.World.Retinue.hasFollower("follower.alchemist"))
    {
        return false;
    }
    return this.blueprint.isQualified();
    return this.blueprint.isQualified;
}

function onCraft(this, _stash)
{
    _stash.add(this.new("scripts/items/misc/snake_oil_item"));
    return;
}
