this.oath_of_endurance_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_endurance";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "坚持初创者安塞姆的誓言就是承担起一种无穷无尽的责任。\n让我们立下忍耐誓言，为即将到来的任务做好准备！";
		this.m.TooltipText = "“三番三次攀登，他们真的耐力惊人。” 据说当年年轻的安瑟姆爬上希加利亚山脉最高的峰顶时，他带着他最值得信任的九名追随者。";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{一位著名将军被问到他希望看到哪支军队在他面前部署，他回答道：‘一支不需要呼吸的军队。’不管一个人有多么熟练，如果他没有战斗的能量，那么他所有的技能都将消失，只剩下呼吸声，甚至连剑术大师也会发现自己只有像一个卖酒的女人一样危险。现在喘上一口气，就等于成功地挥出了宝刀。%companyname%已经充分遵循了这个格言！现在战团已经充满了合适的激情，准备接受另一个誓言！}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "忍耐誓言";
		this.m.OathBoonText = "你的所有战团成员每回合额外恢复" + this.Const.UI.Color.PositiveValue + "]+3[/color] 疲劳。";
		this.m.OathBurdenText = "你在每场战斗中最多出动 [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] 人.";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 赢得目标的战斗次数(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersBattlesWon");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 10;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 9;
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

		if (this.World.Ambitions.getDone() < 3)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() < 10)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5) + (this.m.IsDone ? 0 : 10) + this.m.TimesSkipped * 2;
	}

	function onUpdateEffect()
	{
		this.World.Assets.m.BrothersMaxInCombat = 10;
	}

	function onStart()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_endurance_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersBattlesWon", 0);
		this.World.Assets.resetToDefaults();
		this.World.Assets.updateFormation(true);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_endurance");
		}

		this.World.Statistics.getFlags().set("OathtakersBattlesWon", 0);
	}

});

