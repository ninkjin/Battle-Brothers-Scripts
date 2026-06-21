this.oath_of_righteousness_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_righteousness";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "很少有怪物能像不死生物那样令人厌恶。\n让我们立下正义誓言，击溃这些公然嘲弄生命的污秽邪物！";
		this.m.TooltipText = "“当心那些潜入这个世界的邪恶。抛开世俗事物，全身心投入到彻底安息我们的死者之中。没有人应该在这片黑暗土地上走上第二遍路。” ——年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]在你走过这片大地时，不禁想知道之前有谁来过，之后有谁或什么出现。所以尸体再次行走的景象是一个如此令人不安的回答，大多数人宁愿逃离它也不愿意去寻找确认，因为确认意味着直面。但正是这些没有信仰的畜生成为了%companyname%战团寻找的对象，誓言要在任何地方消灭他们。这是一个正义的事情，需要巨大的勇气和毅力，完成后，%companyname%的士兵们毫不怀疑已经被一种几乎没有人能够感到的成就感所激发。\n\n怀揣正义的热血，%companyname%已经准备迎接他们的下一个誓言！";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.RewardTooltip = "";
		this.m.OathName = "正义誓言";
		this.m.OathBoonText = "你的所有战团成员获得[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] 决心和 [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] 近战和远程技能，以及[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]与亡灵战斗时的近战和远程防御。";
		this.m.OathBurdenText = "你的所有战团成员获得[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] 决心和 [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战和远程技能，以及[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] 近战和远程防御(与其他敌人战斗时)。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 击杀目标的亡灵数目(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersUndeadSlain");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 75;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 50;
		}
		else
		{
			return 25;
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

		if (this.World.Ambitions.getDone() < 3)
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_righteousness_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersUndeadSlain", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_righteousness");
		}

		this.World.Statistics.getFlags().set("OathtakersUndeadSlain", 0);
	}

});

