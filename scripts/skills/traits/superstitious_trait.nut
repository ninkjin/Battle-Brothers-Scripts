this.superstitious_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.superstitious";
		this.m.Name = "迷信";
		this.m.Icon = "ui/traits/trait_icon_26.png";
		this.m.Description = "这东西被诅咒了！这个角色非常迷信，因此面对直接对抗他决心的技能时更加脆弱。";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave"
		];
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]在对恐惧、恐慌、精神控制进行士气检定时的决心"
			}
		];
	}

});

