this.warfork <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.warfork";
		this.m.Name = "战叉";
		this.m.Description = "一种被重新锻造成战场武器的干草叉，介于矛和枪之间。可在一定距离外戳击并与敌人保持距离。";
		this.m.Categories = "矛，双手";
		this.m.IconLarge = "weapons/melee/warfork_01.png";
		this.m.Icon = "weapons/melee/warfork_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_warfork_01";
		this.m.Value = 400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.25;
		this.m.ChanceToHitHead = 5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local prong = this.new("scripts/skills/actives/prong_skill");
		prong.m.Icon = "skills/active_174.png";
		prong.m.IconDisabled = "skills/active_174_sw.png";
		prong.m.Overlay = "active_174";
		this.addSkill(prong);
		local spearwall = this.new("scripts/skills/actives/spearwall");
		spearwall.m.Icon = "skills/active_173.png";
		spearwall.m.IconDisabled = "skills/active_173_sw.png";
		spearwall.m.Overlay = "active_173";
		spearwall.m.BaseAttackName = prong.getName();
		spearwall.setFatigueCost(spearwall.getFatigueCostRaw() + 5);
		spearwall.m.ActionPointCost = 6;
		this.addSkill(spearwall);
	}

});

