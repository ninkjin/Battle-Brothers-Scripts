this.wolf_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.wolf";
		this.m.Description = "一顶结实的附链甲金属头盔，上面盖着一个令人印象深刻的狼头。";
		this.m.NameList = [
			"兽帽",
			"狼之盔",
			"狂战士头罩",
			"野兽头罩",
			"狼冠",
			"捕食者冠"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 48;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2000;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
		this.m.StaminaModifier = -8;
		this.randomizeValues();
	}

});

