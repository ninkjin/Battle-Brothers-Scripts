this.sled_race_event <- this.inherit("scripts/events/event", {
	m = {
		Sledder = null,
		Fat = null,
		Blind = null
	},
	function create()
	{
		this.m.ID = "event.sled_race";
		this.m.Title = "在途中…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]{当凌冽的寒风夹裹着雪花拍打在你脸上时，似乎有人在山上向你招手示意，这简直难以置信。 但就在那，手里拿着雪橇留着胡子的家伙。 他大声问你是否对比赛感兴趣。%SPEECH_ON%谁先到那个鸡头型断崖的石头那谁就赢！%SPEECH_OFF%你问玩这危险游戏干嘛。 他像说错话的狗一样看着你，随后你问他赌什么。他笑着说。%SPEECH_ON%不赌什么！只是为了好玩！%SPEECH_OFF%足够好了。也许 %companyname% 想试试？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有人站出来了！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Fat != null)
				{
					this.Options.push({
						Text = "看起来 %fat% 想来试试。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Blind != null)
				{
					this.Options.push({
						Text = "看起来 %shortsighted% 想来试试。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Options.push({
					Text = "我们有更重要的事要做。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_143.png[/img]{%sledder% 从山地人那拿过雪橇。%SPEECH_ON%我会在适当的时候把你打败。%SPEECH_OFF%当他固定好雪橇时，大家都纷纷挑了挑眉毛。 他把雪橇前头翘起来身子向着坡道倾斜。%SPEECH_ON%准备好了。%SPEECH_OFF%山地人发出信号，两人立即开始了比赛。 你不确定你的人是否做了手脚，但是山地人突然偏离了赛道人仰马翻地摔了出去，雪沾了一身。与此同时 %sledder% 轻松取得了胜利。 你的人欢呼着胜利并把他高举过头顶。 但如果你的人真作弊了，那在山地人的脸上是看不出来的，他只是很高兴他参加了比赛。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很不错！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sledder.getImagePath());
				_event.m.Sledder.getBaseProperties().Initiative += 1;
				_event.m.Sledder.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Sledder.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 主动性"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

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
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_143.png[/img]{%sledder% 从山地人那拿过雪橇。%SPEECH_ON%我会在适当的时候把你打败。%SPEECH_OFF%当他固定好雪橇时，大家都纷纷挑了挑眉毛。 他把雪橇前头翘起来身子向着坡道倾斜。%SPEECH_ON%准备好了。%SPEECH_OFF%山地人发出信号，两人立即开始了比赛。 快到鸡尾型断崖末端的时候比赛仍十分胶着，眼看 %sledder% 就要获胜的时候，因滑行角度失误直接撞上了那石头。 雪橇撞成了碎片，这家伙从石头上飞了过去，幸好落在了松软的雪堆里。 你的人大笑着跑过去帮他重新站起来。 他喘着粗气可能什么地方摔断了身上咔嗒作响，但他还活着。 山地人欢呼雀跃。%SPEECH_ON%你差点就干翻我了，但你的目标应该是停在鸡尾型断崖的石头那，而不是干上去。%SPEECH_OFF%这让你的人哭笑不得。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ouch.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sledder.getImagePath());
				local injury = _event.m.Sledder.addInjury(this.Const.Injury.Mountains);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Sledder.getName() + " 遭受 " + injury.getNameOnly()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Sledder.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_08.png[/img]{%fat% 这是战队手里最胖的人，他决定试试。 你觉得不错－考虑到他的体重他可能会直接冲到终点。 山地人欣然接受比赛，制定好规则后比赛正式开始。 两人轻松地在雪地穿梭，正如你想的一样，胖子在溅起的雪花中咆哮，就像闪电穿云一样壮观。 他速度惊人。 胖子乘风破浪越战越勇，但没法刹车减速了。 他从悬崖上疾驰而过，人就这么没了。 山地人跑过来做个鬼脸。%SPEECH_ON%他还活着！身体可能缺了点什么，但还活着！%SPEECH_OFF%虽然你非常担心，但当你回头的时候，你发现你的人要么笑趴在地要么哭笑不得。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "哦，上帝呀！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Fat.getImagePath());
				local injury = _event.m.Fat.addInjury(this.Const.Injury.Mountains);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Fat.getName() + " 遭受 " + injury.getNameOnly()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Fat.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

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
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_143.png[/img]{%shortsighted% 愿意跟山地人比比。 考虑到他是个近视眼，你不太愿意让他参加，但他在这事儿上表现的挺积极的。 当他坐在雪橇上开始绑绳子，不断向山下瞥的时候，你不由得担心起来他能不能分清楚石头和雪堆的区别。%SPEECH_ON%准备！%SPEECH_OFF%山地人定完规则比赛就开始了。 近视眼几乎一开始就偏离了赛道。 他的头一下子就撞上了一块石头，但谢天谢地，他还没起速。 雪橇就像砸在墙上的西红柿一样摔碎了，近视眼就像馅饼一样撞在石头上。 你跑过去帮他站起来，但你突然觉得你的脚下好像踩着什么很硬的玩意。 一个宝箱！你叫你的人来照顾他然后你拼命的开始挖。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "老天开眼了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Blind.getImagePath());
				local injury = _event.m.Blind.addInjury(this.Const.Injury.Mountains);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Blind.getName() + " 遭受 " + injury.getNameOnly()
				});
				local item = this.new("scripts/items/loot/ancient_gold_coins_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Mountains)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_fat = [];
		local candidates_blind = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.fat"))
			{
				candidates_fat.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.short_sighted"))
			{
				candidates_blind.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Sledder = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_fat.len() != 0)
		{
			this.m.Fat = candidates_fat[this.Math.rand(0, candidates_fat.len() - 1)];
		}

		if (candidates_blind.len() != 0)
		{
			this.m.Blind = candidates_blind[this.Math.rand(0, candidates_blind.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"sledder",
			this.m.Sledder.getNameOnly()
		]);
		_vars.push([
			"fat",
			this.m.Fat ? this.m.Fat.getNameOnly() : ""
		]);
		_vars.push([
			"shortsighted",
			this.m.Blind ? this.m.Blind.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Sledder = null;
		this.m.Fat = null;
		this.m.Blind = null;
	}

});

