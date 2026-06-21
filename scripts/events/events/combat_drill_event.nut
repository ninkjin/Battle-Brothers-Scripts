this.combat_drill_event <- this.inherit("scripts/events/event", {
	m = {
		Teacher = null
	},
	function create()
	{
		this.m.ID = "event.combat_drill";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]你走出帐篷去观察那些人。 他们中的许多人是新雇来的菜鸟，紧张不安地尝试结交新朋友或试着用手拿起武器。%oldguard% 来到你身边。%SPEECH_ON%我知道你在想什么。 你在想你刚刚雇了一堆小鲜肉来打谷子。 我该怎么鞭策这些孩子靠谱一些，使他们在第一次上战场的时候不会吃到兽人的利刃？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好，让我看看你如何教他们格斗。",
					function getResult( _event )
					{
						return "B1";
					}

				},
				{
					Text = "非常好，让我看到他们能使用弓箭。",
					function getResult( _event )
					{
						return "C1";
					}

				},
				{
					Text = "非常好，让他们有体力穿上真正的盔甲。",
					function getResult( _event )
					{
						return "D1";
					}

				},
				{
					Text = "不，他们需要保留他们仅有的一点力量用来战斗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_05.png[/img]%oldguard% 告诉新兵拿起武器。 当他们每个人都拿起一把剑的时候，老兵对他们大吼，说不是每一个想让你死在墓地的敌人都会用同样的利刃。 他们点了点头，然后匆匆地把剑换成了斧头和长矛。 队员们装备好后，训练就开始了。 大多数情况下，%oldguard% 教授一些基础知识，比如如何让一个阵形不仅能让你更容易地保护队友，还能让你更容易地保护自己。%SPEECH_ON%你不需要注视每个角落，如果你的战友在你身边。 但是，如果你们分开了，如果你们都在外面孤单地呆着，那你们就会被狠狠地揍一场，免得你们用一把刀走到一条未知的路上去，我会继续下去，假设你没有的话。%SPEECH_OFF%训练内容变为进攻，%oldguard% 用各种武器展示一些技巧。%SPEECH_ON%用剑你可以砍，切，刺和还击。 不错－用剑很难失手，因为它的每一面都是致命的。 如果我看到你们中的任何一个想要用剑砍断一支箭，就像童话里告诉你们的那样，我会亲自揍你一顿的。 这不是真的，所以别胡思乱想了！\n\n长矛很适合保持距离。 它们不会让你的装甲更厚，但他们会让你更安全。 把矛尖离自己远点。 如果一个穿护甲的畜生通过了这尖尖的一端，那你可就惨了，所以不要让这种事情发生。\n\n最后，该说说斧子了。 只要假装对方是一棵树，然后把它劈成两半就行。 现在我们开始练习！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "向我展示下你能干什么！",
					function getResult( _event )
					{
						return "B2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				_event.m.Teacher.improveMood(0.5, "已经训练了新兵");
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_50.png[/img]从那以后，训练进行得相当顺利，尽管队员们会让对方身上有一些磕碰和瘀伤。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getLevel() > 3)
					{
						continue;
					}

					local meleeSkill = this.Math.rand(0, 2);
					local meleeDefense = meleeSkill == 0 ? this.Math.rand(0, 2) : 0;
					bro.getBaseProperties().MeleeSkill += meleeSkill;
					bro.getBaseProperties().MeleeDefense += meleeDefense;
					bro.getSkills().update();

					if (meleeSkill > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_skill.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
						});
					}

					if (meleeDefense > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/melee_defense.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeDefense + "[/color] 近战防御"
						});
					}

					local injuryChance = 33;

					if (bro.getSkills().hasSkill("trait.clumsy") || bro.getSkills().hasSkill("trait.drunkard"))
					{
						injuryChance = injuryChance * 2.0;
					}

					if (bro.getBackground().isCombatBackground())
					{
						injuryChance = injuryChance * 0.5;
					}

					if (bro.getSkills().hasSkill("trait.dexterous"))
					{
						injuryChance = injuryChance * 0.5;
					}

					if (this.Math.rand(1, 100) <= injuryChance)
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + "遭受轻伤"
							});
						}
						else
						{
							local injury = bro.addInjury(this.Const.Injury.Accident1);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " 遭受 " + injury.getNameOnly()
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C1",
			Text = "[img]gfx/ui/events/event_05.png[/img]%oldguard%集合众人并开始分发训练用的弓箭。%SPEECH_ON%这些东西用于杀人可有点勉强，假如你们对婴儿啥的图谋不轨另说，但现在我们只是拿来练习。\n\n这个东西是怎么工作的，哦，你们已经知道了？你们不是一群傻子？好了，那就来展示一下你们的神射手本领吧。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我看看你们这帮家伙能射中什么。",
					function getResult( _event )
					{
						return "C2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				_event.m.Teacher.improveMood(0.5, "已经训练了新兵");
			}

		});
		this.m.Screens.push({
			ID = "C2",
			Text = "[img]gfx/ui/events/event_10.png[/img]这些人在练习射击靶子，箭在他们的目标周围乱射，少数幸运的人射到了他们应该射的地方。%oldguard% 精疲力竭地指导队员们不停地射击，直到他们的运气完全消失为止。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getLevel() > 3)
					{
						continue;
					}

					local rangedSkill = this.Math.rand(0, 2);
					bro.getBaseProperties().RangedSkill += rangedSkill;
					bro.getSkills().update();

					if (rangedSkill > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/ranged_skill.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + rangedSkill + "[/color] 远程技能"
						});
					}

					local exhaustionChance = 33;

					if (bro.getSkills().hasSkill("trait.asthmatic"))
					{
						exhaustionChance = exhaustionChance * 4.0;
					}

					if (bro.getSkills().hasSkill("trait.athletic"))
					{
						exhaustionChance = exhaustionChance * 0.0;
					}

					if (bro.getSkills().hasSkill("trait.iron_lungs"))
					{
						exhaustionChance = exhaustionChance * 0.0;
					}

					if (this.Math.rand(1, 100) <= exhaustionChance)
					{
						local effect = this.new("scripts/skills/effects_world/exhausted_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + "是筋疲力尽的"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D1",
			Text = "[img]gfx/ui/events/event_05.png[/img]%oldguard% 吹响尖锐的口哨，把新兵召集在他周围。 他环顾四周，咧嘴一笑，然后点了点头。%SPEECH_ON%好了，你们这些笨蛋，乳臭未干的，娘娘腔，蠢货，我们会进行一场行军！%SPEECH_OFF%老兵把剩下的时间都花在无情地驱赶新兵上，直到最后一个人精疲力竭。%SPEECH_ON%呼吸，小宝贝，呼吸！全收进去。 我们有很多事要做，别难过！ 就像你妈妈把你吞下去一样。 现在，我己经找到污点了，就是我比你们许多人跑的都快，所以我明天一定会再见到你们的，时间有的是。 那是太阳出来之前的事了，蠢货们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们还会那样做的，明天！",
					function getResult( _event )
					{
						return "D2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				_event.m.Teacher.improveMood(0.5, "已经训练了新兵");
			}

		});
		this.m.Screens.push({
			ID = "D2",
			Text = "%oldguard% 表现的毫无怜悯之心，让这些人在未来的日子里一次又一次奔跑。 毕竟，他说，这是为了他们自己。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Teacher.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getLevel() > 3)
					{
						continue;
					}

					local stamina = this.Math.rand(0, 3);
					local initiative = stamina == 0 ? this.Math.rand(0, 3) : 0;
					bro.getBaseProperties().Stamina += stamina;
					bro.getBaseProperties().Initiative += initiative;
					bro.getSkills().update();

					if (stamina > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] 最大疲劳"
						});
					}

					if (initiative > 0)
					{
						this.List.push({
							id = 16,
							icon = "ui/icons/initiative.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
						});
					}

					local exhaustionChance = 75;

					if (bro.getSkills().hasSkill("trait.asthmatic"))
					{
						exhaustionChance = exhaustionChance * 2.0;
					}

					if (bro.getSkills().hasSkill("trait.athletic"))
					{
						exhaustionChance = exhaustionChance * 0.5;
					}

					if (bro.getSkills().hasSkill("trait.iron_lungs"))
					{
						exhaustionChance = exhaustionChance * 0.5;
					}

					if (this.Math.rand(1, 100) <= exhaustionChance)
					{
						local effect = this.new("scripts/skills/effects_world/exhausted_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + "是筋疲力尽的"
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local numRecruits = 0;

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().isCombatBackground() && !bro.getBackground().isNoble())
			{
				candidates.push(bro);
			}
			else if (bro.getLevel() <= 3 && !bro.getBackground().isCombatBackground())
			{
				numRecruits = ++numRecruits;
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		if (numRecruits < 3)
		{
			return;
		}

		this.m.Teacher = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10 + numRecruits * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oldguard",
			this.m.Teacher.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Teacher = null;
	}

});

