this.juggler_tempts_fate_event <- this.inherit("scripts/events/event", {
	m = {
		Juggler = null,
		NonJuggler = null
	},
	function create()
	{
		this.m.ID = "event.juggler_tempts_fate";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%juggler% 这个手脚轻快、手脚敏捷的杂耍者正在转着圈，要求兄弟们给他扔几把刀子。 看起来他是想要炫耀自己的杂技。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看你能做什么！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "C" : "Fail1";
					}

				},
				{
					Text = "我雇你可不是来干这个的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				_event.m.Juggler.getFlags().add("juggler_tempted_fate");
			}

		});
		this.m.Screens.push({
			ID = "Fail1",
			Text = "[img]gfx/ui/events/event_05.png[/img]%nonjuggler% 把刀扔过营地。 锋刃在阳光下翻了个面，你看到一道光线闪过杂耍者的眼睛。 他眨眼睛的时间有点长，小刀都扎进他的肩膀了。 他又眨了一下眼睛，这下疼痛真的发作了。 不一会儿，%juggler% 被痛得倒在地上，痛苦地捂着伤口嚎叫。 几人上前帮助，其他人则在旁边大笑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那很痛吧！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				local injury = _event.m.Juggler.addInjury([
					{
						ID = "injury.injured_shoulder",
						Threshold = 0.25,
						Script = "injury/injured_shoulder_injury"
					}
				]);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Juggler.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
				_event.m.Juggler.worsenMood(1.0, "行为失当，自残");

				if (_event.m.Juggler.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Juggler.getMoodState()],
						text = _event.m.Juggler.getName() + this.Const.MoodStateEvent[_event.m.Juggler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Fail2",
			Text = "[img]gfx/ui/events/event_05.png[/img]%juggler% 要的斧头被拿起来朝他扔去。 它以一种尴尬的角度旋转着，就好像那个故意扔它的人让它以一种不确定的方式摇摆着。 没预料到这个，这个杂耍者调整了一下身位，试图抓住那把乱了套的斧头柄，但是那把武器撞到了一把匕首上，划拉过他的肩膀。 他一下子就倒在了地上，刀子像阵雨似地落在他周围。 当一些人照料他的伤口时，另一些人却忍不住为他的痛苦而高兴。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他还好吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				local injury = _event.m.Juggler.addInjury(this.Const.Injury.Accident4);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Juggler.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "Fail3",
			Text = "[img]gfx/ui/events/event_05.png[/img]%nonjuggler% 拿起杂耍人想要的链枷，犹豫了一会儿，把它扔向 %juggler%。飞行途中，武器的链子缠绕在了手柄上。 杂耍者似乎在调整身姿想要接住，但在最后一刻，链子展开了，带着致命的意图甩了回来。 你看到那个杂耍者因为他看到了一场他无法阻止的灾难而睁大了眼睛。 链枷挟着金属漩涡，打在他的脸上。 他被打得不省人事，两绞着双腿，瘫倒在地。 一把掉落的匕首刺穿了他的腿，斧头翻转着砍进他的屁股。 人们吓得抽了一口凉气，很快所有人都站了起来，冲过去帮助他。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他还活着吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				local injury = _event.m.Juggler.addInjury(this.Const.Injury.BluntHead);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Juggler.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]你坐下来，让队员们给 %juggler% 扔几把小刀或匕首。 各种形状规格的刀子们被以各种角度掷向他，但他轻松接住它们，并把它们抛向空中，它们在阳光下旋转着，闪闪发光。 每一件武器重量都不同，但划圈的无缝衔接着实让你印象深刻，多么出类拔萃的能力啊。\n\n 当然，那不可能只是结束。 他的手交替地挥舞着手中的东西，要求有人给他一把斧头。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这太有趣了！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "D" : "Fail2";
					}

				},
				{
					Text = "够了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 10)
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
			Text = "[img]gfx/ui/events/event_05.png[/img]%nonjuggler% 站起来，向 %juggler% 奇妙表演的轨迹投出一把斧子。 杂耍者的危险武器圈圈似乎在一瞬间把斧头吃掉了，一个简单的过渡这把斧子和谐地加入把戏。 人们鼓掌欢呼，但也有几个人咧着嘴笑着，似乎在等待这副无比锋利的牌轰然倒下。\n\n 但显然这个把戏还没结束。 这次没有向任何人挥手，杂耍者只是专注于嗖嗖声，嗖嗖声武器盘旋在他周围，说话想要一个链枷。某人站起来。%SPEECH_ON%他说链枷？%SPEECH_OFF%杂耍者跺跺脚。%SPEECH_ON%是的，链枷，给我扔一个链枷！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不可思议，不过…我还想接着看！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "E" : "Fail3";
					}

				},
				{
					Text = "够了，停下来。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				_event.m.Juggler.getBaseProperties().Bravery += 1;
				_event.m.Juggler.getBaseProperties().MeleeSkill += 1;
				_event.m.Juggler.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 近战技能"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 20)
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]一个链枷被取出并投向 %juggler%。当链枷一边旋转震荡着飞向杂耍者称为他的“表演”的武器风暴时，所有人都怪叫起来。 但是，就像斧头一样，它很快就被金属漩涡吸收了。 人们站起来以前更大声的地欢呼鼓掌。 一些人松了一口气，擦去额头上的汗水，而其他人只能笑着鼓掌，他们对没有发生什么可怕的事情感到很失望，但确实令人印象深刻。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好哇！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				_event.m.Juggler.getBaseProperties().Bravery += 2;
				_event.m.Juggler.getBaseProperties().RangedDefense += 2;
				_event.m.Juggler.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 远程防御"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 30)
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local juggler_candidates = [];
		local nonjuggler_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.juggler")
			{
				if (!bro.getFlags().has("juggler_tempted_fate"))
				{
					juggler_candidates.push(bro);
				}
			}
			else if (bro.getBackground().getID() != "background.slave")
			{
				nonjuggler_candidates.push(bro);
			}
		}

		if (juggler_candidates.len() == 0 || nonjuggler_candidates.len() == 0)
		{
			return;
		}

		this.m.Juggler = juggler_candidates[this.Math.rand(0, juggler_candidates.len() - 1)];
		this.m.NonJuggler = nonjuggler_candidates[this.Math.rand(0, nonjuggler_candidates.len() - 1)];
		this.m.Score = juggler_candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"juggler",
			this.m.Juggler.getNameOnly()
		]);
		_vars.push([
			"nonjuggler",
			this.m.NonJuggler.getName()
		]);
	}

	function onClear()
	{
		this.m.Juggler = null;
		this.m.NonJuggler = null;
	}

});

