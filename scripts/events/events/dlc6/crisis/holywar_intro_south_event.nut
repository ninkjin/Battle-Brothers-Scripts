this.holywar_intro_south_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_intro_south";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{%SPEECH_START%让我们的未来的道路金光闪耀。%SPEECH_OFF%牧师大声的向他的会众们说道。%SPEECH_ON%我问你们，忠实信徒，哪里的光最为闪亮？%SPEECH_OFF%一大群农民互相间低语着。 最后，牧师举起他的手。%SPEECH_ON%是在地平线上，对抗大地她本身的阴影，在那我们才能找到镀金者最强烈的光辉。 现在我们正与那阴影战斗，而地平线上并非大地而是胆敢亵渎圣地的北方无礼崽种！%SPEECH_OFF%人群，一开始有点困惑，突然团结一致，看起来对宗教战争太过了解了。牧师嘴角上扬。%SPEECH_ON%这就对了，我已经可以看到你们心中燃烧着的镀金者之火！ 我们必须不惜代价保卫我们的圣地！%SPEECH_OFF%又一次，回应他的是人群的吼声。 你不知道该怎么理解这群人，但是你知道战争意味着生意而一点额外的宗教狂热可以让生意更好。 | 维齐尔罕见的出现在他土地上的平民前，周边城市的大议会议员们簇拥在他身边。 但他一言不发。 一个身着真金的男人走上前来。%SPEECH_ON%我们的旅途都金光闪耀，不是吗？%SPEECH_OFF%远不如这个牧师般闪亮，人群熙熙攘攘的小声交谈着，尽管没人胆敢反对圣人的主张。牧师继续道。%SPEECH_ON%镀金者对我们中的许多人透露了一个新的威胁事件：北方人在他们所谓的旧神的刺激下，已经席卷南方。 他们可笑的声称，这是一场圣战！ 为了到这来，就这里，来夺走我们的领土与圣地。 很显然，镀金者的光芒给我们展示了道路，但或许对于他人而言这太过耀眼。 这些北方人不明白，但我们会教给他们的，以镀金者的圣火之名教给他们！%SPEECH_OFF%人群嘶吼的活跃起来，任何迟疑都烟消云散了。 你吃下一口当地菜肴，开始寻思你在这场将要到来的圣战能中赚到多少。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战争就要来了。",
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

		if (this.World.Statistics.hasNews("crisis_holywar_start"))
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			local nearTown = false;
			local town;

			foreach( t in towns )
			{
				if (!t.isSouthern())
				{
					continue;
				}

				if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
				{
					nearTown = true;
					town = t;
					break;
				}
			}

			if (!nearTown)
			{
				return;
			}

			this.m.Town = town;
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_holywar_start");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

