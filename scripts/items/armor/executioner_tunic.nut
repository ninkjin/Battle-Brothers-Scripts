// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/executioner_tunic.nut
// Functions: 1

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.executioner_tunic";
    this.m.Name = "Headsman's Vest";
    this.m.Description = "A rugged vest worn by executioners, caked and crusted with blood.";
    this.m.IsDroppedAsLoot = true;
    this.m.ShowOnCharacter = true;
    this.m.Variant = 128;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
    this.m.InventorySound = this.Const.Sound.ClothEquip;
    this.m.Value = 55;
    this.m.Condition = 25;
    this.m.ConditionMax = 25;
    this.m.StaminaModifier = 0;
    return;
}
