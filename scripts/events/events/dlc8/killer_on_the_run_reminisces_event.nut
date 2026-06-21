this.killer_on_the_run_reminisces_event <- this.inherit("scripts/events/event", {
	m = {
		Killer = null
	},
	function create()
	{
		this.m.ID = "event.killer_on_the_run_reminisces";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_46.png[/img]{你甚至不知道他从哪冒出来的。%killer%随意地提到这里埋藏着一具尸体。你知道他是个逃犯杀手，但你礼貌地询问他是如何得知的。他干脆地回答：%SPEECH_ON%因为我就是杀了他并将尸体藏在这里。你知道，这是一次完美的杀戮，因为这个人被疾病折磨得不堪重负。%SPEECH_OFF%听到“疾病”这个词，解剖学家们仿佛看到了一只小老鼠，纷纷转过头来。很快，医疗队就开始挖掘尸体。他们讨论该尸体可能携带的疾病，你不太了解，但他们一致认为了解这个将对他们的研究有巨大的进展。讨论结束后，%killer%冲你做了个鬼脸。他说他杀死那个人是因为他喜欢，而且看到尸体再次出现很高兴。%SPEECH_ON%只可惜那些蠢蛋搞砸了它。它应该得到更好的照顾，更...多的时间。%SPEECH_OFF%你从那个人身边慢慢地退开，让这个怪异的团队重新上路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我选择了...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Killer.getImagePath());
				_event.m.Killer.improveMood(1.0, "回忆起一次旧杀戮。");
				local resolveBoost = this.Math.rand(1, 3);
				_event.m.Killer.getBaseProperties().Bravery += resolveBoost;
				_event.m.Killer.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Killer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});

				if (_event.m.Killer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Killer.getMoodState()],
						text = _event.m.Killer.getName() + this.Const.MoodStateEvent[_event.m.Killer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.anatomist")
					{
						bro.addXP(50, false);
						bro.updateLevel();
						this.List.push({
							id = 16,
							icon = "ui/icons/xp_received.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+50[/color] 经验值"
						});
						bro.improveMood(1.0, "得检查一个有趣的枯萎腐尸。");

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
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local killer_candidates = [];
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.killer_on_the_run")
			{
				killer_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (killer_candidates.len() == 0 || anatomist_candidates.len() <= 1)
		{
			return;
		}

		this.m.Killer = killer_candidates[this.Math.rand(0, killer_candidates.len() - 1)];
		this.m.Score = killer_candidates.len() * 1000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"killer",
			this.m.Killer.getName()
		]);
	}

	function onClear()
	{
		this.m.Killer = null;
	}

});

