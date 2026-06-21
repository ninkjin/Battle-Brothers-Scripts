this.metal_plating_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.metal_plating";
		this.m.Name = "铆接金属片";
		this.m.Description = "铆接到内侧护甲上的厚金属片。是一种非常粗糙但简易快速的增加防护的手段。";
		this.m.ArmorDescription = "这件护甲附加了一层草草铆接的金属片以提供额外的防护。";
		this.m.Icon = "armor_upgrades/upgrade_12.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_12.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_12.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_12_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_12_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_12_back_dead";
		this.m.Value = 300;
		this.m.ConditionModifier = 30;
		this.m.StaminaModifier = 3;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30[/color]耐久"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color]最大疲劳"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

