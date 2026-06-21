this.shepherd_vs_ratcatcher_event <- this.inherit("scripts/events/event", {
	m = {
		Shepherd = null,
		Ratcatcher = null
	},
	function create()
	{
		this.m.ID = "event.shepherd_vs_ratcatcher";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%ratcatcher% 和 %shepherd% 正一起坐在篝火旁。 随着他们谈话的继续，捕鼠者变得有点困惑。%SPEECH_ON%让我，让我，让我把话说清楚。 你－你用一根棍子，它们跟你走，因为你有棍子？ 就是因为那根棍子么？%SPEECH_OFF%点着头，牧羊人解释道。%SPEECH_ON%我更喜欢叫它权杖，不过是的。 羊是简单的动物，它们所需要的只是一个领导者。 这个权杖是我工作职责象征。 我挥舞着权杖，所以我是领导者。 至少在小绵羊眼里是这样的。 一只听话的狗也很有帮助。 说实话，一只狗可能成为真正的领袖，如果它们没有我们所期望和想要的忠诚和荣誉。%SPEECH_OFF%%ratcatcher% 点了点头。%SPEECH_ON%我得试试那根棍子，我说的是那根权杖，用来对付我的老鼠。 再养条狗。%SPEECH_OFF%牧羊人笑了。%SPEECH_ON%或者一只猫。什么？ 我在开玩笑，朋友，只是开玩笑。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就像豆荚里的豌豆。 还是猪圈里的猪？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Shepherd.getImagePath());
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
				_event.m.Shepherd.improveMood(1.0, "建立友谊与 " + _event.m.Ratcatcher.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Shepherd.getMoodState()],
					text = _event.m.Shepherd.getName() + this.Const.MoodStateEvent[_event.m.Shepherd.getMoodState()]
				});
				_event.m.Ratcatcher.improveMood(1.0, "建立友谊与 " + _event.m.Shepherd.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Ratcatcher.getMoodState()],
					text = _event.m.Ratcatcher.getName() + this.Const.MoodStateEvent[_event.m.Ratcatcher.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local shepherd_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 4 && bro.getBackground().getID() == "background.shepherd")
			{
				shepherd_candidates.push(bro);
				break;
			}
		}

		if (shepherd_candidates.len() == 0)
		{
			return;
		}

		local ratcatcher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.ratcatcher")
			{
				ratcatcher_candidates.push(bro);
			}
		}

		if (ratcatcher_candidates.len() == 0)
		{
			return;
		}

		this.m.Shepherd = shepherd_candidates[this.Math.rand(0, shepherd_candidates.len() - 1)];
		this.m.Ratcatcher = ratcatcher_candidates[this.Math.rand(0, ratcatcher_candidates.len() - 1)];
		this.m.Score = (shepherd_candidates.len() + ratcatcher_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shepherd",
			this.m.Shepherd.getNameOnly()
		]);
		_vars.push([
			"ratcatcher",
			this.m.Ratcatcher.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Shepherd = null;
		this.m.Ratcatcher = null;
	}

});

