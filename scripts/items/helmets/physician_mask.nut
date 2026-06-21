this.physician_mask <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.physician_mask";
		this.m.Name = "疫医面具";
		this.m.Description = "一个附有独特的鸟状面具的厚皮革罩头。它的喙用作通气口，里面装有气味香甜的药草来抵御疾病和瘟疫。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ReplaceSprite = true;
		this.m.Variant = 241;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 170;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -3;
		this.m.Vision = -1;
	}

	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "只受到[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]来自有毒瘴气的伤害"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.helmet.onUpdateProperties(_properties);
		_properties.IsResistantToMiasma = true;
	}

});

