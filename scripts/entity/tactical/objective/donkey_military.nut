// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objective/donkey_military.nut
// Functions: 2

function create(this)
{
    this.donkey.create();
    return;
}

function onPlacedOnMap(this)
{
    this.actor.onPlacedOnMap();
    if (0 < 6)
    {
        if (!this.getTile().hasNextTile([]["0"]))
        {
        }
        else
        {
            if ((this.Math > 1) && (this.Math > 1))
            {
                return ((this.Math > 1) && (this.Math > 1));
            }
        }
    }
    if (this.getTile().getNextTile([]["0"]) != null)
    {
        if ([]["0"] == this.Const.Direction.NE)
        {
            this.Tactical.spawnEntity("scripts/entity/tactical/objects/cart_military", this.getTile().getNextTile([]["0"]).Coords).setFlipped(true);
            this.setFlipped(true);
        }
        else
        {
            if ([]["0"] == this.Const.Direction.SE)
            {
                this.Tactical.spawnEntity("scripts/entity/tactical/objects/cart_military", this.getTile().getNextTile([]["0"]).Coords).setFlipped(true);
            }
        }
    }
    return;
}
