this.heavy_lamellar_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.heavy_lamellar_armor";
		this.m.Name = "重型扎甲";
		this.m.Description = "一件重型扎甲，使用相互覆盖的金属板覆盖住绝大部分身体以最大限度提供防护。";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 89;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 5000;
		this.m.Condition = 285;
		this.m.ConditionMax = 285;
		this.m.StaminaModifier = -40;
	}

});

