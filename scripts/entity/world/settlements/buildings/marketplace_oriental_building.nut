// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/marketplace_oriental_building.nut
// Functions: 2

function create(this)
{
    this.marketplace_building.create();
    this.m.UIImage = "ui/settlements/desert_building_06";
    this.m.UIImageNight = "ui/settlements/desert_building_06_night";
    return;
}

function getDefaultShopList(this)
{
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
        [].push({});
    }
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
        [].push({});
        [].push({});
    }
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
        [].push({});
    }
    if (!this.m.Settlement.hasAttachedLocation("attached_location.wheat_farm"))
    {
        [].push({});
    }
    if (this.m.Settlement.getSize() >= 3)
    {
        [].push({});
    }
    if (this.Const.DLC.Unhold)
    {
        [].extend([]);
    }
    if (this.Const.DLC.Wildmen)
    {
        [].push({});
    }
    return [];
}
