this.nasal_feather_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.nasal_feather";
		this.m.Description = "一顶硬化鼻翼盔，附有使用皮革鳞片制作的独特护颈。";
		this.m.NameList = [
			"羽毛鼻翼盔",
			"强化头盔",
			"守护",
			"护盔",
			"保护者"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 51;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 7000;
		this.m.Condition = 265;
		this.m.ConditionMax = 265;
		this.m.StaminaModifier = -18;
		this.m.Vision = -2;
		this.randomizeValues();
	}

});

