this.win_against_x_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		IsFulfilled = false
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.win_against_x";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "让我们先把小规模战斗放一边，去击败至少一打敌人。 这就是我们的名字将在这片土地上广为人知的原因！";
		this.m.RewardTooltip = "为你的胜利获得额外的150声望。";
		this.m.UIText = "赢得一场12个或更多敌人的战斗";
		this.m.TooltipText = "赢得一场12个或更多敌人的战斗，无论是杀死他们，还是让他们四散奔逃。 你可以把它作为合同的一部分，或者按照你自己的方式来完成。";
		this.m.SuccessText = "[img]gfx/ui/events/event_22.png[/img]当你所有的敌人死了或者撤退之后，%bravest_brother% 挥舞着战队的旗帜庆祝。%SPEECH_ON%再一次 %companyname% 开打，%companyname% 再一次占了上风！%SPEECH_OFF%沙哑的欢呼声在他周围回响。 你很快发现你最近的战斗成为了当地城镇和村庄的话题。 每当兄弟在路边的一家酒馆停下来时，他们发现，当讲述那场战斗的故事时，人们会倒酒，而且讲述的内容越是添油加醋，倒酒倒的就越离谱。";
		this.m.SuccessButtonText = "现在谁敢挡在我们面前？";
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 12)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.battle_standard").isDone())
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 12 || this.m.IsFulfilled)
		{
			return true;
		}

		return false;
	}

	function onLocationDestroyed( _location )
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 12)
		{
			this.m.IsFulfilled = true;
		}
	}

	function onPartyDestroyed( _party )
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 12)
		{
			this.m.IsFulfilled = true;
		}
	}

	function onReward()
	{
		this.World.Assets.addBusinessReputation(150);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "你因你的胜利而获得额外的声望"
		});
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeBool(this.m.IsFulfilled);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.IsFulfilled = _in.readBool();
	}

});

