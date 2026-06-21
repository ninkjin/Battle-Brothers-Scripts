this.oath_of_vengeance_ambition <- this.inherit("scripts/ambitions/oaths/oath_ambition", {
	m = {},
	function create()
	{
		this.oath_ambition.create();
		this.m.ID = "ambition.oath_of_vengeance";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "绿皮已经毒害我们的土地太久了。\n让我们立下复仇誓言，反击这种威胁！";
		this.m.TooltipText = "安瑟姆年轻时家人在众名之战期间被兽人杀害。据说他面对绿皮族时，似乎成为了一名不可阻挡的战士，他的追随者试图效仿他这种报复性的武术技能。";
		this.m.SuccessText = "[img]gfx/ui/events/event_180.png[/img]绿皮兽人长期以来一直困扰着人类的土地。尽管它们的威胁长存，很少有人会发誓要摧毁这些生物。它们是一种瘟疫，正因为它们如此危险，大多数人宁愿掉过头去，也不敢去面对这些野兽。然而，%companyname%的人决定发誓一定要追捕到兽人和地精，从而成功找到和消灭它们，一种成就感油然而生。这些人已经迫不及待了：下一个应该发誓做什么？";
		this.m.SuccessButtonText = "{为了小安瑟姆！ | 宣誓者万岁！ | 誓约使者去死吧！}";
		this.m.RewardTooltip = "";
		this.m.OathName = "复仇誓言";
		this.m.OathBoonText = "你的所有战团成员获得[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] 决心, [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] 近战和远程技能，以及[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]与兽人及哥布林战斗时的近战和远程防御。";
		this.m.OathBurdenText = "你的所有战团成员获得[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] 决心, [color=" + this.Const.UI.Color.NegativeValue + "]-5[/color]近战和远程技能，以及[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] 近战和远程防御(与其他敌人战斗时)。";
	}

	function getRenownOnSuccess()
	{
		local additionalRenown = this.getBonusObjectiveProgress() >= this.getBonusObjectiveGoal() ? this.Const.World.Assets.ReputationOnOathBonusObjective : 0;
		return this.Const.World.Assets.ReputationOnOathAmbition + additionalRenown;
	}

	function getRewardTooltip()
	{
		return "誓言目标: 击杀目标的绿皮数目(" + this.getBonusObjectiveProgress() + "/" + this.getBonusObjectiveGoal() + ").";
	}

	function getBonusObjectiveProgress()
	{
		return this.World.Statistics.getFlags().getAsInt("OathtakersGreenskinsSlain");
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
			bro.getSkills().add(this.new("scripts/skills/traits/oath_of_vengeance_trait"));
		}

		this.World.Statistics.getFlags().set("OathtakersGreenskinsSlain", 0);
	}

	function onReward()
	{
		this.World.Statistics.getFlags().increment("OathsCompleted");
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			bro.getSkills().removeByID("trait.oath_of_vengeance");
		}

		this.World.Statistics.getFlags().set("OathtakersGreenskinsSlain", 0);
	}

});

