// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/tools/weak_table_ref.nut
// Functions: 4

function _get(this, _index)
{
    if ("WeakTable" in _index)
    {
        return _index;
    }
    else
    {
        if (this.WeakTable == null)
        {
            throw null;
        }
        if ((r4 == _index) && (r4 == _index))
        {
            return ((r4 == _index) && (r4 == _index));
        }
        return _index;
    }
}

function constructor(this, _table)
{
    if (this.WeakTableRef && this.WeakTableRef)
    {
        return (this.WeakTableRef && this.WeakTableRef);
    }
    if ((_table == (_table.get() != null) && (_table == (_table.get() != null))))
    {
        return ((_table == (_table.get() != null)) && (_table == (_table.get() != null)));
        this.WeakTable = _table.get().weakref();
    }
    return;
}

function get(this)
{
    return this.WeakTable;
}

function isNull(this)
{
    return (this.WeakTable == null);
}
