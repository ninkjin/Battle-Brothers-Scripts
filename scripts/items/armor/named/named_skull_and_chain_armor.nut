this.named_skull_and_chain_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.named_skull_and_chain_armor";
		this.m.Description = "一件粗制的野蛮人护甲，经过调整以在不过于累赘的同时提供防护。它上面有着北方野蛮人部落特有的标记。";
		this.m.NameList = [
			"部落兽皮",
			"野蛮人外套",
			"拾荒护甲",
			"野蛮人皮毛",
			"原始甲胄"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.Variant = 102;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5500;
		this.m.Condition = 190;
		this.m.ConditionMax = 190;
		this.m.StaminaModifier = -24;
		this.randomizeValues();
	}

});

