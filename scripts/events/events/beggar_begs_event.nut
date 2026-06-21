this.beggar_begs_event <- this.inherit("scripts/events/event", {
	m = {
		Beggar = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.beggar_begs";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{在你拿取清单上的货物的时候，你不禁注意到了 %beggar% 逗留在你附近。 叹息着，你终于看向了从前的乞丐并且问他，他想要什么。 就像穷人中最穷的的人一样，他伸出了一只手，问你能不能给他一些克朗。 | 像提前练习过的舞台表演一样，%beggar% 接近了你并且讲了一个很长的关于麻烦、斗嘴、和空瓶子的传说。 曾经的乞丐的运气已经很少了，显然的，他只需要多几枚克朗来勉强过活。 | %otherguy% 告诉你那个 %beggar% 正围绕着营地转悠乞讨一些克朗。 显然的，那个曾经的乞丐只需要一点点更多的东西，他期待能呜咽着给任何会听的人说一个漫长的故事。 听到了这个消息，你自己去会了会那个人，但是在你能说出一个字之前，那个人就开始了他的叙述。 完成了以后，他直视着你，试着判断出你会不会给他些东西。 | 显然的，%beggar% 曾经的乞丐需要些帮助。 他来到了你的面前，祈求几枚克朗来让他过活。 那个男人他看起来像是在贫穷状况下，但是他已经大量地练习过了假装真的贫穷，所以很难说他是真的贫穷，还是假的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "回去干活儿！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "给你，这里有些克朗。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beggar.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你告诉那个男人你会用一把剑穿透他的手如果他不回去工作的话。 男人耸耸肩，并且真的如你所说的那样做了。 这比想的要容易。 | 乞丐的肩膀在你告诉他回去干活儿的时候垂了下来。 你感到有一点不好，但是想起来了他们就是这样得到你的同情的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ok.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beggar.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{乞丐拿了克朗，笑了出来，并且马上回去工作了。 | 对他的这种游戏感到厌烦，你给了乞丐一点克朗并且告诉他回去干活儿。 他鞠了个躬，并且感谢了你，而且令人惊讶的，他真的回去干活儿了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ok.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beggar.getImagePath());
				this.World.Assets.addMoney(-10);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]10[/color] 克朗"
				});
				_event.m.Beggar.improveMood(0.5, "从你这多拿了几个克朗");

				if (_event.m.Beggar.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Beggar.getMoodState()],
						text = _event.m.Beggar.getName() + this.Const.MoodStateEvent[_event.m.Beggar.getMoodState()]
					});
				}
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

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beggar")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Beggar = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;

		do
		{
			local bro = brothers[this.Math.rand(0, brothers.len() - 1)];

			if (bro.getID() != this.m.Beggar.getID())
			{
				this.m.OtherGuy = bro;
			}
		}
		while (this.m.OtherGuy == null);
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"beggar",
			this.m.Beggar.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Beggar = null;
		this.m.OtherGuy = null;
	}

});

