this.raiders_origin_redemption_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null,
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.raiders_origin_redemption_";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_40.png[/img]{%monk% 是一个僧侣，在这一点上，已经非常、非常远离了他在家时的样子了。 独自漂泊的日子已经够苦了，而在路上的日子充满了暴力和掠夺，甚至更糟。 他主动来找你提出要求，这并不奇怪。 尽管在战队已经有一段时间了，但很明显，他仍然是一个文明人。\n\n 他解释了一条古老的法律：作为一名掠夺者，你是不受欢迎的人，但作为一名拥有大量金钱的掠夺者，你仍有机会以自己的方式重新与这片土地上的贵族打交道。 僧侣说他知道谁掌权。 显然，%noblehouse% 对“开辟新渠道”很感兴趣，他们想要 %crowns% 克朗来适应新事物。确切说是文明。}",
			Banner = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让这个事成真。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们不必如此。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_31.png[/img]{你同意僧侣的意见。 你遇到一个中间人和一个贵族，聚在一起。 会议是秘密进行的，一开始有很多戏剧性的唇枪舌剑的废话。 男人穿着黑衣服，双手拿着武器，贵族们互相窃窃私语，但当一切尘埃落定之后…你们一起喝了个痛快。 在未来，%noblehouse% 将会开放更多贸易。}",
			Banner = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "为他们做雇佣兵工作会进一步提升关系。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.World.Flags.set("IsRaidersRedemption", true);
				this.World.Assets.addBusinessReputation(50);
				this.World.Assets.addMoney(-2000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-2000[/color] 克朗"
				});
				_event.m.NobleHouse.addPlayerRelation(20.0, "被贿赂来与你打交道。");
				this.List.push({
					id = 10,
					icon = "ui/icons/relations.png",
					text = "你对于的关系" + _event.m.NobleHouse.getName() + "改善"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.raiders")
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 500)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 2500)
		{
			return;
		}

		if (this.World.Flags.get("IsRaidersRedemption"))
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local candidates_nobles = [];

		foreach( n in nobles )
		{
			if (n.getPlayerRelation() > 5.0 && n.getPlayerRelation() < 25.0)
			{
				candidates_nobles.push(n);
			}
		}

		if (candidates_nobles.len() == 0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_monk = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk" && bro.getLevel() > 1)
			{
				candidates_monk.push(bro);
			}
		}

		if (candidates_monk.len() == 0)
		{
			return;
		}

		this.m.NobleHouse = candidates_nobles[this.Math.rand(0, candidates_nobles.len() - 1)];
		this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk.getName()
		]);
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
		_vars.push([
			"crowns",
			"2,000"
		]);
	}

	function onClear()
	{
		this.m.Monk = null;
		this.m.NobleHouse = null;
	}

});

