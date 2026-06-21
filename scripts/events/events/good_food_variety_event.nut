this.good_food_variety_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.good_food_variety";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_61.png[/img]{餐盘里的食物就像人们的性格那样丰富多彩。 能够让大家吃上如此丰富的食物无疑会大大提振士气！ | 人人都得吃上一顿热腾腾的饱饭，若不仅是一餐热饭，再加上几件配菜和点心？ 那可就太棒了！ 你所提供的丰富多样的食物让人们大饱口福之余还提振了士气。 | 你们的伙食比得上贵族盛宴－或者至少差不多吧。 你能以如此丰盛的美食喂饱战队，使得大家在大饱口福之余对你心怀感激。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Enjoy.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.spartan"))
					{
						continue;
					}
					else if (bro.getSkills().hasSkill("trait.gluttonous") || bro.getSkills().hasSkill("trait.fat"))
					{
						bro.improveMood(2.0, "非常感谢食物的多样性");
					}
					else
					{
						bro.improveMood(1.0, "欣赏食物的多样性");
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local hasBros = false;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.spartan"))
			{
				continue;
			}

			hasBros = true;
			break;
		}

		if (!hasBros)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local food = [];

		foreach( item in stash )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (food.find(item.getID()) == null)
				{
					food.push(item.getID());
				}
			}
		}

		if (food.len() < 4)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

