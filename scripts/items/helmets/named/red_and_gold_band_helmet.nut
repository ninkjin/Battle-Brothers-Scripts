this.red_and_gold_band_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.red_and_gold_band_helmet";
		this.m.Description = "这顶南方风格的头盔在装饰丰富的同时平衡性良好，并且由非常优质的金属制成。";
		this.m.NameList = [
			"夹板头盔",
			"分段头盔",
			"沙王之冠",
			"炽之穹",
			"游牧民的王冠",
			"夹板羽盔"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.VariantString = "helmet_southern_named";
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 255;
		this.m.ConditionMax = 255;
		this.m.StaminaModifier = -17;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

