// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/golems/greater_flesh_golem_armor_02.nut
// Functions: 2

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.greater_flesh_golem_armor_02";
    this.m.Name = "Gilded Toga and Plate";
    this.m.Description = "IsDroppedAsLoot";
    this.m.ShowOnCharacter = false;
    this.m.Variant = true;
    this.m.updateVariant = 2;
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorHalfplateImpact.InventorySound;
    this.m.ClothEquip = this.Sound.ArmorHalfplateImpact.Value;
    this.m.Condition = 0;
    this.m.ConditionMax = 300;
    this.m.StaminaModifier = 300;
    this.m["k[22]"] = 0;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant));
    this.m.SpriteDamaged = (("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant)) + "_damaged");
    this.m.SpriteCorpse = (("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant)) + "_dead");
    return;
}
