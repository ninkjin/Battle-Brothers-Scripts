this.named_sellswords_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.named_sellswords_armor";
		this.m.Description = "这件多层护甲曾属于一个著名的雇佣兵。它富有弹性和灵活性，使得它成为一件绝佳的工艺品。它甚至还有额外的口袋！";
		this.m.NameList = [
			"雇佣兵外套",
			"佣兵的遮挡",
			"复层护甲",
			"护板外套"
		];
		this.m.Variant = 101;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 10000;
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
		this.m.StaminaModifier = -32;
		this.randomizeValues();
	}

});

