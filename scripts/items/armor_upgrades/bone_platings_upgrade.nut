this.bone_platings_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {
		IsUsed = false
	},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.bone_platings";
		this.m.Name = "骨头护板";
		this.m.Description = "由强韧但出奇轻便的骨头制成，这些华丽护板套在常规护甲外面能用作吸能护甲。";
		this.m.ArmorDescription = "一层华丽的骨板附加在这件护甲上。";
		this.m.Icon = "armor_upgrades/upgrade_06.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_06.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_06.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_06_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_06_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_06_back_dead";
		this.m.StaminaModifier = 2;
		this.m.Value = 850;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "每场战斗中完全吸收第一次遭受的不忽视护甲的伤害。"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color]最大疲劳"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "每场战斗中完全吸收第一次遭受的不忽视护甲的伤害。"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.IsUsed)
		{
			return;
		}

		if (_hitInfo.BodyPart == this.Const.BodyPart.Body && _hitInfo.DamageDirect < 1.0)
		{
			this.m.IsUsed = true;
			_properties.DamageReceivedTotalMult = 0.0;
		}
	}

	function onCombatFinished()
	{
		this.m.IsUsed = false;
	}

});

