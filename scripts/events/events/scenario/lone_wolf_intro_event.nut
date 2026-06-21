this.lone_wolf_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.lone_wolf_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_137.png[/img]{你走在骑枪竞技场的看台上。发霉的水果蔬菜散落在地板上。干枯的血液使得座位布满斑点。空气中充满了寂静。当你坐下时，这个地方的木料似乎在齐声呻吟，仿佛被一个罕见的访客所惊扰。\n\n在你手里是张纸条。‘寻找强壮的人，所有人都欢迎，但懂得如何用剑的人优先。’这是一张旧纸条，它的目的很久以前就达到了。但是吸引你眼球的是这项工作的报酬，比你在五场骑枪竞技里赚到的还要多。\n\n如果仅仅是要赚钱的话，竞技和比武都可以去见鬼了。但是你并不是一个适合听从其他团长命令的人。有了这些年来你赚到的钱，你想象着可以组建一支自己的雇佣兵战团。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这正是我将要做的。",
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
		this.m.Title = "独狼";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

