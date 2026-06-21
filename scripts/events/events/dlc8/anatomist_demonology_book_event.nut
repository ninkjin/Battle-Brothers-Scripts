this.anatomist_demonology_book_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_demonology_book";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{你发现%anatomist%正在翻阅一本红色的书。他合上书本叹了口气。%SPEECH_ON%作为一名解剖学家，我必须认为怪物，就如你们这些俗人所称呼的，不会仅仅出现而已。相反，每一件事都有其目的。在某种程度上，通过古老的神灵，我们能够相信这些元素在实际上有一种神圣的目的。然而，我的一些同行却发现了从未以肉眼见过的生物的骨骼。看来这些实体已经完全消失了。这引发了一个问题：这种证据意味着我们自己也将有一天消失吗？在这个问题上肯定，那么，上方的神灵实际上并没有在我们的利益上权衡他们的愿景。我们在偶然的注视下行走。这真是个可怕的想法。%SPEECH_OFF%你好奇地问这些神秘的怪物长什么样子。解剖学家打开红色的书展示了一幅图画。%SPEECH_ON%它们和人类非常相似，但是颈部和肩膀周围的肌肉更加壮实。头骨上有与角类相似的凹槽，脊柱上有额外的椎骨，其中三个靠近上部扩展开来，好像它们正紧紧抓住什么东西，这件事情会从身体上延伸得很远。你看到了吗？在这里？背部几乎像是一片骨质的披风。%SPEECH_OFF%有趣。你问解剖学家是否亲眼见过这些骨骼，他说没有。他说他只在书本上看到过。你问他是否为这本书付费，他说是。你问他是否老旧、奇怪的怪物观念只是一个促销噱头，以获得他购买这本无用之书。解剖学家考虑了一会儿，点了点头，同意这很可能是一本恶搞书。他变得越来越生气，突然就将这本书扔进了篝火里，并誓言未来要致力于更务实的研究。他感谢你能够辨别出这个世界上所谓的庸人自扰和卓越立场。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不要轻信你看到的一切。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				_event.m.Anatomist.worsenMood(0.5, "浪费时间读假魔法书。");
				_event.m.Anatomist.improveMood(1.0, "你帮助他意识到他的恶魔学著作是个骗局。");

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

