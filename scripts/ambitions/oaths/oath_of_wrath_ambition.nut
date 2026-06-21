this.oath_of_wrath_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_wrath";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "在战斗中，没有比懦弱更致命的错误。\n让我们立下愤怒誓言，向敌人证明什么才是真正的崩溃!";
		this.m.TooltipText = "年轻的安瑟姆写了许多关于武术战斗的手册，其中最受欢迎的手册鼓励使用双手武器并避免战术。这些文字的页面上有干血斑驳。";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]在生死战中，只有一种方法可以保证胜利：彻底的歼灭。在这致命的努力中，双手武器是首选。当%companyname%的男人们誓言愤怒时，他们像蛾子跳到一半火红的铁匠铺里，从火炭中退缩时，铁匠像个疯狂的行刑官一样站在旁边，手持铁锤，准备把它的边缘敲平成最终的杀戮武器，并把它翻开，发现这个金属块对于普通人来说太大了，但如果放在合适的手中，却足以将人分成两半。所以%companyname%放弃了防御，欢迎着流血的战斗。\n\n满足了愤怒和饮尽了鲜血，%companyname%已经准备好接受他们的下一个誓言!";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "愤怒誓言";
		this.m.OathBoonText = "你的所有战团成员获得[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] 使用双手或双手握持的近战武器的命中率加成。并且只要武器允许，他们的所有杀敌都将是必死击杀（如斩首，碎颅等）";
		this.m.OathBurdenText = "你的所有战团成员获得[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] 近战防御和 [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] 远程防御";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 击杀目标的敌人数目(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersWrathSlain");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 100;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 75;
		}
		else
		{
			return 50;
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_wrath_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersWrathSlain", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_wrath");
		}

		this.World.Statistics.getFlags().set("OathtakersWrathSlain", 0);
	}

});

