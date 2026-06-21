this.recruiter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
		this.m.Name = "招募员";
		this.m.Description = "招募员是个下三滥的语言艺术家，他会引诱绝望的人们加入雇佣兵战团来逃离他们的贫困生活，然而最终只是迈向死亡。对于任何运营雇佣兵战团的人来说都十分有用。";
		this.m.Image = "ui/campfire/recruiter_01";
		this.m.Cost = 3000;
		this.m.Effects = [
			"使你在雇佣新人时少支付10%，并且测验费减少50%",
			"让每个定居点可招募的新人数量增加2到4人"
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
		this.World.Assets.m.RosterSizeAdditionalMin += 2;
		this.World.Assets.m.RosterSizeAdditionalMax += 4;
		this.World.Assets.m.HiringCostMult *= 0.9;
		this.World.Assets.m.TryoutPriceMult *= 0.5;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "已招募" + this.Math.min(12, this.World.Statistics.getFlags().getAsInt("BrosHired")) + "/12名手下";

		if (this.World.Statistics.getFlags().getAsInt("BrosHired") >= 12)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

