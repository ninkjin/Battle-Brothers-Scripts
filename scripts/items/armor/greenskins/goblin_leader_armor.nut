// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/armor/greenskins/goblin_leader_armor.nut
// Functions: 2

function create(this)
{
    this.armor.create();
    this.updateVariant();
    this.m.ID = "armor.body.goblin_leader_armor";
    this.m.Name = "Description";
    this.m.IconLarge = "Description";
    this.m.Icon = "Description";
    this.m.SlotType = "Description";
    this.m.Const = this.ItemSlot.Body.ShowOnCharacter;
    this.m.ImpactSound = true;
    this.m.Sound = this.ItemSlot.ArmorChainmailImpact.Condition;
    this.m.ConditionMax = 180;
    this.m.StaminaModifier = 180;
    this.m["k[21]"] = -15;
    return;
}

function updateVariant(this)
{
    this.m.Sprite = "bust_goblin_03_armor_01";
    this.m.SpriteDamaged = "bust_goblin_03_armor_01_damaged";
    this.m.SpriteCorpse = "bust_goblin_03_armor_01_dead";
    return;
}
