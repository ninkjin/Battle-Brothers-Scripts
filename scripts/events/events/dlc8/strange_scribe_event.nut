this.strange_scribe_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Dude = null,
		Minstrel = null,
		Killer = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.strange_scribe";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_31.png[/img]{当你在%townname%的时候，你被一个你在当地贵族周围看到的人拦住了。他穿着一件黑色的斗篷，深深地把脸藏在兜帽里。他很可疑。自然，%anatomist%解剖学家把他视为科学观察对象之一。那人鞠躬致意。%SPEECH_ON%我对你的工作非常敬重，%anatomist%。我们读了很多你的论文。%SPEECH_OFF%你把手放在剑上，等着看看会发生什么。那人继续说道。%SPEECH_ON%我们想邀请你一起用餐，深入地讨论身体的重要性问题……%SPEECH_OFF%你走到那人与你之间，问这个“我们”是谁。那人说他是一群研究人体问题的文书和学者中的一员，他们还研究了那些很适应他们野蛮任务性质的生物——即研究世界的怪物。%SPEECH_ON%当然，我们对那些失去自身的人类的野兽也有特别的兴趣……%SPEECH_OFF%由于有这么多的阴谋诡计在蔓延，你并不惊讶解剖学家想跟着这个奇怪的文书去了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我跟你一起走。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "这太可疑了。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Minstrel != null)
				{
					this.Options.push({
						Text = "民谣歌手：%minstrel%知道什么吗？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Killer != null)
				{
					this.Options.push({
						Text = "等等，我们的专门杀人犯%killer%去哪了？",
						function getResult( _event )
						{
							return "F";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_31.png[/img]{如果%anatomist%要去镇上任何地方，那么肯定不会孤身一人。你跟着他，手一直握着剑柄。这个陌生人邀请你来到一个美丽的石头房子，从每个窗户里都可以看到烛光。在里面，你很快就被引到了应该是用餐的桌子旁边，但却发现一个皮肤纸一般薄的苍白男子横在桌子上。这个陌生的抄写员像一个烹饪了自己最好的菜肴的厨师一样鞠躬致意。%SPEECH_ON%我们相信这是重生者，一个已经死去但又复活的人。%SPEECH_OFF%这个奇怪的抄写员卷起袖子，把手臂放到了垂死的尸体上面。它的下颌突然向左右移动，嘴巴大张，白色的双眼翻动。%anatomist%只是往后靠着，表示这很“有趣”。两个人开始交谈，而你紧张不安地摸着剑柄，以防这个“重生者”试图逃跑。当两人结束时，%anatomist%和这位抄写员取出羽毛笔，在彼此的卷轴上签字，同时祝贺对方的成果。\n\n整个事件让你感到非常不安，你注意到僵尸身上的汗珠，但是还没来得及说什么，你就被赶出了屋子。无论他们讨论了什么，解剖学家都变得充满了活力。他小心翼翼地说道%SPEECH_ON%当然，这个生物是假的，我当然注意到了。然而，这让我对当地人的创作深度有了更多的了解。从这样的创造力中，可以获得一些东西，因为人的想象从崇高和真实中悄然创造，并根据自己的直觉推断出尚无科学描述的东西。即使在当地的迷雾和迷信中，我也能取得很大的进步。%SPEECH_OFF%好吧，你提到你知道这是假的，因为那个被认为死了的怪物在出汗。解剖学家点了点头，说你可能没有诊断考察的眼力，但你对街头智慧的掌握很足够。你只是点了点头，希望他的话是善意的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们离开这里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(0.75, "学会了如何更好地应对平信徒。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				local fatigueBoost = this.Math.rand(1, 3);
				_event.m.Anatomist.getBaseProperties().Stamina += fatigueBoost;
				_event.m.Anatomist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + fatigueBoost + "[/color] 疲劳"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你同意让解剖学家走，但你要一起前往。这引起了那个奇怪的抄写员的注意。他似乎不太愿意再继续，失去了最初邀请时的兴致。当你转过一个拐角时，他发出了一声尖锐的鸟叫，几个人走出来，你拔出剑，把%anatomist%推了回去。其中一个人试图袭击你，虽然你最近不太适合战斗，但你用一个快速的挡开把他击退了，并使他放弃了进一步袭击。抄写员和他的手下急忙离开，说你不值得。%anatomist%看起来很失望。%SPEECH_ON%啊，我懂了。这是个骗局，一个既富有创造性又犯罪的尝试。%SPEECH_OFF%环顾四周，你意识到你的钱袋不见了。你看到一个孩子刚好捡到它，然后抛向空中由另一个孩子接住，他们躲在一些水槽上。%anatomist%站在你身边，仰头看着，着迷于这些小淘气所做的工程努力。%SPEECH_ON%看来，一个罪犯失败后，另一个人可能会取而代之。这就是通过摧毁犯罪分子来保持治安的途径。有趣。%SPEECH_OFF%解剖学家突然意识到他的钱包也轻了一点，发现他的钱包也被偷了。你向他身后看去，又看到另一个孩子像老鼠偷奶酪一样跑开了。另一个孩子跑过来，当他没有东西可以偷的时候，试图扒窃你。生气的男孩双手空空地喊道。%SPEECH_ON%找份工作吧！%SPEECH_OFF%叹了口气，你说是时候回到战团了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的淘气鬼。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-175);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]175[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你同意让%anatomist%和那个奇怪的抄写员交谈，但是在你走下街道之前，%minstrel%这个民谣歌手走上前来，面带微笑指着他。%SPEECH_ON%%fakescribe%！你这些天在忙什么呢？这是你新的骗局吗？%SPEECH_OFF%奇怪的抄写员清了清嗓子，他伸出双手，又清了清嗓子，似乎准备深入地谈论某个主题，但随后叹了口气，户外甩开他的斗篷。一个年轻而不怎么学术的小伙子显露出来。他摇了摇头。%SPEECH_ON%在大城市里生活很艰难，%minstrel%。你过得怎么样？%SPEECH_OFF%两人聊了一会儿，你和%anatomist%困惑地望着他们。最终，两个民谣歌手转向你，%minstrel%带路。%SPEECH_ON%队长，这是%fakescribe%。他在%townname%处境艰难。他和我很像，是一个废柴的战士，但也是一个有活力、有勇气的人，一个只需一点时间就能找到真正内在实力的人，尤其是在有女人的情况下。你怎么说，让他来%companyname%？%SPEECH_OFF%%fakescribe%摇了摇头。%SPEECH_ON%呃，啊，在他们那里，我一直没有找到它。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可以，他可以一起来。",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "我们不需要另一个江湖骗子。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"minstrel_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "{[队长]%name%[/队长]被发现以他的吟游诗人天赋在街头欺诈活动中进行部署。在另一位吟游诗人的担保下，他加入了%companyname%寻求在路上的生活。希望这个从骗子变成佣兵的人能够像他经常所说的那样“假装做到直到成功”。}";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你免除了徵用乐师的费用。%anatomist% 解剖学家似乎有些沮丧，表示他渴望得到罕见的知识，但整个世界似乎只提供了骗局和虚假。微笑着，你告诉他要想这是街头知识了。他也微笑着回道。%SPEECH_ON%是啊，也许我应该多获取一些这样的…街头智慧。%SPEECH_OFF%不是，是街头知识。 “街头智慧”听起来很荒谬。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "振作起来，解剖师[%anatomist%]。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_12.png[/img]{你同意让这位解剖学家和奇怪的文书员继续他们的对话，并自己跟上。他带你来到一条相当可疑的小巷的开头。他脸上露出狂野的笑容，慢慢地从袖子里拔出匕首，突然一把刀插穿了他的脸，一丝钢光在他的嘴里闪烁。他呜咽着，另一把刀快速地砍断了他的喉咙。 %killer%，据说是在逃的凶手，从小巷里走出来。%SPEECH_ON%队长，还有，呃，解剖学家？殡仪师？这个人是个杀人犯。而且还侵犯了我的……嗯……事务。%SPEECH_OFF%他把尸体扔在地上，开始脱开披风，揭露这个所谓的文书员实际上装备精良。凶手砍下了其中一只耳朵，然后点头示意。%SPEECH_ON%嘿，看来我们得到了一些免费的装备，不是吗？但我们最好把尸体藏起来。这个人给人一种很了不起的形象，有人可能会对他的缺席产生怀疑。%SPEECH_OFF%无论什么情况，你都不知道该相信什么或谁，但一个流血不止的尸体总是不太好看。当然，在愉快地剥下它的装备之后，你把尸体藏了起来。%anatomist%似乎对%killer%感到不安。他提到在逃的凶手的语调似乎是立刻产生的推测，或者按俗语说的“演戏”。既然事情已经发生了，你只是让他帮忙把装备搬回库存中。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "所说即所见。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(0.75, "目击了一起残忍的谋杀案");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				local attackBoost = this.Math.rand(1, 3);
				local resolveBoost = this.Math.rand(1, 3);
				_event.m.Killer.getBaseProperties().MeleeSkill += attackBoost;
				_event.m.Killer.getBaseProperties().Bravery += resolveBoost;
				_event.m.Killer.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Killer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + attackBoost + "[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Killer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});
				local armors = [
					"armor/padded_leather",
					"armor/patched_mail_shirt",
					"armor/leather_lamellar"
				];
				local weapons = [
					"weapons/dagger",
					"weapons/dagger",
					"weapons/dagger",
					"weapons/rondel_dagger"
				];
				local armor = this.new("scripts/items/" + armors[this.Math.rand(0, armors.len() - 1)]);
				armor.setCondition(this.Math.max(1, armor.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(armor);
				this.List.push({
					id = 10,
					icon = "ui/items/" + armor.getIcon(),
					text = "你获得了" + armor.getName()
				});
				local weapon = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				weapon.setCondition(this.Math.max(1, weapon.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(weapon);
				this.List.push({
					id = 10,
					icon = "ui/items/" + weapon.getIcon(),
					text = "你获得了" + weapon.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_31.png[/img]{你说这种情况太过可疑，不值得冒险。%anatomist%说对外行人来说，所有知识都是可疑的。你告诉他，这个“外行人”已经足够聪明地嗅到了麻烦的味道，就是这样。解刨师很不高兴，但你宁愿他感到激动，也不愿意他死去。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "聪明点，谦虚点。",
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

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary() || t.getSize() < 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local minstrelCandidates = [];
		local killerCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.minstrel")
			{
				minstrelCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.killer_on_the_run")
			{
				killerCandidates.push(bro);
			}
		}

		if (minstrelCandidates.len() > 0 && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
		{
			this.m.Minstrel = minstrelCandidates[this.Math.rand(0, minstrelCandidates.len() - 1)];
		}

		if (killerCandidates.len() > 0)
		{
			this.m.Killer = killerCandidates[this.Math.rand(0, killerCandidates.len() - 1)];
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 10;
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
			"minstrel",
			this.m.Minstrel != null ? this.m.Minstrel.getNameOnly() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getName() : ""
		]);
		_vars.push([
			"fakescribe",
			this.m.Dude != null ? this.m.Dude.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Dude = null;
		this.m.Minstrel = null;
		this.m.Killer = null;
		this.m.Town = null;
	}

});

