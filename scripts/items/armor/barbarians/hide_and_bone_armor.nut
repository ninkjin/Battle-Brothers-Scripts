this.hide_and_bone_armor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.hide_and_bone_armor";
		this.m.Name = "兽皮骨甲";
		this.m.Description = "兽皮与骨头在北方地区是常见的材料。这件护甲同时利用两者以提供可靠的防护。";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 92;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = this.Const.Sound.ArmorBoneImpact;
		this.m.Value = 220;
		this.m.Condition = 95;
		this.m.ConditionMax = 95;
		this.m.StaminaModifier = -10;
	}

});

