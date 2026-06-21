this.barbarian_horn_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.barbarian_horn";
		this.m.Name = "角和骨";
		this.m.Description = "一位自封的野蛮人国王的仪式性装饰。这些稀有且耐用的角作为护甲出奇的有效。";
		this.m.ArmorDescription = "这件盔甲被野蛮人工匠以仪式性的角所装饰。";
		this.m.Icon = "armor_upgrades/upgrade_23.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_23.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_23.png";
		this.m.SpriteFront = "upgrade_23_front";
		this.m.SpriteBack = "upgrade_23_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_23_back_damaged";
		this.m.SpriteCorpseFront = "upgrade_23_front_dead";
		this.m.SpriteCorpseBack = "upgrade_23_back_dead";
		this.m.Value = 500;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = 4;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+40[/color]耐久"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-4[/color]最大疲劳"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

