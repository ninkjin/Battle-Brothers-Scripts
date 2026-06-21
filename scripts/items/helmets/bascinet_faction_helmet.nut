// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/bascinet_faction_helmet.nut
// Functions: 2

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.bascinet_faction_helmet";
    this.m.Name = "Soldier's Heraldic Bascinet";
    this.m.Description = "A metal bascinet worn atop a thick mail coif, decorated with a ribbon in the colors of a noble house.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = 1;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 1400;
    this.m.Condition = 220;
    this.m.ConditionMax = 220;
    this.m.StaminaModifier = -13;
    this.m.Vision = -2;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("faction_helmet_3_" + ("0" + this.m.Variant));
    this.m.SpriteDamaged = (("faction_helmet_3_" + ("0" + this.m.Variant)) + "_damaged");
    this.m.SpriteCorpse = (("faction_helmet_3_" + ("0" + this.m.Variant)) + "_dead");
    this.m.IconLarge = "Icon";
    this.m["helmets/inventory_faction_helmet_3_"] = ((".png" + ("0" + this.m.Variant)) + "k[13]");
    return;
}
