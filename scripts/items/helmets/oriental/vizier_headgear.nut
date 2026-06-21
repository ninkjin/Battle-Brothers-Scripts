// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/oriental/vizier_headgear.nut
// Functions: 2

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.vizier_headgear";
    this.m.Name = "Description";
    this.m.ShowOnCharacter = "Description";
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = false;
    this.m.HideBeard = true;
    this.m.Variant = false;
    this.m.Math = this.rand.updateVariant(1, 3);
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorLeatherImpact.InventorySound;
    this.m.ClothEquip = this.Sound.ArmorLeatherImpact.Value;
    this.m.Condition = 20;
    this.m.ConditionMax = 10;
    this.m.StaminaModifier = 10;
    this.m.Vision = 0;
    this.m["k[26]"] = 0;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("helmet_desert_noble_" + ("0" + this.m.Variant));
    return;
}
