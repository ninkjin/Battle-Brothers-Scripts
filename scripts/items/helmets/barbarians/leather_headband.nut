this.leather_headband <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.leather_headband";
		this.m.Name = "皮革头带";
		this.m.Description = "一条干燥并折叠起来的皮革头带，用来保护前额。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = false;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		local variants = [
			187,
			188
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 30;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
	}

});

