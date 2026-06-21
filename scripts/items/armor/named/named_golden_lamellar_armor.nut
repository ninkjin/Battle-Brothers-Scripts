this.named_golden_lamellar_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.named_golden_lamellar_armor";
		this.m.Description = "一件尤为精心制作的扎甲。它上面覆盖着金箔，这使它真正与众不同。";
		this.m.NameList = [
			"甲胄",
			"守护",
			"防卫",
			"辉煌",
			"金色扎甲"
		];
		this.m.Variant = 100;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 11000;
		this.m.Condition = 285;
		this.m.ConditionMax = 285;
		this.m.StaminaModifier = -40;
		this.randomizeValues();
	}

});

