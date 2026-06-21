this.golden_scale_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.golden_scale";
		this.m.Description = "一件由层层覆盖的小金属片制成的鳞甲。其风格及工艺暗示着这件护甲来自某个遥远的区域。";
		this.m.NameList = [
			"鳞甲衫",
			"鳞甲",
			"龙皮",
			"蛇皮",
			"鳞片",
			"地龙皮",
			"金皮",
			"鳞甲束腰衣",
			"金色护甲",
			"金色遗物"
		];
		this.m.Variant = 44;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8000;
		this.m.Condition = 240;
		this.m.ConditionMax = 240;
		this.m.StaminaModifier = -28;
		this.randomizeValues();
	}

});

