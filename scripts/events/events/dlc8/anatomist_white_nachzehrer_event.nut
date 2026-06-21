this.anatomist_white_nachzehrer_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_white_nachzehrer";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{%anatomist%最近没怎么写他的日记。当他写的时候，笔只是轻轻敲打着纸张，却没有任何重要的内容。你询问他为什么烦恼。他用忧郁的语气回答道，他来这片土地的首要目标就是要找到白色纳克扎勒，一种比它种族中的任何一种都大的怪物。你告诉他你已经杀了几只相当肥大的纳克，但解剖学家摇了摇头。%SPEECH_ON% 根据文献，这种纳克扎勒无人能杀，因为它变得如此之大，肉已经变成了白色，而且它被覆盖着一层一层厚厚的老茧，任何钢铁都无法 penetrate。我希望在这片土地找到它，但看来我可能是被唬弄了。也许告诉我这个故事的解剖学家让我去了一次徒劳的狩猎。我担心，流氓，我已经变成了一个傻瓜。%SPEECH_OFF% 你告诉他这个生物听起来像纳克扎勒的“国王”，如果是这样，那么它可能不再漫游，而是使用一些较小的纳克扎勒来为它工作。解剖学家笑了起来。 %SPEECH_ON%确实，这可能就是真相！当然，这需要我亲自去查探。%SPEECH_OFF% 你进一步证实自己的想法，指出也许“白色纳克扎勒”之所以如此苍白是因为它没有得到足够的阳光。解剖学家笑了。%SPEECH_ON%拜托，流氓，你的第一次观察就足够了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不要让你的“白娜恰”让你眼瞎，该死的蠢蛋。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				_event.m.Anatomist.improveMood(1.5, "他对白色纳希扎尔存在的信念得以更新。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

