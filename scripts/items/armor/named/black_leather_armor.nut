this.black_leather_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.black_leather";
		this.m.Description = "一件精心制作的硬化皮甲，内有一件衬垫棉甲及链甲。穿着很轻但非常结实。";
		this.m.NameList = [
			"皮革胸甲",
			"链甲衫",
			"皮甲",
			"外皮",
			"外壳",
			"守护",
			"外套",
			"黑夜斗篷",
			"黑甲",
			"黑暗预兆"
		];
		this.m.Variant = 42;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2000;
		this.m.Condition = 115;
		this.m.ConditionMax = 115;
		this.m.StaminaModifier = -12;
		this.randomizeValues();
	}

});

