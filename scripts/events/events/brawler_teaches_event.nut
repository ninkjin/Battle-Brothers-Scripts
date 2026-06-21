this.brawler_teaches_event <- this.inherit("scripts/events/event", {
	m = {
		Brawler = null,
		Student = null
	},
	function create()
	{
		this.m.ID = "event.brawler_teaches";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]一个影子从你背后穿过。 当你回头看时，%brawler% 正站在那里，眼中带着深邃的目光。 他断断续续地敲了很久的指关节，然后问他是否可以训练 %noncom%。你问为什么。 打手俯视着你。%SPEECH_ON%因为他弱呗。%SPEECH_OFF%哼，这很好。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "看看你能让他坚持多久。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "让他更强壮，你能做到么？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "教他如何打斗。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				this.Characters.push(_event.m.Student.getImagePath());
				_event.m.Brawler.getFlags().add("brawler_teaches");
				_event.m.Student.getFlags().add("brawler_teaches");
				_event.m.Brawler.improveMood(0.25, "使他更坚强了 " + _event.m.Student.getName());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_06.png[/img]%brawler% 和 %noncom% 被发现在一个坭坑里，他们的手被布和树叶包裹着，用来垫在指关节上，以防止他们每次出拳都互相擦伤。 打手让他的受训者沿战圈逆时针方向跑跳，一边走一边挥拳打在空中，每次他经过时，他的训练者都会打他或踢他。 这两个人工作时时满脸是汗。 当 %noncom% 动作开始变得缓慢，%brawler% 击打他，就像骑师对一匹缓慢的马。\n\n 一小时后，%brawler% 后退一步，并让他的受训者攻击他。 可以预见的是，这种攻击是漫无目的和令人遗憾的。 漫长而循环的出拳没有任何能量。 打手躲闪并反击受训者的每一次进攻。%SPEECH_ON%看看在你累了的时候会发生什么？ 这就是我们必须训练的原因。 即使是最能干、最致命的人，如果肺里没有空气，脚下没有有力的双腿，也一文不值。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是看看这个我就累了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				this.Characters.push(_event.m.Student.getImagePath());
				local skill = this.Math.rand(2, 4);
				_event.m.Student.getBaseProperties().Stamina += skill;
				_event.m.Student.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Student.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + skill + "[/color] 最大疲劳"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]打手让 %noncom% 完全静止不动。 他绕着那个人转了一圈，一边掰着指关节，一边打量着他。 最后，他让大家知道他的意图。%SPEECH_ON%我要打你直到你崩溃。%SPEECH_OFF%给受训者一点时间来了解将要发生的事情。 他深深地吸了一口气，然后点了点头。%brawler% 毫不犹豫地挥拳猛击那人的胸部。 他滚了过去，肩膀被踢了好几次，直到他再次站了起来。\n\n打手继续绕圈和打人。 并不是每一次打击都是令人信服的：大多数打击都是为了造成痛苦，但不是所谓的不可逆转的伤害。 打手，如果他想，他完全可以赤手空拳杀死这个人，但这不是训练的目的。 你意识到这种“强硬起来”的方式可能在某个时候发生在打手自己身上。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "什么不杀死你却能使你变得更强大？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				this.Characters.push(_event.m.Student.getImagePath());
				local skill = this.Math.rand(2, 4);
				_event.m.Student.getBaseProperties().Hitpoints += skill;
				_event.m.Student.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Student.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + skill + "[/color] 生命值"
				});
				_event.m.Student.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Student.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_06.png[/img]%brawler% 这个重磅的－有一手的－粗暴的－而且－会翻跟头的打手身体前倾，双臂在身前呈防御姿势，而 %noncom% 站在旁边，试图模仿这个姿势。 打手把身体放低，朝 %noncom%的腋下冲去，双手搂住他的腰，把他举在空中，然后把他扔到地上。%brawler% 走开了，掰着指关节，叫 %noncom% 站起来。%SPEECH_ON%你需要做好两个准备：我在低处，和我在高处。%SPEECH_OFF%%noncom% 掸去身上的灰尘，然后抱怨了一下。%SPEECH_ON%我怎么可能两全其美呢？%SPEECH_OFF%打手忽视了这个问题，只是要求这个人攻击他。%noncom% 被迫强起打出一记重拳。%brawler% 扭肩躲闪并交替出拳反击，将 %noncom% 击倒。 这个拳击手又掰响了指关节并开始吐口水。%SPEECH_ON%练习。就是这样做。现在站起来，让我们再来一遍。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许他将会被打造成为一个真正的雇佣兵。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				this.Characters.push(_event.m.Student.getImagePath());
				local attack = this.Math.rand(1, 2);
				local defense = this.Math.rand(1, 2);
				_event.m.Student.getBaseProperties().MeleeSkill += attack;
				_event.m.Student.getBaseProperties().MeleeDefense += defense;
				_event.m.Student.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Student.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + attack + "[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Student.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + defense + "[/color] 近战防御"
				});
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

		local candidates_brawler = [];
		local candidates_student = [];

		foreach( bro in brothers )
		{
			if (bro.getFlags().has("brawler_teaches"))
			{
				continue;
			}

			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.brawler")
			{
				candidates_brawler.push(bro);
			}
			else if (bro.getLevel() < 3 && !bro.getBackground().isCombatBackground())
			{
				candidates_student.push(bro);
			}
		}

		if (candidates_brawler.len() == 0 || candidates_student.len() == 0)
		{
			return;
		}

		this.m.Brawler = candidates_brawler[this.Math.rand(0, candidates_brawler.len() - 1)];
		this.m.Student = candidates_student[this.Math.rand(0, candidates_student.len() - 1)];
		this.m.Score = (candidates_brawler.len() + candidates_student.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brawler",
			this.m.Brawler.getNameOnly()
		]);
		_vars.push([
			"noncom",
			this.m.Student.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Brawler = null;
		this.m.Student = null;
	}

});

