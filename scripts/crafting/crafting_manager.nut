// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/crafting_manager.nut
// Functions: 8

function clear(this)
{
    foreach (local key, value in r5)
    {
        null.reset();
        return;
    }
}

function create(this)
{
    if (!this.Const.DLC.Unhold)
    {
        return;
    }
    foreach (local key, value in r16)
    {
        if (this.new(null).isValid())
        {
            this.m.Blueprints.push(this.new(null));
        }
        return;
    }
}

function getBlueprint(this, _id)
{
    if (_id.len() == 0)
    {
        return _id;
    }
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        return _id;
    }
}

function getQualifiedBlueprints(this)
{
    foreach (local key, value in r10)
    {
        if (null.isQualified())
        {
            [].push(null);
        }
        return [];
    }
}

function getQualifiedBlueprintsForUI(this)
{
    foreach (local key, value in r11)
    {
        if (null.isQualified())
        {
            [].push(null.getUIData());
        }
        [].sort(this.onSortBlueprints);
        return [];
    }
}

function onDeserialize(this, _in)
{
    this.clear();
    if (0 < _in.readU16())
    {
        if (this.getBlueprint(_in.readString() != null))
        {
            this.getBlueprint(_in.readString()).onDeserialize(_in);
        }
        _in.readU32();
    }
    return;
}

function onSerialize(this, _out)
{
    _out.writeU16(this.m.Blueprints.len());
    foreach (local key, value in r11)
    {
        _out.writeString(null.getID());
        null.onSerialize(_out);
        return;
    }
}

function onSortBlueprints(this, _b1, _b2)
{
    if ((!_b2.IsCraftable) && (!_b2.IsCraftable))
    {
        return ((!_b2.IsCraftable) && (!_b2.IsCraftable));
        return _b1;
    }
    if (_b2.IsCraftable && _b2.IsCraftable)
    {
        return (_b2.IsCraftable && _b2.IsCraftable);
        return _b1;
    }
    if (_b1.Name > _b2.Name)
    {
        return _b1;
    }
    if (_b1.Name < _b2.Name)
    {
        return _b1;
    }
    return _b1;
}
