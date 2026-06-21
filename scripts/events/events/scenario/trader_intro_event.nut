this.trader_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.trader_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_95.png[/img]尸体堆上的苍蝇嗡嗡作响，%ch1%站在苍蝇中间仿佛是他修建了这个死亡图腾然后招来这些苍蝇一般。他转向你。%SPEECH_ON%是绿皮干的。没有人类能把一个人的头像这样劈成两半，任何有点理智的人也都不会像这样子把尸体堆起来。并且在这些箭头上还有哥布林毒药。%SPEECH_OFF%%ch2%点了点头。%SPEECH_ON%昨天我们才发现一名商人被强盗吊死，现在又是这些。道路对于装着财富的货车来说越来越危险了。现在，我不是说我用剑的手不麻利，但只有我们两个帮工简直就是不停的投骰子撞运。先生，你应该考虑雇佣更多护卫。%SPEECH_OFF%",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "唉，我们会没事的。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们不止会雇佣更多护卫！",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				local brothers = this.World.getPlayerRoster().getAll();
				this.Characters.push(brothers[0].getImagePath());
				this.Characters.push(brothers[1].getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_95.png[/img]你摇了摇头。%SPEECH_ON%不。我们现在要做的不止是反击。我想要雇佣一些佣兵在组建一个佣兵团，如果你们想要份稳定的收入的话，你们两位可以当我的第一批佣兵。%SPEECH_OFF%",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "先前进吧，我们还有货物要卖！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				local brothers = this.World.getPlayerRoster().getAll();
				this.Characters.push(brothers[0].getImagePath());
				this.Characters.push(brothers[1].getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_95.png[/img]你摇了摇头。%SPEECH_ON%我们几乎没有在盈利。我没有多余的钱雇更多护卫。但如果我们找到一条新的有利可图的贸易路线就不一样了。我就打算这样干！%SPEECH_OFF%",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "先前进吧，我们还有货物要卖！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				local brothers = this.World.getPlayerRoster().getAll();
				this.Characters.push(brothers[0].getImagePath());
				this.Characters.push(brothers[1].getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "贸易商队";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"ch1",
			brothers[0].getName()
		]);
		_vars.push([
			"ch2",
			brothers[1].getName()
		]);
	}

	function onClear()
	{
	}

});

