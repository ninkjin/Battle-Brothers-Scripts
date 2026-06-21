this.fangshire <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.fangshire";
		this.m.Name = "夏尔之牙";
		this.m.Description = "夏尔之牙是一只北方老虎的头骨，将穿戴者的脸深深地、黑暗地藏在两个凶猛的尖牙后面。最初是外号野兽人的凶悍北方掠夺者比约兰戴着它，在他进行血腥袭击并烧毁海岸线上的许多村庄时，它向敌人们的内心灌输着恐惧。当比约兰最终被杀后，夏尔之牙被当作战利品运向了南方。有传言说，穿戴者的眼睛发出一种尖锐的黄色光芒，让他能看穿最黑暗的夜晚。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.IsIndestructible = true;
		this.m.Variant = 24;
		this.updateVariant();
		this.m.ImpactSound = [
			"sounds/enemies/skeleton_hurt_03.wav"
		];
		this.m.Value = 300;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -5;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "允许佩戴者在黑夜视物，并取消任何夜间惩罚。"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.helmet.onUpdateProperties(_properties);
		_properties.IsAffectedByNight = false;
	}

});

