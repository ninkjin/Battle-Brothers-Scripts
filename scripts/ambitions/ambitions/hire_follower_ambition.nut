this.hire_follower_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.hire_follower";
		this.m.Duration = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "这里有厨师，侦察兵还有很多人可以在战场外支援我们。\n我们会雇一个最适合我们需要的！";
		this.m.UIText = "雇佣一个人作为你的非战斗追随者随从";
		this.m.TooltipText = "获得至少“赏识”（250）的声望，解锁你的随从中非战斗追随者的第一个位置。 你可以通过完成合同和赢得战斗来提高自己的声望。 然后，在随从界面中雇佣一个非战斗追随者。 一些追随者要求你满足特定的先决条件来解锁他们的服务。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]%SPEECH_ON%所以他们不是战士？%SPEECH_OFF%一个佣兵问道。 你摇摇头，他们就抓他们的。%SPEECH_ON%但他们还是被雇佣了？%SPEECH_OFF%你点头。佣兵噘起嘴唇一秒钟，然后澄清。%SPEECH_ON%绝对不打架？%SPEECH_OFF%不打架。%SPEECH_ON%没有一个吗？所以他们会到处放屁，到处做任何事情？%SPEECH_OFF%你解释说，并不是雇佣兵团的每一个重要角色都需要战斗。 在你列出了所有其他人可以帮忙的工作之后，佣兵想了一会儿。%SPEECH_ON%那他们能清点库存吗？ 因为我真的厌倦了。%SPEECH_OFF%No. Of course not. 你永远不会让你的秘密惩罚转嫁给别人。";
		this.m.SuccessButtonText = "这将在今后的日子里对我们大有裨益。";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 1)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < this.Const.BusinessReputation[this.Const.FollowerSlotRequirements[0]] - 100)
		{
			return;
		}

		if (this.World.Retinue.getNumberOfCurrentFollowers() >= 1)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Retinue.getNumberOfCurrentFollowers() >= 1)
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

