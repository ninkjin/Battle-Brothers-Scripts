this.named_metal_nose_horn_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_metal_nose_horn_helmet";
		this.m.Description = "这顶头盔一定曾属于某个出众的野蛮人战士。它的尺寸和风格对所有南方人来说都极其陌生。";
		this.m.NameList = [
			"全覆头盔",
			"尖刺头盔",
			"带刃护盔",
			"大号面罩",
			"斗士头盔"
		];
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.UseRandomName = false;
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.HideCharacterHead = true;
		this.m.Variant = 234;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5000;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = -15;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

