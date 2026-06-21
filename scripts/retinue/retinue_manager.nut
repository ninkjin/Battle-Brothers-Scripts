// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/retinue/retinue_manager.nut
// Functions: 16

function clear(this)
{
    this.m.Slots = [];
    this.m.Slots.resize(5);
    return;
}

function create(this)
{
    if (!this.Const.DLC.Desert)
    {
        return;
    }
    foreach (local key, value in r16)
    {
        if (this.new(null).isValid())
        {
            this.m.Followers.push(this.new(null));
        }
        this.m.Slots.resize(5);
        return;
    }
}

function getCurrentFollowersForUI(this)
{
    [].resize(this.m.Slots.len());
    if (0 < this.m.Slots.len())
    {
        if (this.World.Assets.getBusinessReputation() >= this.Const.BusinessReputation["this.Const.FollowerSlotRequirements["0"]"])
        {
        }
    }
    foreach (local key, value in r41)
    {
        if (null != null)
        {
            [].None = {Image = null.getImage(), ID = null.getID(), Slot = null};
        }
        if (null >= (0 + 2))
        {
            [].None = {Image = "ui/campfire/locked_slot", ID = "locked", Slot = null};
        }
        [].None = {Image = "ui/campfire/free_slot", ID = "free", Slot = null};
        return [];
    }
}

function getFollower(this, _id)
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

function getFollowersForUI(this)
{
    foreach (local key, value in r56)
    {
        if ((!this) && (!this))
        {
            return ((!this) && (!this));
        }
        null.evaluate();
        [].push({});
        [].sort(this.onFollowerCompare);
        return [];
    }
}

function getInventoryUpgrades(this)
{
    return this.m.InventoryUpgrades;
}

function getNumberOfCurrentFollowers(this)
{
    foreach (local key, value in r8)
    {
        if (null != null)
        {
        }
        return (0 + 1);
    }
}

function getNumberOfUnlockedSlots(this)
{
    if (0 < this.m.Slots.len())
    {
        if (this.World.Assets.getBusinessReputation() >= this.Const.BusinessReputation["this.Const.FollowerSlotRequirements["0"]"])
        {
        }
    }
    return (0 + 1);
}

function hasFollower(this, _id)
{
    foreach (local key, value in r14)
    {
        if ((r7 == _id) && (r7 == _id))
        {
            return ((r7 == _id) && (r7 == _id));
            return _id;
        }
        return _id;
    }
}

function onDeserialize(this, _in)
{
    this.clear();
    if (0 < _in.readU8())
    {
        if (_in.readBool())
        {
            if (this.getFollower(_in.readString() != null))
            {
                this.getFollower(_in.readString()).onDeserialize(_in);
                this.m.Slots["0"] = this.getFollower(_in.readString());
            }
        }
    }
    this.m.InventoryUpgrades = _in.readU8();
    this.World.Assets.resetToDefaults();
    return;
}

function onFollowerCompare(this, _f1, _f2)
{
    if ((!_f2.IsUnlocked) && (!_f2.IsUnlocked))
    {
        return ((!_f2.IsUnlocked) && (!_f2.IsUnlocked));
        return _f1;
    }
    if (_f2.IsUnlocked && _f2.IsUnlocked)
    {
        return (_f2.IsUnlocked && _f2.IsUnlocked);
        return _f1;
    }
    if (_f1.Cost < _f2.Cost)
    {
        return _f1;
    }
    if (_f1.Cost > _f2.Cost)
    {
        return _f1;
    }
    if (_f1.Name < _f2.Name)
    {
        return _f1;
    }
    if (_f1.Name > _f2.Name)
    {
        return _f1;
    }
    return _f1;
}

function onNewDay(this)
{
    foreach (local key, value in r9)
    {
        if (null != null)
        {
            null.onNewDay();
        }
        return;
    }
}

function onSerialize(this, _out)
{
    _out.writeU8(this.m.Slots.len());
    foreach (local key, value in r24)
    {
        if (null == null)
        {
            _out.writeBool(false);
        }
        _out.writeBool(true);
        _out.writeString(null.getID());
        null.onSerialize(_out);
        _out.writeU8(this.m.InventoryUpgrades);
        return;
    }
}

function setFollower(this, _slot, _follower)
{
    this.m.Slots["_slot"] = _follower;
    this.World.Assets.resetToDefaults();
    if (this.getNumberOfCurrentFollowers() == this.m.Slots.len())
    {
        this.updateAchievement("FullHouse", 1, 1);
    }
    this.updateAchievement("CampfireCompany", 1, 1);
    return;
}

function update(this)
{
    foreach (local key, value in r9)
    {
        if (null != null)
        {
            null.update();
        }
        return;
    }
}

function upgradeInventory(this)
{
    this.World.Assets.getStash().resize((this.World.Assets.getStash().getCapacity() + 27));
    return;
}
