this.anatomist_dissects_beetles_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_dissects_beetles";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{你发现%anatomist%蹲在一块木头上。他将三只甲虫排列在那里。其中一只被针刺在木头上，它的小腿无助地蹬着。另一只只剩下一个身体壳，它的腿被割去并放在它旁边。最后一只在一小罐水中，上面压着一块石头。%anatomist%摇了摇头。%SPEECH_ON%这些生物所能承受的压力是相当惊人的。身体上的损伤并不像我们一样意味着毁灭。以这三个为例:穿刺，肢解和淹水。但它们都还活着。效率是非常高的，你不同意吗？%SPEECH_OFF%当然。你问他从哪里弄来那些甲虫。他耸了耸肩。%SPEECH_ON%我们睡觉时它们正爬满我们全身。我只是碰巧熬夜抓到了一些。比如这只浸水的，在你的耳朵上啄啄啄时，我就抓住了它。%SPEECH_OFF%你告诉他继续他的研究，并尽可能多地捕捉甲虫。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我得开始戴头盔睡觉了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				_event.m.Anatomist.improveMood(1.0, "迷恋甲虫。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

