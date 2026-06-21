this.jesters_hat <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.jesters_hat";
		this.m.Name = "小丑帽";
		this.m.Description = "这顶五颜六色的帽子是由小丑、艺人和类似旅行者的标志性头饰。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		this.m.Variant = 86;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.JesterImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 70;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = 0;
	}

});

