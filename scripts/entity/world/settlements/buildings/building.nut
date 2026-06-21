// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/settlements/buildings/building.nut
// Functions: 28

function <anonymous>(this)
{
    this.World.State.getTownScreen().showMainDialog();
    return;
}

function <anonymous>(this)
{
    return (!this.World.State.getTownScreen().isAnimating());
}

function create(this)
{
    return;
}

function fillStash(this, _list, _stash, _priceMult, _allowDamagedEquipment)
{
    _stash.clear();
    foreach (local key, value in r188)
    {
        while (r16)
        {
            if (true)
            {
                if ((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) >= null.R)
                {
                    if (this.new(("scripts/items/" + null.S).getID() == "misc.copper_ingots"))
                    {
                        if (this.new(("scripts/items/" + null.S).getID() == "misc.copper_ingots"))
                        {
                            if ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().FoodRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().FoodRarityMult) >= null.R))
                            {
                                return ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().FoodRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().FoodRarityMult) >= null.R));
                                if ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MedicalRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MedicalRarityMult) >= null.R))
                                {
                                    return ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MedicalRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MedicalRarityMult) >= null.R));
                                    if ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MineralRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MineralRarityMult) >= null.R))
                                    {
                                        return ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MineralRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().MineralRarityMult) >= null.R));
                                        if ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().BuildingRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().BuildingRarityMult) >= null.R))
                                        {
                                            return ((((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().BuildingRarityMult) >= null.R) && (((this.Math.rand(0, 100) * this.getSettlement().getModifiers().RarityMult) * this.getSettlement().getModifiers().BuildingRarityMult) >= null.R));
                                            _stash.add(this.new(("scripts/items/" + null.S)));
                                        }
                                    }
                                }
                            }
                            if ((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0))
                            {
                                return ((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0) || (this.getSettlement().getModifiers().BuildingRarityMult < 1.0));
                            }
                            if (((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) > 1) && ((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) > 1))
                            {
                                return (((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) > 1) && ((this.getSettlement().getModifiers().BuildingRarityMult < 1.0) > 1));
                                if (this.Math.rand(1, 100) <= 50)
                                {
                                    this.new(("scripts/items/" + null.S)).setCondition((this.Math.rand((this.new(("scripts/items/" + null.S)).getConditionMax() * 0.4000000059604645), this.new(("scripts/items/" + null.S)).getConditionMax()) * 1.0));
                                }
                            }
                            this.new(("scripts/items/" + null.S)).setPriceMult((null.P * _priceMult));
                            if ((this.new(("scripts/items/" + null.S).getID() == "misc.copper_ingots") && (this.new(("scripts/items/" + null.S)).getID() == "misc.copper_ingots")))
                            {
                                return ((this.new(("scripts/items/" + null.S)).getID() == "misc.copper_ingots") && (this.new(("scripts/items/" + null.S)).getID() == "misc.copper_ingots"));
                            }
                            _stash.sort();
                            this.onAfterFillStash(_stash);
                            return;
                        }
                    }
                }
            }
        }
    }
}

function getAllowDamaged(this)
{
    return false;
}

function getDefaultShopList(this)
{
    return [];
}

function getDescription(this)
{
    return this.m.Description;
}

function getID(this)
{
    return this.m.ID;
}

function getName(this)
{
    return this.m.Name;
}

function getPriceMult(this)
{
    return 1.0;
}

function getSettlement(this)
{
    return this.m.Settlement;
}

function getSounds(this)
{
    if (this.World.getTime().IsDaytime)
    {
    }
    return this.m.SoundsAtNight;
}

function getStash(this)
{
    return null;
}

function getTooltip(this)
{
    if ((!this.m.IsClosedAtNight) && (!this.m.IsClosedAtNight))
    {
        return ((!this.m.IsClosedAtNight) && (!this.m.IsClosedAtNight));
    }
    return null;
}

function getTooltipIcon(this)
{
    return this.m.TooltipIcon;
}

function getUIImage(this)
{
    if (this.World.getTime().IsDaytime)
    {
    }
    return this.m.UIImageNight;
}

function isClosedAtNight(this)
{
    return this.m.IsClosedAtNight;
}

function isHidden(this)
{
    return false;
}

function isRepairOffered(this)
{
    return this.m.IsRepairOffered;
}

function onAfterFillStash(this, _stash)
{
    foreach (local key, value in r18)
    {
        if (null.getID() == "armor.head.greatsword_faction_helm")
        {
            null.setVariant(this.getSettlement().getOwner().getBanner());
        }
        return;
    }
}

function onClicked(this)
{
    return;
}

function onDeserialize(this, _in)
{
    return;
}

function onSerialize(this, _out)
{
    return;
}

function onSettlementEntered(this)
{
    return;
}

function onUpdateDraftList(this, _list)
{
    return;
}

function onUpdateShopList(this, _list)
{
    clone this.extend(this.getDefaultShopList());
    return _list;
}

function pushUIMenuStack(this)
{
    this.World.State.getMenuStack().push(function() /* closure #0 */, function() /* closure #1 */);
    return;
}

function setSettlement(this, _s)
{
    this.m.Settlement = this.WeakTableRef(_s);
    return;
}
