// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/golems/flesh_golem_facewrap.nut
// Functions: 2

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.flesh_golem_facewrap";
    this.m.Name = "Leather Facewrap";
    this.m.Description = "ShowOnCharacter";
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = false;
    this.m.HideBeard = true;
    this.m.ReplaceSprite = true;
    this.m.Variant = true;
    this.m.Math = []["this.rand.len(0, ([].updateVariant() - 1))"];
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorLeatherImpact.InventorySound;
    this.m.ClothEquip = this.Sound.ArmorLeatherImpact.Value;
    this.m.Condition = 0;
    this.m.ConditionMax = 50;
    this.m.StaminaModifier = 50;
    this.m.Vision = 0;
    this.m["k[29]"] = 0;
    return;
}

function updateVariant(this)
{
    if (this.m.Variant > 9)
    {
    }
    this.m.Sprite = ("bust_flesh_golem_helmet_" + ("0" + this.m.Variant));
    this.m.SpriteDamaged = (("bust_flesh_golem_helmet_" + ("0" + this.m.Variant)) + "_damaged");
    this.m.SpriteCorpse = (("bust_flesh_golem_helmet_" + ("0" + this.m.Variant)) + "_dead");
    return;
}
