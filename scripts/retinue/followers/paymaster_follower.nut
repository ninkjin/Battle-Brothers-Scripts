this.paymaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
		this.m.Name = "出纳员";
		this.m.Description = "出纳员负责所有战团的日常财务和组织事务，比如支付工资。";
		this.m.Image = "ui/campfire/paymaster_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"每人每日的工资减少15%",
			"手下逃离战团的概率降低50%",
			"阻止手下要求涨工资的事件出现"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function isVisible()
	{
		return this.World.Assets.getBrothersMax() >= 16;
	}

	function onUpdate()
	{
		this.World.Assets.m.DailyWageMult *= 0.85;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "战团名册中有" + this.Math.min(16, this.World.getPlayerRoster().getSize()) + "/16位成员";

		if (this.World.getPlayerRoster().getSize() >= 16)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

