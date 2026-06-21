this.volunteers_event <- this.inherit("scripts/events/event", {
	m = {
		Dude1 = null,
		Dude2 = null,
		Dude3 = null
	},
	function create()
	{
		this.m.ID = "event.volunteers";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "long-text-warning\n[img]gfx/ui/events/event_80.png[/img]{你正坐在帐篷中，手指捻弄着羽毛笔。有一段时间以前，你看到一个抄写员这样做，但你就是弄不明白他是怎么那么快捻动而不掉笔的。即使微风吹过，也能听到你在指尖打弄时发出的声音。%randombrother%摇了摇头。%SPEECH_ON%我们会从这里面经济上恢复过来吗？%SPEECH_OFF%叹了口气，你抬起头。你曾希望士兵们能够保持镇静，不为损失而担忧，但鉴于最近一系列事件，该公司似乎几乎处于不可逆转的损失边缘。士气低落，库房空虚，但即使你有钱，许多人也可能不愿意加入该公司，因为它的业绩很糟糕。就在这时，一个雇佣兵带着三个人进入了你们的营地。前面的人介绍了自己，然后陈述了他的观点。%SPEECH_ON%我们知道%companyname%的声誉，为此我们走了很远的路来见证它。现在，如果我可以坦诚地说，你们看起来很累，一点都不像传说中的那样，但是，该死，我们知道这个世界很难对付人类，唯一能做的就是克服困难。我们不是走了这么远才因小事而心烦吧？%SPEECH_OFF%这些人提供了不需要预付雇佣费的服务，而且公司的其他成员也因为这个世界仍然高度评价他们和他们的努力而感到振奋。所有那些用来充实%companyname%声誉的时间终于得到了回报。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude1);
						this.World.getPlayerRoster().add(_event.m.Dude2);
						this.World.getPlayerRoster().add(_event.m.Dude3);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude1.onHired();
						_event.m.Dude2.onHired();
						_event.m.Dude3.onHired();
						return 0;
					}

				},
				{
					Text = "我们没事，谢谢。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude1 = roster.create("scripts/entity/tactical/player");
				_event.m.Dude1.setStartValuesEx([
					"bastard_background",
					"caravan_hand_background",
					"deserter_background",
					"houndmaster_background"
				]);
				_event.m.Dude1.getBackground().buildDescription(true);
				_event.m.Dude2 = roster.create("scripts/entity/tactical/player");
				_event.m.Dude2.setStartValuesEx([
					"killer_on_the_run_background",
					"gambler_background",
					"graverobber_background",
					"poacher_background",
					"thief_background"
				]);
				_event.m.Dude2.getBackground().buildDescription(true);
				_event.m.Dude3 = roster.create("scripts/entity/tactical/player");
				_event.m.Dude3.setStartValuesEx([
					"butcher_background",
					"gravedigger_background",
					"mason_background",
					"miller_background",
					"miner_background",
					"peddler_background",
					"ratcatcher_background",
					"shepherd_background",
					"tailor_background"
				]);
				_event.m.Dude3.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude1.getImagePath());
				this.Characters.push(_event.m.Dude2.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1800 || this.World.Assets.getMoney() > 1500)
		{
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 5)
		{
			return;
		}

		if (fallen[0].Time > this.World.getTime().Days + 7 || fallen[1].Time > this.World.getTime().Days + 7 || fallen[2].Time > this.World.getTime().Days + 7 || fallen[3].Time > this.World.getTime().Days + 7 || fallen[4].Time > this.World.getTime().Days + 7)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() < 2)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() + 3 >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 20;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude1 = null;
		this.m.Dude2 = null;
		this.m.Dude3 = null;
	}

});

