this.manhunters_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.manhunters_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_172.png[/img]{游牧民、城邦和流浪者之间不断的冲突意味着有好生意：逃兵、罪犯、战俘和负债者在这片土地四处逃窜，而你手持镣铐追捕他们。\n\n尽管他们所统治的土地一片荒芜，但南方城邦们人口众多且不断流动，这使得人本身成为一种值得收获的资源。河水般流动的人们跟原料一般都是经济的一种。\n\n战俘构成了你队伍的绝大部分，战败之人必须服从并为另一股势力战斗：你的势力。罪犯和普通的流氓到处都是，他们很容易就能从那些无法处理这些堕落居民的小村落里挑拣出来。还有那些负债者…地狱之火诅咒的灵魂必须通过努力才能回到金铎的光芒沐浴中，并通过鲜血、汗水和泪水找到救赎。尽管大部分人都会成为劳工，你还是喜欢把他们编入自己的战团里。负债者不会抗议，因为即使是祭司也说，他们一定会在镀金者的崇高愿景中，在%companyname%之中忏悔。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "每个人都可以通过努力干活还清金铎的债务而获得救赎。",
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
		this.m.Title = "搜捕者";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

