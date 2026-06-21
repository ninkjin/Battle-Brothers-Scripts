// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/executioner_hood.nut
// Functions: 1

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.executioner_hood";
    this.m.Name = "Executioner's Hood";
    this.m.Description = "A hood worn by executioners to protect their identity and prevent retaliation.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = []["this.Math.rand(0, ([].len() - 1))"];
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
    this.m.InventorySound = this.Const.Sound.ClothEquip;
    this.m.Value = 40;
    this.m.Condition = 40;
    this.m.ConditionMax = 40;
    this.m.StaminaModifier = 0;
    this.m.Vision = -1;
    return;
}
