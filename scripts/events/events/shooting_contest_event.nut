this.shooting_contest_event <- this.inherit("scripts/events/event", {
	m = {
		Archer1 = null,
		Archer2 = null
	},
	function create()
	{
		this.m.ID = "event.shooting_contest";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img] 一阵低语声越来越嘈杂，直到你无法集中注意力。 你放下你的羽毛笔，带着墨水瓶所能承受的不会被打破的能量走出你的帐篷。%archer1% 和 %archer2% 站在那里争吵谁射的更准。 他们就迫不及待地询问是否可以举办一场射击比赛来决定谁是正确的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，很好。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "我们可浪费不起箭。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer1.getImagePath());
				this.Characters.push(_event.m.Archer2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_10.png[/img] 你举起双手，告诉他们在回帐篷之前必须做什么。 外面传来了射出的箭的嗖嗖声，随后击穿了他们发现的目标。 一次又一次。队员们的喧嚣声更大了，因此你只能设想这些旁观者能长点心。 最后，比赛在某种程度上结束了－用一场令人振奋的沉默来表示－然后你回到了工作中。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "终于平静下来了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer1.getImagePath());
				this.Characters.push(_event.m.Archer2.getImagePath());
				_event.m.Archer1.getFlags().increment("ParticipatedInShootingContests", 1);
				_event.m.Archer2.getFlags().increment("ParticipatedInShootingContests", 1);
				this.World.Assets.addAmmo(-30);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_ammo.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-30[/color] 弹药"
					}
				];
				_event.m.Archer1.getBaseProperties().RangedSkill += 1;
				_event.m.Archer1.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Archer1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程技能"
				});
				_event.m.Archer2.getBaseProperties().RangedSkill += 1;
				_event.m.Archer2.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Archer2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程技能"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_10.png[/img]感觉好像他们的争论永远不会结束，你给他们许可，让他们在回到你的帐篷之前来一场小竞赛。 此后不久，你会听到箭的夜间拉弦，释放和寻找目标的声音。 那些“嗖”的东西很快“嗖”的一声消失了，空气中慢慢充满了围观人群的喧闹声。 当你试着集中注意力时，你会注意到这些人已经狂热地射击了很长一段时间了。 你从帐篷里退了出来，发现两名弓箭手又吵了起来，每个人都用手指着对方，然后拿起一支箭，愤怒地向下发射。 他们的目标甚至不再是目标了，而是一丛丛的箭头，从上面每射一箭都会被折断。\n\n你摇了摇头，命令这两个人立刻停下来，免得他们把战队的箭都用完了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不能让你们两个人单独呆两秒钟！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer1.getImagePath());
				this.Characters.push(_event.m.Archer2.getImagePath());
				_event.m.Archer1.getFlags().increment("ParticipatedInShootingContests", 1);
				_event.m.Archer2.getFlags().increment("ParticipatedInShootingContests", 1);
				this.World.Assets.addAmmo(-60);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_ammo.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-60[/color] 弹药"
					}
				];
				_event.m.Archer1.getBaseProperties().Bravery += 1;
				_event.m.Archer1.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Archer1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Archer2.getBaseProperties().Bravery += 1;
				_event.m.Archer2.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Archer2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "你摇头说不，因为补给太少了以至于不能支持这样的行为。 这两个人叹着气走开了，继续在远处大声争吵。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "还有更重要的事情去做。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer1.getImagePath());
				this.Characters.push(_event.m.Archer2.getImagePath());
				_event.m.Archer1.worsenMood(1.0, "请求被拒绝");

				if (_event.m.Archer1.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer1.getMoodState()],
						text = _event.m.Archer1.getName() + this.Const.MoodStateEvent[_event.m.Archer1.getMoodState()]
					});
				}

				_event.m.Archer2.worsenMood(1.0, "请求被拒绝");

				if (_event.m.Archer2.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer2.getMoodState()],
						text = _event.m.Archer2.getName() + this.Const.MoodStateEvent[_event.m.Archer2.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getAmmo() <= 80)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.bowyer")
			{
				if (!bro.getFlags().has("ParticipatedInShootingContests") || bro.getFlags().get("ParticipatedInShootingContests") < 3)
				{
					candidates.push(bro);
				}
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		this.m.Archer1 = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Archer2 = null;
		this.m.Score = candidates.len() * 5;

		do
		{
			this.m.Archer2 = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		while (this.m.Archer2 == null || this.m.Archer2.getID() == this.m.Archer1.getID());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"archer1",
			this.m.Archer1.getName()
		]);
		_vars.push([
			"archer2",
			this.m.Archer2.getName()
		]);
	}

	function onClear()
	{
		this.m.Archer1 = null;
		this.m.Archer2 = null;
	}

});

