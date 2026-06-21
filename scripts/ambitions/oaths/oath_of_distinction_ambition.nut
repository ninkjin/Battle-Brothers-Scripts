this.oath_of_distinction_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_distinction";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "真正杰出的是那些能够遵循年轻的安瑟姆的教导的人。\n让我们立下超群誓言，证明我们有资格走他的路！";
		this.m.TooltipText = "小安瑟姆经常寻求独处，有时甚至是在战场上。 “用这种方式证明你的价值，即使是古神也不会说他们的眼睛在他们所看到的荣耀中有错误。”";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{许多剑术大师都是独处的。 他们的想法是，他们不是在与前面的人战斗，而是在为中间的空间而战。 虽然你不可能理解剑术大师和佣兵在空中舞剑的细微差别，但你会意识到这一公理的核心真理。 宣誓者，虽然可敬、勤奋，但内心仍然勇敢得近乎残酷，过分自信得荒谬可笑。 超群誓言在精神上遵循了剑术大师的技艺，而宣誓者则铭记于心。 每个人都独立自主地努力证明自己，证明自己值得别人的称赞。 如果有任何无偏见的俗人碰巧在观看，那么就不可能说 %companyname% 没有作为一个精良的队伍脱颖而出。\n\n但是区别是不可避免的。 我们不能整天霸占着荣耀！ 到下一个誓言！}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "超群誓言";
		this.m.OathBoonText = "你的战团成员获得 [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] 决心, [color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] 每回合疲劳恢复, and deal [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] 伤害(如果相邻板块上没有盟友)";
		this.m.OathBurdenText = "你的人不会从盟友的击杀中获得经验。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 让你的一位战团成员升级" + this.getBonusObjectiveGoal() + " 次(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		brothers.sort(function ( _a, _b )
		{
			if (_a.getFlags().getAsInt("OathtakersDistinctionLevelUps") > _b.getFlags().getAsInt("OathtakersDistinctionLevelUps"))
			{
				return -1;
			}
			else if (_a.getFlags().getAsInt("OathtakersDistinctionLevelUps") < _b.getFlags().getAsInt("OathtakersDistinctionLevelUps"))
			{
				return 1;
			}

			return 0;
		});
		return brothers[0].getFlags().getAsInt("OathtakersDistinctionLevelUps");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 3;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 2;
		}
		else
		{
			return 2;
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

		if (this.World.Ambitions.getDone() < 1)
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_distinction_trait"));
			bro.getFlags().set("OathtakersDistinctionLevelUps", 0);
		}
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_distinction");
			bro.getFlags().set("OathtakersDistinctionLevelUps", 0);
		}
	}

});

