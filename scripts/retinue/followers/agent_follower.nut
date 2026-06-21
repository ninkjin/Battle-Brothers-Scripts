this.agent_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.agent";
		this.m.Name = "谍报官";
		this.m.Description = "谍报官在各处都有耳目，很清楚哪里正在发生什么事件以及是否有回报丰厚的合同。";
		this.m.Image = "ui/campfire/agent_01";
		this.m.Cost = 4000;
		this.m.Effects = [
			"不论你在哪里都会在提示栏里揭示定居点的可用合同及目前状态。"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "与一个贵族家族或城邦达到同盟关系"
			}
		];
	}

	function onUpdate()
	{
	}

	function onEvaluate()
	{
		local allied = false;
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			if (n.getPlayerRelation() >= 90.0)
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}

		local citystates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( c in citystates )
		{
			if (c.getPlayerRelation() >= 90.0)
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}
	}

});

