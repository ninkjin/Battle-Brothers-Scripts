this.ratcatcher_catches_food_event <- this.inherit("scripts/events/event", {
	m = {
		Ratcatcher = null
	},
	function create()
	{
		this.m.ID = "event.ratcatcher_catches_food";
		this.m.Title = "露营时…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img] 随着口粮消耗殆尽，%ratcatcher% 小心地走进了你的帐篷，几声饥饿的人们发出的呻吟在帐篷的屏风关上前传进屋里。 他说他有个解决当前食物不足问题的办法。 你都不想去问那办法是什么，但现在你别无选择。 捕鼠者把一个麻袋甩到桌子上。 袋子的有些地方还在来回颤动，里头传出尖锐的叫声。 他狠狠地往袋子上砸了几拳，然后陪着笑看向你。%SPEECH_ON%不好意思，里头还有个活的！%SPEECH_OFF%老鼠肉在动物肉里算不上有营养，而且也不健康，但至少它们能让战队的人在抵达下一个城镇或农庄前不至于饿死。 你不情不愿的接受了这个让你的手下免于挨饿的提案。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们别无选择…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
				local food = this.new("scripts/items/supplies/strange_meat_item");
				food.setAmount(12);
				this.World.Assets.getStash().add(food);
				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + food.getAmount() + "[/color] 老鼠肉"
					}
				];
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Ratcatcher.getID())
					{
						continue;
					}

					if (bro.getBackground().isNoble())
					{
						bro.worsenMood(1.0, "对你的领导失去信心");
						bro.worsenMood(2.0, "拿老鼠肉当饭吃");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					{
						local r = this.Math.rand(1, 5);

						if (r == 1 && !bro.getBackground().isLowborn())
						{
							bro.worsenMood(1.0, "拿老鼠肉当饭吃");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
						else if (r == 2 && !bro.getSkills().hasSkill("injury.sickness"))
						{
							local effect = this.new("scripts/skills/injury/sickness_injury");
							bro.getSkills().add(effect);
							this.List.push({
								id = 10,
								icon = effect.getIcon(),
								text = bro.getName() + "生病了"
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() > 15)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.ratcatcher")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Ratcatcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"ratcatcher",
			this.m.Ratcatcher.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Ratcatcher = null;
	}

});

