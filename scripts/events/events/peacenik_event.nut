this.peacenik_event <- this.inherit("scripts/events/event", {
	m = {
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.peacenik";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_40.png[/img]正在路上走着，你遇到了一个男人，他正盯着地上的一个洞看。 很自然地，你走过去问他在做什么。 他说洞里有一只兽人。 你往下一看。还真有。 你拔出配剑，问自己是否应该照顾照顾它。%SPEECH_ON%什么？不！我想让它活着。 我想我们可以试着去理解它。%SPEECH_OFF%试着去理解它？这个男人在说什么？他恳求着。%SPEECH_ON%让我们试试吧！ 每个人看到兽人都会杀，但它们不仅仅是动物。 它们表现出智慧，如果它们有智慧，那就意味着它们能学习，如果它们能学习，那么也许它们能学会与我们共存。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "狗也很聪明，但我们怎么对待坏狗呢？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "对的。祝你好运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_40.png[/img]%houndmaster% 点头，解释说，不管一只动物多么聪明或训练有素，它仍然是一只动物。 和平主义者想了一会儿。%SPEECH_ON%呃－不过，它不仅仅是一只狗！%SPEECH_OFF%你的驯兽师抓住那人的肩膀。%SPEECH_ON%但是你已经把它逼得走投无路了，不是吗？ 你认为一个拥有智慧的人在这种情况下会做什么，他的背后是墙而敌人就在眼前？ 现在不是交“和平”朋友的时候，无论是与人类还是野兽。%SPEECH_OFF%陌生人慢慢地开始点头。 他看到了争论的意义，谢天谢地，没有再阻碍你解决掉兽人。 解决掉兽人以后，那人给了你一袋克朗。%SPEECH_ON%我想试着用这些克朗来保值增值。 如果你没有出现，我现在可能已经死了，很明显，现在不会发生这种事了。 把这当作我的谢意，佣兵。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常感谢。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				this.World.Assets.addMoney(50);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]50[/color] 克朗"
				});
				_event.m.Houndmaster.getBaseProperties().Bravery += 1;
				_event.m.Houndmaster.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Houndmaster.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Houndmaster.improveMood(1.0, "讲授动物的本性");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Houndmaster.getMoodState()],
					text = _event.m.Houndmaster.getName() + this.Const.MoodStateEvent[_event.m.Houndmaster.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.houndmaster")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"houndmaster",
			this.m.Houndmaster.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Houndmaster = null;
	}

});

