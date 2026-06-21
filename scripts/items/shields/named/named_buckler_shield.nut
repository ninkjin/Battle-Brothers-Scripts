// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/shields/named/named_buckler_shield.nut
// Functions: 3

function create(this)
{
    this.named_shield.create();
    this.m.ID = "shield.named_buckler";
    this.m.NameList = this.Const.Strings.ShieldNames;
    this.m.Description = "This buckler has been crafted entirely from metal, vastly enhancing its durability. Though it offers poor protection against ranged attacks, it is far lighter to handle than larger shields.";
    this.m.AddGenericSkill = true;
    this.m.ShowOnCharacter = true;
    this.m.SoundOnHit = this.Const.Sound.ShieldHitMetal;
    this.m.Variant = 1;
    this.updateVariant();
    this.m.Value = 150;
    this.m.MeleeDefense = 10;
    this.m.RangedDefense = 5;
    this.m.StaminaModifier = -4;
    this.m.Condition = 48;
    this.m.ConditionMax = 48;
    this.randomizeValues();
    return;
}

function onEquip(this)
{
    this.shield.onEquip();
    this.addSkill(this.new("scripts/skills/actives/knock_back"));
    return;
}

function updateVariant(this)
{
    this.m.Sprite = ("shield_buckler_01_named_0" + this.m.Variant);
    this.m.SpriteDamaged = (("shield_buckler_01_named_0" + this.m.Variant) + "_damaged");
    this.m.ShieldDecal = (("shield_buckler_01_named_0" + this.m.Variant) + "_destroyed");
    this.m.IconLarge = (("shields/inventory_buckler_shield_01_named_0" + this.m.Variant) + ".png");
    this.m.Icon = (("shields/icon_buckler_shield_01_named_0" + this.m.Variant) + ".png");
    return;
}
