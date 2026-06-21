// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/arena_faction.nut
// Functions: 3

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
    this.m.Type = this.Const.FactionType.Arena;
    this.m.Base = "world_base_10";
    this.m.TacticalBase = "bust_base_beasts";
    this.m.CombatMusic = this.Const.Music.BeastsTracks;
    this.m.Footprints = this.Const.BeastFootprints;
    this.m.PlayerRelation = 0.0;
    this.m.IsHidden = true;
    this.m.IsRelationDecaying = false;
    return;
}
