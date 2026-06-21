// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/attached_location/fishing_huts_oriental_location.nut
// Functions: 4

function create(this)
{
    this.fishing_huts_location.create();
    this.m.Sprite = "world_southern_fishing_huts";
    this.m.SpriteDestroyed = "world_southern_fishing_huts_ruins";
    return;
}

function onUpdateDraftList(this, _list)
{
    if (!this.isActive())
    {
        return;
    }
    _list.push("fisherman_southern_background");
    _list.push("fisherman_southern_background");
    _list.push("fisherman_southern_background");
    _list.push("fisherman_southern_background");
    return;
}

function onUpdateProduce(this, _list)
{
    _list.push("supplies/dried_fish_item");
    return;
}

function onUpdateShopList(this, _id, _list)
{
    if (_id == "building.marketplace")
    {
        _list.push({});
        _list.push({});
        _list.push({});
        _list.push({});
    }
    return;
}
