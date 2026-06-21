this.oath_of_valor_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.oath_of_valor";
		this.m.Name = "英勇誓言";
		this.m.Icon = "ui/traits/trait_icon_83.png";
		this.m.Description = "这个角色已经立下英勇誓言，发誓在战斗中不惜一切代价坚持到底。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "不会逃离战斗"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color]经验获取"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 0.85;
	}

});

