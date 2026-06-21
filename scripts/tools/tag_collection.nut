// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/tools/tag_collection.nut
// Functions: 10

function add(this, _tag, _value)
{
    if (!this.m.rawin(_tag))
    {
        this.m.rawset(_tag, {});
    }
    return;
}

function get(this, _tag)
{
    if (this.m.rawin(_tag))
    {
        return _tag;
    }
    return _tag;
}

function getAsFloat(this, _tag)
{
    if (this.m.rawin(_tag))
    {
        return _tag;
    }
    return _tag;
}

function getAsInt(this, _tag)
{
    if (this.m.rawin(_tag))
    {
        return _tag;
    }
    return _tag;
}

function has(this, _tag)
{
    return this.m.rawin(_tag);
    return _tag;
}

function increment(this, _tag, _value)
{
    if (!this.m.rawin(_tag))
    {
        this.m.rawset(_tag, {});
    }
    this.m.rawset(_tag, {});
    return;
}

function onDeserialize(this, _in, _clearCurrent)
{
    if (_clearCurrent)
    {
        this.m = {};
    }
    if (0 < _in.readU16())
    {
        if (_in.readU8() == 0)
        {
        }
        else
        {
            if (_in.readU8() == 1)
            {
            }
            else
            {
                if (_in.readU8() == 2)
                {
                }
            }
        }
        this.set(_in.readString(), _in.readString());
    }
    return;
}

function onSerialize(this, _out)
{
    _out.writeU16(this.m.len());
    foreach (local key, value in r53)
    {
        _out.writeString(null.Key);
        if (typeof(this) == "integer")
        {
            _out.writeU8(0);
            _out.writeI32(null.Value);
        }
        else
        {
            if (typeof(this) == "float")
            {
                _out.writeU8(1);
                _out.writeF32(null.Value);
            }
            else
            {
                if (typeof(this) == "bool")
                {
                    _out.writeU8(2);
                    _out.writeBool(null.Value);
                }
                _out.writeU8(3);
                _out.writeString(null.Value);
            }
        }
        return;
    }
}

function remove(this, _tag)
{
    this.m.rawdelete(_tag);
    return;
}

function set(this, _tag, _value)
{
    this.m.rawset(_tag, {});
    return;
}
