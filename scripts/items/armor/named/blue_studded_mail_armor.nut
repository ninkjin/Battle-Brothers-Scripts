this.blue_studded_mail_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.blue_studded_mail";
		this.m.Description = "这件特殊链甲衫由棉甲及结实的镶钉皮夹克组合而成，轻盈但具有防护性。";
		this.m.NameList = [
			"内衬链甲",
			"蛤蟆皮",
			"食人魔皮",
			"复层护甲",
			"强化链甲"
		];
		this.m.Variant = 46;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4000;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -16;
		this.randomizeValues();
	}

});

