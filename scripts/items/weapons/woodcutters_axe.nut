this.woodcutters_axe <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.woodcutters_axe";
		this.m.Name = "伐木斧";
		this.m.Description = "一把长长的双手斧，每一次挥动都会异常沉重。一般用它来砍伐大树，但用来砍人应该也不错。";
		this.m.Categories = "斧，双手";
		this.m.IconLarge = "weapons/melee/axe_two_handed_02.png";
		this.m.Icon = "weapons/melee/axe_two_handed_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_axe_two_handed_02";
		this.m.Value = 400;
		this.m.ShieldDamage = 30;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/split_man"));
		this.addSkill(this.new("scripts/skills/actives/round_swing"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 5);
		this.addSkill(skillToAdd);
	}

});

