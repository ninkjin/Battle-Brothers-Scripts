this.named_noble_mail_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.named_noble_mail_armor";
		this.m.Description = "这件轻型链甲曾是一位著名刺剑大师的私人物品。它和束腰衣一样轻，但能保护所有身体重要部位。";
		this.m.NameList = [
			"强化链甲",
			"黑夜斗篷",
			"贵族链甲",
			"刺剑链甲"
		];
		this.m.Variant = 99;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5500;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -15;
		this.randomizeValues();
	}

});

