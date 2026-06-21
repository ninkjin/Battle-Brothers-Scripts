this.arena_fighter_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.arena_fighter";
		this.m.Name = "角斗士";
		this.m.Icon = "ui/traits/trait_icon_74.png";
		this.m.Description = "听到人群高呼你的名字会让人上瘾。这个角色开始享受竞技场里的生死角斗并用取悦观众的方式解决敌人。";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]决心"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 5;
	}

});

