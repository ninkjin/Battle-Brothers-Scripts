this.ratcatcher_crafts_net_event <- this.inherit("scripts/events/event", {
	m = {
		Ratcatcher = null
	},
	function create()
	{
		this.m.ID = "event.ratcatcher_crafts_net";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]你在闲逛时看见 %ratcatcher% 坐在一边，手上满是绳子。 他异常迅猛地把麻绳打成绳环－以绳子可以被绕成环的最大限度－看得你都不敢把脚凑到那堆绳子旁边去了。 你好奇地询问他在干嘛。 就好像他早就等着你发问似的，他唰一下举起他的作品，宣布他给自己织了一张网。 啊！ 你一拍大腿。%SPEECH_ON%它在战场上肯定会很有用的！%SPEECH_OFF%捕鼠者撅起了嘴唇。 慢慢放下了他的网。%SPEECH_ON%噢，我本来是想…用它…给我抓几只老鼠来着…%SPEECH_OFF%他停了一会，然后抬起头来，脸上挂着诡异的笑容。%SPEECH_ON%但我会把它用在战场上的！ 不论是老鼠，人还是别的什么毛茸茸又到处乱窜的东西都别想从我手底下溜走！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
				local item = this.new("scripts/items/tools/throwing_net");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.ratcatcher")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Ratcatcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"ratcatcher",
			this.m.Ratcatcher.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Ratcatcher = null;
	}

});

