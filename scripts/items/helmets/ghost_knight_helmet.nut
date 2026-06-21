// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/ghost_knight_helmet.nut
// Functions: 1

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.ghost_knight_helmet";
    this.m.Name = "Rachegeist's Helm";
    this.m.Description = "What once animated the Rachegeist's armor has long dissipated, leaving this ornate and well-preserved full helm behind.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = 267;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 4000;
    this.m.Condition = 300;
    this.m.ConditionMax = 300;
    this.m.StaminaModifier = -18;
    this.m.Vision = -3;
    return;
}
