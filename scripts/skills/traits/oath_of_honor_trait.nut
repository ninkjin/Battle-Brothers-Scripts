this.oath_of_honor_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.oath_of_honor";
		this.m.Name = "荣誉誓言";
		this.m.Icon = "ui/traits/trait_icon_82.png";
		this.m.Description = "这个角色已经立下荣誉誓言，发誓将用近身战斗夺取胜利。";
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
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "如果心情允许，将以自信的士气开始战斗。"
			},
			{
				id = 11,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "不能使用远程攻击或工具"
			}
		];
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoodState() >= this.Const.MoodState.Neutral && actor.getMoraleState() < this.Const.MoraleState.Confident)
		{
			actor.setMoraleState(this.Const.MoraleState.Confident);
		}
	}

});

