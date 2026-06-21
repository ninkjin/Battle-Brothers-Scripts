this.oath_of_honor_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_honor";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "作为战士，我们决不能忽视真正的荣誉。\n让我们立下荣誉誓言，与我们的对手短兵相接！";
		this.m.TooltipText = "“当箭被拉上弦时，心境转变。当剑挥舞时，一切都如应当的位置那样。把弓箭的技艺放下，走向近战，相信你的钢铁所寻求的，必然会找到。”——年轻的安瑟姆";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]无论弓手们想说什么，当事情到了这个地步，没有什么比面对面遇见一名男子，你们各自手持剑，交错的刀剑间，对视一眼，然后在战斗中找到短暂的喘息，直到无一幸存。即使在比赛中，巨大的事件也不是一些荒谬的事情，比如从头上把苹果射出去或者把鸟射下来。不，是骑士比武！军事战斗！这是由%companyname%进行的最伟大的荣誉。\n\n现在，该战团已经强大，准备接受它的下一个誓言！";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "荣誉誓言";
		this.m.OathBoonText = "你的所有战团成员将以自信士气开始战斗。";
		this.m.OathBurdenText = "你的所有战团成员无法使用远程武器。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 在不贴身的情况下完成目标的击杀次数(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersSoloKills");
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_honor_trait"));
			bro.getSkills().add(this.new("scripts/skills/special/oath_of_honor_warning"));
		}

		this.World.Statistics.getFlags().set("OathtakersSoloKills", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_honor");
			bro.getSkills().removeByID("special.oath_of_honor_warning");
		}

		this.World.Statistics.getFlags().set("OathtakersSoloKills", 0);
	}

});

