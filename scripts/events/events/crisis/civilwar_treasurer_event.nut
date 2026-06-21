this.civilwar_treasurer_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_treasurer";
		this.m.Title = "在路上…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_72.png[/img]当你在行军时，你发现一个农夫正被一个看上去很富裕的人搭讪。 看到你，农夫很快叫了起来。%SPEECH_ON%先生，帮帮我！这位司库要拿走我的庄稼！%SPEECH_OFF%司库理所当然的点了点头。%SPEECH_ON%没错。我是 %noblehouse% 派来为军队收集粮食的。 这是我们的土地，也是我们的庄稼。%SPEECH_OFF%战争的折磨越来越严重... %randombrother% 问你想做什么。",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "离那个农夫远点！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "这不关我们的事。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你们两个都给我让开。 这些粮食归我了！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_72.png[/img]虽然道德在战争中没有什么用，但你认为这个贫穷的农夫并没有做错什么。 你抓住司库的衬衫，把他按在农舍的墙上。 他的眼睛睁得大大的，好像你刚刚刺破了某种不可战胜的面纱。%SPEECH_ON%你知道你在做什么吗？%SPEECH_OFF%你松开了手，因为这个人虽然没有什么战斗力，但从他名字上看出来他有后台。%SPEECH_ON%告诉你的人，这个农夫已经没有什么可给的了。 这个季节庄稼欠收，知道吗？%SPEECH_OFF%你把一只手放在剑柄上。 男人瞥了它一眼，然后迅速点头。%SPEECH_ON%我会的，我照做！%SPEECH_OFF%农夫从心底感谢你，他从他的食物储备里面挤出一袋谷物来感谢你的行为。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "今天我们做了一件大好事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "你威胁了他们的一个司库");
				this.World.Assets.addMoralReputation(1);
				local food = this.new("scripts/items/supplies/ground_grains_item");
				this.World.Assets.getStash().add(food);
				this.World.Assets.updateFood();
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.farmhand" && this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.25, "你帮助了一个处境危险的农夫");

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
			Text = "[img]gfx/ui/events/event_72.png[/img]跟贵族家族战争中的利益相比，农夫的事情不过是小事。 你选择置身事外。 当司库的临时工把一袋袋的谷物搬上载重货车时，他走过来说。%SPEECH_ON%我要告诉贵族们你在这的决定。 你本可以阻止我们，但你没有。 谢谢你，雇佣兵。我们军队的人比你想象的更需要这些食物。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
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
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "你尊重他们中的一个司库的权威");
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_72.png[/img]起初，这里似乎有两个选择，但是作为一个没有贵族责任和任何社会束缚的佣兵，你有了第三个选择：给你和你的人拿食物。 司库和农夫都表示抗议，但是你的手下拔出了刀，这是一个让任何形式的辩论都能瞬间保持沉默行动。\n\n 总的来说，没什么好拿的，而且你会为此惹恼平民和贵族。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们得先照顾好自己。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "你威胁了他们的一个司库");
				this.World.Assets.addMoralReputation(-2);
				local maxfood = this.Math.rand(2, 3);

				for( local i = 0; i < maxfood; i = ++i )
				{
					local food = this.new("scripts/items/supplies/ground_grains_item");
					this.World.Assets.getStash().add(food);
					this.World.Assets.updateFood();
					this.List.push({
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你获得了" + food.getName()
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= bestDistance)
			{
				bestDistance = d;
				bestTown = t;
				break;
			}
		}

		if (bestTown == null)
		{
			return;
		}

		this.m.NobleHouse = bestTown.getOwner();
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
	}

});

