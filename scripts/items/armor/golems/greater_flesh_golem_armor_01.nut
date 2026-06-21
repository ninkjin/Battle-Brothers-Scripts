// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/golems/greater_flesh_golem_armor_01.nut
// Functions: 2

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.greater_flesh_golem_armor_01";
    this.m.Name = "Silk Toga";
    this.m.Description = "IsDroppedAsLoot";
    this.m.ShowOnCharacter = false;
    this.m.Variant = true;
    this.m.updateVariant = 1;
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorLeatherImpact.InventorySound;
    this.m.ClothEquip = this.Sound.ArmorLeatherImpact.Value;
    this.m.Condition = 0;
    this.m.ConditionMax = 80;
    this.m.StaminaModifier = 80;
    this.m["k[22]"] = 0;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant));
    this.m.SpriteDamaged = ("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant));
    this.m.SpriteCorpse = (("bust_greater_flesh_golem_armor_" + ("0" + this.m.Variant)) + "_dead");
    return;
}
