// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/stash_container.nut
// Functions: 35

function add(this, _item)
{
    if (this.getFirstEmptySlot() != null)
    {
        this.m.Items["this.getFirstEmptySlot()"] = _item;
        if (_item != null)
        {
            _item.onAddedToStash(this.m.ID);
        }
        return _item;
    }
    else
    {
        if (this.m.IsResizable)
        {
            this.m.Items.push(_item);
            if (_item != null)
            {
                _item.onAddedToStash(this.m.ID);
            }
            return _item;
        }
    }
    return _item;
}

function assign(this, _array)
{
    this.m.Items = _array;
    this.m.Capacity = _array.len();
    return;
}

function clear(this)
{
    if (this.m.IsResizable)
    {
        this.m.Items = [];
    }
    else
    {
        if (0 < this.m.Items.len())
        {
            this.m.Items["0"] = null;
        }
    }
    return;
}

function create(this)
{
    this.m.Capacity = 0;
    this.m.Items = [];
    return;
}

function getCapacity(this)
{
    return this.m.Capacity;
}

function getFirstEmptySlot(this)
{
    if (0 < this.m.Items.len())
    {
        if (this.m.Items["0"] == null)
        {
            return 0;
        }
    }
    return null;
}

function getID(this)
{
    return this.m.ID;
}

function getItemAtIndex(this, _index)
{
    if ((_index < this.m.Items) && (_index < this.m.Items))
    {
        return ((_index < this.m.Items) && (_index < this.m.Items));
        return _index;
    }
    return _index;
}

function getItemByID(this, _id)
{
    if (0 < this.m.Items.len())
    {
        if ((this.m.Items[0] == _id) && (this.m.Items[0] == _id))
        {
            return ((this.m.Items[0] == _id) && (this.m.Items[0] == _id));
            return _id;
        }
    }
    return _id;
}

function getItemByInstanceID(this, _instanceID)
{
    if (0 < this.m.Items.len())
    {
        if ((this.m.Items[0] == _instanceID) && (this.m.Items[0] == _instanceID))
        {
            return ((this.m.Items[0] == _instanceID) && (this.m.Items[0] == _instanceID));
            return _instanceID;
        }
    }
    return _instanceID;
}

function getItems(this)
{
    return this.m.Items;
}

function getNumberOfEmptySlots(this)
{
    if (0 < this.m.Items.len())
    {
        if (this.m.Items["0"] == null)
        {
        }
    }
    return (0 + 1);
}

function getNumberOfFilledSlots(this)
{
    if (0 < this.m.Items.len())
    {
        if (this.m.Items["0"] != null)
        {
        }
    }
    return (0 + 1);
}

function hasEmptySlot(this)
{
    if ((this.m.Items.len() - 1) >= 0)
    {
        if (this.m.Items["(this.m.Items.len() - 1)"] == null)
        {
            return (this.m.Items.len() - 1);
        }
    }
    return false;
}

function insert(this, _item, _index)
{
    if (!this.isValidSlot(_index))
    {
        return _item;
    }
    if (this.isSlotEmpty(_index))
    {
        this.m.Items["_index"] = _item;
        _item.onAddedToStash(this.m.ID);
        return _item;
    }
    this.m.Items["_index"] = _item;
    _item.onAddedToStash(this.m.ID);
    return _item;
}

function isEmpty(this)
{
    return (this.m.Items.len() == 0);
}

function isLastTakenSlot(this, _index)
{
    if (((_index + 1) < this.m.Items) && ((_index + 1) < this.m.Items))
    {
        return (((_index + 1) < this.m.Items) && ((_index + 1) < this.m.Items));
        if ((_index + 1) < this.m.Items.len())
        {
            if (this.m.Items["(_index + 1)"] != null)
            {
                return _index;
            }
        }
        return _index;
    }
    return _index;
}

function isLocked(this)
{
    return this.m.IsLocked;
}

function isResizable(this)
{
    return this.m.IsResizable;
}

function isSlotEmpty(this, _index)
{
    if ((_index < this.m.Items) && (_index < this.m.Items))
    {
        return ((_index < this.m.Items) && (_index < this.m.Items));
        return _index;
    }
    return _index;
}

function isValidSlot(this, _index)
{
    if ((_index < this.m.Items) && (_index < this.m.Items))
    {
        return ((_index < this.m.Items) && (_index < this.m.Items));
        return _index;
    }
    return _index;
}

function makeEmptySlots(this, _n)
{
    if ((this.m.Items.len() - 1) >= 0)
    {
        if (this.m.Items["(this.m.Items.len() - 1)"] == null)
        {
        }
        if ((0 + 2) >= _n)
        {
            return;
        }
    }
    if (0 < (_n - (0 + 2)))
    {
        if ((this.m.Items.len() - 1) >= 0)
        {
            if (this.m.Items["(this.m.Items.len() - 1)"] == null)
            {
            }
            else
            {
                if (this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food) || this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food) || this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food))
                {
                    return (this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food) || this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food) || this.m.Items["(this.m.Items.len() - 1)"].isItemType(this.Const.Items.ItemType.Food));
                }
                else
                {
                    if (this.m.Items["(this.m.Items.len() - 1)"].getValue() < 90000)
                    {
                    }
                }
            }
        }
        if ((this.m.Items.len() - 1) >= 0)
        {
            this.m.Items["(this.m.Items.len() - 1)"] = null;
        }
    }
    return;
}

function onDeserialize(this, _in)
{
    this.clear();
    if (this.m.Items.len() < _in.readU16())
    {
        this.m.Items.resize(_in.readU16());
    }
    if (0 < _in.readU16())
    {
        if (_in.readBool())
        {
            this.new(this.IO.scriptFilenameByHash(_in.readI32())).onDeserialize(_in);
            this.m.Items["0"] = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
        }
    }
    return;
}

function onItemCompare(this, _item1, _item2)
{
    if ((_item2 == null) && (_item2 == null))
    {
        return ((_item2 == null) && (_item2 == null));
        return _item1;
    }
    else
    {
        if ((_item2 != null) && (_item2 != null))
        {
            return ((_item2 != null) && (_item2 != null));
            return _item1;
        }
        if ((_item2 == null) && (_item2 == null))
        {
            return ((_item2 == null) && (_item2 == null));
            return _item1;
        }
        if (_item1.getItemType() > _item2.getItemType())
        {
            return _item1;
        }
        if (_item1.getItemType() < _item2.getItemType())
        {
            return _item1;
        }
        if (_item1.getCategories() > _item2.getCategories())
        {
            return _item1;
        }
        if (_item1.getCategories() < _item2.getCategories())
        {
            return _item1;
        }
        if (_item1.getID() > _item2.getID())
        {
            return _item1;
        }
        if (_item1.getID() < _item2.getID())
        {
            return _item1;
        }
        return _item1;
    }
}

function onSerialize(this, _out)
{
    _out.writeU16(this.m.Items.len());
    if (0 != this.m.Items.len())
    {
        if (this.m.Items["0"] == null)
        {
            _out.writeBool(false);
        }
        _out.writeBool(true);
        _out.writeI32(this.m.Items["0"].ClassNameHash);
        this.m.Items["0"].onSerialize(_out);
    }
    return;
}

function remove(this, _item)
{
    if (typeof(this) == "table")
    {
    }
    if (this.getItemByInstanceID(_item.getInstanceID() != null))
    {
        this.m.Items["this.getItemByInstanceID(_item.getInstanceID()).index"] = null;
        if (this.m.IsResizable)
        {
            this.m.Items.remove(this.getItemByInstanceID(_item.getInstanceID()).index);
        }
        this.m.Items["this.getItemByInstanceID(_item.getInstanceID()).index"].onRemovedFromStash(this.m.ID);
        return _item.getInstanceID();
    }
    return _item.getInstanceID();
}

function removeByID(this, _id)
{
    if (0 < this.m.Items.len())
    {
        if ((this.m.Items[0] == _id) && (this.m.Items[0] == _id))
        {
            return ((this.m.Items[0] == _id) && (this.m.Items[0] == _id));
            this.m.Items["0"] = null;
            if (this.m.IsResizable)
            {
                this.m.Items.remove(0);
            }
            this.m.Items["0"].onRemovedFromStash(this.m.ID);
            return _id;
        }
    }
    return _id;
}

function removeByIndex(this, _index)
{
    if ((this.getItemAtIndex(_index).item != null) && (this.getItemAtIndex(_index).item != null))
    {
        return ((this.getItemAtIndex(_index).item != null) && (this.getItemAtIndex(_index).item != null));
        this.m.Items["this.getItemAtIndex(_index).index"] = null;
        if (this.m.IsResizable)
        {
            this.m.Items.remove(this.getItemAtIndex(_index).index);
        }
        this.getItemAtIndex(_index).item.onRemovedFromStash(this.m.ID);
        return _index;
    }
    return _index;
}

function resize(this, _size)
{
    this.m.Items.resize(_size);
    this.m.Capacity = _size;
    return;
}

function setID(this, _id)
{
    this.m.ID = _id;
    return;
}

function setLocked(this, _value)
{
    this.m.IsLocked = _value;
    return;
}

function setResizable(this, _value)
{
    this.m.IsResizable = _value;
    return;
}

function shrink(this)
{
    if (!this.m.IsResizable)
    {
        return;
    }
    if (0 < this.m.Items.len())
    {
        if (this.m.Items["0"] != null)
        {
            [].push(this.m.Items["0"]);
        }
    }
    this.m.Items = [];
    return;
}

function sort(this)
{
    this.m.Items.sort(this.onItemCompare);
    return;
}

function swap(this, _sourceIndex, _targetIndex)
{
    if (_sourceIndex == _targetIndex)
    {
        return _sourceIndex;
    }
    if (this && this)
    {
        return (this && this);
        this.m.Items["_sourceIndex"] = this.m.Items["_targetIndex"];
        this.m.Items["_targetIndex"] = this.m.Items["_sourceIndex"];
        return _sourceIndex;
    }
    return _sourceIndex;
}
