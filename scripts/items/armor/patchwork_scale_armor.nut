// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/patchwork_scale_armor.nut
// Functions: 1

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.patchwork_scale_armor";
    this.m.Name = "Patchwork Scale Armor";
    this.m.Description = "This rusted scale vest was assembled from bits and pieces of other suits of armor, yet the result is less than the sum of its parts.";
    this.m.SlotType = this.Const.ItemSlot.Body;
    this.m.IsDroppedAsLoot = true;
    this.m.ShowOnCharacter = true;
    this.m.Variant = 117;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 2000;
    this.m.Condition = 220;
    this.m.ConditionMax = 220;
    this.m.StaminaModifier = -29;
    return;
}
