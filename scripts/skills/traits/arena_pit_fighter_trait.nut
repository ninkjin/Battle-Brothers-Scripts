this.arena_pit_fighter_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.pit_fighter";
		this.m.Name = "斗士";
		this.m.Icon = "ui/traits/trait_icon_73.png";
		this.m.Description = "这个角色刚刚涉足角斗这种野蛮行当，并活着完成了它。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getTooltip()
	{
		local matches = this.getContainer().getActor().getFlags().getAsInt("ArenaFights");
		local won = this.getContainer().getActor().getFlags().getAsInt("ArenaFightsWon");
		local text;

		if (matches == 1)
		{
			text = "到目前为止，这个角色参加了一场比赛";

			if (won == 1)
			{
				text = text + "并且赢了。";
			}
			else
			{
				text = text + "但是输了。";
			}
		}
		else
		{
			if (won == matches)
			{
				won = "每一";
			}

			text = "到目前为止，这个角色参加了" + matches + "场比赛并赢了" + won + "场。";
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
				text = this.getDescription() + text
			}
		];
	}

});

