this.horn_plate_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.horn_plate";
		this.m.Name = "角板";
		this.m.Description = "这些角板块由大自然能提供的最坚固而柔韧的材料制作。套在常规护甲外面时，它们能帮忙偏斜来袭的打击。";
		this.m.ArmorDescription = "一些角板块提供了额外的防护。";
		this.m.Icon = "armor_upgrades/upgrade_22.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_22.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_22.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_22_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_22_back";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_22_back_dead";
		this.m.ConditionModifier = 30;
		this.m.Value = 1200;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30[/color]耐久"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "身体所受近战伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "身体所受近战伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedMeleeMult *= 0.9;
		}
	}

});

