// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/marauder_helmet_with_closed_mail.nut
// Functions: 1

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.marauder_helmet_with_closed_mail";
    this.m.Name = "Marauder Helmet with Closed Mail";
    this.m.Description = "A rusted helmet with an attached closed mail neck guard commonly used by coastal raiders.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = []["this.Math.rand(0, ([].len() - 1))"];
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
    this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
    this.m.Value = 1250;
    this.m.Condition = 245;
    this.m.ConditionMax = 245;
    this.m.StaminaModifier = -20;
    this.m.Vision = -2;
    return;
}
