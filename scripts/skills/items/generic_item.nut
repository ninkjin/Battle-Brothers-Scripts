// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/items/generic_item.nut
// Functions: 3

function create(this)
{
    this.m.ID = "items.generic";
    this.m.Name = this.Const.Items.Default.GenericItemName;
    this.m.Description = "?!";
    this.m.Icon = this.Const.Items.Default.GenericItemIcon;
    this.m.Type = this.Const.SkillType.Item;
    this.m.Order = this.Const.SkillOrder.Item;
    this.m.IsActive = false;
    this.m.IsHidden = true;
    this.m.IsStacking = true;
    this.m.IsSerialized = false;
    this.m.IsRemovedAfterBattle = false;
    return;
}

function onTurnStart(this)
{
    if ((this.m.Item != null) && (this.m.Item != null))
    {
        return ((this.m.Item != null) && (this.m.Item != null));
        this.m.Item.onTurnStart();
    }
    this.removeSelf();
    return;
}

function onUpdate(this, _properties)
{
    if ((this.m.Item != null) && (this.m.Item != null))
    {
        return ((this.m.Item != null) && (this.m.Item != null));
        this.m.Item.onUpdateProperties(_properties);
    }
    this.removeSelf();
    return;
}
