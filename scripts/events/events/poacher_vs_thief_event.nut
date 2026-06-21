this.poacher_vs_thief_event <- this.inherit("scripts/events/event", {
	m = {
		Poacher = null,
		Thief = null
	},
	function create()
	{
		this.m.ID = "event.poacher_vs_thief";
		this.m.Title = "露营时…";
		this.m.Cooldown = 150.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]你走出了帐篷，看见 %poacher% 和 %thief% 互相讲着故事。 你不知道一个偷猎者和一个小偷怎么会有共同话题，但是他们似乎相处的很好。 大笑着，%poacher% 又讲了另外一个故事。%SPEECH_ON%从前，我就在这块贵族领地里靠猎鹿为生。 狩猎这些鹿是其中最简单的部分。 有一次我正在一片草地中间处理猎物的时候，我听见了有一阵蹄声。 于是我赶快把一个绳索搭到树上，把打到的鹿绑上去，接着用力把它吊了起来。 没过几分钟，磕嗒磕哒，就看见一个贵族带着一个警察和一群执法者的随从出现在了我的面前。%SPEECH_OFF%%thief% 挑了挑眉毛。%SPEECH_ON%那可真是个危险的境地，先生。%SPEECH_OFF%偷猎者点了点头。%SPEECH_ON%可供我回转的余地就像一个处女夹紧的双腿之间一样。 那个贵族就在我躲着的树底下走着，查看着地上的血迹。 他大喊着叫我自己出来认罪。 我是不会去做这种傻事，但是倒霉的是，那头该死的鹿开始往下滑了。 我伸出手去拉它，但是可能是树枝已经支撑不住了，它折断了。 贵族听见了他的鹿的腹部折断树枝的噼啪声，抬头向上看来，与此同时我正坠向死亡，直到那条该死的绳子缠绕住了我的脚，把我倒吊在了我的领主面前。 我向他们挥了挥手，说“你好啊，伙计们，我也不想以这种方式出现的。”%SPEECH_OFF%小偷开怀大笑，但是脸上露出了几分担忧。%poacher% 向他摆了摆手。%SPEECH_ON% 唉，感谢 神明，他们也觉得我蛮好笑的。 我只是在地牢里呆了短短六个月就是了。 也没什么大不了的，真的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Right.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Poacher.getImagePath());
				this.Characters.push(_event.m.Thief.getImagePath());
				_event.m.Poacher.improveMood(1.0, "建立友谊与 " + _event.m.Thief.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Poacher.getMoodState()],
					text = _event.m.Poacher.getName() + this.Const.MoodStateEvent[_event.m.Poacher.getMoodState()]
				});
				_event.m.Thief.improveMood(1.0, "建立友谊与 " + _event.m.Poacher.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
					text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
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

		local poacher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.poacher")
			{
				poacher_candidates.push(bro);
			}
		}

		if (poacher_candidates.len() == 0)
		{
			return;
		}

		local thief_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.thief")
			{
				thief_candidates.push(bro);
			}
		}

		if (thief_candidates.len() == 0)
		{
			return;
		}

		this.m.Poacher = poacher_candidates[this.Math.rand(0, poacher_candidates.len() - 1)];
		this.m.Thief = thief_candidates[this.Math.rand(0, thief_candidates.len() - 1)];
		this.m.Score = (poacher_candidates.len() + thief_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"poacher",
			this.m.Poacher.getNameOnly()
		]);
		_vars.push([
			"thief",
			this.m.Thief.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Poacher = null;
		this.m.Thief = null;
	}

});

