this.named_metal_skull_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_metal_skull_helmet";
		this.m.Description = "一种典型的北方野蛮人的重型头盔，有颅骨状的面罩。这顶头盔沉重且令人印象深刻。";
		this.m.NameList = [
			"北方面甲",
			"金属颅骨",
			"面罩",
			"宗族之貌",
			"面具",
			"钢铁面罩",
			"部落面容",
			"烧杀者凝视"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.HideCharacterHead = true;
		this.m.Variant = 232;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5000;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -13;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

