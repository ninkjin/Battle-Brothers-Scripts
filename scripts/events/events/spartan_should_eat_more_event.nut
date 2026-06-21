this.spartan_should_eat_more_event <- this.inherit("scripts/events/event", {
	m = {
		Spartan = null
	},
	function create()
	{
		this.m.ID = "event.spartan_should_eat_more";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img] %spartan% 对自己的食量总是有点苛刻。 你不确定这是某种宗教仪式的一部分，是一种责任感，还是他只是吃得不多。 无论如何，食物的缺乏已经削弱了这个人，你发现他几乎不能在一根圆木上坐直。 你手里拿着一碗肉和玉米，不知道该不该把它给他。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不会打扰你的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 75 ? "B" : "C";
					}

				},
				{
					Text = "吃东西，笨蛋！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 75 ? "D" : "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Spartan.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img] 你认为这个人以前可能经历过这种情况，决定离开他。 几分钟后，你发现他走路和说话都很正常。 事实上，对于一个吃得那么少的人来说，他是可以应付自如的！",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "人各有所爱。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Spartan.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img] 这个人以前做过这件事，他可以再做一次。 你转身去别处吃饭，却听到那人倒在地上。 他完全昏过去了，似乎在下山的路上撞到了头。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你在七层地狱遇到什么了？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Spartan.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Spartan.addLightInjury();
					this.List = [
						{
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Spartan.getName() + "遭受轻伤"
						}
					];
				}
				else
				{
					local injury = _event.m.Spartan.addInjury(this.Const.Injury.Concussion);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Spartan.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img] 你命令他吃饭。 他拒绝，但你提醒他这是“命令”，而不是请求。 这个佣兵照着吩咐去做，从你的碗里小心翼翼地吃着。 他抱怨说他不想再吃了，但你命令他把饭吃完。 随着时间的推移，他身上的一切似乎都解除了。 他的眼睛恢复了活力，他站起身来，脚步轻盈。 不幸的是，他不在意别人叫他打破自己的个人准则了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别让我再重复这个事了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Spartan.getImagePath());
				_event.m.Spartan.worsenMood(1.0, "被迫违背信仰吃东西");

				if (_event.m.Spartan.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Spartan.getMoodState()],
						text = _event.m.Spartan.getName() + this.Const.MoodStateEvent[_event.m.Spartan.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img] 命令他吃饭，他照做了。 一开始，他似乎很不情愿，但咬了几口后，他跳进碗里，把自己灌满了果汁，脸颊上布满了玉米粒。 他高兴得几乎要发疯了。 你提醒他食物是多么好吃。 就你个人而言，你认为这肉煮得有点过头了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别让我再重复这个事了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Spartan.getImagePath());
				_event.m.Spartan.getSkills().removeByID("trait.spartan");
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_icon_08.png",
						text = _event.m.Spartan.getName() + "不再是斯巴达人"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.spartan") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Spartan = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"spartan",
			this.m.Spartan.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Spartan = null;
	}

});

