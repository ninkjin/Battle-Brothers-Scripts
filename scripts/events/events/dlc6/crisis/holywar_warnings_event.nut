this.holywar_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holy_warnings";
		this.m.Title = "在路上…";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{一个农民在路上从你身边经过。 他漫不经心的提到他无法理解为什么神要让他们的追随者互相战斗。 如果他们真的想解决这件事，为什么不自己上？ 你抓住他的衣服并问他在扯些什么。他摆脱开。%SPEECH_ON%嗨！手拿开，不然我就咔了你！ 而且我只是在发牢骚，仅此而已。 很多传言说镀金家伙和旧神信徒在对头锤。 又一次。现在让我安静会！%SPEECH_OFF%那个人走开了，嘟哝着，讽刺的是，他离你越远，音量就越大。 | 你遇到了一个镀金者和旧神祗的僧侣还是什么的集会。 他们在讨论一场战争的可能性，以及当它发生时怎么保护自己。 值得欣赏的友善，说真的，不过空气中确实有一股宗教上审判日的气息。 | 一个在路边修着载重货车的男人摇了摇头。%SPEECH_ON%你知道的，我只想从世界上的这个点走到另一个，仅此而已。 但是不，不行。狗日的…玩意！ 总是有什么玩意！总得出状况。 嗨，说道轮子，我这里听说个消息：镀金者和旧神祗们又要开始撞头了。 看到风暴云了吗。 是天上的圣战。 意味着这里也要圣战了。 我期盼在它开始前离它远点。 你见过上次圣战吗？可不是什么好事。%SPEECH_OFF%你确认这确实不是好事，但是这种事情也意味着要有活干了 %companyname%。 | %SPEECH_ON%膝盖苦恼着我。%SPEECH_OFF%你看过去看到一个老人摇摆着两个木桩假肢。他笑道。%SPEECH_ON%这是在说，我膝盖的灵魂在躁动。 当我还有腿的时候，膝盖的刺痛意味着坏天气要来了。 现在没有了的膝盖的剧痛意味着什么更糟的东西。%SPEECH_OFF%一个年轻的男孩过来并把老人扶到了手推车上。 在他离开前，你问他在说什么。 他转向一边，眉头紧皱，手互相紧握，相对于他的实际状况而言看起来些许潇洒和活跃。%SPEECH_ON%来自天上的审判。 镀金者，旧神，或许不止他们。 我想他们都在调戏我们，策划我们自相残杀来取乐他们，这样他们好有场戏看。 你看起来像个佣兵，所以我想当那些圣职者准备让他们的袍子染上血红色时你的生意会很不错。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴知道。",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.HolyWar && this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Warning)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();

			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(playerTile) <= 4)
				{
					return;
				}
			}

			this.m.Score = 80;
		}
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

