this.player_character_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.player";
		this.m.Name = "玩家角色";
		this.m.Icon = "ui/traits/trait_icon_63.png";
		this.m.Description = "这是你的玩家角色，换句话说就是你自己。如果他死了，你的战役就结束了。你不能解雇他，他也永远不会抛弃你。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
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
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]决心"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 10;
	}

});

