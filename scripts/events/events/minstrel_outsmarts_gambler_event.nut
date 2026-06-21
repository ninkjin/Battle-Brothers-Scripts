this.minstrel_outsmarts_gambler_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		Gambler = null
	},
	function create()
	{
		this.m.ID = "event.minstrel_outsmarts_gambler";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img] %gambler%，这个赌品有问题的家伙，他显然是想在营地里到处找几个人来玩马蹄铁游戏－当然，要赌几个钱。 看起来 %minstrel%，那个狡猾的吟游诗人，已经答应了他并下了赌注。 他说他很擅长赌博赌徒反驳他说自己是最好的。 \n\n 那两个人举起马蹄铁不断投掷直到胳膊累了太阳下山。 没有人是赢家因为他们两个不分胜负。在又一轮相持不下的对决之后，%minstrel% 说如果还想再比那么就只能使用左手不然就算了。%gambler% 同意了。 他先上，掷出去三个马蹄铁。 前两个都偏离了目标，但是最后一个套在木桩上面打着圈。 他咧嘴一笑祝吟游诗人好运。%minstrel% 点了点头并且把袖子撸起来。 他吐了吐舌头并且眨了一下眼睛，瞄准他的目标。 他的脚就像在做踢踏舞并且在他扔出去之前他回过身看了一下那名赌徒说，%SPEECH_ON%哦不好意思我是一个左撇子。%SPEECH_OFF%那个吟游诗人不加思索地把马蹄铁扔了出去。 这次投掷非常完美正好落在木桩的正中央，接下来的两次抛得如此之快如此天衣无缝任何观看的人都会爆发出巨大的喝彩。 赌徒只能不敢置信地闭上嘴。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很有用却无耻的小聪明。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Gambler.getImagePath());
				_event.m.Minstrel.improveMood(1.0, "智胜 " + _event.m.Gambler.getName());

				if (_event.m.Minstrel.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Minstrel.getMoodState()],
						text = _event.m.Minstrel.getName() + this.Const.MoodStateEvent[_event.m.Minstrel.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_minstrel = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.minstrel")
			{
				candidates_minstrel.push(bro);
			}
		}

		if (candidates_minstrel.len() == 0)
		{
			return;
		}

		local candidates_gambler = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gambler")
			{
				candidates_gambler.push(bro);
			}
		}

		if (candidates_gambler.len() == 0)
		{
			return;
		}

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.Gambler = candidates_gambler[this.Math.rand(0, candidates_gambler.len() - 1)];
		this.m.Score = (candidates_minstrel.len() + candidates_gambler.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"gambler",
			this.m.Gambler.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.Gambler = null;
	}

});

