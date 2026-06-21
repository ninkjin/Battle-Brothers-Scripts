this.named_goblin_heavy_bow <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_goblin_heavy_bow";
		this.m.NameList = this.Const.Strings.BowNames;
		this.m.UseRandomName = false;
		this.m.Description = "哥布林知道如何制作高效的轻型弓。这一张由一些不知名的浅色木材制成，体积虽小却依旧有着惊人的拉力。";
		this.m.Categories = "弓，双手";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2200;
		this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -2;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.1;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/ranged/bow_goblin_02_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/ranged/bow_goblin_02_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_goblin_bow_02_named_0" + this.m.Variant;
	}

	function getAmmoID()
	{
		return "ammo.arrows";
	}

	function getAdditionalRange( _actor )
	{
		return _actor.getCurrentProperties().IsSpecializedInBows ? 1 : 0;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/quick_shot"));
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}

});

