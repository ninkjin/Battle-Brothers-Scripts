this.oath_of_dominion_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_dominion";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "饕餮猛兽们是人类文明永恒的威胁。\n让我们立下统御誓言，与大自然的浪潮相抗争！";
		this.m.TooltipText = "“我们源自野兽，但野兽也希望我们回归。远离自然的原始状态，证明自己胜过自然，让自己的人性握在自己的手中，透过自己的双眼看到。”-年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]在这个世界上，没有比普通野兽更常见的威胁了。然而，尽管这种动物疾病猖獗，很少有人愿意拿起武器去追杀它们。只有你们所有人，%companyname%，发誓要击杀这些怪物，并且你们做到了。以稳定的手和平静的心，你们履行了这个誓言。\n\n在野兽和怪物面前战胜，这些人已经准备好去接下来的挑战了！";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.RewardTooltip = "";
		this.m.OathName = "统御誓言";
		this.m.OathBoonText = "你的所有战团成员获得[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] 决心和 [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] 近战和远程技能(与野兽战斗时)";
		this.m.OathBurdenText = "你的所有战团成员获得[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] 决心和 [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] 近战和远程技能(与其他敌人战斗时)。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 击杀目标的野兽数目(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersBeastsSlain");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 50;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 35;
		}
		else
		{
			return 20;
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

		if (this.World.Ambitions.getDone() < 2)
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_dominion_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersBeastsSlain", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_dominion");
		}

		this.World.Statistics.getFlags().set("OathtakersBeastsSlain", 0);
	}

});

