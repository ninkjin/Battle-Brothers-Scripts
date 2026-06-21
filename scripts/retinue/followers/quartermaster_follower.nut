this.quartermaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.quartermaster";
		this.m.Name = "军需官";
		this.m.Description = "凭借多年跟随商队旅行的经验，军需官能够将任何武器盔甲还有行李旋转挤压到最佳位置，以尽可能有效地利用空间。";
		this.m.Image = "ui/campfire/quartermaster_01";
		this.m.Cost = 3000;
		this.m.Effects = [
			"你可携带弹药的上限增加100",
			"你可携带工具和医疗用品的上限各增加50"
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
		this.World.Assets.m.AmmoMaxAdditional = 100;
		this.World.Assets.m.MedicineMaxAdditional = 50;
		this.World.Assets.m.ArmorPartsMaxAdditional = 50;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "完成" + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone")) + "/5个护送商队合同";

		if (this.World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

