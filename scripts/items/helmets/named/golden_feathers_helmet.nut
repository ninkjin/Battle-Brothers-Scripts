this.golden_feathers_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.golden_feathers";
		this.m.Description = "一顶异域风格的坚固合金头盔，配有一件完整链甲头罩从而提供极佳防护。";
		this.m.NameList = [
			"头盔",
			"金色头盖",
			"羽毛头盔",
			"闪光头盔",
			"头罩头盔"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 50;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6000;
		this.m.Condition = 240;
		this.m.ConditionMax = 240;
		this.m.StaminaModifier = -16;
		this.m.Vision = -3;
		this.randomizeValues();
	}

});

