this.gold_and_black_turban <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.gold_and_black_turban";
		this.m.Description = "这种南方风格的头盔装饰丰富且平衡良好，并且由最高质量的材料制成。";
		this.m.NameList = [
			"南方之冠",
			"沙漠羽冠",
			"太阳头巾",
			"金色羽冠",
			"维齐尔的骄傲",
			"沙王之盔",
			"蝎子头盔",
			"太阳面纱",
			"金铎的骄傲",
			"金铎的面容"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.VariantString = "helmet_southern_named";
		this.m.Variant = 2;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 290;
		this.m.ConditionMax = 290;
		this.m.StaminaModifier = -20;
		this.m.Vision = -3;
		this.randomizeValues();
	}

});

