this.beast_hunter_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.beast_hunters_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_124.png[/img]你在房间里见到了雇佣你的人。他把手边的食物饮料还有雇佣合同递向了你。杀死森林中的女巫，你就会得到一笔钱。你和你的手下按照合同约定杀死了女巫，并且将其头颅带了回来。\n\n但是见到你回归的雇主只是大笑起来。他说正是这个女巫帮他登上了权力的巅峰，而你们则将他从女巫的债务中解放了出来，正是他愚弄了你和你愚蠢的手下。他的走狗们从阴影中走出，剑已出鞘。这场埋伏起于一个罪犯的自大，最后以他身首分家而告终。但是代价是你失去了众多手下的野兽杀手，只剩下你，%bs1%，%bs2%，还有%bs3%活下来了。\n\n这个世界上怪物往往将自己隐藏起来：人类的残忍隐藏在愚忠之后，野兽的恐怖隐藏在黑暗的传奇之中。身为一队野兽杀手的领袖你越来越难以分辨这两者的区别。如果你要靠猎杀生物赚钱，那为什么不将人类也加入清单一锅炖了呢？",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "自私自大之人才是最邪恶的野兽。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "野兽杀手";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bs1",
			brothers[0].getNameOnly()
		]);
		_vars.push([
			"bs2",
			brothers[1].getNameOnly()
		]);
		_vars.push([
			"bs3",
			brothers[2].getNameOnly()
		]);
	}

	function onClear()
	{
	}

});

