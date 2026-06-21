this.oath_of_sacrifice_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_sacrifice";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "如果我们沉迷于世俗事务，我们就无法成为初创者安塞姆那样的榜样。\n让我们立下牺牲誓言，将我们的意志磨练到最尖锐的地步。";
		this.m.TooltipText = "“如果一切都在老神的馈赠之内，那么痛苦本身将是他们最苦涩的果实。尽管如此，这仍然是一种贡献，因此我们与痛苦的斗争是极其自私的。脱离治疗师的疗愈，同样也要脱离商人的借贷。”——年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{修道院的僧侣将会数日不喝水，数周不进食，永远不会有性。人们相信牺牲是“万物的调味料”，它是如此强大，以至于在那些自愿经历痛苦的人的灰烬中，可以找到耐力本身的残留物。现在，你承担了类似的誓言，理解了为何圣人会像母亲般对待自己弟兄的灰烬。对于%companyname%来说，这种永恒的力量分布在全战团，因为悲惨是可怕的，但是与你的战斗兄弟们肩并肩地承受共同的苦难，是一种令人动容的药剂，它将思维局限于那些必须完成的事情，排斥所有世俗的事物。\n\n现在，士兵们将会治愈，他们的思维将会回归到使他们脚踏实地的束缚上来。让修道院的僧侣为长远的奉献而付出，他们有更强的智慧和信仰，他们是应该仰望的，而不是像他们一样愚蠢地跟随。\n\n至于未来，是时候让立誓者接受另一种誓言了！}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "牺牲誓言";
		this.m.OathBoonText = "你的所有战团成员不再需要工资。";
		this.m.OathBurdenText = "你的所有战团成员无法从伤残中恢复。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() <= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 誓言期间承受不多于" + this.getBonusObjectiveGoal() + "的伤残次数(" + this.getBonusObjectiveProgress() + (this.getBonusObjectiveProgress() == 1 ? "次" : "次") + "已承受";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersInjuriesSuffered");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 4;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 6;
		}
		else
		{
			return 8;
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_sacrifice_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersInjuriesSuffered", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_sacrifice");
		}

		this.World.Statistics.getFlags().set("OathtakersInjuriesSuffered", 0);
	}

});

