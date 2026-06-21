this.negative_falling_apart_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.negative_falling_apart";
		this.m.Name = "四分五裂";
		this.m.Description = "";
		this.m.ArmorDescription = "这盔甲快散架了。长期的使用和疏于维护使它处于一种无法修理的可悲状态。";
		this.m.Icon = null;
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_downgrade_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_downgrade_01.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "downgrade_01_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "downgrade_01_back";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "downgrade_01_back_dead";
		this.m.Value = -200;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "无盔甲附件位置"
		});
	}

	function onAdded()
	{
		this.m.Armor.m.Condition += -20;
		this.m.Armor.m.ConditionMax += -20;
	}

});

