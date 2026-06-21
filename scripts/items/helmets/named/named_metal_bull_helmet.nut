this.named_metal_bull_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_metal_bull_helmet";
		this.m.Description = "使用非常坚固的合金制成的强化头盔。它装饰华丽且沉重，但提供了非凡的防护。";
		this.m.NameList = [
			"角盔",
			"合金头盔",
			"古代轻盔",
			"保护者",
			"角冠"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 233;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8000;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -22;
		this.m.Vision = -3;
		this.randomizeValues();
	}

});

