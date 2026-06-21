// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/golems/fault_finder_eye_mask.nut
// Functions: 1

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.fault_finder_eye_mask";
    this.m.Name = "Occult Eye Mask";
    this.m.Description = "A crude mask bearing an occult symbol that covers the face.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = false;
    this.m.HideBeard = true;
    this.m.ReplaceSprite = true;
    this.m.Variant = 245;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
    this.m.InventorySound = this.Const.Sound.ClothEquip;
    this.m.Value = 0;
    this.m.Condition = 30;
    this.m.ConditionMax = 30;
    this.m.StaminaModifier = 0;
    this.m.Vision = -3;
    return;
}
