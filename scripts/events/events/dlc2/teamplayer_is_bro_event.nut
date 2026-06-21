this.teamplayer_is_bro_event <- this.inherit("scripts/events/event", {
	m = {
		Teamplayer = null
	},
	function create()
	{
		this.m.ID = "event.teamplayer_is_bro";
		this.m.Title = "在途中…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_65.png[/img]{%teamplayer%，总是以团队利益为重，似乎已经单枪匹马地帮助了士气的提升。一个雇佣兵解释道%SPEECH_ON%我不知道该怎么解释。%SPEECH_OFF%另一位表达能力更强的雇佣兵则说道。%SPEECH_ON%他似乎不仅仅是个佣兵，你明白吗？他是我们可以依靠的人。就像一个兄弟一样。当然不是亲兄弟，更像是个义兄。一个好兄弟，如果你愿意这么说的话。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "%teamplayer% 是最好的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teamplayer.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Teamplayer.getID() || this.Math.rand(1, 100) <= 10)
					{
						continue;
					}

					if (!bro.getFlags().has("IsTeamplayerInspired") && this.Math.rand(1, 100) <= 50)
					{
						bro.getFlags().set("IsTeamplayerInspired", true);
						bro.getBaseProperties().Bravery += 1;
						bro.getSkills().update();
						this.List.push({
							id = 16,
							icon = "ui/icons/bravery.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
						});
					}

					bro.improveMood(0.5, "很高兴有个兄弟 " + _event.m.Teamplayer.getName());

					if (bro.getMoodState() > this.Const.MoodState.Neutral)
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local numOthers = 0;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.teamplayer"))
			{
				candidates.push(bro);
			}
			else if (!bro.getFlags().has("IsTeamplayerInspired"))
			{
				numOthers = ++numOthers;
			}
		}

		if (candidates.len() == 0 || numOthers == 0)
		{
			return;
		}

		this.m.Teamplayer = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"teamplayer",
			this.m.Teamplayer.getName()
		]);
	}

	function onClear()
	{
		this.m.Teamplayer = null;
	}

});

