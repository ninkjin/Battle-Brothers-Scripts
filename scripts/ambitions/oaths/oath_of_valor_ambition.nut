this.oath_of_valor_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_valor";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们必须有勇气面对任何挑战，无论挑战多么艰巨。\n让我们立下英勇誓言，向所有人证明我们的勇敢！";
		this.m.TooltipText = "“在危难时刻，请记住：勇气可以克服技能。虽然勇气不能单独决定战斗的胜负，但纯粹的决心可以让你活下来，这是战斗之教训最好的结论。”——年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{一个人不能仅凭技能和能力就获得成功。很多人都知道如何挥舞剑，举起斧头或者放箭。这并不是人类成长的关键，而是来自他自己内心的通过艰辛锻炼锤炼的品质。在那里锻造的坚如钢铁，永不言弃，因为即使是一个勇猛的战士在世界的历史长河中倒下了，他的名字也会被后人赞颂，被同类人传颂。\n\n现在，由于该战团已经证明了自己最坚定的元素，它已经准备好接受另一个誓言了!}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "英勇誓言";
		this.m.OathBoonText = "你的战团成员在战斗中永远不会逃跑。";
		this.m.OathBurdenText = "你的所有战团成员获得[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] 经验值";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 以寡敌众赢得目标的战斗次数" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersDefeatedOutnumbering");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 5;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 4;
		}
		else
		{
			return 3;
		}
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5) + (this.m.IsDone ? 0 : 10) + this.m.TimesSkipped * 2;
	}

	function onStart()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_valor_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersDefeatedOutnumbering", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_valor");
		}

		this.World.Statistics.getFlags().set("OathtakersDefeatedOutnumbering", 0);
	}

});

