this.roster_of_20_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.roster_of_20";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "让我们把人数增加到20人，这样伤员就能得到休息恢复活力重新上场。";
		this.m.UIText = "战队人数达到20人";
		this.m.TooltipText = "雇佣足够多的人来达到20人的名册。 访问各地的定居点，寻找适合你需要的新兵。";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]连续好几天，你和来自各行各业、社会各个角落的潜在雇佣兵们谈判，筛选掉那些无能者和贪婪者。在动荡的时代，似乎每个流浪汉、每个打零工的人、每个贵族家庭的小儿子都想成为雇佣兵。\n\n这些人很高兴加入战团的壮大阵容，而那些被拒绝的人将成为接下来几周里的笑柄。%highestexperience_brother%拍了拍你的肩膀。%SPEECH_ON%你记得那个人吗？他说他杀了好几个兽人头，但实际上却是来自%randomtown%的一个面包师傅！捏捏那些懒散的二头肌，用树枝打农夫的儿子什么的，起初几天都挺好玩的，但最后反而比追逐强盗还累活呢。%SPEECH_OFF%现在你手下有20个人，不是全部都是老练的，也不是全部都经过考验，但能够轮换伤员将意味着在战场上更加新鲜的部队。";
		this.m.SuccessButtonText = "终于招满人了。";
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 15)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= 20)
		{
			this.m.IsDone = true;
			return;
		}

		if (this.World.Assets.getBrothersMax() < 20)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= 15)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.roster_of_12").isDone())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.getPlayerRoster().getSize() >= 20)
		{
			return true;
		}

		return false;
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

