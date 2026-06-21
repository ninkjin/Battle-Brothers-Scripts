this.pimp_and_harlots_event <- this.inherit("scripts/events/event", {
	m = {
		Payment = 0
	},
	function create()
	{
		this.m.ID = "event.pimp_and_harlots";
		this.m.Title = "在路上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_85.png[/img]在行进的时候，你遇见了一个站在路边的女人。 她站在一辆驴拉的载重货车之前。 看见你们，她高兴地拍了拍手，然后大声地喊叫着。 一会儿之后，一群少妇从载重货车上挤下来，然后排列在你们面前。 她们打扮得很糟糕，如果按艺术里的说法，排练地也很糟糕。 她们大部分看起来都更应该作为一名平凡的妇女出现在别的地方。 你走上前询问这群妇女们的领头人她在干什么。 她咧着嘴笑着。%SPEECH_ON%我是一个肉体商人，一个贩卖好东西的商人。 这些，就是我的货物。%SPEECH_OFF%她向妓女们挥了挥手。 她们排列地更整齐了一些，或者说放松了一些，假装对你和你的人们很有兴趣。皮条客点了点头。%SPEECH_ON%让我们帮你们放松一下，哼？ 很久没有了不是吗？ 就这几个人，我打赌你只需要花 %cost% 克朗。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "按你说的成交！",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 60)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "不如你把贵重物品交出来？",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "不了，谢谢。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]尽管你的一些人在抗议，你还是拒绝了皮条客的提议。她耸耸肩。%SPEECH_ON%该死的，我就知道我应该再招募一些小男孩来。好吧，随你的便了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们到下个城镇之后再去找乐子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.worsenMood(0.75, "你拒绝为了妓女付钱");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
			Text = "[img]gfx/ui/events/event_85.png[/img]妓女们缓步向前走来，其中几人懒散地眨了眨眼，另外几人神色困倦。 这是一群糟糕的农妇，但是你的人们已经等不及了。 你接受了皮条客的报价，而你的人们则去做之后该做的，躲进了灌木丛和其他各种各样的隐蔽的角落里。 在他们行动的时候，皮条客悄悄地贴近了你。%SPEECH_ON%谢谢你没有抢劫我们。%SPEECH_OFF%你耸耸肩，说那可没准。她也耸耸肩。%SPEECH_ON%我知道，但是我认为你不会的。 我和你，有很多相似的地方。 你为食物而战斗，而我们用皮肉。%SPEECH_OFF%感到有点好奇，你问她是否还在用皮肉获取食物。她笑了笑。%SPEECH_ON%只有到需要的时候才会。 这个“领头人”身份是一个很棒的工作。 你现在还在为你自己而亲自“战斗”吗？%SPEECH_OFF%你告诉了她真相。%SPEECH_ON%我曾经杀了很多，很多的人。%SPEECH_OFF%她紧紧地贴向了你，手向下伸去。%SPEECH_ON%好吧那么。%SPEECH_OFF%确实那么。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "值得的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-_event.m.Payment);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Payment + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(1.0, "和妓女玩得很开心");

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

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_07.png[/img]你同意了这个建议。 皮条客和她的妓女们向前走来，就像一群好色的蛇挤进了你的队伍里。 在你们大部分的人都已经脱下裤子之后不久，一队土匪出现在了树丛之外。 你赶忙抓起了你的利刃，真正开了锋的那一把，光着双腿将一个盗贼的头砍下，又刺穿了另一个的胸膛。 更多的强盗冲了上来，都拔出了武器准备战斗，但是皮条客突然跳了出来，站在你们两者之间。%SPEECH_ON%喔！这儿不会再死人了！%SPEECH_OFF%你的人还没有意识到这个少妇究竟是怎么在你面前先发制人的。 也就是说 %companyname% 依旧有一种自然的力量，无论是否穿着裤子，而且皮条客也意识到了这一点。 她大声呵斥着雇工。%SPEECH_ON%我记得我告诉过你们这群傻瓜如果顾客们看起来很危险，不要攻击。 他们看起来是不是很危险？该死的。看到了没，佣兵。 我要收双倍的报酬然后离开。 给我们双倍报酬，我们要走了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好吧，成交。",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "这可不行。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_07.png[/img]你不准备让你的人冒险，然后答应了她的条件。 拿走了钱，她点了点头。%SPEECH_ON%大多数人在这种情况下会让他们的荣耀感支配他们，但是你知道怎么样让你的手下保持安全。 一个聪明的雇佣兵在如今的日子里很稀有，你的手下们也会对有你这么个领袖而高兴。%SPEECH_OFF%土匪和妓女们离开了，%randombrother% 走了过来哼哼道。%SPEECH_ON%好吧，狗屎。我感觉我现在硬得可以日穿一个少妇。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我不需要知道这个。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-_event.m.Payment * 2);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Payment * 2 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_06.png[/img]你没有说不行，而是用你的行动来表示。 持剑在手，你把它倒转过来狠狠地抽向皮条客的脸。 在她目瞪口呆得望着你时，你把剑回转过来，一剑砍下了她的头。 而你的人们，裤子都还没穿上，赶紧拿起了他们的武器并开始战斗起来。 一些妓女掏出了匕首，刺向了你的伙计们，一些伙计被刺伤了，但是迅速地解决了妓女们。 大部分的妓女们都是无害的，但是却在困惑和混乱中被屠杀了。\n\n强盗们，估计没有料到会有真正的战斗，则向他们短暂而又可悲的生命说了声再见。 当一切结束的时候，地上留下了超过20具尸体，大部分的雇佣兵身上都带着伤痕。 你则开始回收着战场上还能用的东西。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "也许在我们没有穿上裤子的时候应该避免战斗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/weapons/dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/bludgeon");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Math.rand(100, 300);
				this.World.Assets.addMoney(item);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						local injury = bro.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " 遭受 " + injury.getNameOnly()
						});
					}
					else
					{
						local injury = bro.addInjury(this.Const.Injury.PiercingBody);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " 遭受 " + injury.getNameOnly()
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_07.png[/img]你仔细考虑了这个提议，然后意识到这些只是一群不知从何而来的女人。 你反手扇了皮条客一个嘴巴，把她打倒在地。 她摸着被打的脸颊，说，想要粗暴的来的话要加钱。你点了点头。%SPEECH_ON%是的，要拿你们有的一切来换。 伙计们，把她们拿下。%SPEECH_OFF%皮条客问你，这是不是一次抢劫，你点了点头。 在你表明你的意图的那一刻，一群全副武装的男人从附近的灌木丛中钻了出来。 皮条客站了起来，摸了摸她的脸。%SPEECH_ON%我还愿意把这次交易继续下去，佣兵。 一个响亮的耳光在这次交易里没有任何影响。 这个是意料之中的，但是抢劫犯，杀人犯和强奸犯也在意料之中。 现在，如果你想继续做你想做的事，我会让那些人做我需要的事，那就是保护我和我的财务安全。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好的，我们走。",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "可怜的守卫。进攻！",
					function getResult( _event )
					{
						return "I";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_64.png[/img]你看着那些守卫和那些你不想在这次抢劫中失去的人们，你点了点头。%SPEECH_ON%聪明的女士。好吧。这里不会有流血事件了。%SPEECH_OFF%皮条客松了一口气。%SPEECH_ON%很高兴我们能达成共识。 恐怕我之前的提议已经失效了吧。我相信你能理解的。%SPEECH_OFF%收剑入鞘，是的，你说道。 两个兄弟啐了一口唾沫，摇了摇头。 他们认为因为你的侵略性而错失了一次美好的休息。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你看不出来他们要抢劫我们吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(1.0, "因为你，错过了一次理性交流的好机会");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
			ID = "I",
			Text = "[img]gfx/ui/events/event_60.png[/img]这些“守卫”不是骗人的。 你命令你的人进攻。 这次打斗仅仅是一次简短的骚动。 这些妓女们雇佣的打手们表现得就像没有准备好进行真正的战斗的样子。\n\n 在战斗结束之后，你看见那辆载重货车仍然停在那里，但是皮条客和她的妓女们都跑了。 她们一定在你们打斗的时候逃跑了。 她们甚至还把驴子带走了，真是个幸运的家伙。\n\n 你的人抢劫了载重货车。 在你们搬走了所有没有固定住的东西的时候，%randombrother% 听见了一阵敲击声。 他找了找货车的底部，拉了拉一条绳索，一块木板掉了下来，接着一个浑身裹着黑色皮革的男人滚了出来。 你推下了他脸上蒙着的面罩。 他深深地吸了一口气。%SPEECH_ON%谢－谢谢！旧神啊，我还以为她们会把我在这里关一辈子！%SPEECH_OFF%你问道他是谁。他把嘴里的碎布吐了吐。%SPEECH_ON%瘸子。%SPEECH_OFF%只是“瘸子”？他点了点头。%SPEECH_ON%是的，先生。哇，你在这搞到了不少好武器。 还有这些贼棒的盔甲。哼，我的主人已经跑了。所以…%SPEECH_OFF%你摇了摇头。%SPEECH_ON%去最近的城镇里把你自己洗干净，陌生人。%SPEECH_OFF%他点了点头。%SPEECH_ON%如你所愿，主人。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是的，是的。去吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/weapons/dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/bludgeon");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Math.rand(100, 300);
				this.World.Assets.addMoney(item);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " 遭受 " + injury.getNameOnly()
							});
						}
						else
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + "遭受轻伤"
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 10)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() <= 3)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 50 * brothers.len() * 2 + 500)
		{
			return;
		}

		this.m.Payment = 50 * brothers.len();
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cost",
			this.m.Payment
		]);
	}

	function onClear()
	{
		this.m.Payment = 0;
	}

});

