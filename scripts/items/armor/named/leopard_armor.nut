this.leopard_armor <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.leopard_armor";
		this.m.Description = "一件重型甲片扎甲，结合有精细的链甲及舒适的内衬。是一件真正精工制作的作品，几乎过于珍贵到不适合在战斗中遭受损坏。";
		this.m.NameList = [
			"金铎的拥抱",
			"金铎的守护",
			"闪光扎甲",
			"维齐尔的甲胄",
			"沙漠之壳",
			"大师猎人的护甲"
		];
		this.m.VariantString = "body_southern_named";
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 15000;
		this.m.Condition = 290;
		this.m.ConditionMax = 290;
		this.m.StaminaModifier = -35;
		this.randomizeValues();
	}

});

