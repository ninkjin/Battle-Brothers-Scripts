this.brigand_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.brigand";
		this.m.Name = "强盗";
		this.m.Description = "这个强盗现在可能已经年迈力衰，但他的名字曾在这片土地上威震一时。以一顿热饭作为交换，他会很开心的跟你分享他从他的线人那里得到的行进中的商队信息。";
		this.m.Image = "ui/campfire/brigand_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"使你能随时看到一些商队的位置，即使在你的视野之外"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsBrigand = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "劫掠了" + this.Math.min(4, this.World.Statistics.getFlags().getAsInt("CaravansRaided")) + "/4个商队";

		if (this.World.Statistics.getFlags().getAsInt("CaravansRaided") >= 4)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

