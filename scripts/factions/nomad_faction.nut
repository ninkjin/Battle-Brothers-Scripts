// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/nomad_faction.nut
// Functions: 3

function create(this)
{
    this.faction.create();
    this.m.Type = this.Const.FactionType.OrientalBandits;
    this.m.Base = "world_base_07";
    this.m.TacticalBase = "bust_base_nomads";
    this.m.CombatMusic = this.Const.Music.OrientalBanditTracks;
    this.m.PlayerRelation = 0.0;
    this.m.IsHidden = true;
    this.m.IsRelationDecaying = false;
    return;
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
