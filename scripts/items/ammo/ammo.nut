// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/ammo/ammo.nut
// Functions: 16

function consumeAmmo(this)
{
    if (this.getContainer().getActor().isPlayerControlled())
    {
        this.Tactical.Entities.spendAmmo(this.m.AmmoCost);
    }
    return;
}

function create(this)
{
    this.item.create();
    this.m.SlotType = this.Const.ItemSlot.Ammo;
    return;
}

function getAmmo(this)
{
    return this.m.Ammo;
}

function getAmmoCost(this)
{
    return this.m.AmmoCost;
}

function getAmmoMax(this)
{
    return this.m.AmmoMax;
}

function getAmmoType(this)
{
    return this.m.AmmoType;
}

function getAmountString(this)
{
    return ((this.m.Ammo + "/") + this.m.AmmoMax);
}

function getIcon(this)
{
    if (this.m.Ammo > 0)
    {
        return this.m.Icon;
    }
    return this.m.IconEmpty;
}

function isAmountShown(this)
{
    return true;
}

function isDroppedAsLoot(this)
{
    return;
}

function onDeserialize(this, _in)
{
    this.item.onDeserialize(_in);
    this.m.Ammo = _in.readU16();
    return;
}

function onEquip(this)
{
    this.item.onEquip();
    if (this.m.ShowOnCharacter)
    {
        this.getContainer().getAppearance().ShowQuiver = this.m.ShowQuiver;
        if (this.m.ShowQuiver)
        {
            this.getContainer().getAppearance().Quiver = this.m.Sprite;
        }
        this.getContainer().updateAppearance();
    }
    if (!this.getContainer().getActor().isPlayerControlled())
    {
        this.m.Ammo = this.Math.rand(1, this.Math.max(1, (this.m.AmmoMax - 1)));
    }
    return;
}

function onSerialize(this, _out)
{
    this.item.onSerialize(_out);
    _out.writeU16(this.m.Ammo);
    return;
}

function onUnequip(this)
{
    this.item.onUnequip();
    if (this.m.ShowOnCharacter)
    {
        this.getContainer().getAppearance().ShowQuiver = false;
        this.getContainer().updateAppearance();
    }
    return;
}

function playInventorySound(this, _eventType)
{
    this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
    return;
}

function setAmmo(this, _a)
{
    this.m.Ammo = _a;
    return;
}
