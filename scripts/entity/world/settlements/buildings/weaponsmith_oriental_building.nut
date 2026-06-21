// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/weaponsmith_oriental_building.nut
// Functions: 2

function create(this)
{
    this.weaponsmith_building.create();
    this.m.ID = "building.weaponsmith_oriental";
    this.m.UIImage = "ui/settlements/desert_building_04";
    this.m.UIImageNight = "ui/settlements/desert_building_04_night";
    return;
}

function getDefaultShopList(this)
{
    if (this.Const.DLC.Unhold)
    {
        [].extend([]);
    }
    if (this.Const.DLC.Wildmen)
    {
        [].extend([]);
    }
    foreach (local key, value in r22)
    {
        if (this.Math.rand(1, 100) <= 30)
        {
            [].push({});
        }
        return [];
    }
}
