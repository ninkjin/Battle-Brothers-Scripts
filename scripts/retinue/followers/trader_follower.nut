this.trader_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.trader";
		this.m.Name = "交易员";
		this.m.Description = "南方商人以他们交易技巧而闻名。你真幸运，能说服这样一名讨价还价的大师加入你的战团。而且还这么便宜！";
		this.m.Image = "ui/campfire/trader_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"每个生产贸易商品的地点都增加1单位可交易的货物，比如来自盐矿的盐，允许你进行更大额度的交易"
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
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "售出" + this.Math.min(25, this.World.Statistics.getFlags().getAsInt("TradeGoodsSold")) + "/25件贸易商品";

		if (this.World.Statistics.getFlags().getAsInt("TradeGoodsSold") >= 25)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

