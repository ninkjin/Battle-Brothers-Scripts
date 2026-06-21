this.anatomist_vs_ailing_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Ailing = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_ailing";
		this.m.Title = "露营时…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%ailing% 这个身体欠佳的佣兵盯着篝火蜷缩在一起。他已经病了一段时间，看起来情况并没有好转。然而，%anatomist%解剖学家建议他可能能够调制一种解药，一种他可以服用来增强身体和治愈自己的药剂。%SPEECH_ON%我看过它很多次。现在，有一个问题：所需的成分不是我们当前所在的地方所产，但是我对这方面的知识已经足够丰富，我可以轻松找到合适的替代品。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去治疗他的疾病。",
					function getResult( _event )
					{
						local outcome = this.Math.rand(1, 100);

						if (outcome <= 33)
						{
							return "B";
						}
						else if (outcome <= 66)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "不，这听起来一点都不安全。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Ailing.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你让%anatomist%去做他的工作，不管那是什么。解剖师和%ailing%消失在帐篷里一段时间。当战团准备继续前进时，%ailing%变成了一个新人。他有了新的能量，并且步履轻盈。%anatomist%拿着他的笔记本出来写笔记。%SPEECH_ON%结果很好，真的很好。%SPEECH_OFF%你好奇地问他到底做了什么。他从专注中醒来，瞪着你，然后把笔记本转开，不让你看。他继续自言自语。%SPEECH_ON%最好的结果？不，我不能写出最好的结果。他可能会遭受一些点滴的后遗症。%SPEECH_OFF%嗯。希望%ailing%只是被治愈了，就这样吧。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上 then.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Ailing.getSkills().removeByID("trait.ailing");
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_icon_59.png",
						text = _event.m.Ailing.getName() + "不再病弱"
					}
				];
				local healthBoost = this.Math.rand(2, 4);
				_event.m.Ailing.getBaseProperties().Hitpoints += healthBoost;
				_event.m.Ailing.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Ailing.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + healthBoost + "[/color] 生命值"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Ailing.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你让 %anatomist% 继续。 他和 %ailing% 离开了一段时间，一起走进了一个帐篷。几个小时过去了，战团应该尽快回归道路。你走过去进了帐篷，%ailing%躺在铺位上，手臂交叉在头上，腿弯曲在膝盖上。他满身是汗，时不时地左右扭头，%anatomist%在他身边做笔记。%SPEECH_ON%看起来手术并没有像预期的那样顺利，但是即使是意外结果也能包含重要的信息。%SPEECH_OFF%你愤怒地问这个人能不能活下来，解剖学家点点头。%SPEECH_ON%他可能会有一些幻觉，但最终他还是会成为一个正常的人，也就是一个有呼吸的动物——不好意思，是一个有呼吸的人。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那我们上路吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Ailing.getSkills().removeByID("trait.ailing");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_59.png",
					text = _event.m.Ailing.getName() + "不再病弱"
				});

				if (!_event.m.Ailing.getSkills().hasSkill("trait.paranoid"))
				{
					local trait = this.new("scripts/skills/traits/paranoid_trait");
					_event.m.Ailing.getSkills().add(trait);
					this.List.push({
						id = 10,
						icon = trait.getIcon(),
						text = _event.m.Ailing.getName() + "获得偏执狂状态。"
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Ailing.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你决定任由解剖学家进行操作，希望%ailing%能迅速恢复。随着时间的流逝，你需要让战团重新上路，%anatomist%还没有走出帐篷。你过去偷看。\n\n你发现解剖学家坐在旁边的凳子上。他一只手搭在桌子上，手在疯狂地记笔记。他的另一只手松弛在两腿之间，拇指和手指时而按在一起，做着奇怪的捏合手势，似乎在数秒数。你的目光转向%ailing%，他正坐在床上，腿伸出床沿，脚踩在地上。他抬起头看着你。%SPEECH_ON%嗨，队长，我现在感觉好多了，非常非常好。准备好...征服世界了。%SPEECH_OFF%这个人站起身来，猛击胸口，但声音并没有提高。%SPEECH_ON%我们继续上路吧？%SPEECH_OFF%他走出帐篷，当帐篷飘动关闭时，%anatomist%停止写作，放下鹅毛笔。他点点头。%SPEECH_ON%手术很成功。他已经不再生病了。不但这样，他的身体更健康了。%SPEECH_OFF%那还有其他变化？这不是你想看到的语言。你将不得不密切关注这个人，看看他到底有什么变化。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不再进行实验了，解剖学家。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Ailing.getSkills().removeByID("trait.ailing");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_59.png",
					text = _event.m.Ailing.getName() + "不再病弱"
				});
				local new_traits = [
					"scripts/skills/traits/bloodthirsty_trait",
					"scripts/skills/traits/brute_trait",
					"scripts/skills/traits/cocky_trait",
					"scripts/skills/traits/deathwish_trait",
					"scripts/skills/traits/dumb_trait",
					"scripts/skills/traits/gluttonous_trait",
					"scripts/skills/traits/impatient_trait",
					"scripts/skills/traits/irrational_trait",
					"scripts/skills/traits/paranoid_trait",
					"scripts/skills/traits/spartan_trait",
					"scripts/skills/traits/superstitious_trait"
				];
				local num_new_traits = 2;

				while (num_new_traits > 0 && new_traits.len() > 0)
				{
					local trait = this.new(new_traits.remove(this.Math.rand(0, new_traits.len() - 1)));

					if (!_event.m.Ailing.getSkills().hasSkill(trait.getID()))
					{
						_event.m.Ailing.getSkills().add(trait);
						this.List.push({
							id = 10,
							icon = trait.getIcon(),
							text = _event.m.Ailing.getName() + "获得了" + trait.getName()
						});
						num_new_traits = num_new_traits - 1;
					}
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Ailing.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你告诉队医%anatomist%不需要。%ailing%足够坚强可以自行康复。解剖学家叹了口气。你感觉到他没有真正的兴趣去帮助这个佣兵，只是对他进行实验感兴趣。%SPEECH_ON%伟大的进步只能伴随着巨大的风险而来，队长。%SPEECH_OFF%他说着走了，他的旧书上被他的羽毛笔勾画着一个名字。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "关于击打您的拳头...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "被剥夺了研究机会");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local ailingCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.anatomist" && bro.getSkills().hasSkill("trait.ailing"))
			{
				ailingCandidates.push(bro);
			}
		}

		if (ailingCandidates.len() == 0 || anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Ailing = ailingCandidates[this.Math.rand(0, ailingCandidates.len() - 1)];
		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 5 * ailingCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"ailing",
			this.m.Ailing.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Ailing = null;
	}

});

