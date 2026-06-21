// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/weapons/named/named_exesword.nut
// Functions: 3

function create(this)
{
    this.named_weapon.create();
    this.m.Variant = this.Math.rand(1, 2);
    this.updateVariant();
    this.m.ID = "weapon.named_exesword";
    this.m.NameList = this.Const.Strings.GreatswordNames;
    this.m.Description = "An expertly honed executioner's sword that ensures a painless demise. The ornately decorated blade suggests it has been used to sever many a noble neck.";
    this.m.Categories = "Sword, Two-Handed";
    this.m.SlotType = this.Const.ItemSlot.Mainhand;
    this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
    this.m.ItemType = ((this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon) | this.Const.Items.ItemType.TwoHanded);
    this.m.IsAgainstShields = true;
    this.m.IsAoE = true;
    this.m.AddGenericSkill = true;
    this.m.ShowQuiver = false;
    this.m.ShowArmamentIcon = true;
    this.m.Value = 4300;
    this.m.ShieldDamage = 16;
    this.m.Condition = 72.0;
    this.m.ConditionMax = 72.0;
    this.m.StaminaModifier = -12;
    this.m.RegularDamage = 95;
    this.m.RegularDamageMax = 110;
    this.m.ArmorDamageMult = 0.8999999761581421;
    this.m.DirectDamageMult = 0.3499999940395355;
    this.m.ChanceToHitHead = 5;
    this.randomizeValues();
    return;
}

function onEquip(this)
{
    this.weapon.onEquip();
    this.addSkill(this.new("scripts/skills/actives/execute_skill"));
    this.addSkill(this.new("scripts/skills/actives/exesword_decapitate"));
    this.new("scripts/skills/actives/split_shield").setFatigueCost((this.new("scripts/skills/actives/split_shield").getFatigueCostRaw() + 5));
    this.addSkill(this.new("scripts/skills/actives/split_shield"));
    return;
}

function updateVariant(this)
{
    this.m.IconLarge = (("weapons/melee/sword_exe_01_named_0" + this.m.Variant) + ".png");
    this.m.Icon = (("weapons/melee/sword_exe_01_named_0" + this.m.Variant) + "_70x70.png");
    this.m.ArmamentIcon = ("icon_sword_exe_01_named_0" + this.m.Variant);
    return;
}
