this.hedge_knight_vs_refugee_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight = null,
		Refugee = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.hedge_knight_vs_refugee";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_52.png[/img]%hedgeknight%这位野骑士走到一位正在吃饭的%refugee%身边。那名前难民看到他耸立的身影，缓缓地转过身来。%SPEECH_ON%干嘛？%SPEECH_OFF%野骑士哼了一声，吐出一团巨大的痰。他再次哼了一声。%SPEECH_ON%你从家里逃了出来。你看着它被火焰吞噬，却选择了背对火源逃走。这个战团现在是你的家，那么现在是什么使你停止逃离火焰？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "来吧，%hedgeknight%。 停下来！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你可以自己解决这个问题。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				this.Characters.push(_event.m.Refugee.getImagePath());

				if (_event.m.OtherGuy != null)
				{
					this.Options.push({
						Text = "Wait. %streetrat%，你看起来有话要说？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_52.png[/img]你踏前一步，告诉这个野骑士别把自己的自尊心挂在嘴边。战团不是为了满足他的虚荣心而来的。这个身材魁梧的男人大笑着下了车。%SPEECH_ON%正如您所说，先生。我可不想惹起和公主打架。%SPEECH_OFF%战团人大笑起来，但是难民只是凝视着他碗里的食物，就像有人在里面吐口水一样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，我想已经解决了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				this.Characters.push(_event.m.Refugee.getImagePath());
				local bravery = this.Math.rand(1, 3);
				_event.m.Refugee.getBaseProperties().Bravery -= bravery;
				_event.m.Refugee.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Refugee.getName() + "失去[color=" + this.Const.UI.Color.NegativeEventValue + "]-" + bravery + "[/color] 决心"
				});
				_event.m.Refugee.worsenMood(1.0, "在战队面前受到羞辱");

				if (_event.m.Refugee.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Refugee.getMoodState()],
						text = _event.m.Refugee.getName() + this.Const.MoodStateEvent[_event.m.Refugee.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]你没有干涉。那个野骑士继续说道。%SPEECH_ON%我对你的痛苦没有任何同情心，明白吗？%SPEECH_OFF%难民点了点头。%SPEECH_ON%是啊，但谁又有同情你呢？%SPEECH_OFF%%refugee%的手臂迅速向前，将盘子翻到了篝火里。叉子卡在了 %hedgeknight% 的大腿上，%refugee% 拔也拔不出来，就像卡在橡木树干里一样。 野骑士咬紧牙关，扑倒在难民身上，将他摁在地上，让他呼吸着泥土。其它的战团成员都站起来退后了。你向前走了一步，但 %hedgeknight% 伸出手来阻止了你。%SPEECH_ON%好了，小子。你还有一战的资本。%SPEECH_OFF%他拿回叉子，并向外伸出。一滴血在叉齿间淌下来。%SPEECH_ON%你在吃什么？噢，对了，好吃吗？很好，我会和我的那一份加倍一起给你。来，坐下吧。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴那已经解决了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				this.Characters.push(_event.m.Refugee.getImagePath());
				local bravery = this.Math.rand(1, 3);
				_event.m.Refugee.getBaseProperties().Bravery += bravery;
				_event.m.Refugee.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Refugee.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + bravery + "[/color] 决心"
				});
				_event.m.Refugee.improveMood(1.0, "得到了一些认可 " + _event.m.HedgeKnight.getName());

				if (_event.m.Refugee.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Refugee.getMoodState()],
						text = _event.m.Refugee.getName() + this.Const.MoodStateEvent[_event.m.Refugee.getMoodState()]
					});
				}

				_event.m.HedgeKnight.improveMood(0.5, "喜欢上了" + _event.m.Refugee.getName() + "一些");

				if (_event.m.HedgeKnight.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.HedgeKnight.getMoodState()],
						text = _event.m.HedgeKnight.getName() + this.Const.MoodStateEvent[_event.m.HedgeKnight.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_80.png[/img]%streetrat%迈步向前。他指着那个野骑士。%SPEECH_ON%你对火焰一窍不通。%SPEECH_OFF%%hedgeknight%笑了，转过身来，弹了弹手指。%SPEECH_ON%我当然知道。我就是火。%SPEECH_OFF%那个卑微的人挺胸直立，双臂交叉。%SPEECH_ON%而我们不是灰烬，而是木柴本身。你是贵族的娼妓，这才是你真正的身份。他们拿高价请你，你便以你的力量和残忍度日，并按照他们的吩咐行动。就像……像妓女一样……%SPEECH_OFF%另一个佣兵举起了手指。%SPEECH_ON%我觉得你在概括我们所有人。我们是雇佣兵。%SPEECH_OFF%另一个佣兵加入进来。%SPEECH_ON%你刚刚把自己跟引火物相比较了？%SPEECH_OFF%%streetrat%揉了揉头。%SPEECH_ON%是这样，对不起，那个野骑士刚刚吓到我了，让我忘了我想说的话。%SPEECH_OFF%战团看了看周围，然后爆笑起来，任何敌意都消失了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们为什么要打来打去？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				this.Characters.push(_event.m.OtherGuy.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.OtherGuy.getID() || bro.getID() == _event.m.HedgeKnight.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

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
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local hedge_knight_candidates = [];
		local refugee_candidates = [];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.hedge_knight")
			{
				hedge_knight_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.refugee")
			{
				refugee_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.beggar" || bro.getBackground().getID() == "background.cripple" || bro.getBackground().getID() == "background.servant" || bro.getBackground().getID() == "background.ratcatcher")
			{
				other_candidates.push(bro);
			}
		}

		if (hedge_knight_candidates.len() == 0 || refugee_candidates.len() == 0)
		{
			return;
		}

		this.m.HedgeKnight = hedge_knight_candidates[this.Math.rand(0, hedge_knight_candidates.len() - 1)];
		this.m.Refugee = refugee_candidates[this.Math.rand(0, refugee_candidates.len() - 1)];
		this.m.Score = (hedge_knight_candidates.len() + refugee_candidates.len()) * 5;

		if (other_candidates.len() != 0)
		{
			this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hedgeknight",
			this.m.HedgeKnight.getNameOnly()
		]);
		_vars.push([
			"refugee",
			this.m.Refugee.getName()
		]);
		_vars.push([
			"streetrat",
			this.m.OtherGuy != null ? this.m.OtherGuy.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.HedgeKnight = null;
		this.m.Refugee = null;
		this.m.OtherGuy = null;
	}

});

