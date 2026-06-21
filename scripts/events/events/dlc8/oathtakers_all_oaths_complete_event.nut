this.oathtakers_all_oaths_complete_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.oathtakers_all_oaths_complete";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_180.png[/img]{年轻的安瑟姆（Young Anselm）最后的誓言已经完成了。誓言守护者（Oathtakers）真正地赢得了他们的名声！只有一个问题留待解决：现在该怎么办呢？你从来没有确定过第一位誓言守护者（First Oathtaker）守誓完成后会发生什么，现在当你完成了它们，你和战团的其他成员都意识到：要继续前行。现在回头去做什么呢？谁想回到旧日缺乏引导的生活中？虚弱、无目的地漂浮着生活？这显然不是年轻的安瑟姆想要通过走上终极道路来实现的愿景。你告诉士兵们，每个誓言都有它的含义，也许所有的誓言在一起形成了它们自己的意义。誓言守护者之路只有当誓言守护者希望它结束时才会结束。你看着这群人。%SPEECH_ON%如果你觉得自己不需要守誓，那就请离开吧。%SPEECH_OFF%沉思的目光在这群人中传递开来。最终，有人抬起头来。%SPEECH_ON%只有一种方法可以离开年轻的安瑟姆的引导，那就是加入他的行列！%SPEECH_OFF%这群人欢呼雀跃。为年轻的安瑟姆乾杯，为寻找他的下颌骨，为杀死所有守誓者（Oathbringers）乾杯！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "为了年轻的安瑟姆！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(2.0, "完成了所有年轻安瑟姆的誓言。");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}

					bro.getBaseProperties().Bravery += 1;
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
					});
				}
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

		local all_oaths_complete = this.World.Ambitions.getAmbition("ambition.oath_of_camaraderie").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_distinction").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_dominion").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_endurance").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_fortification").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_honor").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_humility").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_righteousness").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_sacrifice").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_valor").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_vengeance").isDone() && this.World.Ambitions.getAmbition("ambition.oath_of_wrath").isDone();

		if (!all_oaths_complete)
		{
			return;
		}

		this.m.Score = 600;
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

