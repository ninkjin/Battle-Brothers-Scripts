this.drill_sergeant_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "教官";
		this.m.Description = "教官曾经是一名雇佣兵，但伤病提早结束了他的生涯。现在他会训练你手下的纪律，并大喊大叫以确保每个人都能从自己的错误中吸取教训。";
		this.m.Image = "ui/campfire/drill_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"使你的手下在1级时获得20%额外经验，每提高一级就减少2%",
			"使充当后备的人不会因不参加战斗而降低心情"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "让一个遭受了永久伤势的非负债者手下退休"
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsDisciplined = true;
	}

	function onEvaluate()
	{
		if (this.World.Statistics.getFlags().getAsInt("BrosWithPermanentInjuryDismissed") > 0)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

