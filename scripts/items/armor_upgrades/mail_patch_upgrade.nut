this.mail_patch_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.mail_patch";
		this.m.Name = "链甲补块";
		this.m.Description = "一大块链甲片，能附加到任何护甲上以进一步保护脆弱部位。";
		this.m.ArmorDescription = "这件护甲附加了一大块链甲以进一步保护脆弱部位。";
		this.m.Icon = "armor_upgrades/upgrade_09.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_09.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_09.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_09_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_09_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_09_back_dead";
		this.m.Value = 200;
		this.m.ConditionModifier = 20;
		this.m.StaminaModifier = 2;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color]耐久"
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
	}

});

