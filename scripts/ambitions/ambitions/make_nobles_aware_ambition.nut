this.make_nobles_aware_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.make_nobles_aware";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们需要吸引其中一个贵族家族的眼球，以获得更有利可图的工作。 他们在玩自己的危险游戏，但只要报酬丰厚又有什么关系呢？";
		this.m.RewardTooltip = "你将解锁由贵族签发的报酬更好的全新合同。";
		this.m.UIText = "达到“专业”声望";
		this.m.TooltipText = "以“专业”（1050声望）闻名，以吸引贵族家族的注意。 你可以通过完成合同和赢得战斗来提高自己的声望。";
		this.m.SuccessText = "[img]gfx/ui/events/event_31.png[/img]想要让人们对 %companyname% 这个名字产生兴趣，从而增加你在贵族中的前景，你推动你的人去做伟大的事，表现出杰出的勇敢，还有大量的流血事件。 在几份合同和几场小冲突之后，你付出了足够的努力和时间，让一些领主注意到了战队的能力。\n\n这些都是出身名门世家的人，他们通过一个死去很久的祖先征服一群手无寸铁的农民来统治这片土地。 正如 %highestexperience_brother% 所说，现在这些娇生惯养、近亲繁殖的纨绔子弟对你印象深刻，足以让战队在他们的争斗与你集为一体了。 如果你洗洗脸，礼貌地提出要求，他们就会不时地给你一份有利可图的合同。 你可以祝贺自己！";
		this.m.SuccessButtonText = "我们要从贵族的口袋里掏钱了！";
	}

	function onUpdateScore()
	{
		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 800)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.battle_standard").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() >= 1050 && this.World.FactionManager.isGreaterEvil())
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getBusinessReputation() >= 1050)
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "贵族现在会给你合同"
		});

		if (!this.World.Assets.getOrigin().isFixedLook())
		{
			if (this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart")
			{
				this.World.Assets.updateLook(14);
			}
			else
			{
				this.World.Assets.updateLook(2);
			}

			this.m.SuccessList.push({
				id = 10,
				icon = "ui/icons/special.png",
				text = "你在世界地图上的形象已经更新了"
			});
		}
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

