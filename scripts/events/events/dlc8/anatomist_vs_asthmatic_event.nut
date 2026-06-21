this.anatomist_vs_asthmatic_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Asthmatic = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_asthmatic";
		this.m.Title = "露营时…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你走近了解剖学家%anatomist%与患有呼吸困难的人 %asthmatic%面对面的交谈。这个人极其不擅长简单的呼吸，几乎是按部就班的频率，这个人来向你请求。他说解剖学家有可能治愈他的肺部。%anatomist%点点头。%SPEECH_ON%这只是一个小手术，虽然会痛，但这个勇敢的主体——抱歉，这个勇敢的动物——天哪，对不起，这个勇敢的病人已经准备好充分接受挑战了。只要你说好，我就可以开始，并在短时间内完成。%SPEECH_OFF%你不确定这件事情是否可行，但如果 %asthmatic% 能像某只被榨干生命的兔子一样，在夜间止住喘息，那就太好了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去做吧，但要小心。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "去做吧，必要时不考虑手段。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "不，我不会冒险他的生命。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Asthmatic.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{您同意了这个手术，之后那两个人就消失了一段时间。不久后，像踩在死狗肺脏上的%asthmatic%走过来，露出了灿烂的笑容。他站得笔直，挺胸抬头，深深地吸了一口气，身体像蟾蜍一样膨胀，脸颊鼓起，然后他慢慢地呼出气来，没有哮喘，也没有喉咙发痒，脸也没有变红，手臂放松了，但他并没有头晕。%SPEECH_ON%那个解剖学家真的把我修补得好极了，他简直就是个奇迹。%SPEECH_OFF%那个人转过身来，露出了肉体上的一系列吸气时会弯曲的凹陷。%anatomist%端着奇怪的金属器具过来清洗，他摇了摇头。%SPEECH_ON%至少我们中的一个对结果非常满意，这是已经到达了的程度。%SPEECH_OFF%您不确定为什么那个解剖学家很生气，但您瞥了一眼他的一本书，里面记载了用手术刀和勺子切除肺部的手术，他肯定不是这么对待%asthmatic%的吧。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Surely...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Asthmatic.getSkills().removeByID("trait.asthmatic");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_22.png",
					text = _event.m.Asthmatic.getName() + "不再哮喘"
				});
				_event.m.Asthmatic.addHeavyInjury();
				this.List.push({
					id = 11,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Asthmatic.getName() + "遭受重伤"
				});
				_event.m.Asthmatic.improveMood(1.0, "不再哮喘");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 11,
						icon = this.Const.MoodStateIcon[_event.m.Asthmatic.getMoodState()],
						text = _event.m.Asthmatic.getName() + this.Const.MoodStateEvent[_event.m.Asthmatic.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Asthmatic.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{您批准了这个程序。%asthmatic%转身对解剖学家说，解剖学家随即将金属尖插入男子的胸膛深处。这个男人痛苦地龇牙咧嘴，手指弯曲，仿佛要抓住疼痛本身。当%anatomist%像持刃一样拿着该工具向前再次出击时，您向前跳并阻止了他。他困惑地看着您%SPEECH_ON%这是程序的一部分，你不明白吗？现在，我必须继续刺穿他。我们将再给他穿八个洞。%SPEECH_OFF%%asthmatic%尖叫起来，他并不像是在高贵地反对这个过程。您告诉解剖学家这个过程结束了。他叹了口气，放低了工具。%SPEECH_ON%任何重要的事情都需要痛苦，佣兵。不论是您亲自去获取头颅来换取克朗，还是我为了追求治愈而痛苦。如果疼痛不是关键因素，我们也不会以自己的方式扰乱自然秩序。%SPEECH_OFF%您让他闭嘴，告诉他现在结束了。他叹了口气，拿着抹布清洗工具走开了。%asthmatic%为您介入表示感激，并喘着气说感谢您。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只要轻松一点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local injury = _event.m.Asthmatic.addInjury([
					{
						ID = "injury.pierced_lung",
						Threshold = 0.0,
						Script = "injury/pierced_lung_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Asthmatic.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Asthmatic.worsenMood(0.5, "被疯子攻击受伤了。");

				if (_event.m.Asthmatic.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 11,
						icon = this.Const.MoodStateIcon[_event.m.Asthmatic.getMoodState()],
						text = _event.m.Asthmatic.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.worsenMood(1.0, "被剥夺了研究机会");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 11,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Asthmatic.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你想，为什么不试试全新的方法？ %asthmatic%同意了。%SPEECH_ON%既然会有疼痛，那就让它值得。%SPEECH_OFF%两个人走进帐篷后，你考虑着要不要看一看。但你意识到你可能无法忍受，无论它是什么，而且你也不想单单因为你的存在干扰解剖师的工作。虽然如此，两个人很快就重新出现了。%asthmatic%站直了身子，深吸一口气，然后一口气都吐了出来。%SPEECH_ON%我从没感觉过这么舒服。%SPEECH_OFF%他说，然后握了握%anatomist%的手。治愈的人走了。%anatomist%清洁了他的手%SPEECH_ON%不幸的是，出现了一些并发症。让我看看，我们有什么…%SPEECH_OFF%解剖师展开一卷匆忙写下的笔记，其中一些笔记上沾满了血。你读到了……}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢。噢，不。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Asthmatic.getSkills().removeByID("trait.asthmatic");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_22.png",
					text = _event.m.Asthmatic.getName() + "不再哮喘"
				});
				local trait = this.new("scripts/skills/traits/iron_lungs_trait");
				_event.m.Asthmatic.getSkills().add(trait);
				this.List.push({
					id = 11,
					icon = trait.getIcon(),
					text = _event.m.Asthmatic.getName() + "获得铁肺。"
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

					if (!_event.m.Asthmatic.getSkills().hasSkill(trait.getID()))
					{
						_event.m.Asthmatic.getSkills().add(trait);
						this.List.push({
							id = 12,
							icon = trait.getIcon(),
							text = _event.m.Asthmatic.getName() + "获得了" + trait.getName()
						});
						num_new_traits = num_new_traits - 1;
					}
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Asthmatic.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你告诉解剖学家%anatomist%不需要。解剖学家嘟起嘴，对医学和科学的价值进行了一些冷静的辩论，而你则告诉他，没有人要肺部被某个傻瓜弄坏的佣兵的价值。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好啦好啦，去在课本里哭去吧。",
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
		local asthmaticCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.anatomist" && bro.getSkills().hasSkill("trait.asthmatic"))
			{
				asthmaticCandidates.push(bro);
			}
		}

		if (asthmaticCandidates.len() == 0 || anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Asthmatic = asthmaticCandidates[this.Math.rand(0, asthmaticCandidates.len() - 1)];
		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 5 * asthmaticCandidates.len();
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
			"asthmatic",
			this.m.Asthmatic.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Asthmatic = null;
	}

});

