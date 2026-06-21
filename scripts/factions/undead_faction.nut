// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/undead_faction.nut
// Functions: 3

function create(this)
{
    this.faction.create();
    this.m.Type = this.Const.FactionType.Undead;
    this.m.Base = "world_base_03";
    this.m.TacticalBase = "bust_base_undead";
    this.m.CombatMusic = this.Const.Music.UndeadTracks;
    this.m.Footprints = this.Const.UndeadFootprints;
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
