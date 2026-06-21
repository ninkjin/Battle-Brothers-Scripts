// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/weapons/golems/golem_spear_sword.nut
// Functions: 3

function create(this)
{
    this.weapon.create();
    this.m.ID = "weapon.golem_spear_sword";
    this.m.Name = "Spear and Sword";
    this.m.Description = "SlotType";
    this.m.Const = this.ItemSlot.Mainhand.ItemType;
    this.m.Items = ((this.ItemSlot.Weapon.Items.MeleeWeapon | this.ItemSlot.Weapon.Items.TwoHanded) | this.ItemSlot.Weapon.Items.IsDoubleGrippable);
    this.m.IsDroppedAsLoot = true;
    this.m.AddGenericSkill = false;
    this.m.ShowQuiver = true;
    this.m.ShowArmamentIcon = false;
    this.m.ArmamentIcon = true;
    this.m.icon_dual_spear_sword_01 = "RangeMin";
    this.m.RangeMax = 1;
    this.m.RangeIdeal = 1;
    this.m.Value = 1;
    this.m.Condition = 0;
    this.m.ConditionMax = 0;
    this.m.StaminaModifier = 0;
    this.m.RegularDamage = 0;
    this.m.RegularDamageMax = 0;
    this.m.ArmorDamageMult = 0;
    this.m.DirectDamageMult = 0.0;
    this.m["k[35]"] = 0.0;
    return;
}

function onEquip(this)
{
    this.weapon.onEquip();
    this.addSkill(this.new("scripts/skills/actives/golem_slash_skill"));
    this.addSkill(this.new("scripts/skills/actives/golem_thrust_skill"));
    return;
}

function onUpdateProperties(this, _properties)
{
    this.weapon.onUpdateProperties(_properties);
    return;
}
