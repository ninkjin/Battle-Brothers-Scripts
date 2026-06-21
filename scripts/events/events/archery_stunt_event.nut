this.archery_stunt_event <- this.inherit("scripts/events/event", {
	m = {
		Clown = null,
		Archer = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.archery_stunt";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]一阵骚动把你从帐篷里吸引出来。 人们坐在几根树桩上或地上，急切地望着远处的什么东西。 眯着眼睛，你看到 %clown% 和 %archer% 正在做一些奇怪的事情。 一个苹果放在一个人的头上，另一个人拿着弓走开了。\n\n你问 %otherguy% 这是怎么回事，他解释说，这两个人要尝试一些高端或奇葩的玩法，包括从一个人的头上射下一只水果。 震惊之余，你惊呼这根本不安全，那个队员笑着解释说，这才是重点。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "马上停下！",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "好吧…也许这会很有趣。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= _event.m.Archer.getCurrentProperties().RangedSkill)
						{
							return "C";
						}
						else
						{
							return "B1";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_10.png[/img]你仔细考虑了一下形势。 队员们望着你，以为你会制止，但你却坐在他们中间。 人群中爆发出一阵短暂的欢呼声，但很快就静了下来，低声耳语起来，因为 %clown% 和 %archer% 已经准备就绪了。%SPEECH_ON%射中那个苹果十拿九稳！%SPEECH_OFF%一个兄弟高声尖叫。笑声在人群中荡漾。%SPEECH_ON%从那么远的距离看，%clown_short%的鼻子都有点像苹果。%SPEECH_OFF%更多的笑声传来，但你终究有点紧张，因为表演即将开始。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢！",
					function getResult( _event )
					{
						return "B2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_10.png[/img]%archer% 把肩膀对着 %clown% 拉起他的弓，可以看到他的轮廓是一个由木头，绳子和手臂组成的月牙形。 你看不到 %clown%的脸，但你认为他是闭着眼睛的。 他射击了。 箭呼啸而过。然后就看不到了。%clown% 向后摇晃着，捂着脸。 这看起来不太好。 这个人的尖叫着。众人惊呼。%archer% 慢慢地放下他的弓，看着它，好像它有毛病似的。\n\n 最后，%clown% 从你身边经过，箭划伤了他的头。 另一个兄弟在后面徘徊，在混乱中安静地吃着苹果。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会留下个伤疤…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				local injury = _event.m.Clown.addInjury(this.Const.Injury.Archery);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Clown.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Archer.worsenMood(2.0, "严重受伤" + _event.m.Clown.getName() + "意外地");

				if (_event.m.Archer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID() || bro.getID() == _event.m.Archer.getID())
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.fainthearted"))
					{
						bro.worsenMood(1.0, "感到 " + _event.m.Clown.getName());

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_10.png[/img]当你点头表示肯定时，人们欢呼起来。 你坐在他们中间，%archer% 和 %clown% 也做好了准备，前者整理弓箭，而后者把苹果在头上放平。 当水果摆稳后，弓箭手将弓向后拉开，当他瞄准时，形成了一个人，木头和绳子的构成的月牙形轮廓。 这些人在打赌他是否会失手。 你想把目光移开，但场面实在太壮观了。\n\n 随着箭的释放，队员们发出了一声惊叹声，仿佛某种长久以来预言的不祥之兆终于发生了。 男人们蜷缩在座位上，皱着眉头，咬紧牙关。 苹果被从 %clown%的脑袋上打落了，果实和箭旋转着飞走了。 短暂的沉默之后，人们爆发出欢呼声。%clown% 鞠了一躬，而 %archer% 放松了下手腕，看起来长舒一口气。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "搞定了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Clown.getBaseProperties().Bravery += 1;
				_event.m.Clown.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Clown.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Archer.getBaseProperties().RangedSkill += 1;
				_event.m.Archer.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Archer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程技能"
				});
				_event.m.Clown.improveMood(1.0, "参加了一场表演");

				if (_event.m.Clown.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Clown.getMoodState()],
						text = _event.m.Clown.getName() + this.Const.MoodStateEvent[_event.m.Clown.getMoodState()]
					});
				}

				_event.m.Archer.improveMood(1, "展示了他的射箭技术");

				if (_event.m.Archer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID() || bro.getID() == _event.m.Archer.getID())
					{
						continue;
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 10 && !bro.getSkills().hasSkill("trait.bright"))
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
		this.m.Screens.push({
			ID = "D",
			Text = "你摇头说“不”，然后走到那两个人中间。%SPEECH_ON%如果你们都想耍把戏，应该去参加马戏团。 在有人受重伤之前马上回去工作。%SPEECH_OFF%一股失望的情绪席卷了这些人。 有些人甚至会喝倒彩，少数人对你竖起大拇指，其他人也许做出了更粗暴的手势。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是为大家好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Clown.worsenMood(1.0, "请求被拒绝");

				if (_event.m.Clown.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Clown.getMoodState()],
						text = _event.m.Clown.getName() + this.Const.MoodStateEvent[_event.m.Clown.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID())
					{
						continue;
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 10 && !bro.getSkills().hasSkill("trait.bright") && !bro.getSkills().hasSkill("trait.fainthearted"))
					{
						bro.worsenMood(1.0, "没有得到他所希望的娱乐");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local clown_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.minstrel" || bro.getBackground().getID() == "background.juggler" || bro.getBackground().getID() == "background.vagabond") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				clown_candidates.push(bro);
			}
		}

		if (clown_candidates.len() == 0)
		{
			return;
		}

		local archer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.bowyer") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				archer_candidates.push(bro);
			}
		}

		if (archer_candidates.len() == 0)
		{
			return;
		}

		this.m.Clown = clown_candidates[this.Math.rand(0, clown_candidates.len() - 1)];
		this.m.Archer = archer_candidates[this.Math.rand(0, archer_candidates.len() - 1)];
		this.m.Score = clown_candidates.len() * 3;

		do
		{
			this.m.OtherGuy = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherGuy == null || this.m.OtherGuy.getID() == this.m.Clown.getID() || this.m.OtherGuy.getID() == this.m.Archer.getID());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"clown",
			this.m.Clown.getName()
		]);
		_vars.push([
			"clown_short",
			this.m.Clown.getNameOnly()
		]);
		_vars.push([
			"archer",
			this.m.Archer.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Clown = null;
		this.m.Archer = null;
		this.m.OtherGuy = null;
	}

});

