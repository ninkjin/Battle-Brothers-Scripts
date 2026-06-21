// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/armorsmith_oriental_building.nut
// Functions: 3

function create(this)
{
    this.armorsmith_building.create();
    this.m.ID = "building.armorsmith_oriental";
    this.m.UIImage = "ui/settlements/desert_building_01";
    this.m.UIImageNight = "ui/settlements/desert_building_01_night";
    return;
}

function getDefaultShopList(this)
{
    if (this.Const.DLC.Unhold)
    {
        [].extend([]);
        [].extend([]);
    }
    foreach (local key, value in r22)
    {
        if (this.Math.rand(1, 100) <= 33)
        {
            [].push({});
        }
        foreach (local key, value in r22)
        {
            if (this.Math.rand(1, 100) <= 33)
            {
                [].push({});
            }
            return [];
        }
    }
}

function getStash(this)
{
    return this.m.Stash;
}
