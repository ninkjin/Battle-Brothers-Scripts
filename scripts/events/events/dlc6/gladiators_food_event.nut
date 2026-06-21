this.gladiators_food_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator = null
	},
	function create()
	{
		this.m.ID = "event.gladiators_food";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_155.png[/img]{角斗士们在要求更好的食物。%SPEECH_ON%抱歉，“队长”，但是你让我拿这东西怎么办？%SPEECH_OFF%%gl% 举起一片面包。%SPEECH_ON%肉呢？看看它。看。着它。 谁做的这个？面包师？ 你想让我吃面包师烤出来的软玩意？ 我想吃些会反抗的东西。 面包会反抗吗？ 我不这么认为。%SPEECH_OFF%看起来角斗士或许离竞技场很远但是并没有忘记那里的厨师每天提供的美食。 或许你应该找点更高档的食物来平息他们。 | %SPEECH_START%好东西在哪，哏？%SPEECH_OFF%%gl% 举起一份食物。 它被卷成一条从他的手中垂下。%SPEECH_ON%这不是角斗士该有的食物，这是软蛋的食物！%SPEECH_OFF%他转过身来，把食物扔了出去，食物拍打在战队载重货车的侧面，没有粘住然后便像个倒挂的钩子般软了下来。%SPEECH_ON%我们要求更好的食物，队长！ 不是这些变质的玩意。%SPEECH_OFF%你或许应该试着给角斗士安排点符合他们标准的食物。 | %SPEECH_START%酒呢？美食呢！%SPEECH_OFF%%gl% 拿着他的一盘食物并把它像飞盘一样扔出去。 它飞的还挺远，食物洒呈一个锥形。%SPEECH_ON%我要求美食，队长！ 我的美食在哪里？%SPEECH_OFF%看起来角斗士需要更高质量的食物。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你已经花了我不少钱了！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.gladiator" && bro.getFlags().get("IsPlayerCharacter"))
					{
						bro.worsenMood(1.5, "需要更好的食物");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.gladiators")
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasExquisiteFood = false;

		foreach( item in stash )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (item.getRawValue() >= 85)
				{
					hasExquisiteFood = true;
					break;
				}
			}
		}

		if (hasExquisiteFood)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gladiator" && bro.getFlags().get("IsPlayerCharacter"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Gladiator = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 40;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gl",
			this.m.Gladiator != null ? this.m.Gladiator.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Gladiator = null;
	}

});

