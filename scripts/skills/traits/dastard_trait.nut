this.dastard_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.dastard";
		this.m.Name = "畏缩";
		this.m.Icon = "ui/traits/trait_icon_38.png";
		this.m.Description = "这个角色会在任何可能的情况下逃跑。最好盯着他点。";
		this.m.Titles = [
			"胆小鬼",
			"懦夫",
			"小鸡"
		];
		this.m.Excluded = [
			"trait.determined",
			"trait.brave",
			"trait.deathwish",
			"trait.bloodthirsty",
			"trait.fearless",
			"trait.cocky",
			"trait.optimist",
			"trait.hate_greenskins",
			"trait.hate_undead",
			"trait.hate_beasts"
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
				icon = "ui/icons/morale.png",
				text = "将以动摇的士气开始战斗"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "总是满足于充当后备"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoodState() >= this.Const.MoodState.Disgruntled && actor.getMoraleState() > this.Const.MoraleState.Wavering)
		{
			actor.setMoraleState(this.Const.MoraleState.Wavering);
		}
	}

});

