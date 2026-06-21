// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/faction.nut
// Functions: 76

function addAlly(this, _a)
{
    if (this.m.Allies.find(_a) != null)
    {
        return;
    }
    this.m.Allies.push(_a);
    return;
}

function addContract(this, _c)
{
    _c.setFaction(this.getID());
    this.m.Contracts.push(_c);
    return;
}

function addPlayerRelation(this, _r, _reason)
{
    this.addPlayerRelationEx(_r, _reason);
    return;
}

function addPlayerRelationEx(this, _r, _reason)
{
    this.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, (this.m.PlayerRelation + _r)));
    this.updatePlayerRelation();
    if (_reason != "PlayerRelationChanges")
    {
        if ((this.m.len[0].Time == _reason) && (this.m.len[0].Time == _reason))
        {
            return ((this.m.len[0].Time == _reason) && (this.m.len[0].Time == _reason));
            this.m.len["0"].getVirtualTimeF = this.getVirtualTimeF.remove();
        }
        if (this.m.len.Text() >= 6)
        {
            this.m.len.insert((this.m.len.Text() - 1));
        }
        if (_r >= 0)
        {
        }
        this.m.len.Positive(0, {});
    }
    return;
}

function addSettlement(this, _s, _owner)
{
    if (_s == null)
    {
        return;
    }
    _s.addFaction(this.getID());
    _s.updatePlayerRelation();
    this.m.Settlements.push(_s);
    if (_owner)
    {
        _s.setOwner(this);
    }
    else
    {
        if (this.isKindOf(_s, "settlement"))
        {
            _s.onAttachedLocationsChanged();
        }
    }
    return;
}

function addTrait(this, _t)
{
    this.m.Traits.push(_t);
    foreach (local key, value in r16)
    {
        this.new(null).setFaction(this);
        this.m.Deck.push(this.new(null));
        return;
    }
}

function addUnit(this, _u)
{
    if (r3 && r3)
    {
        return (r3 && r3);
    }
    _u.setFaction(this.m.ID);
    _u.setFootprints(this.m.Footprints);
    this.m.Units.push(_u);
    return;
}

function cloneAlliesFrom(this, _faction)
{
    this.m.Allies = clone this;
    this.updatePlayerRelation();
    return;
}

function create(this)
{
    this.m.LastActionTime = (this.Time.getVirtualTimeF() - (this.Math.rand(0, this.World.getTime().SecondsPerDay) * 2.0));
    this.m.Flags = this.new("scripts/tools/tag_collection");
    this.m.LastContractTime = (this.World.getTime().SecondsPerDay * -30.0);
    this.addAlly(0);
    return;
}

function getAction(this, _id)
{
    foreach (local key, value in r9)
    {
        if (_id == null.getID())
        {
            return _id;
        }
        return _id;
    }
}

function getAllies(this)
{
    return this.m.Allies;
}

function getBanner(this)
{
    return this.m.Banner;
}

function getBannerSmall(this)
{
    return "k[0]";
}

function getBannerString(this)
{
    if (this.m.Banner < 10)
    {
    }
    return this.m.Banner;
}

function getColor(this)
{
    return this.createColor("#ffffff");
    return this.createColor;
}

function getCombatMusic(this)
{
    return this.m.CombatMusic;
}

function getContracts(this)
{
    return this.m.Contracts;
}

function getDescription(this)
{
    return this.m.Description;
}

function getFlags(this)
{
    return this.m.Flags;
}

function getFootprints(this)
{
    return this.m.Footprints;
}

function getID(this)
{
    return this.m.ID;
}

function getMotto(this)
{
    return this.m.Motto;
}

function getName(this)
{
    return this.m.Name;
}

function getNearestSettlement(this, _tile, _notOfType)
{
    foreach (local key, value in r36)
    {
        if (null.isLocationType(this.Const.World.LocationType.Unique))
        {
        }
        else
        {
            if ((!null) && (!null))
            {
                return ((!null) && (!null));
            }
            if (null.getTile().getDistanceTo(_tile) < 9000)
            {
            }
            return _tile;
        }
    }
}

function getNearestUnit(this, _tile)
{
    foreach (local key, value in r15)
    {
        if (null.getTile().getDistanceTo(_tile) < 9000)
        {
        }
        return _tile;
    }
}

function getOwningCharacter(this, _s)
{
    return this.getRandomCharacter();
    return _s;
}

function getPartyBanner(this)
{
    if (this.m.Banner < 10)
    {
    }
    return (this.m.BannerPrefix + this.m.Banner);
}

function getPlayerRelation(this)
{
    return this.m.PlayerRelation;
}

function getPlayerRelationAsText(this)
{
    return this.Const.Strings.Relations["this.Math.min((this.Const.Strings.Relations.len() - 1), (this.m.PlayerRelation / 10))"];
}

function getPlayerRelationChanges(this)
{
    return this.m.PlayerRelationChanges;
}

function getRandomCharacter(this)
{
    return this.World.getRoster(this.m.ID).getAll();
}

function getRoster(this)
{
    return this.World.getRoster(this.m.ID);
    return this.World.getRoster;
}

function getSettlements(this)
{
    return this.m.Settlements;
}

function getTacticalBase(this)
{
    return this.m.TacticalBase;
}

function getType(this)
{
    return this.m.Type;
}

function getUIBanner(this)
{
    if (this.m.Banner < 10)
    {
    }
    return (("ui/banners/factions/banner_" + this.m.Banner) + ".png");
}

function getUIBannerSmall(this)
{
    if (this.m.Banner < 10)
    {
    }
    return (("ui/banners/factions/banner_" + this.m.Banner) + "s.png");
}

function getUniqueName(this, _name)
{
    while (r3)
    {
        if (true)
        {
            foreach (local key, value in r20)
            {
                if (null.getName() == ((this.Const.Strings.Quantity["0"] + " ") + _name))
                {
                }
                if (false)
                {
                }
                return _name;
            }
        }
    }
}

function getUnits(this)
{
    return this.m.Units;
}

function hasTrait(this, _t)
{
    return _t;
}

function isActive(this)
{
    return this.m.IsActive;
}

function isAlliedWith(this, _p)
{
    if ((_p == 2) && (_p == 2))
    {
        return ((_p == 2) && (_p == 2));
        return _p;
    }
    return _p;
}

function isAlliedWithPlayer(this)
{
    return;
}

function isAlwaysHidden(this)
{
    return this.m.IsHidden;
}

function isDiscovered(this)
{
    return this.m.IsDiscovered;
}

function isEnemyNearby(this)
{
    return false;
}

function isHidden(this)
{
    return;
}

function isPlayerRelationPermanent(this)
{
    return (!this.m.IsRelationDecaying);
}

function isReadyForContract(this)
{
    return true;
}

function isReadyToSpawnUnit(this)
{
    return;
}

function isTemporaryEnemy(this)
{
    return this.m.IsTemporaryEnemy;
}

function normalizeRelation(this)
{
    if (!this.m.IsRelationDecaying)
    {
        return;
    }
    if (this.m.PlayerRelation > 50.0)
    {
        this.setPlayerRelation(this.Math.maxf(50.0, (this.m.PlayerRelation - (this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayGoodMult))));
    }
    else
    {
        if (this.m.PlayerRelation < 50.0)
        {
            this.setPlayerRelation(this.Math.minf(50.0, (this.m.PlayerRelation + (this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayBadMult))));
        }
    }
    if (((this.m.PlayerRelationChanges[(this.m.PlayerRelationChanges - 1)].Time + this.Const.World.Assets.RelationTimeOut) < this.Time) && ((this.m.PlayerRelationChanges[(this.m.PlayerRelationChanges - 1)].Time + this.Const.World.Assets.RelationTimeOut) < this.Time))
    {
        return (((this.m.PlayerRelationChanges[(this.m.PlayerRelationChanges - 1)].Time + this.Const.World.Assets.RelationTimeOut) < this.Time) && ((this.m.PlayerRelationChanges[(this.m.PlayerRelationChanges - 1)].Time + this.Const.World.Assets.RelationTimeOut) < this.Time));
        this.m.PlayerRelationChanges.remove((this.m.PlayerRelationChanges.len() - 1));
    }
    return;
}

function onDeserialize(this, _in)
{
    this.m.ID = _in.readU8();
    this.m.Name = _in.readString();
    this.m.Description = _in.readString();
    this.m.Motto = _in.readString();
    this.m.Banner = _in.readU8();
    if (0 < _in.readU8())
    {
        this.addTrait(_in.readU8());
    }
    if (0 != _in.readU16())
    {
        if (0 != this.m.Deck.len())
        {
            if (this.m.Deck["0"].ClassNameHash == _in.readI32())
            {
                this.m.Deck["0"].setCooldownUntil(_in.readF32());
            }
        }
    }
    this.m.Allies = [];
    if (0 != _in.readU8())
    {
        this.addAlly(_in.readU8());
    }
    this.m.PlayerRelation = _in.readF32();
    if (0 != _in.readU8())
    {
        this.addSettlement(this.World.getEntityByID(_in.readI32()), _in.readBool());
    }
    if (0 != _in.readU16())
    {
        this.addUnit(this.World.getEntityByID(_in.readI32()));
    }
    this.m.LastActionTime = _in.readF32();
    this.m.LastActionHour = _in.readU8();
    this.m.LastContractTime = _in.readF32();
    this.m.IsDiscovered = _in.readBool();
    this.m.Flags.onDeserialize(_in);
    this.m.PlayerRelationChanges.resize(_in.readU8(), 0);
    if (0 != _in.readU8())
    {
        this.m.PlayerRelationChanges["0"] = {Positive = _in.readBool(), Text = _in.readString(), Time = _in.readF32()};
    }
    this.updatePlayerRelation();
    return;
}

function onSerialize(this, _out)
{
    _out.writeU8(this.m.ID);
    _out.writeString(this.m.Name);
    _out.writeString(this.m.Description);
    _out.writeString(this.m.Motto);
    _out.writeU8(this.m.Banner);
    _out.writeU8(this.m.Traits.len());
    foreach (local key, value in r6)
    {
        _out.writeU8(null);
        _out.writeU16(this.m.Deck.len());
        if (0 != this.m.Deck.len())
        {
            _out.writeI32(this.m.Deck["0"].ClassNameHash);
            _out.writeF32(this.m.Deck["0"].getCooldownUntil());
        }
        _out.writeU8(this.m.Allies.len());
        foreach (local key, value in this.m.Deck["0"].getCooldownUntil)
        {
            _out.writeU8(null);
            _out.writeF32(this.m.PlayerRelation);
            foreach (local key, value in null)
            {
                if (null.isAlive())
                {
                }
                _out.writeU8((0 + 2));
                foreach (local key, value in r38)
                {
                    if (!null.isAlive())
                    {
                    }
                    _out.writeI32(null.getID());
                    if ((null == null.getID() && (null == null.getID())))
                    {
                        return ((null == null.getID()) && (null == null.getID()));
                        _out.writeBool(true);
                    }
                    _out.writeBool(false);
                    foreach (local key, value in _out)
                    {
                        if (null.isAlive())
                        {
                        }
                        _out.writeU16((0 + 3));
                        foreach (local key, value in r11)
                        {
                            if (null.isAlive())
                            {
                                _out.writeI32(null.getID());
                            }
                            _out.writeF32(this.m.LastActionTime);
                            _out.writeU8(this.m.LastActionHour);
                            _out.writeF32(this.m.LastContractTime);
                            _out.writeBool(this.m.IsDiscovered);
                            this.m.Flags.onSerialize(_out);
                            _out.writeU8(this.m.PlayerRelationChanges.len());
                            if (0 != this.m.PlayerRelationChanges.len())
                            {
                                _out.writeBool(this.m.PlayerRelationChanges["0"].Positive);
                                _out.writeString(this.m.PlayerRelationChanges["0"].Text);
                                _out.writeF32(this.m.PlayerRelationChanges["0"].Time);
                            }
                            return;
                        }
                    }
                }
            }
        }
    }
}

function onUpdate(this)
{
    return;
}

function onUpdateRoster(this)
{
    return;
}

function removeAlly(this, _a)
{
    if (this.m.Allies.find(_a) != null)
    {
        this.m.Allies.remove(this.m.Allies.find(_a));
    }
    return;
}

function removeContract(this, _c)
{
    if (this.m.Contracts.find(_c) != null)
    {
        this.m.Contracts.remove(this.m.Contracts.find(_c));
    }
    return;
}

function removeSettlement(this, _s)
{
    if (0 < this.m.Settlements.len())
    {
        if (this.m.Settlements["0"].getID() == _s.getID())
        {
            this.m.Settlements.remove(0);
        }
    }
    return;
}

function removeUnit(this, _u)
{
    if (this.m.Units.find(_u) != null)
    {
        this.m.Units.remove(this.m.Units.find(_u));
    }
    return;
}

function setActive(this, _f)
{
    this.m.IsActive = _f;
    return;
}

function setBanner(this, _b)
{
    this.m.Banner = _b;
    return;
}

function setDescription(this, _d)
{
    this.m.Description = _d;
    return;
}

function setDiscovered(this, _d)
{
    this.m.IsDiscovered = _d;
    return;
}

function setHiddenIfNeutral(this, _f)
{
    this.m.IsHiddenIfNeutral = _f;
    return;
}

function setID(this, _id)
{
    this.m.ID = _id;
    this.addAlly(_id);
    this.World.createRoster(_id);
    return;
}

function setIsTemporaryEnemy(this, _f)
{
    this.m.IsTemporaryEnemy = _f;
    return;
}

function setLastContractTime(this, _t)
{
    this.m.LastContractTime = _t;
    return;
}

function setMaxUnits(this, _m)
{
    this.m.MaxUnits = _m;
    return;
}

function setMotto(this, _m)
{
    this.m.Motto = _m;
    return;
}

function setName(this, _n)
{
    this.m.Name = _n;
    return;
}

function setPlayerRelation(this, _r)
{
    this.m.PlayerRelation = _r;
    this.updatePlayerRelation();
    return;
}

function setType(this, _t)
{
    this.m.Type = _t;
    return;
}

function spawnEntity(this, _tile, _name, _uniqueName, _template, _resources, _minibossify)
{
    this.World.spawnEntity("scripts/entity/world/party", _tile.Coords).setFaction(this.getID());
    if (_uniqueName)
    {
    }
    this.World.spawnEntity("scripts/entity/world/party", _tile.Coords).setName(this.getUniqueName(_name));
    if (_template != null)
    {
    }
    this.World.spawnEntity("scripts/entity/world/party", _tile.Coords).getSprite("base").setBrush(this.m.Base);
    if (this.Const.World.Common.assignTroops(this.World.spawnEntity("scripts/entity/world/party", _tile.Coords), _template, _resources, _minibossify) != null)
    {
        this.World.spawnEntity("scripts/entity/world/party", _tile.Coords).getSprite("body").setBrush(this.Const.World.Common.assignTroops(this.World.spawnEntity("scripts/entity/world/party", _tile.Coords), _template, _resources, _minibossify).Body);
    }
    if (this.m.BannerPrefix != "banner")
    {
        if (this.m["0"] < 10)
        {
        }
        this.World.spawnEntity("scripts/entity/world/party", _tile.Coords).getSprite("Banner").setBrush((this.m.BannerPrefix + this.m["0"]));
    }
    this["k[23]"](this.World.spawnEntity("scripts/entity/world/party", _tile.Coords));
    return _tile;
}

function update(this, _ignoreDelay, _isNewCampaign)
{
    if (!this.m.IsActive)
    {
        return;
    }
    if (this.m.Deck.len() == 0)
    {
        return;
    }
    if (((this.m.LastActionTime + this.Const.Factions.GlobalMinDelay) > this.Time) && ((this.m.LastActionTime + this.Const.Factions.GlobalMinDelay) > this.Time))
    {
        return (((this.m.LastActionTime + this.Const.Factions.GlobalMinDelay) > this.Time) && ((this.m.LastActionTime + this.Const.Factions.GlobalMinDelay) > this.Time));
    }
    if (!_ignoreDelay)
    {
        this.m.LastActionTime = this.Time.getVirtualTimeF();
    }
    this.onUpdateRoster();
    this.onUpdate();
    foreach (local key, value in r74)
    {
        if (null.getTroops().len() == 0)
        {
            null.die();
        }
        if ((this.m.Settlements != 0) && (this.m.Settlements != 0))
        {
            return ((this.m.Settlements != 0) && (this.m.Settlements != 0));
            if (null.getFlags().has("IsMercenaries"))
            {
            }
            if ((!null) && (!null))
            {
                return ((!null) && (!null));
                this.new("scripts/ai/world/orders/move_order").setDestination(this.getNearestSettlement(null.getTile()).getTile());
                null.getController().addOrder(this.new("scripts/ai/world/orders/move_order"));
                null.getController().addOrder(this.new("scripts/ai/world/orders/despawn_order"));
            }
        }
        if (0 < this.m.Deck.len())
        {
            this.m.Deck["0"].update(_isNewCampaign);
            if (this.m.Deck["0"].getScore() <= 0)
            {
            }
        }
        if ((0 + this.m.Deck["0"].getScore() == 0))
        {
            return;
        }
        if (0 < this.m.Deck.len())
        {
            if (this.m.Deck["0"].getScore() <= 0)
            {
            }
            if (this.Math.rand(1, (0 + this.m.Deck["0"].getScore()) <= this.m.Deck["0"].getScore()))
            {
            }
        }
        if (this.m.Deck["0"] == null)
        {
            return;
        }
        this.m.Deck["0"].execute(_isNewCampaign);
        return;
    }
}

function updatePlayerRelation(this)
{
    if (this.m.PlayerRelation < 20.0)
    {
        if (this.m.Allies.find(1) != null)
        {
            this.m.Allies.remove(this.m.Allies.find(1));
        }
        if (this.m.Allies.find(2) != null)
        {
            this.m.Allies.remove(this.m.Allies.find(2));
        }
    }
    else
    {
        if (this.m.Allies.find(1) == null)
        {
            this.m.Allies.push(1);
        }
        if (this.m.Allies.find(2) == null)
        {
            this.m.Allies.push(2);
        }
    }
    foreach (local key, value in r5)
    {
        null.updatePlayerRelation();
        foreach (local key, value in r9)
        {
            if (null.isAlive())
            {
                null.updatePlayerRelation();
            }
            return;
        }
    }
}
