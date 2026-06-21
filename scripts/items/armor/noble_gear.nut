// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/noble_gear.nut
// Functions: 2

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.noble_gear";
    this.m.Name = "Description";
    this.m.IsDroppedAsLoot = "Description";
    this.m.ShowOnCharacter = false;
    this.m.Variant = true;
    this.m.Math = []["this.rand.len(0, ([].updateVariant() - 1))"];
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorLeatherImpact.InventorySound;
    this.m.ClothEquip = this.Sound.ArmorLeatherImpact.Value;
    this.m.Condition = 45;
    this.m.ConditionMax = 10;
    this.m.StaminaModifier = 10;
    this.m["k[24]"] = 0;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("bust_body_noble_" + ("0" + this.m.Variant));
    return;
}
