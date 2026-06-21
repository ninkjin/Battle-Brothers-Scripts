this.education_event <- this.inherit("scripts/events/event", {
	m = {
		DumbGuy = null,
		Scholar = null
	},
	function create()
	{
		this.m.ID = "event.education";
		this.m.Title = "在途中…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_15.png[/img]旅途之中，%scholar% 对 %dumbguy%的弱智现象产生了某种兴趣。%scholar_short% 说，给他一些时间，他可以教那个蠢货多学点东西。对 %dumbguy_short% 是否能够长点能耐这件事－某人时常会自信满满－但作为指挥官的你认为某人在所有事情上都会高估自己的能耐。 不仅如此，%scholar_short% 以往的表现显示其性格属于不太禁得起挫折的类型。 因此他这种好为人师的表现也许只是为了填补内心的脆弱和空虚。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "看看你能教些他什么。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "B" : "C";
					}

				},
				{
					Text = "别管 %dumbguy% 了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.DumbGuy.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_15.png[/img]{你发现 %scholar% 和 %dumbguy% 正盯着一团污物。 原来 %scholar_short% 在一块棕色画布上画了一些几何图形，字母，数字，以及一些看着像星座一样的图案。 很显然教学工作已经持续了几个钟头了。 \n\n虽然教鞭依然在手。但 %scholar% 对星座知识的教学工作已经显得有些抓狂了。%dumbguy%，那张蠢脸因为绞尽脑汁而皱成一团，可依旧一问三不知。%scholar% 终于狠狠折断了教鞭然后一脚把自己的教案踏入尘埃。 就是匹马！就是马！%scholar% 抱怨着完全是对马弹琴，长叹一口气，然后随着没完没了的骂声走了。 确实，你也觉得教傻子是个倒霉活。 | 不久你看到 %scholar% 又盯着 %dumbguy% 做事。“仔细数甲虫，别碾死它们”，扮老师的某人恼怒地叮嘱道。%dumbguy% 低头看着自己沾满着昆虫甲壳的碎片的手。 他点头，带着完全理解的表情，开始扯掉剩余活甲虫的腿。于是你从 %scholar% 嘴里听到了从未听过的污言秽语。 | 而后你听见 %scholar% 和 %dumbguy% 正在对吼。 俩人已经面红脖子粗。%dumbguy_short% 说老子就这德行咋地吧，而 %scholar_short% 坚持认为人人都该读书认字。 于是 %dumbguy_short% 干脆一拍屁股不搭理 %scholar_short% 了。 看来这就是这场师生游戏的最后一课了。 | 你发现 %dumbguy% 蹲在小溪边，正盯着自己的在粼粼水波的倒影发呆。 这家伙连发呆都能把自己晒得暴皮。 你赶紧问他出了啥事，他抱怨说 %scholar% 教的玩意儿他根本不能理解，还好 %scholar% 自行停止了这种疯狂行为。 你宽慰 %dumbguy% 说这没什么大不了的，舞刀弄枪并不需要多高的智商。 天生我才必有用，做好自己的本分就行。 那人傻傻一笑，憨劲十足。 你带他回营地后又跑去安慰了 %scholar% 一番。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{你为什么不学？！ | 无知是福。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.DumbGuy.getImagePath());
				_event.m.Scholar.worsenMood(2.0, "未能教导。" + _event.m.DumbGuy.getName() + "任何事情");

				if (_event.m.Scholar.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List = [
						{
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Scholar.getMoodState()],
							text = _event.m.Scholar.getName() + this.Const.MoodStateEvent[_event.m.Scholar.getMoodState()]
						}
					];
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_15.png[/img]{你发现 %dumbguy% 正盯着桌上的一摞硬币沉思中。 询问之下得到的回答是正在计算自己未来的退休金。 首先，他居然说出了退休这个词。 其次，他还真学会算账了？看来待会儿得请 %scholar% 好好喝一顿。 | 你看到 %dumbguy% 正坐在树墩上在羊皮纸上写着什么东西。 好奇之下你不禁出言相询，得到的回答是写信。 当你问到寄信对象时，这老兄有点不好意思地说，寄给谁重要吗？ 与此同时，你看见不远处的 %scholar%，正双手抱胸，一脸的志得意满。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fascinating.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Scholar.getImagePath());
				this.Characters.push(_event.m.DumbGuy.getImagePath());
				_event.m.Scholar.improveMood(2.0, "教导了" + _event.m.DumbGuy.getName() + "某些东西");
				_event.m.DumbGuy.getSkills().removeByID("trait.dumb");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_17.png",
					text = _event.m.DumbGuy.getName() + "不再傻了"
				});

				if (_event.m.Scholar.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Scholar.getMoodState()],
						text = _event.m.Scholar.getName() + this.Const.MoodStateEvent[_event.m.Scholar.getMoodState()]
					});
				}
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

		local dumb_candidates = [];
		local scholar_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.dumb"))
			{
				dumb_candidates.push(bro);
			}
			else if ((bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.historian") && !bro.getSkills().hasSkill("trait.hesitant"))
			{
				scholar_candidates.push(bro);
			}
		}

		if (dumb_candidates.len() == 0 || scholar_candidates.len() == 0)
		{
			return;
		}

		this.m.DumbGuy = dumb_candidates[this.Math.rand(0, dumb_candidates.len() - 1)];
		this.m.Scholar = scholar_candidates[this.Math.rand(0, scholar_candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dumbguy",
			this.m.DumbGuy.getName()
		]);
		_vars.push([
			"dumbguy_short",
			this.m.DumbGuy.getNameOnly()
		]);
		_vars.push([
			"scholar",
			this.m.Scholar.getName()
		]);
		_vars.push([
			"scholar_short",
			this.m.Scholar.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.DumbGuy = null;
		this.m.Scholar = null;
	}

});

