this.black_and_gold_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.black_and_gold";
		this.m.Description = "这套独特的护甲在铸造时使用了古老的知识。它的轻链甲与金色夹板重叠，以可负担的累赘提供很高的防护。";
		this.m.NameList = [
			"金铎的闪耀守护",
			"金铎的外皮",
			"太阳斗篷",
			"炽热链甲",
			"日灼甲胄",
			"闪耀束腰衣",
			"蝎王之甲"
		];
		this.m.VariantString = "body_southern_named";
		this.m.Variant = 2;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 9000;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -25;
		this.randomizeValues();
	}

});

