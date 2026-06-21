this.determined_delivers_peptalk_event <- this.inherit("scripts/events/event", {
	m = {
		Determined = null
	},
	function create()
	{
		this.m.ID = "event.determined_delivers_peptalk";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_58.png[/img]你开始担心一种不祥之兆会降临在队员们身上。 他们围坐在篝火旁，没头没脑地往火里加木头。 每一张脸都表现出一种控制的缺失，确切说是掌握自己命运的那种缺失。 如果一个人不知道明天会不会比今天更好，那他怎么能继续前进呢？ 就在你要回答这个问题的时候，%determined% 站了起来，表情是如此的沮丧，但他快速转换情绪的能力让整个战队都感到震惊。%SPEECH_ON%看看你们这些可怜的家伙。 你认为你是独一无二的吗？ 你以为你是第一个觉得自己很糟糕的人吗？ 不，当然不。 你不应该是第一个放弃的人。 躺下，就不再起来。 这是一件容易的事。 这就是这个世界想搞你的。 周围操蛋的事多了去了，如果你不想在这种我们称之为生活的惩罚中消沉，就没有必要像你们这样把事情想得一团糟。%SPEECH_OFF%这番话一出，你就看到整个战队一片欢腾。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这家伙说得对！",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Determined.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_58.png[/img]%determined% 继续说着，他的拇指几乎扎进了胸膛。%SPEECH_ON%我不是想说世界有多操蛋。 我要让全世界为我们道歉。 我没有请求任何邀请，所以我没有在这个操蛋的派对上表现得很好。 下辈子见，兄弟们，但在那之前，让我们在此生共舞吧！%SPEECH_OFF%一阵欢呼爆发了，队员们站了起来，以一种兴高采烈的方式爆发了出来，仿佛大地把他们一直拴在一起。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "讲得好，讲得好！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Determined.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getMoodState() <= this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "受启发于" + _event.m.Determined.getNameOnly() + "的演讲");

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
		if (this.World.Assets.getAverageMoodState() >= this.Const.MoodState.Concerned)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getSkills().hasSkill("trait.determined"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Determined = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 6;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"determined",
			this.m.Determined.getName()
		]);
	}

	function onClear()
	{
		this.m.Determined = null;
	}

});

