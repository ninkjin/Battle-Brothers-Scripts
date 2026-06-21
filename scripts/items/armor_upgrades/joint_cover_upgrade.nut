this.joint_cover_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.joint_cover";
		this.m.Name = "金属关节护盘";
		this.m.Description = "一对能覆盖肩膀脆弱关节的大型金属护盘。";
		this.m.ArmorDescription = "附加了一对大型金属护盘以保护肩膀脆弱关节。";
		this.m.Icon = "armor_upgrades/upgrade_10.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_10.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_10.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_10_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_10_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_10_back_dead";
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

