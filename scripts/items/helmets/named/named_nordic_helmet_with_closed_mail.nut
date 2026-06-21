this.named_nordic_helmet_with_closed_mail <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_nordic_helmet_with_closed_mail";
		this.m.Description = "这顶带面罩的北欧盔制作工艺非同凡响，令人印象深刻的不止其外观，也包括其防护性。";
		this.m.NameList = [
			"海寇头盔",
			"枭匪头盔",
			"装饰北欧盔",
			"酋长头盔",
			"雕刻北欧盔",
			"贵族北欧盔"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 206;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 7500;
		this.m.Condition = 265;
		this.m.ConditionMax = 265;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

