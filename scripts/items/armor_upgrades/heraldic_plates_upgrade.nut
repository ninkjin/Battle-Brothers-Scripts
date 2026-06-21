this.heraldic_plates_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.heraldic_plates";
		this.m.Name = "纹章护肩";
		this.m.Description = "用来固定在护甲肩膀处的大型护肩。";
		this.m.ArmorDescription = "这件护甲的肩部固定了大型护肩。";
		this.m.Variant = this.Math.rand(14, 18);
		this.updateVariant();
		this.m.Value = 500;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = 4;
	}

	function updateVariant()
	{
		local variant = this.m.Variant;

		if (variant < 10)
		{
			variant = "0" + variant;
		}

		this.m.Icon = "armor_upgrades/upgrade_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_" + variant + ".png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_" + variant + ".png";
		this.m.SpriteFront = "upgrade_" + variant + "_front";
		this.m.SpriteBack = "upgrade_" + variant + "_back";
		this.m.SpriteDamagedFront = "upgrade_" + variant + "_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_" + variant + "_back_damaged";
		this.m.SpriteCorpseFront = "upgrade_" + variant + "_front_dead";
		this.m.SpriteCorpseBack = "upgrade_" + variant + "_back_dead";
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

