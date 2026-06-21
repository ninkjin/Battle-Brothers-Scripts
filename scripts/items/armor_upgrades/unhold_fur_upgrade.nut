this.unhold_fur_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.unhold_fur";
		this.m.Name = "巨魔毛皮斗篷";
		this.m.Description = "一件用冰原巨魔那厚实而高贵的白色毛皮制成的斗篷。可以穿在任何盔甲上外侧以使穿戴者对远程武器更有耐性。";
		this.m.ArmorDescription = "一件厚厚的白色毛皮斗篷附加在这件护甲上，使它对远程武器有更高的耐性。";
		this.m.Icon = "armor_upgrades/upgrade_02.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_02.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_02.png";
		this.m.SpriteFront = "upgrade_02_front";
		this.m.SpriteBack = "upgrade_02_back";
		this.m.SpriteDamagedFront = "upgrade_02_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_02_back";
		this.m.SpriteCorpseFront = "upgrade_02_front_dead";
		this.m.SpriteCorpseBack = "upgrade_02_back_dead";
		this.m.ConditionModifier = 10;
		this.m.StaminaModifier = 0;
		this.m.Value = 1000;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]耐久"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "身体所受的远程伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "身体所受的远程伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedRangedMult *= 0.8;
		}
	}

});

