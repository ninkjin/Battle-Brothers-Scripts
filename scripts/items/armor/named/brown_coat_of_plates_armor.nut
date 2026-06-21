this.brown_coat_of_plates_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.brown_coat_of_plates";
		this.m.Description = "一件结合了坚固金属护板的厚链甲束腰衣。这件护甲在最激烈的战斗中也能保护其穿戴者。";
		this.m.NameList = [
			"甲胄",
			"守护",
			"防卫",
			"屏障",
			"板甲",
			"护板背心",
			"护命衣"
		];
		this.m.Variant = 45;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 14000;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -36;
		this.randomizeValues();
	}

});

