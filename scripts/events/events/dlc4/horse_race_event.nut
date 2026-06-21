this.horse_race_event <- this.inherit("scripts/events/event", {
	m = {
		Other = null,
		Fat = null,
		Athletic = null,
		Dumb = null,
		Reward = 0
	},
	function create()
	{
		this.m.ID = "event.horse_race";
		this.m.Title = "在路上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你遇到了一个牵着一匹高瘦的马的缰绳的男人，那匹马的鬃毛污秽不堪，已经光彩不再。 那马有着灰白色的胡子，它干裂，布满了白色钙质层的嘴唇使劲抽动着想要喝点水。 看见了你，它的主人招了招手。%SPEECH_ON%来，来！我有个为那些足够勇敢、足够快，认为自己能够获胜的人的赌要打！%SPEECH_OFF%对此感到好奇，你问了他那个赌是什么。 男人轻轻拍了拍那匹马，一片尘土因为这一拍飞了起来，并且你能够看到，他留下了一个掌印在马的肩膀上。%SPEECH_ON%和我的马赛跑！不是用别的马，忘了它吧，是用你人类的腿！ 如果你输了，你就给我 %reward% 克朗。 如果你赢了，我给你双倍。 你准备好了吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好。来个人过去和那匹马赛跑！",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Athletic != null)
				{
					this.Options.push({
						Text = "我们最健壮的小伙子，%athlete%，要和那匹马赛跑。",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				if (_event.m.Fat != null)
				{
					this.Options.push({
						Text = "我们最胖的人，%fat%，会为了给我们带来欢乐去赛跑。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Dumb != null)
				{
					this.Options.push({
						Text = "我觉得，只有 %dumb% 足够头脑不清楚，才会去和一匹马赛跑。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Options.push({
					Text = "不了，谢谢。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{你选了 %randombrother% 去试试，看看他能不能胜过那牲口。 比赛的规则看谁第一个到一颗苹果树那儿去，但在你能为你的佣兵开始喝彩之前，马就完全打败了他。 它到了终点线，并且开始为了吃苹果而摆弄树枝。 战队都沉默地坐着，但当 %randombrother% 以隔得很远的最后一名的身份冲过终点线的时候，他们都高兴地放声大笑，就好像他赢下了王国最好的妓院的钥匙。 马的主人笑了。%SPEECH_ON%别为难自己，好心的先生。 快乐是偶然的。%SPEECH_OFF%看起来的确是那个人在精彩比赛中的努力使你的团队感到快乐。} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这确实是很有意思的娱乐。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				this.World.Assets.addMoney(-_event.m.Reward);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Reward + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Other.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 40)
					{
						bro.improveMood(1.0, "感到愉快来自 " + _event.m.Other.getName() + "骑马比赛");

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
			Text = "%terrainImage%{%athlete% 走上前去。他的小腿将他的袜子顶的鼓了起来，他将肩膀转了转来放松。%SPEECH_ON%好啊，我将会和那匹不咋样的马赛跑。%SPEECH_OFF%赌注已经下好了，马的主人把你领向了一条路。 赛道已经准备好了，他拿着一双分开的木钳子，并且将其往后拉，通过一些尖头。 钳子咔嚓一声合上了，当他把绳子切断的时候，比赛开始了。 尽管那匹马没精神得看起来就像个落汤鸡一样，但是它却立即领先了敏捷的佣兵一步。 只有在半路，佣兵的耐力才看起来让他占据了优势，只是他最终还是在重点线输掉了比赛。 马的主人拍了拍他的手。%SPEECH_ON%噢，这可真是很接近的一次比赛！ 是我见过的最接近的一次！%SPEECH_OFF%你点了点头，并且给了他他应得的东西。%athlete% 被打败了，但是尽管如此，看起来这次失败在某些方面上锻炼了他，并且战队也真的挺享受这场精彩的比赛的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不错的尝试。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Athletic.getImagePath());
				this.World.Assets.addMoney(-_event.m.Reward);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Reward + "[/color] 克朗"
				});
				_event.m.Athletic.getBaseProperties().Stamina += 1;
				_event.m.Athletic.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Athletic.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 最大疲劳"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Athletic.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "感到愉快来自 " + _event.m.Athletic.getName() + "骑马比赛");

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
			Text = "%terrainImage%{感到相当的勇敢，你指派战团里最胖的人来解决这场比赛。%fat% 向前走了一步，挑了挑眉毛，问你是否真的确定把他选作你的赛马勇士。 你把你的手放在他的肩上，并且说，他是你所见过的成为佣兵的人里最胖的，但是你相信他。 你还相信，那匹马是虚弱的只剩下一口气的动物，它的生命即将到头了，但是这句话你只在心里说了。\n\n 人和马站到了一起。 一棵苹果树离得不远，第一个到达那里的将成为获胜者。 规则敲定了以后，比赛开始了。 那不是一场很接近的比赛。%fat% 几乎是立即被拉在了后面，他缓慢而沉重的沿着赛道移动着，他的脸红的像甜菜根一样，气喘吁吁，大家几乎要因眼前的景象笑死。 胖胖的佣兵和虚弱的马匹在苹果树后碰面了，在那儿他们分享了他们劳动的果实。 你付给了马匹主人他应得的。 他一边数硬币一边微笑。%SPEECH_ON%不要经常用这种赛跑来当节目，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可是输了钱的，你会再来一次么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Fat.getImagePath());
				this.World.Assets.addMoney(-_event.m.Reward);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Reward + "[/color] 克朗"
				});
				_event.m.Fat.getBaseProperties().Bravery += 1;
				_event.m.Fat.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Fat.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Fat.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "感到愉快来自 " + _event.m.Fat.getName() + "骑马比赛");

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
			Text = "%terrainImage%{你选择了 %dumb%，战队里最大的白痴来当你的赛马勇士。 马的主人看了一眼那个人，随后便挑了挑眉毛。%SPEECH_ON%好吧。好的。%SPEECH_OFF%比赛的规则很清楚：第一个到达不远处的一棵苹果树的，就是胜利者。 人和马在赛道上站成了一线。 假装知道他自己在干嘛，%dumb% 蹲出了一个三尖式。 马的主人喊了一声，在他的牲口的臀部猛地拍了拍。%dumb% 以一个漂亮的大跨步起跑，并且令人惊讶地跑在了马的前面，但是他在跑第二圈的时候不能很好地控制住自己的速度和倾斜角度，结果撞上了马匹。 马双腿一软失了前蹄，而 %dumb% 不知怎地撞进了它腰部的曲线中，在翻转中被抛上了天空。 这一幕逊爆了，你确定以后再也不会再见到了。 马匹重新站了起来，在 %dumb% 无意识的身体飞过终点线的时候疑惑地四处看了看。 你把你的手掌伸向正在用手紧紧抱住自己头的马匹主人。%SPEECH_ON%旧神啊，老兄，你不为自己的佣兵考虑考虑吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他会没事的，付钱吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dumb.getImagePath());
				this.World.Assets.addMoney(_event.m.Reward * 3);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + _event.m.Reward * 3 + "[/color] 克朗"
				});
				local injury = _event.m.Dumb.addInjury(this.Const.Injury.Concussion);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Dumb.getName() + " 遭受 " + injury.getNameOnly()
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

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 1000)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_fat = [];
		local candidates_athletic = [];
		local candidates_dumb = [];
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
			else if (bro.getSkills().hasSkill("trait.athletic"))
			{
				candidates_athletic.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.dumb") && !bro.getSkills().hasSkill("injury.severe_concussion"))
			{
				candidates_dumb.push(bro);
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

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_fat.len() != 0)
		{
			this.m.Fat = candidates_fat[this.Math.rand(0, candidates_fat.len() - 1)];
		}

		if (candidates_athletic.len() != 0)
		{
			this.m.Athletic = candidates_athletic[this.Math.rand(0, candidates_athletic.len() - 1)];
		}

		if (candidates_dumb.len() != 0)
		{
			this.m.Dumb = candidates_dumb[this.Math.rand(0, candidates_dumb.len() - 1)];
		}

		this.m.Reward = this.Math.rand(3, 6) * 100;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"randombrother",
			this.m.Other.getNameOnly()
		]);
		_vars.push([
			"fat",
			this.m.Fat ? this.m.Fat.getNameOnly() : ""
		]);
		_vars.push([
			"athlete",
			this.m.Athletic ? this.m.Athletic.getNameOnly() : ""
		]);
		_vars.push([
			"dumb",
			this.m.Dumb ? this.m.Dumb.getNameOnly() : ""
		]);
		_vars.push([
			"reward",
			this.m.Reward
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.Fat = null;
		this.m.Athletic = null;
		this.m.Dumb = null;
		this.m.Reward = 0;
	}

});

