this.runaway_harem_event <- this.inherit("scripts/events/event", {
	m = {
		Citystate = null
	},
	function create()
	{
		this.m.ID = "event.runaway_harem";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你遇到一片稀疏的游牧民和一些维齐尔人的士兵在争论。 在他们中间是另一群看起来好像某种可能在维齐尔的后宫里的女人。 随着你靠近都停下来看着你。 一个维齐尔士兵的军官挥手示意让你离开。%SPEECH_ON%这跟你无关，逐币者。%SPEECH_OFF%但是，或许是想把你卷入这个事件，游牧民们解释道：这些女人都是“负债者”，那些要为失误或者冒犯服侍别人的人。 这个情形中，他们得去服侍维齐尔。 但是，她们逃跑了，并且把负债者这个概念视为异端的游牧民们接纳了她们。%SPEECH_ON%嘿，逐币者！不要听进那个游民的毒药！ 还有游牧民，这些女人得跟我们走，或者你们全得死在这里。%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不太想掺和进去。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "这些女人属于维齐尔。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "这些女人有选择去哪的自由。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你拔出剑并告诉维齐尔的人滚开，希望这能奏效，因为跟他们打起来恐怕不会很干净利落。 幸运的，他们撤退了。军官嘲弄的鞠了个躬。%SPEECH_ON%这些女人自由了，但她们负镀金者的债尚未偿还，她们将会在这灼热的沙坑中受苦，一个她们永远无法逃离的地狱！%SPEECH_OFF%笑着，你感谢他的想象力。 游牧民们，还有被解救的后宫，尽管主要是通过眼神，表达谢意。 其中一个游牧民交给你一份礼物。%SPEECH_ON%我们拿着这些不是为了我们自己，而是为了经过像你这样的旅行者的时候。 我们不追寻物质上的舒适，至少不是这个世界中的。 而且不要相信那个维齐尔的人。他在撒谎。 镀金者在检阅我们时会看到我们的高尚的。%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "享受你们的自由吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
				this.World.Assets.addMoralReputation(1);
				this.World.Assets.addMoney(100);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]100[/color] 克朗"
					}
				];
				_event.m.Citystate.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "你帮助维齐尔的后宫逃跑");
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你知道什么时候是个赚钱的好机会，尤其是作为维齐尔的代理人的时候。 拔出剑，你跳到游牧民和女人们中间，告诉前者后退回到沙漠里去。 游牧民们掏出弓箭和短矛，但是他们的头领制止了他们。%SPEECH_ON%不，入侵者以他觉得最适合的方式介入了，很显然镀金者选择了他来裁决这件事。 带走女人吧，这样争端被解决了。%SPEECH_OFF%维齐尔的人把女人带回队伍里。 军官丢给你一个厚重的包。%SPEECH_ON%报酬，逐币者。这不是你的工作，但也不意味着没有报酬。 你从镀金者的狱火中拯救了这些负债者女人。 记住我们的慷慨，嗯哼？%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们很期待与你主人的进一步合作。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
				this.World.Assets.addMoney(150);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]150[/color] 克朗"
					}
				];
				_event.m.Citystate.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "你帮助带回了维齐尔的后宫");
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你摇了摇头愿女人们好运，但是在你能离开前就事态就解决了：游牧民们后退，维齐尔的人把她们带走了。 当你问游牧民为什么他们这么快就放弃了，他们的头领说因为你肯定是镀金者派来的裁决者，如果你选择放弃，那也意味着他们也该照做。 看起来游牧民们面对职业士兵毫无机会，而你是他们最后的希望。}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "事情就是这样。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local bestTown;
		local bestDistance = 9000;

		foreach( t in towns )
		{
			local d = currentTile.getDistanceTo(t.getTile());

			if (d <= bestDistance)
			{
				bestDistance = d;
				bestTown = t;
			}
		}

		if (bestTown == null || bestDistance < 7)
		{
			return;
		}

		this.m.Citystate = bestTown.getOwner();
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Citystate = null;
	}

});

