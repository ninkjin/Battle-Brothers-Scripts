// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/barbarian_faction.nut
// Functions: 3

function create(this)
{
    this.faction.create();
    this.m.Type = this.Const.FactionType.Barbarians;
    this.m.Base = "world_base_12";
    this.m.TacticalBase = "bust_base_wildmen_01";
    this.m.CombatMusic = this.Const.Music.BarbarianTracks;
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
