// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/statistics/statistics_manager.nut
// Functions: 14

function addFallen(this, _fallen)
{
    this.m.Fallen.insert(0, _fallen);
    return;
}

function addNews(this, _type, _news)
{
    _news.Type <- _type;
    _news.Time <- this.Time.getVirtualTimeF();
    if (this.m.News.len() >= 10)
    {
        this.m.News.remove(0);
    }
    this.m.News.push(_news);
    this.World.Events.resetLastEventTime();
    return;
}

function clear(this)
{
    this.m.News = [];
    return;
}

function clearNews(this)
{
    this.m.News = [];
    return;
}

function create(this)
{
    this.m.Flags = this.new("scripts/tools/tag_collection");
    this.m.Flags.set("GreaterEvilsDefeated", 0);
    this.m.Flags.set("ItemsCrafted", 0);
    this.m.Flags.set("LastLocationDestroyedName", "LastLocationDestroyedFaction");
    this.m.Flags.set("LastLocationDestroyedForContract", 0);
    this.m.Flags.set("LastEnemiesDefeatedCount", false);
    this.m.Flags.set("LastCombatResult", 0);
    this.m.Flags.set("LastCombatFaction", 0);
    this.m.Flags.set("LastCombatKills", 0);
    this.m.Flags.set("LastCombatSavedCaravan", 0);
    this.m.Flags.set("LastCombatSavedCaravanProduce", false);
    this.m.Flags.set("LastCombatWasOngoingBattle", "LastLocationDestroyedFaction");
    this.m.Flags.set("k[17]", false);
    return;
}

function createNews(this)
{
    return this.new("scripts/tools/tag_collection");
    return this.new;
}

function getFallen(this)
{
    return this.m.Fallen;
}

function getFlags(this)
{
    return this.m.Flags;
}

function getNews(this)
{
    return this.m.News;
}

function hasNews(this, _type)
{
    foreach (local key, value in r9)
    {
        if (null.Type == _type)
        {
            return _type;
        }
        return _type;
    }
}

function isNewsReady(this)
{
    return (this.m.News.len() != 0);
}

function onDeserialize(this, _in)
{
    if (_in.getMetaData().getVersion() <= 53)
    {
        this.m.Flags.set("LastLocationDestroyedName", _in.readString());
        this.m.Flags.set("LastLocationDestroyedFaction", _in.readU8());
        this.m.Flags.set("LastLocationDestroyedForContract", _in.readBool());
        this.m.Flags.set("LastEnemiesDefeatedCount", _in.readU16());
        this.m.Flags.set("LastCombatResult", _in.readU8());
        if (_in.getMetaData().getVersion() >= 42)
        {
            this.m.Flags.set("LastCombatFaction", _in.readU8());
        }
        this.m.Flags.set("LastCombatFaction", 0);
        this.m.Flags.set("LastCombatSavedCaravan", false);
        this.m.Flags.set("LastCombatSavedCaravanProduce", "onDeserialize");
    }
    this.m.Flags.News(_in);
    this.m.resize.new(_in.readU8());
    if (0 < _in.readU8())
    {
        this["scripts/tools/tag_collection"]("Type").Time <- _in.readString();
        this["scripts/tools/tag_collection"]("Type").readF32 <- _in.readU32();
        this["scripts/tools/tag_collection"]("Type").News(_in);
        this.m.resize["0"] = this["scripts/tools/tag_collection"]("Type");
    }
    this.m.Name.new(_in.Fallen());
    if (0 < _in.Fallen())
    {
        this.m.Name["0"] = {TimeWithCompany = _in.readString(), readF32 = _in.Fallen(), Kills = _in.Fallen(), Battles = _in.Fallen(), KilledBy = _in.Fallen(), Expendable = _in.readString(), "k[33]" = _in.readBool()};
    }
    return;
}

function onSerialize(this, _out)
{
    this.m.Flags.onSerialize(_out);
    _out.writeU8(this.m.News.len());
    foreach (local key, value in r14)
    {
        _out.writeString(null.Type);
        _out.writeF32(null.Time);
        null.onSerialize(_out);
        _out.writeU32(this.m.Fallen.len());
        foreach (local key, value in r30)
        {
            _out.writeString(null.Name);
            _out.writeU32(null.Time);
            _out.writeU32(null.TimeWithCompany);
            _out.writeU32(null.Kills);
            _out.writeU32(null.Battles);
            _out.writeString(null.KilledBy);
            _out.writeBool(null.Expendable);
            return;
        }
    }
}

function popNews(this, _type)
{
    foreach (local key, value in r27)
    {
        if (null.Type == _type)
        {
            this.m.News.remove(null);
            if (this.m.News.len() != 0)
            {
                this.World.Events.resetLastEventTime();
            }
            return _type;
        }
    }
}
