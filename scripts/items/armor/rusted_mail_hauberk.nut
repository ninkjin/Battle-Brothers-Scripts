// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/rusted_mail_hauberk.nut
// Functions: 1

function create(this)
{
    this.armor.create();
    this.m.ID = "armor.body.rusted_mail_hauberk";
    this.m.Name = "Rusted Mail Hauberk";
    this.m.Description = "A long and heavy chainmail armor, turned rigid in places by rust and dirt.";
    this.m.SlotType = this.Const.ItemSlot.Body;
    this.m.IsDroppedAsLoot = true;
    this.m.ShowOnCharacter = true;
    this.m.Variant = 116;
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
    this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
    this.m.Value = 650;
    this.m.Condition = 140;
    this.m.ConditionMax = 140;
    this.m.StaminaModifier = -18;
    return;
}
