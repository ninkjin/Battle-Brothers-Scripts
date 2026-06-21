this.monk_vs_monk_event <- this.inherit("scripts/events/event", {
	m = {
		Monk1 = null,
		Monk2 = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.monk_vs_monk";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img] 唉，在营火旁布满了谈话和辩论的人。 人们正在享受啤酒和食物但是突然两个的互相训斥的声音传来并且这声音让整个营地都安静了下来，这不是因为这两个人比别人喊的更大声，而是因为这两人这两人正在做一些不符合他们身份的事情：僧侣 %monk1% 和 %monk2% 正在激烈地进行一场神学辩论。\n\n你所受的教育并不能让你理解他们争论的错综复杂之处，但你知道狠瞪着另一个人的脸愤怒地指着他，或一本圣经，很可能是在找麻烦。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这不关我的事。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "一个雇佣兵战队可不适合谈信仰！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk1.getImagePath());
				this.Characters.push(_event.m.Monk2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img] 过了一会，你认为在爆发肉体冲突之前你应该停止这两人的争吵，但是你马上记起来这两位神职人员已经不是第一次进行这种辩论了。 这就是他们现在所做的。 所以你决定让他们现在就把事情搞清楚，随着时间的推移，他们的声音变小，并且脸也快贴近书本近乎要靠在一起。 他们静静地在那边解读着，脑袋随着眼球的移动而不断摇晃着。 最后，%monk1% 抬起头来将书举起，指着书上的一些句子。%SPEECH_ON%这里！没错就在这里！“人是泥土做的”，而不是“人是血做的”。 人类不可能是用血做成的，他拥有血液！ 但是人类不可能离开自己本身，懂？ 现在理解了吗？%SPEECH_OFF%%monk2% 挠了挠自己的下巴，点了点头，但是之后马上大声说道。%SPEECH_ON%如果…%SPEECH_OFF%他还没来得及说完 %monk1% 已经合上圣经并且将它砸向说话人的脑袋。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这群神职人员避免了另一个灾难。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk1.getImagePath());
				this.Characters.push(_event.m.Monk2.getImagePath());
				_event.m.Monk1.improveMood(1.0, "在宗教问题上进行了一次激动人心的演讲");

				if (_event.m.Monk1.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk1.getMoodState()],
						text = _event.m.Monk1.getName() + this.Const.MoodStateEvent[_event.m.Monk1.getMoodState()]
					});
				}

				_event.m.Monk2.improveMood(1, "在宗教问题上进行了一次激动人心的演讲");

				if (_event.m.Monk2.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk2.getMoodState()],
						text = _event.m.Monk2.getName() + this.Const.MoodStateEvent[_event.m.Monk2.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]现在，这两个僧侣的争吵已经不是第一次了。 上次辩论时这两位很快就把问题解决了。 所以你认为这一回也会和上一次一样快速结束。 唉，这次不是。 他们的声音越来越大。 你从没想到僧侣会说出这么尖酸刻薄的话。 狠毒和粗俗甚至不能描述这种反常态的侮辱。 但是这没持续多久几秒钟以后他们都已经在地上了，互相拳打脚踢知道你下达命令让 %otherguy% 结束这一切。\n\n和战队里佣兵的相处和他们血腥的日常，这个似乎，已经在他们两个原本应该和平的行为增添了自己的符号。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想这就是他们所说的信仰危机。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk1.getImagePath());
				this.Characters.push(_event.m.Monk2.getImagePath());
				_event.m.Monk1.getBaseProperties().Bravery += 1;
				_event.m.Monk1.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Monk2.getBaseProperties().Bravery += 1;
				_event.m.Monk2.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Monk1.worsenMood(1.0, "失去镇静，诉诸暴力");

				if (_event.m.Monk1.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk1.getMoodState()],
						text = _event.m.Monk1.getName() + this.Const.MoodStateEvent[_event.m.Monk1.getMoodState()]
					});
				}

				_event.m.Monk2.worsenMood(1.0, "失去镇静，诉诸暴力");

				if (_event.m.Monk2.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk2.getMoodState()],
						text = _event.m.Monk2.getName() + this.Const.MoodStateEvent[_event.m.Monk2.getMoodState()]
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Monk1.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Monk1.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.Monk1.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Monk1.getName() + " 遭受 " + injury.getNameOnly()
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Monk2.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Monk2.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.Monk2.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Monk2.getName() + " 遭受 " + injury.getNameOnly()
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local monk_candidates = [];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() < 3)
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.monk")
			{
				monk_candidates.push(bro);
			}
			else
			{
				other_candidates.push(bro);
			}
		}

		if (monk_candidates.len() < 2)
		{
			return;
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		this.m.Monk1 = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		this.m.Monk2 = null;
		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];

		do
		{
			this.m.Monk2 = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		}
		while (this.m.Monk2 == null || this.m.Monk2.getID() == this.m.Monk1.getID());

		this.m.Score = monk_candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk1",
			this.m.Monk1.getNameOnly()
		]);
		_vars.push([
			"monk2",
			this.m.Monk2.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Monk1 = null;
		this.m.Monk2 = null;
		this.m.OtherGuy = null;
	}

});

