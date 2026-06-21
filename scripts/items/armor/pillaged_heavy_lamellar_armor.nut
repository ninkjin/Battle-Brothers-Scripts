// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/pillaged_heavy_lamellar_armor.nut
// Functions: 1

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.pillaged_heavy_lamellar_armor";
    this.m.Name = "Pillaged Heavy Lamellar Armor";
    this.m.Description = "A heavy suit of lamellar worn over a mail shirt, surely taken from someone more well off than its current owner. Blood and sweat have turned it brown and rusted.";
    this.m.SlotType = this.Const.ItemSlot.Body;
    this.m.IsDroppedAsLoot = true;
    this.m.ShowOnCharacter = true;
    this.m.Variant = 118;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 2750;
    this.m.Condition = 255;
    this.m.ConditionMax = 255;
    this.m.StaminaModifier = -42;
    return;
}
