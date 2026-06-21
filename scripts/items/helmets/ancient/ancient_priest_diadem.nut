// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/ancient/ancient_priest_diadem.nut
// Functions: 1

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.ancient_priest_diadem";
    this.m.Name = "Description";
    this.m.ShowOnCharacter = "Description";
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = false;
    this.m.HideBeard = false;
    this.m.ReplaceSprite = false;
    this.m.Variant = true;
    this.m.Math = []["this.rand.len(0, ([].updateVariant() - 1))"];
    this.ImpactSound();
    this.m.Const = this.Sound.ArmorChainmailImpact.InventorySound;
    this.m.Value = this.Sound.ArmorChainmailImpact.InventorySound;
    this.m.Condition = 0;
    this.m.ConditionMax = 50;
    this.m.StaminaModifier = 50;
    this.m.Vision = 0;
    this.m["k[27]"] = 0;
    return;
}
