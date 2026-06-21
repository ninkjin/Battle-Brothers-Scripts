this.lute <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.lute";
		this.m.Name = "鲁特琴";
		this.m.Description = "一种乐器，有技巧的人拨动它的弦能够发出令人愉快的声音（砸在敌人身体上发出的声音同样令人愉快）。";
		this.m.Categories = "乐器，双手";
		this.m.IconLarge = "weapons/melee/lute_01.png";
		this.m.Icon = "weapons/melee/lute_01_70x70.png";
		this.m.BreakingSound = "sounds/combat/lute_break_01.wav";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_lute";
		this.m.Value = 120;
		this.m.Condition = 2.0;
		this.m.ConditionMax = 2.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 10;
		this.m.ArmorDamageMult = 0.1;
		this.m.DirectDamageMult = 0.4;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local s = this.new("scripts/skills/actives/knock_out");
		s.m.IsFromLute = true;
		s.m.Icon = "skills/active_88.png";
		s.m.IconDisabled = "skills/active_88_sw.png";
		s.m.Overlay = "active_88";
		this.addSkill(s);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

