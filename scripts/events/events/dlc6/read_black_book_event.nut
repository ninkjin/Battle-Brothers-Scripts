this.read_black_book_event <- this.inherit("scripts/events/event", {
	m = {
		Historian = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.read_black_book";
		this.m.Title = "露营时…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]{%nonhistorian% 进入你的帐篷。%SPEECH_ON%队长，快来，有人出了点问题是 %historian%！%SPEECH_OFF%你赶到现场。%historian% 抱着博学者的书就好像远古人保护最初的火苗一样。 他紧攥着血肉封皮，手颤抖着，他抬头用满是血丝的眼看向你。%SPEECH_ON%我知道这本书在说什么，队长，我知道它在说什么！%SPEECH_OFF%你蹲下，引得他后退，摇着头。%SPEECH_ON%不。不！是终结！ 一切的终结！ 我们…我们只是达到那里的工具，你难道不能理解吗？ 我们做的一切，其他人做的一切，都是通往终极终点的方式：万物的死亡。 我们的存在给予它力量，没有我们，它就能再次安眠。 但只要还有存在，它就不能睡下！%SPEECH_OFF%你摇头问他在说什么。 他把书反过来展示出一片纯黑书页，但他把手指指向上面的一个点好似你应该在那里读到一句话。%SPEECH_ON%这不是书，队长，这是指示，关于怎么把死灵复苏。%SPEECH_OFF%你问他谁可能拥有这种知识，%historian% 露出狂乱的笑容。.%SPEECH_ON%那里没有“谁”，没有“什么”！ 它是一个消除的工具，被一个自称达库尔的个体投入这个世界！%SPEECH_OFF%你告诉手下照顾好他，因为他看起来明显已经失去理智了。 其中一个佣兵拿来 %historian%的译本，但是他们只是一片潦草写下的胡言乱语，不比原本好理解多少。%SPEECH_ON%就算我们可以理解其中的词语，就算我们可以应用它，我也不认为我们应该这么做。 看，只在你我之间说，那片他展示给你的书页？ 它上面之前是有字的。 而且我是说在你走过来的时候。 我能看到字，我能看到符号。 但是在某一刻，墨水，灰尘，还是什么，它就这么遍布了书页。 就好像我们不应该拥有这个知识。%SPEECH_OFF%这很有可能，但是有一种更黑暗的设想浮现在你的脑海中：信息是要传给 %historian% 的，但他有限的理解不是用来给你提供帮助的，而只是作为别的什么巨大阴谋中的一个工具。 你只被展示了你该知道的，仅此而已…}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不安的想法。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local effect = this.new("scripts/skills/traits/mad_trait");
				_event.m.Historian.getSkills().add(effect);
				_event.m.Historian.improveMood(2.0, "已经看到了事情的结局");
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Historian.getName() + "已经疯了"
				});
				this.Characters.push(_event.m.Other.getImagePath());
				this.Characters.push(_event.m.Historian.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_12.png[/img]{%nonhistorian% 进入你的帐篷。%SPEECH_ON%队长，快来，有人出了点什么事是 %historian%！%SPEECH_OFF%你赶到现场。%historian% 抱着博学者的书就好像远古人保护最初的火苗一样。 他紧攥着血肉封皮，手颤抖着，他抬头用满是血丝的眼看向你。%SPEECH_ON%我知道这本书在说什么，队长，我知道它在说什么！%SPEECH_OFF%你蹲下，引得他后退，摇着头。%SPEECH_ON%不。不！是终结！ 一切的终结！ 我们…我们只是达到那里的工具，你难道不能理解吗？ 我们做的一切，其他人做的一切，都是通往终极终点的方式：万物的死亡。 我们的存在给予它力量，没有我们，它就能再次安眠。 但只要还有存在，它就不能睡下！%SPEECH_OFF%你摇头问他在说什么。 他把书反过来展示出一片纯黑书页，但他把手指指向上面的一个点好似你应该在那里读到一句话。%SPEECH_ON%这不是书，队长，这是指示，关于怎么把死灵复苏。%SPEECH_OFF%你问他谁可能拥有这种知识，%historian% 露出狂乱的笑容。.%SPEECH_ON%那里没有“谁”，没有“什么”！ 它是一个消除的工具，被达库尔放到这个世界上！%SPEECH_OFF%其中一个人拿来 %historian%的译本，但是他们只是一片潦草写下的胡言乱语，不比原本好理解多少。%SPEECH_ON%只是我们之间的事，那片他展示给你的书页？ 它上面之前是有字的。 而且我是说在你走过来的时候。 我能看到字，我能看到符号。 但是在某一刻，墨水，灰尘，还是什么，它就这么遍布了书页。 就好像我们不应该拥有这个知识。%SPEECH_OFF%这很有可能，但是有一种更黑暗的设想浮现在你的脑海中：信息是要传给 %historian% 的，但他有限的理解不是用来给你提供帮助的，而只是作为别的什么巨大阴谋中的一个工具。 你只被展示了你该知道的，仅此而已…}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔即将降临到我们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local effect = this.new("scripts/skills/traits/mad_trait");
				_event.m.Historian.getSkills().add(effect);
				_event.m.Historian.improveMood(2.0, "已经看到了事情的结局");
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Historian.getName() + "已经疯了"
				});
				this.Characters.push(_event.m.Other.getImagePath());
				this.Characters.push(_event.m.Historian.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.Flags.get("IsLorekeeperDefeated") || this.World.Flags.get("IsLorekeeperTradeMade"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_historian = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.mad"))
			{
				return;
			}

			if (bro.getBackground().getID() == "background.historian" && bro.getLevel() >= 2 || bro.getBackground().getID() == "background.cultist" && bro.getLevel() >= 9)
			{
				candidates_historian.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_historian.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasBlackBook = false;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.black_book")
			{
				hasBlackBook = true;
				break;
			}
		}

		if (!hasBlackBook)
		{
			return;
		}

		this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = 100;
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
		_vars.push([
			"nonhistorian",
			this.m.Other.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			return "B";
		}
		else
		{
			return "A";
		}
	}

	function onClear()
	{
		this.m.Historian = null;
		this.m.Other = null;
	}

});

