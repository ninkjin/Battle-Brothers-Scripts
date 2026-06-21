this.arena_veteran_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.arena_veteran";
		this.m.Name = "角斗大师";
		this.m.Icon = "ui/traits/trait_icon_75.png";
		this.m.Description = "作为一个有着许多伤疤的角斗大师，这个角色知道如何让观众为血腥的场面欢呼。获胜的几率越低，娱乐效果越好！";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		local matches = this.getContainer().getActor().getFlags().getAsInt("ArenaFights");
		local won = this.getContainer().getActor().getFlags().getAsInt("ArenaFightsWon");

		if (won == matches)
		{
			won = "每一";
		}

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription() + "到目前为止，这个角色参加了" + matches + "场比赛并赢了" + won + "场。"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color]决心"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]几率被击倒而不是直接死亡，前提未遭到必死击杀"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 10;
		_properties.SurviveWithInjuryChanceMult *= 1.51;
	}

});

