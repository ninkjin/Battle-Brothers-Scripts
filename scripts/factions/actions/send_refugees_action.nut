this.send_refugees_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_refugees_action";
		this.m.Cooldown = 300.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		local hasInactive = false;

		foreach( a in _faction.getSettlements()[0] )
		{
			if (!a.isActive() && a.isMilitary())
			{
				hasInactive = true;
				break;
			}
		}

		if (!hasInactive)
		{
			return;
		}

		local mySettlements = _faction.getSettlements();
		local allSettlements = this.World.EntityManager.getSettlements();
		local settlements = this.getRandomConnectedSettlements(2, mySettlements, allSettlements, true);

		if (settlements.len() < 2)
		{
			return;
		}

		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];
		this.m.Score = 5;
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function onExecute( _faction )
	{
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Refugees", false, this.Const.World.Spawn.Peasants, this.Math.rand(30, 60));
		party.getSprite("banner").Visible = false;
		party.getSprite("body").setBrush("figure_civilian_0" + this.Math.rand(1, 2));
		party.setDescription("逃离战争恐怖的难民，被打倒、疲惫和绝望。");
		party.setFootprintType(this.Const.World.FootprintsType.Refugees);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 50);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(despawn);
	}

});

