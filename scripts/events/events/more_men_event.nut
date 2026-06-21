this.more_men_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.more_men";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]这一整个战队的人－但其实不过是一个零零散散的小团队－全部都进入你的帐篷里面。 一群佣兵以这样的方式出现在眼前并不是最友好的景象所以在看见他们的一瞬间你的手就向剑伸去。 但是很快你就注意到他们并没有携带武器也没有带着一副想要杀人的表情。 尽管他们并没有想要发动叛乱来砍掉你的头，尽管如此你还是把这个可能性暗暗记在心里。\n\n 他们没有立刻说话而是等待你先发出问题，对此你感到些许欣慰。 这代表了他们对你的尊重，所以你也把手伸了回来不再去想它。 你交叉双臂撑在桌子上，然年询问他们的想法。\n\n 他们解释说现在团队实在是太过单薄。 现在他们去的每一个地方都充满着危险并且也在担心他们现在参加的每场新的战斗都有可能成为他们最后一场。 最后，他们坦率地表达了他们的愿望：如果团队想要生存下去，那名这里需要更多的成员。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只要我能负担的起我就会招募更多的人来。",
					function getResult( _event )
					{
						if (this.World.Assets.getMoney() >= 3000)
						{
							return "D";
						}
						else
						{
							return this.Math.rand(1, 100) <= 50 ? "E" : "F";
						}

						return "E";
					}

				},
				{
					Text = "我们很快就会有新人加入团队－我向你保证。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "这里不需要招募新的人，我们现在做的很好。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]你马上站了起来并且用指关节扣了扣桌面让你面前的兄弟们注意你的讲话。%SPEECH_ON%脑子聪明的人总会不谋而合我已经预留了克朗去招募新的兄弟了！%SPEECH_OFF%兄弟们脸上焦急、近乎悲伤的表情慢慢地开始改变。 他们开始欢呼并且向你点头表达感谢并且互相说着诸如“太好了”和“不用为之后担心了”之类的话。 当他们离开了以后，你注意到他们的背后藏着匕首。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是时候雇佣新人了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]对于他们你只能说抱歉，团队的状况不适合再雇佣一名新的兄弟。%SPEECH_ON%你们是我见过的最好的战士。 我不认为有什么东西值得你们害怕。 该恐惧的是那些敌人因为他们遭遇了我们！%SPEECH_OFF%但是你激动的演讲似乎并没有什么用。 一个人向前倾着身子一只手臂放在背后想要拿出什么东西，但另一个人拍了拍他的肩膀并且很快地摇了摇头。 他紧紧地注视着你然后说。%SPEECH_ON%这可真是一个令人失望的决定，先生，但是我们的想法不会有改变我们需要新的人手。%SPEECH_OFF%当他们转身离开时你注意到刚才刚才那个男人后背别着一个匕首而且鞘内匕首上的钩子被打开了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可能真的是一个问题…",
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
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(this.Math.rand(1, 3), "对你的领导失去信心");

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
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]你张开自己的双臂露出了就像无法卖水給口渴的人那种无奈的苦笑，你开始撒谎。%SPEECH_ON%我们根本没有足够的资金来雇用更多的人。%SPEECH_OFF%面前这些人根本不接受你的说法。 一个人立刻转身离开帐篷，离开后你就听到一阵咒骂和咒骂声。 另一个团队里的成员向自己背后伸出手。 你又瞥了一眼你的剑。 他看到你这样做，然后把手放回你能看到的地方。最后，他朝你点头致意。%SPEECH_ON%我们应该像我们刚才要求的那样做，先生。现在马上。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可能真的是一个问题…",
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
					bro.worsenMood(this.Math.rand(1, 6), "感觉在你的领导下被欺骗了而失去信心");
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[bro.getMoodState()],
						text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]当他们听到你说没有足够的克朗去雇佣新的伙伴时，他们点了点头。%SPEECH_ON%我们想到你会这么说。 我们有一个建议，把这说出来不是一件很轻松的事情，我们会把自己留存下来的退休金给你好让你去雇佣人手。 你可以从我们接下来要得到的工资中扣除一点来得到这份钱。%SPEECH_OFF%你迅速抬头看了一眼他们，这个好建议似乎不像是他们能想出来的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们很快就会有新的兄弟－感谢你们所有人的付出。",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "没那个必要。",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_05.png[/img]你告诉他们你已经没有钱去雇佣新的佣兵时。 他们叹气并且无奈的耸拉着脑袋。%SPEECH_ON%你说得对，先生。这只是一个建议。 就如同以前一样，我们还是会听你的命令。%SPEECH_OFF%人们转身离开了，他们显得比以前更懒散，也更沉寂了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我相信战队的情况会好转的。",
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
					if (this.Math.rand(1, 100) <= 20)
					{
						bro.worsenMood(1, "对你的领导失去信心");

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
			ID = "G",
			Text = "[img]gfx/ui/events/event_05.png[/img]你站起来和每个人握手。 当你大声地说你希望事情不会发展到这个地步时，你却暗自庆幸自己现在有了更多的克朗可以支配。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "来让我们雇佣更多的人加入战队！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(1000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + 1000 + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.getBaseProperties().DailyWage += 3;
					bro.getSkills().update();
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_daily_money.png",
						text = bro.getName() + "现在被支付" + bro.getDailyCost() + "克朗每天"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_05.png[/img]你看了看这些人。 他们的表情认真严肃，而不是之前那副为最近的胜利或获得战利品而咧嘴大笑的模样。 虽然你雇佣不起更多的兄弟，但真的没有必要削减他们的工资。%SPEECH_ON%我很敬佩你们提出这样的建议时所表现出的无私和勇敢，但我不认为自己是有荣誉感的人来同意你们的请求。 你们的存款将保持原样。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "无论如何都谢谢你们的支持。",
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
					if (this.Math.rand(1, 100) <= 20)
					{
						bro.improveMood(1.0, "对你的领导有信心");

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
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf" || this.World.Assets.getOrigin().getID() == "scenario.gladiators")
		{
			return;
		}

		if (this.World.getTime().Days <= 10)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() == 1 || brothers.len() > 5)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

