this.peddler_sells_rat_event <- this.inherit("scripts/events/event", {
	m = {
		Peddler = null,
		Ratcatcher = null
	},
	function create()
	{
		this.m.ID = "event.peddler_sells_rat";
		this.m.Title = "露营时…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%SPEECH_ON%最后说一次，不要，我绝对不会买一只老鼠。%SPEECH_OFF%你看见捕鼠者 %ratcatcher% 转了个弯，令人讨厌的小贩 %peddler% 则紧紧地跟在他的身后。 小贩再次抬高了声调。%SPEECH_ON%当然你不会买！ 你是个捕鼠者，为什么要买呢？但是如果…%SPEECH_OFF%捕鼠者停了下来并转身看着小贩，用力地用一根手指戳着小贩的胸口。%SPEECH_ON%老鼠不是从树上长出来的，%peddler%！他们有不同的血统！ 如果我需要一只老鼠来陪伴我，我会自己去找！ 现在，如果你需要杀老鼠，那我们还能谈。%SPEECH_OFF%%peddler%的眼镜看向地面，想了一会。 突然，他抬起头来，激动地举起了一只手指。%SPEECH_ON%额，那一只金鱼？ 你要不要买一只金鱼？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这里一切都很正常。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_peddler = [];
		local candidates_ratcatcher = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.peddler")
			{
				candidates_peddler.push(bro);
			}
			else if (bro.getBackground().getID() == "background.ratcatcher")
			{
				candidates_ratcatcher.push(bro);
			}
		}

		if (candidates_peddler.len() == 0 || candidates_ratcatcher.len() == 0)
		{
			return;
		}

		this.m.Peddler = candidates_peddler[this.Math.rand(0, candidates_peddler.len() - 1)];
		this.m.Ratcatcher = candidates_ratcatcher[this.Math.rand(0, candidates_ratcatcher.len() - 1)];
		this.m.Score = candidates_peddler.len() * candidates_ratcatcher.len() * 3 * 50000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"peddler",
			this.m.Peddler.getName()
		]);
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
		this.m.Peddler = null;
		this.m.Ratcatcher = null;
	}

});

