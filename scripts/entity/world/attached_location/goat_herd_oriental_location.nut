// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/attached_location/goat_herd_oriental_location.nut
// Functions: 3

function create(this)
{
    this.goat_herd_location.create();
    this.m.Sprite = "world_southern_goat";
    this.m.SpriteDestroyed = "world_southern_goat_ruins";
    return;
}

function onUpdateDraftList(this, _list)
{
    if (!this.isActive())
    {
        return;
    }
    _list.push("daytaler_southern_background");
    _list.push("shepherd_southern_background");
    _list.push("shepherd_southern_background");
    _list.push("shepherd_southern_background");
    _list.push("shepherd_southern_background");
    return;
}

function onUpdateShopList(this, _id, _list)
{
    if (_id == "building.marketplace")
    {
        _list.push({});
        _list.push({});
        _list.push({});
    }
    return;
}
