this.historian_records_adventures_event <- this.inherit("scripts/events/event", {
	m = {
		Historian = null
	},
	function create()
	{
		this.m.ID = "event.historian_records_adventures";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_15.png[/img]手里拿着一本皮革封面的大部头著作，%historian% 步伐沉重地走进了你的帐篷。 没有说一句话，他把书放在桌上，然后后退了一步。 你把你手里的羽毛笔放下，问道，这是什么。 他说，打开它。 叹了一口气，你翻开书的封面，发现里面杂乱地写着一些你熟知的名字和事迹。 这是你战队的历史和曾经经历的冒险。 你轻轻敲着书页，看着那些温暖心灵的、让人心碎的曾今。 合上书籍，你把它推回桌上。 历史学家问，还有什么需要修改的吗，你摇了摇头。 你对历史学家说，把它给营地里的伙计们都读一读，它一定会鼓舞他们的精神。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "%companyname% 的所作所为不应该被遗忘。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) >= 90)
					{
						continue;
					}

					bro.improveMood(1.0, "为战队的成就感到骄傲");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 9 && bro.getBackground().getID() == "background.historian")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Historian = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"historian",
			this.m.Historian.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Historian = null;
	}

});

