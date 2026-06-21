// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/crowd_oriental_building.nut
// Functions: 2

function create(this)
{
    this.crowd_building.create();
    return;
}

function getUIImage(this)
{
    if ((!this.World.IsDaytime) && (!this.World.IsDaytime))
    {
        return ((!this.World.IsDaytime) && (!this.World.IsDaytime));
        return this.World.getRoster(this.m.Settlement.getID());
    }
    if (this.World.getRoster(this.m.Settlement.getID().getSize() <= 3))
    {
    }
    if (this.World.getRoster(this.m.Settlement.getID().getSize() <= 6))
    {
    }
    return this.World.getRoster(this.m.Settlement.getID());
}
