this.oath_of_camaraderie_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {
		DisableEffect = false
	},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_camaraderie";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "没有任何一位宣誓者能够独自面对世界上的所有邪恶。\n让我们立下友谊誓言，以免失去真正的盟友！";
		this.m.TooltipText = "小安瑟姆认为，有时，召集尽可能多的人参加战斗是正确的，即使大群人确实威胁到了指挥系统。 的确，“所有人都应该支持他们的兄弟”。";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]{力量在于人数，友情在于兄弟情谊。 虽然增派人手会阻碍你的指挥能力，但在每次战斗过程中，%companyname% 很快意识到，通过与你身边的人并肩作战，相信他能完成他的工作，他也相信你能完成你的工作，就能克服战斗的混乱。 这一经历使战队经受住了战争的浩劫。\n\n现在，战队知道可以通过信任自己的成员来对抗敌人，准备再次宣誓！}";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.OathName = "友谊誓言";
		this.m.OathBoonText = "你可以带上 [color=" + this.Const.UI.Color.PositiveValue + "]14[/color] 人.";
		this.m.OathBurdenText = "你的人总是随机以动摇或溃散士气开始战斗。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 让你的战团成员变得自信(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersBrosConfident");
	}

	function getBonusObjectiveGoal()
	{
		if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Hard)
		{
			return 150;
		}
		else if (this.World.Assets.getCombatDifficulty() >= this.Const.Difficulty.Normal)
		{
			return 100;
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
		if (!this.m.DisableEffect)
		{
			this.World.Assets.m.BrothersMaxInCombat = 14;
		}
	}

	function onStart()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_camaraderie_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersBrosConfident", 0);
		this.World.Assets.resetToDefaults();
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_camaraderie");
		}

		this.World.Statistics.getFlags().set("OathtakersBrosConfident", 0);
		this.m.DisableEffect = true;
		this.World.Assets.resetToDefaults();
		this.World.Assets.updateFormation(true);
	}

});

