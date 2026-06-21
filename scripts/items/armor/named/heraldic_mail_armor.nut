this.heraldic_mail_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.heraldic_mail";
		this.m.Description = "这件链甲束腰衣由最高质量的材料制作，并且富有珍贵的装饰物和配件。确实配得上一位骑士。";
		this.m.NameList = [
			"纹章链甲",
			"辉煌",
			"宏伟",
			"华丽",
			"炫耀",
			"完整链甲",
			"链甲束腰衣",
			"链甲衣",
			"职责",
			"荣誉",
			"贵族链甲"
		];
		this.m.Variant = 36;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 7000;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -26;
		this.randomizeValues();
	}

});

