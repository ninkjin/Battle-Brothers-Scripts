this.come_across_burial_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.come_across_burial";
		this.m.Title = "在路上…";
		this.m.Cooldown = 130.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_28.png[/img]在路上，你遇到一群人围着一堆土。 走近一点，你发现这是一场葬礼。 一位与会者转向你。%SPEECH_ON%你认识他吗？ 你在他身边打过仗吗？%SPEECH_OFF%你摇摇头，开始挤进人群中去看那个人。 你发现这个人的尸体像僵尸一样陈旧。 他的胸前有一把非常锋利闪闪发光的剑，脏兮兮的被虫蛀手指抓着剑柄。%randombrother% 来到你的身边耳语道。%SPEECH_ON%那是，呃，一个看起来很不错的武器，我就是说说。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们把它变成我们的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 35 ? "B" : "C";
					}

				},
				{
					Text = "别管他们了。",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_36.png[/img]你拔出你的剑，其他队员也这么做了。 雇佣兵们把人群往后推，但没有你想象的那么多阻碍。 一位与会者走上前。%SPEECH_ON%这是你要的剑，是吗？ 继续，拿去吧。 那个死者提到了像你这样的人。 说你比他更需要这把剑。%SPEECH_OFF%你举起剑，问他这是不是他们都站在周围的原因。那人笑着说。%SPEECH_ON%不是的，他还说他永远不会死，所以我们很想知道他说的话是否会成真。%SPEECH_OFF%你慢慢地拿起剑，现在很好奇是否有人说过要杀掉把手按在剑上的那个人。 谢天谢地，从表面上看，这个伟大的死人并没有说这样的话。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他不再需要那东西了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/longsword");
				item.setCondition(27.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_28.png[/img]你穿过人群，抓起死者的剑。 一名与会者尖叫起来。%randombrother% 打开酒瓶塞，把泡沫喷到一个农民脸上。 战队的其他成员拿出了他们的武器，以确保任何进一步的抗议不会发生。 一位上了年纪的妇女从人群中穿过，像老妇人一样，摇摇晃晃的。%SPEECH_ON%先生，那不属于你。还给我们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是时候动手了。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "这个老太婆说的对，我们不应该再打扰这场葬礼了。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_36.png[/img]你告诉老太太把她那古怪的屁股钻到洞里去然后去死。 死者的剑进了你的仓库 %companyname% 回到了道路上。\n\n农民们心烦意乱的叫喊着，说你所做的事将会在风中传播，就像一千头牛在拉屎放屁一样。 你只是大笑，很欣赏他们的想象力。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "世道就是如此。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-3);
				local item = this.new("scripts/items/weapons/longsword");
				item.setCondition(27.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_28.png[/img]你把剑放回死者的手里。 老太太点头。%SPEECH_ON%所以你们是能够听从良言的好人。%SPEECH_OFF%另一个农民为你的荣誉欢呼，其他人也纷纷效仿。 在这帮世俗之人看来，仅仅拿走武器再放回去，就足以成为一种值得庆祝的义举。 也许你应该经常假装偷窃。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "反正我们也不需要。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(5);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 15)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.Forest || currentTile.Type == this.Const.World.TerrainType.LeaveForest || currentTile.Type == this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		this.m.Score = 2;
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

