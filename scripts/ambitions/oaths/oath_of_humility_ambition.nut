this.oath_of_humility_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_humility";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "要时刻警醒：骄傲自满是位缓慢却阴险的杀手。\n让我们立下谦逊誓言，并反思一下我们的缺点。";
		this.m.TooltipText = "“既然你们是追求权力的人，就要时刻倾听弱者的声音……因为弱者比你更了解强者，而他们也会比你更了解你自己。”——年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]任何软弱的人都可以跪下，但在强大的位置上做到这一点才是真正的谦卑。虽然%companyname%可以利用它的声誉来赚取新的财富，但它选择了退让，将其财富的一部分奉献给有需要的人，回馈社区，这些社区在第一时间提供了这些合同。很多人从这个经历中学到了很多，或许这些方法在今后的生活或来世都会有所用处。%companyname%已经准备好迎接下一个挑战了。";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "谦逊誓言";
		this.m.OathBoonText = "你的所有战团成员获得[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] 经验值 。";
		this.m.OathBurdenText = "你赚了[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] 任务收益。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 完成目标的合同数(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersContractsComplete");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 7;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 6;
		}
		else
		{
			return 5;
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

	function onUpdateEffect()
	{
		this.World.Assets.m.ContractPaymentMult *= 0.75;
	}

	function onStart()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_humility_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersContractsComplete", 0);
		this.World.Assets.resetToDefaults();
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_humility");
		}

		this.World.Statistics.getFlags().set("OathtakersContractsComplete", 0);
	}

});

