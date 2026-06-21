// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/weapons/legendary/miasma_flail.nut
// Functions: 3

function create(this)
{
    this.weapon.create();
    this.m.ID = "weapon.miasma_flail";
    this.m.Name = "Censer of the Diviner";
    this.m.Description = "A heavy censer, repurposed into a vicious flail-head, on a long handle. You know not what incense the Grand Diviner used to fuel his mad visions, but it burns like poison and the weapon produces it from some unknown, inexorable source.";
    this.m.Categories = "Flail, Two-Handed";
    this.m.IconLarge = "weapons/melee/miasma_flail_01.png";
    this.m.Icon = "weapons/melee/miasma_flail_01_70x70.png";
    this.m.SlotType = this.Const.ItemSlot.Mainhand;
    this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
    this.m.ItemType = (((this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon) | this.Const.Items.ItemType.TwoHanded) | this.Const.Items.ItemType.Legendary);
    this.m.IsAoE = true;
    this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
    this.m.AddGenericSkill = true;
    this.m.ShowQuiver = false;
    this.m.ShowArmamentIcon = true;
    this.m.ArmamentIcon = "icon_miasma_flail_01";
    this.m.Value = 14000;
    this.m.ShieldDamage = 0;
    this.m.Condition = 120.0;
    this.m.ConditionMax = 120.0;
    this.m.StaminaModifier = -16;
    this.m.RangeMin = 1;
    this.m.RangeMax = 2;
    this.m.RangeIdeal = 2;
    this.m.RegularDamage = 60;
    this.m.RegularDamageMax = 110;
    this.m.ArmorDamageMult = 1.100000023841858;
    this.m.DirectDamageMult = 0.30000001192092896;
    this.m.ChanceToHitHead = 15;
    return;
}

function onEquip(this)
{
    this.weapon.onEquip();
    this.addSkill(this.new("scripts/skills/actives/censer_strike"));
    this.addSkill(this.new("scripts/skills/actives/censer_castigate_skill"));
    return;
}

function onUpdateProperties(this, _properties)
{
    this.weapon.onUpdateProperties(_properties);
    return;
}
