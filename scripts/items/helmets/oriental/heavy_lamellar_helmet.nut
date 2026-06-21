this.heavy_lamellar_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.heavy_lamellar_helmet";
		this.m.Name = "重型扎甲头盔";
		this.m.Description = "一顶由相互覆盖的金属片制作而成的头盔。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ReplaceSprite = true;
		this.m.VariantString = "helmet_southern";
		this.m.Variant = 3;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 2500;
		this.m.Condition = 255;
		this.m.ConditionMax = 255;
		this.m.StaminaModifier = -17;
		this.m.Vision = -2;
	}

});

