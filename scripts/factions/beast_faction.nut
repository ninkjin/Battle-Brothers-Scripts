// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/beast_faction.nut
// Functions: 6

function addPlayerRelation(this, _r, _reason)
{
    return;
}

function addPlayerRelationEx(this, _r, _reason)
{
    return;
}

function create(this)
{
    this.faction.create();
    this.m.Type = this.Const.FactionType.Beasts;
    this.m.Base = "world_base_10";
    this.m.TacticalBase = "bust_base_beasts";
    this.m.CombatMusic = this.Const.Music.BeastsTracks;
    this.m.Footprints = this.Const.BeastFootprints;
    this.m.PlayerRelation = 0.0;
    this.m.IsHidden = true;
    this.m.IsRelationDecaying = false;
    return;
}

function getCombatMusic(this)
{
    if ((this.World.State.getPlayer().getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills) && (this.World.State.getPlayer().getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills))
    {
        return ((this.World.State.getPlayer().getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills) && (this.World.State.getPlayer().getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills));
        return this.World.State.getPlayer().getTile();
    }
    return this.World.State.getPlayer().getTile();
}

function onDeserialize(this, _in)
{
    this.faction.onDeserialize(_in);
    return;
}

function onSerialize(this, _out)
{
    this.faction.onSerialize(_out);
    return;
}
