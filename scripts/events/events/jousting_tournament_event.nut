this.jousting_tournament_event <- this.inherit("scripts/events/event", {
	m = {
		Jouster = null,
		Opponent = "",
		Bet = 0
	},
	function create()
	{
		this.m.ID = "event.jousting_tournament";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%jouster% 手里拿着一张纸走过来。 他砰地一声把它摔到你的桌子上，说他想要参加。 你拿起卷轴，展开它，看到当地一个小镇正在举办一场马术比赛。 那人抱着肩，等待你的回答。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好，你可以参加。",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "不行，我们还有更重要的事情要做。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_96.png[/img]你同意 %jouster% 去参加，同时自己也想亲眼看看，也就跟着去了。\n\n你刚走近赛场，比赛就发出剧烈的噼啪响声。 扈从们抱着满怀的盔甲和武器，来回奔忙着，其中一些步伐缓慢，肩上扛着巨大的长矛。 另一些人则骑着看起来非常高贵的马，不少都穿着饰有纹章的胸甲。 远处，你可以听到疾驰的风声，沉重的马蹄声，接着传来金属撞击木头的噼啪声，最后爆发出欢呼。\n\n当你环顾庆祝活动的时候，一个贵族走过来拦住了你。 他一只手掂量着钱包的重量，另一只手拿着扫帚抽在嘴角上搅动，问你愿不愿意打个赌。 你问我为什么。 他点了点头，指着在集合点对面的 %jouster%，签了名正要参加比赛。 显然他要面对的是这个贵族的骑士本人，他的名字是 %opponent%。%SPEECH_ON%小赌怡情，不是吗？ 就赌 %bet% 怎样？ 胜者全拿，当然了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就这么定了！",
					function getResult( _event )
					{
						_event.m.Bet = 500;
						return "P";
					}

				},
				{
					Text = "我不赌博。",
					function getResult( _event )
					{
						return "P";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "P",
			Text = "[img]gfx/ui/events/event_96.png[/img]你坐在平民和一个像贵族的人中间。 只有当地的领主与那些乌合之众有点区别，和像是他的儿子、女儿以及来自全国各地的皇室成员们一起坐在更高的席位上。\n\n%jouster% 下一局就是她，扈从正帮忙把他的马牵到一条赛道上。 沿着赛道，%opponent% 策马进入场地，他骑着一匹黑色的马，带着一套镶着金色的饰物和流苏，呈现跃动的紫色的盔甲。 他和 %jouster% 都拿起他们的长矛，把头盔上的护面盔往下一拍。\n\n一个吠叫者在王室包厢里叫出他们的名字，然后一个牧师说了几句关于这是神授权的比赛，如果今天这里有人死去，他将和另一个世界的最伟大的人位列同席，和他们一起被这个世界的人记住。 不管他们说了什么，两个竞技者压低了长矛，在吠叫者和牧师就座之前就发起了冲锋。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "令人兴奋！",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 30 + 5 * _event.m.Jouster.getLevel())
						{
							return "Win";
						}
						else
						{
							return "Lose";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Win",
			Text = "[img]gfx/ui/events/event_96.png[/img]从未见过这样的比赛，当两位选手在跑道上快速向前冲时，你不受控制地屏住呼吸。 雄壮的马迈着有节奏的步调，蹄子踢出大块的泥土，奔跑时盔甲上也反射出闪耀的光斑在观众席上来回跃动，泥块和光斑混杂在一起，观众们晃动得头晕眼花，孩子们大叫着，醉汉们举起的马克杯溢撒出来啤酒来，年轻公主们攥着他们的礼服，想要变得勇敢的王子在鼓掌，不知道什么时候从你面前经过，你自己也站起来大叫。\n\n %opponent% 挣扎着稳住自己，长矛上下摆动，矛尖摇摆不定，寻找目标。\n\n他没有找到。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢！",
					function getResult( _event )
					{
						if (_event.m.Bet > 0)
						{
							return "WinBet";
						}
						else
						{
							return "WinNobet";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "WinNobet",
			Text = "[img]gfx/ui/events/event_96.png[/img]%jouster% 的长矛在他的对手的胸膛上撞得粉碎，清晰可见的木屑和碎片爆裂开来，一匹没有骑手的马，竞技者挂在他的马蹄上，完全脱离了他的马鞍，毫无动作或呼吸地面朝下倒在战场上。 人群中爆发出一阵大叫，你也很快加入了这场酝酿爆发的风暴，你的耳朵淹没在刺耳的杂音中，在你今生难忘的地方，瞬间横扫一切。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "万岁！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				_event.m.Jouster.improveMood(2.0, "赢得了一场比赛");

				if (_event.m.Jouster.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Jouster.getMoodState()],
						text = _event.m.Jouster.getName() + this.Const.MoodStateEvent[_event.m.Jouster.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "WinBet",
			Text = "[img]gfx/ui/events/event_96.png[/img]%jouster% 的长矛在他的对手的胸膛上撞得粉碎，清晰可见的木屑和碎片爆裂开来，一匹没有骑手的马，竞技者挂在他的马蹄上，完全脱离了他的马鞍，毫无动作或呼吸地面朝下倒在战场上。 人群中爆发出一阵大叫，你也很快加入了这场酝酿爆发的风暴，你的耳朵淹没在刺耳的杂音中，在你今生难忘的地方，瞬间横扫一切。\n\n当你还在庆祝的时候，和你打赌的那个贵族走了过来，把一个钱包丢到到你手里。 你本想说点什么，但还没来得及说，他就生气地转身走开了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "万岁！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				this.World.Assets.addMoney(_event.m.Bet);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你赢了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + _event.m.Bet + "[/color] 克朗"
				});
				_event.m.Jouster.improveMood(2.0, "赢得了一场比赛");

				if (_event.m.Jouster.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Jouster.getMoodState()],
						text = _event.m.Jouster.getName() + this.Const.MoodStateEvent[_event.m.Jouster.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Lose",
			Text = "[img]gfx/ui/events/event_96.png[/img]从未见过这样的比赛，当两位选手在跑道上快速向前冲时，你不受控制地屏住呼吸。 雄壮的马迈着有节奏的步调，蹄子踢出大块的泥土，奔跑时盔甲上也反射出闪耀的光斑在观众席上来回跃动，泥块和光斑混杂在一起，观众们晃动得头晕眼花，孩子们大叫着，醉汉们举起的马克杯溢撒出来啤酒来，年轻公主们攥着他们的礼服，想要变得勇敢的王子在鼓掌，不知道什么时候从你面前经过，你自己也站起来大叫。\n\n%jouster% 挣扎着稳住自己，长矛上下摆动，矛尖摇摆不定，寻找目标。\n\n他没有找到。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ohh...",
					function getResult( _event )
					{
						if (_event.m.Bet > 0)
						{
							return "LoseBet";
						}
						else
						{
							return "LoseNobet";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "LoseNobet",
			Text = "[img]gfx/ui/events/event_96.png[/img]%opponent% 的长矛垂直击中了 %jouster% 的胸膛，炸得粉碎。 那人一下子仰倒在马鞍上，他伴随着打着旋儿的碎片和木粉坐了起来。 他拼命地伸手去抓缰绳。 看到这些，你以为它已经恢复状态了，但缰绳却断了，从手里滑出去。%jouster% 向后倒飞出去，从坐骑的后腿上滚下去，然后双脚着地。 尽管他还站着，他已经输了。\n\n人群中炸开了，向胜利者和失败者热烈地鼓掌。 甩了甩有点痛的肩膀，%jouster% 拍拍上面的灰。 你发现他又回到了集合地。 他说他的枪出毛病了，你提醒他的马的缰绳松了。 就在这时，胜利者从他身边走过，身后跟着一群崇拜他的女人，还有一个扈从牵着一匹相当神气的马。 你没想到的是，%opponent% 和 %jouster% 握手并互相表示祝贺，一场精彩的比赛。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢，好吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				local injury = _event.m.Jouster.addInjury(this.Const.Injury.Jousting);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Jouster.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "LoseBet",
			Text = "[img]gfx/ui/events/event_96.png[/img]%opponent% 的长矛垂直击中了 %jouster% 的胸膛，炸得粉碎。 那人一下子仰倒在马鞍上，他伴随着打着旋儿的碎片和木粉坐了起来。 他拼命地伸手去抓缰绳。 看到这些，你以为它已经恢复状态了，但缰绳却断了，从手里滑出去。%jouster% 向后倒飞出去，从坐骑的后腿上滚下去，然后双脚着地。 尽管他还站着，他已经输了。\n\n 人群中炸开了，向胜利者和失败者热烈地鼓掌。 甩了甩有点痛的肩膀，%jouster% 拍拍上面的灰。 你发现他又回到了集合地。 他说他的枪出毛病了，你提醒他的马的缰绳松了。 就在这时，胜利者从他身边走过，身后跟着一群崇拜他的女人，还有一个扈从牵着一匹相当神气的马。 你没想到的是，%opponent% 和 %jouster% 握手并互相表示祝贺，一场精彩的比赛。 \n\n 然而和你打赌的那个贵族不那么对竞技精神感兴趣。 他向你走来，脸上带着鄙夷的笑容，搓着双手。 你不情愿地把说好的钱交给他。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢，好吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				this.World.Assets.addMoney(-_event.m.Bet);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Bet + "[/color] 克朗"
				});
				local injury = _event.m.Jouster.addInjury(this.Const.Injury.Jousting);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Jouster.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]告诉 %jouster% 并不顺利。 他滔滔不绝地说他在比赛时能挣多少钱，而你却如何把他们据为己有。 当然，直到他找到你，要求你补偿他所说的 %compensation% 钱之前，这还算有趣的抱怨。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好，我确实应该补偿你。",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "你现在是个雇佣兵了，而不是一个竞技者。 最好习惯它。",
					function getResult( _event )
					{
						return "I";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_64.png[/img]你站起来，拍了拍 %jouster% 的肩膀。%SPEECH_ON%我毫不怀疑，像你这样技艺高超的人肯定能在这次比赛中脱颖而出。 但我需要一个像你这样的人在这里，在营地。 我会直接补偿你失去的价值，你不用证明了。%SPEECH_OFF%有点圆滑的话让他冷静下来。 他点头，只飞快地瞄了一眼，好像似乎接受这些报酬是不光彩的。 不想这名佣兵看起来显得像一个毫无荣誉的傻瓜，在荣誉和金钱里考验意志力，你命令他收下钱。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在你可以出去了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				this.World.Assets.addMoney(-500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_64.png[/img]你扯下宣传海报，把它放在蜡烛上。 当火焰吞噬纸张的时候，你制定了一些基本规则为 %jouster%。%SPEECH_ON%我雇你来当佣兵，不是什么游手好闲的竞技者。 如果你想参加锦标赛，那么你可以退还所有的装备和基本工资。 否则，滚出我的帐篷。%SPEECH_OFF%这样的时机这么说这不太好，但最终雇佣兵仅仅只会离开你的帐篷，而不是整个战队。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "回去干活儿！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Jouster.getImagePath());
				_event.m.Jouster.worsenMood(2.0, "被拒绝参加比赛");

				if (_event.m.Jouster.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Jouster.getMoodState()],
						text = _event.m.Jouster.getName() + this.Const.MoodStateEvent[_event.m.Jouster.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 500)
		{
			return;
		}

		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 1)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getLevel() < 4)
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.adventurous_noble" || bro.getBackground().getID() == "background.disowned_noble" || bro.getBackground().getID() == "background.regent_in_absentia" || bro.getBackground().getID() == "background.bastard" || bro.getBackground().getID() == "background.hedge_knight") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Jouster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}

	function onPrepare()
	{
		this.m.Opponent = this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)];
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"jouster",
			this.m.Jouster.getName()
		]);
		_vars.push([
			"opponent",
			this.m.Opponent
		]);
		_vars.push([
			"bet",
			500
		]);
		_vars.push([
			"compensation",
			500
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Jouster = null;
		this.m.Opponent = "";
		this.m.Bet = 0;
	}

});

