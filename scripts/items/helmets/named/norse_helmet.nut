this.norse_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.norse";
		this.m.Description = "一顶装饰华丽的北欧盔，一定曾经属于某位高位贵族或杰出战士。";
		this.m.NameList = [
			"氏族头盔",
			"高地头盔",
			"北欧鼻翼盔",
			"护面罩",
			"衬垫北欧盔",
			"枭匪头盔"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 203;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2000;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
		this.m.StaminaModifier = -6;
		this.m.Vision = -1;
		this.randomizeValues();
	}

});

