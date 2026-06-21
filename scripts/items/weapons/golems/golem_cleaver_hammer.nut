// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/weapons/golems/golem_cleaver_hammer.nut
// Functions: 3

function create(this)
{
    this.weapon.create();
    this.m.ID = "weapon.golem_cleaver_hammer";
    this.m.Name = "Cleaver and Hammer";
    this.m.Description = "SlotType";
    this.m.Const = this.ItemSlot.Mainhand.ItemType;
    this.m.Items = ((this.ItemSlot.Weapon.Items.MeleeWeapon | this.ItemSlot.Weapon.Items.TwoHanded) | this.ItemSlot.Weapon.Items.IsDoubleGrippable);
    this.m.IsDroppedAsLoot = true;
    this.m.AddGenericSkill = false;
    this.m.ShowQuiver = true;
    this.m.ShowArmamentIcon = false;
    this.m.ArmamentIcon = true;
    this.m.icon_dual_cleaver_hammer_01 = "RangeMin";
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
    this.new("scripts/skills/actives/golem_cleave_skill").m.Icon = "skills/active_68.png";
    this.new("scripts/skills/actives/golem_cleave_skill").m.IconDisabled = "skills/active_68_sw.png";
    this.new("scripts/skills/actives/golem_cleave_skill").m.Overlay = "active_68";
    this.addSkill(this.new("scripts/skills/actives/golem_cleave_skill"));
    this.addSkill(this.new("scripts/skills/actives/golem_decapitate_skill"));
    this.new("scripts/skills/actives/golem_batter_skill").m.Icon = "skills/active_60.png";
    this.new("scripts/skills/actives/golem_batter_skill").m.IconDisabled = "skills/active_60_sw.png";
    this.new("scripts/skills/actives/golem_batter_skill").m.Overlay = "active_60";
    this.addSkill(this.new("scripts/skills/actives/golem_batter_skill"));
    return;
}

function onUpdateProperties(this, _properties)
{
    this.weapon.onUpdateProperties(_properties);
    return;
}
