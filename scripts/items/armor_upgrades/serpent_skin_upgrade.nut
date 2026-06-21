this.serpent_skin_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.serpent_skin";
		this.m.Name = "大蛇皮披风";
		this.m.Description = "一件用沙漠大蛇轻薄闪光的鳞片制成的披风，尤其更耐高温和火焰。";
		this.m.ArmorDescription = "一件大蛇皮披风附加在这件盔甲上，使它更耐高温和火焰";
		this.m.Icon = "armor_upgrades/upgrade_27.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_27.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_27.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_27_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_27_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_27_back_dead";
		this.m.Value = 600;
		this.m.ConditionModifier = 30;
		this.m.StaminaModifier = 2;
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
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color]最大疲劳"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "来自火焰和火器的伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "来自火焰和火器的伤害降低[color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
	}

	function onEquip()
	{
		this.item.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onUnequip()
	{
		this.item.onUnequip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
	}

	function onAdded()
	{
		this.armor_upgrade.onAdded();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onRemoved()
	{
		this.armor_upgrade.onRemoved();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
	}

});

