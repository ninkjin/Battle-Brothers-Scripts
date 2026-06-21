this.named_steppe_helmet_with_mail <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.named_steppe_helmet_with_mail";
		this.m.Description = "一顶以草原居民风格精巧制作的头盔。使用金配件装饰，并附有额外的护面。";
		this.m.NameList = [
			"草原盔",
			"装饰鼻翼盔",
			"头饰盔",
			"马毛盔"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 204;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5000;
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -12;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

