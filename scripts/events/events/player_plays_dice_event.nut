this.player_plays_dice_event <- this.inherit("scripts/events/event", {
	m = {
		Gambler = null,
		PlayerDice = 0,
		GamblerDice = 0
	},
	function create()
	{
		this.m.ID = "event.player_plays_dice";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_62.png[/img]走了一天的路之后，在休息的时候，%gambler% 手里拿着一副骰子和一个杯子走到了你的身边。 他问你想不想来玩一个小游戏。 规则非常简单：每个人摇一次骰子，点数高的人获胜。 这是一个好机会！每次的赌注是二十五克朗。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那就来玩玩吧！",
					function getResult( _event )
					{
						_event.m.Gambler.improveMood(1.0, "和你玩了一场骰子游戏");
						_event.m.PlayerDice = this.Math.rand(3, 18);
						_event.m.GamblerDice = this.Math.rand(3, 18);

						if (_event.m.PlayerDice == _event.m.GamblerDice)
						{
							return "D";
						}
						else if (_event.m.PlayerDice > _event.m.GamblerDice)
						{
							return "C";
						}
						else
						{
							return "B";
						}
					}

				},
				{
					Text = "我没有时间干这个。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gambler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_62.png[/img]你掷骰子，一共得到 %playerdice%。\n\n%gambler% 接着，掷得了 %gamblerdice%。\n\n{好吧，你输了。赌徒一把抓走了骰子－和你的二十五克朗一起－并问你还想不想再来一盘。 | 你的骰运似乎不是很好，让赌徒挣到了钱。 他抬头看着你，笑了笑。%SPEECH_ON%再来一盘吗？%SPEECH_OFF% | 你算了算骰出来的点数，哎呀，你输了。 赌徒问你还想不想再来一盘。 | 你输了！但是如果再掷骰一次的话… | 你输了！简单地一骰，普通的失败。 但是这一次却比你在战场上所遭受的失败轻微太多。 赌徒问你还要不要再来一盘。 | 众神躲避着你和你那愚蠢的骰子。 输了游戏是最小的一种失败，但是你的自尊要比这二十五克朗值钱多了。 你要不要再来一盘？ | 神明们背叛了你，仅仅为了这少少的二十克朗。 没准你再掷骰一次就能把它们赢回来？ | 你看着你的骰子不停颤动，有那么一瞬间，你看见了胜利的点数－在它倾斜着倒向另一边之前，这也揭示了你最终的失败。 赌徒笑着问你要不要再来一盘。 | 你的投掷非常完美！ 但是你怎么却输了呢？ 他只要那几个数字就能赢了！ 摇着头，你在想着是否还要再来一盘。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "再掷一次！",
					function getResult( _event )
					{
						_event.m.PlayerDice = this.Math.rand(3, 18);
						_event.m.GamblerDice = this.Math.rand(3, 18);

						if (_event.m.PlayerDice == _event.m.GamblerDice)
						{
							return "D";
						}
						else if (_event.m.PlayerDice > _event.m.GamblerDice)
						{
							return "C";
						}
						else
						{
							return "B";
						}
					}

				},
				{
					Text = "今天就到这吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gambler.getImagePath());
				this.World.Assets.addMoney(-25);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]25[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_62.png[/img]你掷骰子，一共得到 %playerdice%。\n\n%gambler% 接着，掷得了 %gamblerdice%。\n\n{你赢了！赌徒鼓了鼓掌。%SPEECH_ON%新人的好运！%SPEECH_OFF%你把双手抱在胸前。%SPEECH_ON%我觉得，这仅仅是运气好？%SPEECH_OFF%赌徒笑了笑，问你要不要来测试一下你的理论。 | 赌徒向后一靠。%SPEECH_ON%好吧，我会被诅咒的。再来一盘！%SPEECH_OFF% | 赌徒向后一靠。%SPEECH_ON%{好吧，我踏马就是一个马屁 | 如果神明们没有抛弃我的话，那我一定是被诅咒了 | 现在，这是幸运女神一场糟糕的演出 | 我祈求着幸运女神的名字，但是她究竟给我带来了什么 | 好吧，真不幸，至少对于我而言是这样的 | 唔，这是一个胜利的一掷 | 我这是要破产了啊 | 踏马的阉马之子 | 一泡猪屎 | 真晦气，像生病的修女一样 | 我得说这是一次大师级的投掷 | 你这样掷骰就跟抢劫一样 | 也许 %randomtown% 可以加入兽人 | 人们都说瞎松鼠找不到坚果 | 用玫瑰搔我的肛门，然后叫我胜利与和平的公主}，你赢了！让我们再来一盘！%SPEECH_OFF% | 你赢了！微笑着，你拿走了你挣的钱，赌徒问道你还想不想再来一盘。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "再掷一次！",
					function getResult( _event )
					{
						_event.m.PlayerDice = this.Math.rand(3, 18);
						_event.m.GamblerDice = this.Math.rand(3, 18);

						if (_event.m.PlayerDice == _event.m.GamblerDice)
						{
							return "D";
						}
						else if (_event.m.PlayerDice > _event.m.GamblerDice)
						{
							return "C";
						}
						else
						{
							return "B";
						}
					}

				},
				{
					Text = "今天就到这吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gambler.getImagePath());
				this.World.Assets.addMoney(25);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你赢了 [color=" + this.Const.UI.Color.PositiveEventValue + "]25[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_62.png[/img]你掷骰子，一共得到 %playerdice%。\n\n%gambler% 接着，掷得了 %gamblerdice%。\n\n点数一样。 平局！再来？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "再掷一次！",
					function getResult( _event )
					{
						_event.m.PlayerDice = this.Math.rand(3, 18);
						_event.m.GamblerDice = this.Math.rand(3, 18);

						if (_event.m.PlayerDice == _event.m.GamblerDice)
						{
							return "D";
						}
						else if (_event.m.PlayerDice > _event.m.GamblerDice)
						{
							return "C";
						}
						else
						{
							return "B";
						}
					}

				},
				{
					Text = "今天就到这吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gambler.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() <= 100)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gambler" || bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.raider")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Gambler = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gambler",
			this.m.Gambler.getName()
		]);
		_vars.push([
			"playerdice",
			this.m.PlayerDice
		]);
		_vars.push([
			"gamblerdice",
			this.m.GamblerDice
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Gambler = null;
		this.m.PlayerDice = 0;
		this.m.GamblerDice = 0;
	}

});

