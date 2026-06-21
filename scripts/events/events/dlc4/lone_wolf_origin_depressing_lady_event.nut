this.lone_wolf_origin_depressing_lady_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.lone_wolf_origin_depressing_lady";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_91.png[/img]{你在一个贵族的房子外面碰到一个老妇人。她对你的评价就好像她在回顾自己的过去。有趣的是，你问她想要什么。这位女士微笑。%SPEECH_ON%你真的知道你在做什么吗？像个野骑士一样在这片土地上游荡，一次次地杀戮、屠杀、强奸女人们？%SPEECH_OFF%你礼貌地告诉她，你实际上不只是一个经常找乐子的人，而是一个真正的佣兵。她耸肩，把手伸向一位贵族的房子。%SPEECH_ON%那又怎么样呢？ 他们永远不会接纳你。 你会成为一名战士。 你不属于这里。 你只有在他们允许的情况下才能进去。 这不是一个你可以自我升华的世界。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会改变这个世界的。",
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
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
		this.m.Score = 25;
	}

	function onPrepare()
	{
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

