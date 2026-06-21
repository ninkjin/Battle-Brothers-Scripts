this.ranged_mastery_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.ranged_mastery";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "咱们战队缺乏老练的弓箭手，限制了咱们的策略选择。我们得训练三名弓箭或弩箭大师从远处给予致命威胁！";
		this.m.UIText = "有1人点出弓精通或弩精通天赋";
		this.m.TooltipText = "有3人点出弓精通或弩精通天赋。";
		this.m.SuccessText = "[img]gfx/ui/events/event_10.png[/img]每有机会，你都会鼓励你指挥下的人进行几次群射。每个人都参与其中，即使是那些愚蠢的傻瓜，如果你允许的话，他们也会穿着盔甲睡觉。任何目标都足够了：一棵小树的树干，一只在清晨吃草的母鹿，或者一个逃命的哥布林侦察兵。%SPEECH_ON%是的，我们是全世界干草捆的公敌！%SPEECH_OFF%%randombrother%在练习中指着一个常见的目标说道。当他的一个战友的箭从他的头附近呼啸而过时，他躲开了，并咒骂着射手。\n\n经过大量的练习，这些箭越来越接近靶心，由于战团部署了训练有素的弓箭手，你的前排呼吸更轻松，存活时间也更长，至少在一定程度上更长。";
		this.m.SuccessButtonText = "这对我们很有帮助。";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.Math.min(3, this.getBrosWithMastery()) + "/3)";
	}

	function getBrosWithMastery()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local count = 0;

		foreach( bro in brothers )
		{
			local p = bro.getCurrentProperties();

			if (p.IsSpecializedInBows)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInCrossbows)
			{
				count = ++count;
			}
		}

		return count;
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 25)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local count = this.getBrosWithMastery();

		if (count >= 3)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local count = this.getBrosWithMastery();

		if (count >= 3)
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

