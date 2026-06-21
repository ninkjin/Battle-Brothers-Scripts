this.direwolf_pelt_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.direwolf_pelt";
		this.m.Name = "恐狼毛皮披风";
		this.m.Description = "由凶猛的恐狼毛皮鞣制并缝合而成，作为野兽猎人的战利品围在脖子上。穿戴这样的野兽毛皮能让人显得令人生畏。";
		this.m.ArmorDescription = "一件恐狼毛皮披风附加在这件护甲上，它可以让穿戴者显得令人生畏。";
		this.m.Icon = "armor_upgrades/upgrade_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_01.png";
		this.m.SpriteFront = "upgrade_01_front";
		this.m.SpriteBack = "upgrade_01_back";
		this.m.SpriteDamagedFront = "upgrade_01_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_01_back";
		this.m.SpriteCorpseFront = "upgrade_01_front_dead";
		this.m.SpriteCorpseBack = "upgrade_01_back_dead";
		this.m.Value = 600;
		this.m.ConditionModifier = 15;
		this.m.StaminaModifier = 0;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]耐久"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "所有近战对手的决心减少[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "所有近战对手的决心减少[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.Threat += 5;
	}

});

