this.named_bronze_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.named_bronze_armor";
		this.m.Description = "这件护甲由一种奇怪的合金制成，并且以野蛮人的标准来说制作精良。是一件真正的珍品。";
		this.m.NameList = [
			"暗淡甲胄",
			"合金板护甲",
			"污损的堡垒",
			"部落板甲"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.Variant = 103;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 9000;
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
		this.m.StaminaModifier = -35;
		this.randomizeValues();
	}

});

