this.oath_of_fortification_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_fortification";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "邪恶之徒躲藏在公理与正义的高墙之外。\n让我们立下壁垒誓言，把这堵高墙拍在他们脸上！";
		this.m.TooltipText = "“信任你的盾牌，就像你相信旧神一样，因为树木和土地的贡献不应被浪费在懦夫的神经紧张上。” - 年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{古帝国的文献记载了军事编队之间的关系是如此之紧密和紧凑，以至于就像是脚下漫步的城堡：数百个盾牌像蛇鳞或乌龟壳一样紧密结合。%companyname%尽力复制这些理论，总需要一些时间来整合这些要素，但您从未打算将其变成一个卓越的演练。古人拥有帝国，而你是一群不和谐的人和宣誓者。但根据你的估计，毕竟团队仍在坚持，因此这个誓言是一个杰出的成功。\n\n现在是时候放下盾牌和古代帝国的热情，并接受新的誓言了！}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "壁垒誓言";
		this.m.OathBoonText = "你的所有战团成员中使用盾牌技能时减少 [color=" + this.Const.UI.Color.NegativeValue + "25%疲劳积累。”盾墙“技能提供额外 [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] 近战防御和 [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] 远程防御。 “撞退”技能在成功命中时会对目标施加踉跄效果。";
		this.m.OathBurdenText = "你的所有战团成员在战斗的第一个回合无法移动。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() <= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "如果你在誓言期间从未损失过战团成员，你会获得额外的声望。 (" + this.getBonusObjectiveProgress() + "已死亡)";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersBrosDead");
	}

	function getBonusObjectiveGoal()
	{
		return 0;
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_fortification_trait"));
			bro.getSkills().add(this.new("scripts/skills/special/oath_of_fortification_warning"));
		}

		this.World.Statistics.getFlags().set("OathtakersBrosDead", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_fortification");
			bro.getSkills().removeByID("special.oath_of_fortification_warning");
		}

		this.World.Statistics.getFlags().set("OathtakersBrosDead", 0);
	}

});

