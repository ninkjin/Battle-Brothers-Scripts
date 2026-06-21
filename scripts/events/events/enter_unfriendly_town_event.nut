this.enter_unfriendly_town_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.enter_unfriendly_town";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{The {denizens | citizens | peasants | laymen | townfolk} of %townname% greet you with {向你们扔臭鸡蛋，而且扔的又快又准，你无可奈何的认为，这些人不会给你面子的。 | 一个涂着柏油和羽毛的娃娃在附近的树上荡秋千。 它的脸与你的脸非常像，但你认为这只不过是个巧合。 | 几个吵闹的孩子，毫无疑问是被父母放出来做坏事的，在成人世界里，这样做会引起一定程度的暴力回应。 当这些小崽子在你身后制造混乱的时候，你命令你的人用他们的靴子。 一顿猛踹赶走了这些小杂种，但是这又能管用多久呢？ | 燃烧着的你的肖像。 农民们把它扔到猪槽里灭火。 他们围成一圈，确保你不会看到肖像的残骸。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不能在这里待下去了。",
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearTown = false;
		local town;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer() && t.getFactionOfType(this.Const.FactionType.Settlement).getPlayerRelation() <= 35)
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
		this.m.Score = 15;
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

