this.oathtakers_noble_contracts_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.oathtakers_noble_contracts";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_63.png[/img]{那人给你带来了一个惊人的发现：在小安瑟姆的颅骨内侧有一封小小的，卷起来的信件－它的蜡封上有一枚贵族戒指印章的花纹。 在征得大家的同意后，你打开蜡封并且开始阅读。 你发现小安瑟姆出生血统高贵，并且他持有法庭的缺席令状－或者用佣兵的说法，就是进入贵族法庭的许可。 你看向大家并说，%SPEECH_ON%小安瑟姆又一次保佑了我们！%SPEECH_OFF%那些跟贵族交谈接任务的佣兵们多半成了被灭口的替罪羊，以免亵渎到贵族们圣洁的地板，但是小安瑟姆的信件上有一个独特的记号：这意味着整个队伍中的任何人都将得到一个完全相同的觐见贵族的渠道，而且这个渠道永久有效。 那人推测小安瑟姆一定在贵族圈子里有着很高的地位才能做到这些，并且推测小安瑟姆可能对你所做的一切评价甚高并且想要将他的力量赐予你。%SPEECH_ON%但是，嗯，是谁把卷轴放进他的脑袋里的？%SPEECH_OFF%%randombrother% 询问道。你和手下叫他闭嘴。 执着于弄清楚怎么了为什么如何办到等问题毫无意义。 这显然是一个奇迹，并且这也是又一个证明宣誓者走在正确道路上的明证。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "有这个令状，即使是贵族也会给我们工作。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Ambitions.getAmbition("ambition.make_nobles_aware").setDone(true);
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "贵族现在会给你合同"
				});
			}

		});
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

		if (this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1050)
		{
			return;
		}

		this.m.Score = 2000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

