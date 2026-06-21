this.wooden_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.wooden_flail";
		this.m.Name = "木质链枷";
		this.m.Description = "两根由短链连起来的大木棍，是一种用来敲打谷物堆来去壳的农具。作为一种应急武器，它的攻击有些难以预测，但很适合绕过盾牌的掩护。";
		this.m.Categories = "链枷，单手";
		this.m.IconLarge = "weapons/melee/flail_02.png";
		this.m.Icon = "weapons/melee/flail_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_flail_02";
		this.m.Value = 40;
		this.m.ShieldDamage = 0;
		this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local flail = this.new("scripts/skills/actives/flail_skill");
		flail.m.Icon = "skills/active_62.png";
		flail.m.IconDisabled = "skills/active_62_sw.png";
		flail.m.Overlay = "active_62";
		this.addSkill(flail);
		local lash = this.new("scripts/skills/actives/lash_skill");
		lash.m.Icon = "skills/active_94.png";
		lash.m.IconDisabled = "skills/active_94_sw.png";
		lash.m.Overlay = "active_94";
		this.addSkill(lash);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

