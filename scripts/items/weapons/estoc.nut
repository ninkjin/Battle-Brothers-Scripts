// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/weapons/estoc.nut
// Functions: 2

function create(this)
{
    this.weapon.create();
    this.m.ID = "weapon.estoc";
    this.m.Name = "Estoc";
    this.m.Description = "A long, edgeless blade ending in a sharpened point designed to pierce through gaps in armor.";
    this.m.Categories = "Dagger, Two-Handed";
    this.m.IconLarge = "weapons/melee/estoc_01.png";
    this.m.Icon = "weapons/melee/estoc_01_70x70.png";
    this.m.SlotType = this.Const.ItemSlot.Mainhand;
    this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
    this.m.ItemType = ((this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon) | this.Const.Items.ItemType.TwoHanded);
    this.m.AddGenericSkill = true;
    this.m.ShowQuiver = false;
    this.m.ShowArmamentIcon = true;
    this.m.ArmamentIcon = "icon_estoc_01";
    this.m.Value = 2600;
    this.m.Condition = 64.0;
    this.m.ConditionMax = 64.0;
    this.m.StaminaModifier = -9;
    this.m.RegularDamage = 35;
    this.m.RegularDamageMax = 50;
    this.m.ArmorDamageMult = 0.75;
    this.m.DirectDamageMult = 0.44999998807907104;
    this.m.ChanceToHitHead = 5;
    return;
}

function onEquip(this)
{
    this.weapon.onEquip();
    this.addSkill(this.new("scripts/skills/actives/estoc_stab_skill"));
    this.addSkill(this.new("scripts/skills/actives/perforate_skill"));
    this.addSkill(this.new("scripts/skills/actives/skewer_skill"));
    return;
}
