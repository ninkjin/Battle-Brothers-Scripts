this.pitchfork <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.pitchfork";
		this.m.Name = "干草叉";
		this.m.Description = "一种有粗尖齿的长柄农具，用来挑起并整理干草。作为一种临时武器它可以用来与敌人保持距离，但它难以造成严重杀伤并且对盔甲效果很差。";
		this.m.Categories = "长柄武器，双手";
		this.m.IconLarge = "weapons/melee/pitchfork_01.png";
		this.m.Icon = "weapons/melee/pitchfork_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_pitchfork_01";
		this.m.Value = 150;
		this.m.ShieldDamage = 0;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -14;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_57.png";
		impale.m.IconDisabled = "skills/active_57_sw.png";
		impale.m.Overlay = "active_57";
		this.addSkill(impale);
		local repel = this.new("scripts/skills/actives/repel");
		repel.m.Icon = "skills/active_58.png";
		repel.m.IconDisabled = "skills/active_58_sw.png";
		repel.m.Overlay = "active_58";
		this.addSkill(repel);
	}

});

