this.shadow_dissection_event <- this.inherit("scripts/events/event", {
	m = {
		Talkers = [],
		Anatomist = null,
		Cultist = null,
		Monk = null,
		Mercenary = null,
		Swordmaster = null,
		Minstrel = null,
		OtherBro = null,
		Killer = null
	},
	function create()
	{
		this.m.ID = "event.shadow_dissection";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{战团已在一座废弃的祈祷堂旁扎营，士兵们围着篝火，将影兽投射在石墙上。先是兔子，然后是喘息的狗，当然还有鸟、蛇头以及小老鼠。一位雇佣兵思考着，这些影子在没有人看的时候在干什么。他举起手来，黑色的影子映在石墙上。%SPEECH_ON%我的意思是无论我们去哪里，这些东西都跟着我们，我们戏弄它们，但我们真的没有想太多。看看这个，这是什么？%SPEECH_OFF%他张开双手，在墙上投出十个黑影。士兵们若有所思……}",
			Banner = "",
			Characters = [],
			Options = [],
			function start( _event )
			{
				if (_event.m.Anatomist != null)
				{
					this.Options.push({
						Text = "%anatomist%这位解剖学家有什么话要说？",
						function getResult( _event )
						{
							return "B";
						}

					});
				}

				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "[邪教徒]%cultist%又在喃喃自语了。",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "我们的武僧%monk%似乎很热衷于回答。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Mercenary != null)
				{
					this.Options.push({
						Text = "为什么大家都看着这个最牛的自由佣兵？",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				if (_event.m.Swordmaster != null)
				{
					this.Options.push({
						Text = "%swordmaster% 剑术大师似乎有话要说。",
						function getResult( _event )
						{
							return "F";
						}

					});
				}

				if (_event.m.Minstrel != null)
				{
					this.Options.push({
						Text = "自然，吟游诗人[%minstrel%]已经准备好了谈话。",
						function getResult( _event )
						{
							return "G";
						}

					});
				}

				if (_event.m.Killer != null && this.Options.len() < 6)
				{
					this.Options.push({
						Text = "那是什么声音？",
						function getResult( _event )
						{
							return "H";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_184.png[/img]{%anatomist% 解剖学家从篝火旁抬起头，脸上的阴影随着火焰的升降而扭曲。%SPEECH_ON%我们的影子只是对这个世界的切割，一步黑暗既伤害又治愈，用我们存在的阴影切割地球，这种短暂的方式只能预示我们留在这里的景象。但是影子是否会想要解剖你？它是否希望解放其他类似自己的实体？它肯定不是独自一人。肯定我们的内心也有阴影。它们是否会在我们内心的墙壁上反复映射？当我们睡觉时怎么办？这些东西是否会从内部针对我们，还是溜到外面漫游？它们是否是我们内心精神的守卫，离开我们在晚上并将我们留给梦魇般的恐怖，当我们清醒时，这些梦魇肯定存在吗？比起我们的影子透过我们的阴影在地上落下的那些短暂的记忆，早晨的清晨更能映射出真相。%SPEECH_OFF%一名雇佣兵盯着他。%SPEECH_ON%什么？%SPEECH_OFF%其余的雇佣兵嘲笑起来。%SPEECH_ON%嘿, 老兄, 我们只是想像男人和妓女那样做，玩玩而已。看这个, 我是 %anatomist% 的影子。胡说八道！%SPEECH_OFF%众人大笑，一个雇佣兵模仿嘴巴一遍又一遍地张合。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "至少解剖学家对此不以为意。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Anatomist.getID())
					{
						bro.improveMood(0.75, "感觉智商高于其他人");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (this.Math.rand(1, 100) <= 50)
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_03.png[/img]{%cultist%邪教徒向火堆倾斜，脸几乎贴着火焰。 他的眼睛睁大，湿润的皮肤变干并脱落，直到血管在白色上肥厚。 他往后靠。%SPEECH_ON%阴影只是更大黑暗的大使。%SPEECH_OFF%营火发出噼啪声，男人们看着他，他的影子在修道院的墙上绽放，一瞬间，队伍在那黑暗中看到了其他东西，扭曲而倾斜的实体，而不是受到%cultist%形状支配的东西。当火势减弱时，阴影分解成碎片，并逐渐消失在更大的夜晚中，只剩下邪教徒自己的被阴影笼罩的身影在修道院的墙上摇曳不定。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "奇怪的夜晚，奇怪的阴影。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.improveMood(1.5, "达库尔在等待着。");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (this.Math.rand(1, 100) <= 20)
					{
						bro.worsenMood(1.0, "感到不安" + _event.m.Cultist.getName());

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
			ID = "D",
			Text = "[img]gfx/ui/events/event_40.png[/img]{%monk%大师站起来，向古老的神祈祷。他一手放在胸前，另一只手高举，仿佛在做一次伟大的演讲。%SPEECH_ON%我们应该关注产生暗影的火焰，因为这正是我们的神灌注给我们的火焰，让我们把白昼带入黑夜，使我们的生产习惯永不止息，使我们对善良的忠诚无误。%SPEECH_OFF%众人高呼“听听！”}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "愿他们守护着我们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Monk.getID() || bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(1.0, "受...启发" + _event.m.Monk.getName());

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}

						if (this.Math.rand(1, 100) <= 33)
						{
							bro.getBaseProperties().Bravery += 1;
							this.List.push({
								id = 16,
								icon = "ui/icons/bravery.png",
								text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_82.png[/img]{其中一名雇佣兵站起来，指着篝火对面宣称%mercenary%的影子最可怕。这个高大的佣兵听到自己的名字被大声说出恼怒地看了过来，咬紧牙关缓缓举起双手，战团的其他人都害怕地后退。%mercenary%交叉双手，伸出大拇指。%SPEECH_ON%这是只小鸡，看见了吧？%SPEECH_OFF%其他人看看墙上的影像，那看上去绝对不像只小鸡，但是没有人敢这么说，他们都点头表示赞同.%SPEECH_ON%实话说，%mercenary%，这是我见过最好的公鸡了。%SPEECH_OFF%众人发出笑声，但是%mercenary%站了起来，笑声戛然而止。%SPEECH_ON%我说了这是只小鸡，对吧？%SPEECH_OFF%其他人急忙点头，承认这是只小鸡，紧张的气氛舒缓下来，但是影子游戏就此结束了。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我觉得它有点像一条蚯蚓。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Mercenary.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Mercenary.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.75, "很高兴他能并肩作战。" + _event.m.Mercenary.getName());

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(0.5, "害怕 (Afraid of)" + _event.m.Mercenary.getName());

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
			ID = "F",
			Text = "[img]gfx/ui/events/event_17.png[/img]{剑术大师%swordmaster%点头并跟它说话。%SPEECH_ON%我一直在想影子的问题。当你在白天战斗时，是否有两场战斗在进行？一场是肉体的，一场是在你脚下的影子的战斗？当你杀死一个人时，你是否也杀死了他的影子？或者你的影子杀死了他的？我们自己的影子又是什么？因为当我发现自己在没有光的战斗中时，这根本不是一场战斗，而是一种无意义的事，四肢乱动，刀剑乱舞。盲目表现。只有在影子靠近腰部时，我们才能真正说这是人的战斗，是他们天赋的战斗。%SPEECH_OFF%一名雇佣兵恭敬地倾斜了一个杯子。%SPEECH_ON%那么不管任何事情或者方式如何，愿我的影子永远都不会越过你的智慧，%swordmaster%。%SPEECH_OFF%战团举起酒杯。乾杯!}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "他的影子穿越着巨大的危险。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Swordmaster.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(1.0, "他很高兴和[caption]一起战斗。" + _event.m.Swordmaster.getName());

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
			ID = "G",
			Text = "[img]gfx/ui/events/event_26.png[/img]{[brackets]%minstrel%[/brackets]旅行诗人站起身来，头歪向一侧，脚步蹒跚，眼睛盯着自己在修道院墙上的影子，每走一步就是一步，影子也越来越小。他像看待一个身体一样凝视着那个影子，然后向它靠近，就像必须解决的命案一样。突然，他站直了起来，双手叉腰。%SPEECH_ON%老天保佑，伙计们，我已经看透了！我的影子绝对是个花心大萝卜！一个臭味相投的家伙。他裤裆里有一把大锤子，每个女人都像个钉子！他是个风流浪子！还是个酒鬼，可怜的穷鬼。还有...还有一个小偷！这个贼再怎么脏也掩饰不了它的明艳。还是一个小恶魔，一个充满突发事件的小老鼠。就在前几天，我的影子在%othersellsword%的靴子里屙了一坨便便！我简直不敢相信！%SPEECH_OFF%%othersellsword%跳了起来，撞倒了营火，火星散落而出，仿佛在欢笑中旋转扭曲。他走了过来。%SPEECH_ON%我就知道那不是狗屎你这个混蛋！什么样的男人在另一个男人的靴子里拉屎！%SPEECH_OFF%佣兵滑倒了一跤，这引起了战团的掌声，旅行诗人轻盈地舞蹈着，他的影子与一个吻和挥手告别。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "吟游诗人的影子比我还受欢迎。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Minstrel.getID() || bro.getID() == _event.m.OtherBro.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 66)
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
			ID = "H",
			Text = "[img]gfx/ui/events/event_51.png[/img]{当男人们玩弄着影子时，披头散发且正在逃亡中的%killer%，被认为是凶手的人，提着珠宝和其他物品向营地走来，它们的金属表面闪现着深红色的光彩。他自言自语着，但突然停下来看着战团的其他成员。%SPEECH_ON%哦。你们还醒着吗？我只是，呃，出去转了一圈。%SPEECH_OFF%他的脸上有血迹，在指甲下也粘满了血。意识到自己有麻烦了，他放下了物品。%SPEECH_ON%这些当然是给战团的。我只是太，呃，感激你们收留我了。想着要回报你们，你们懂吧？%SPEECH_OFF%男人们注视着这些物品。你问这个人是否有人会来找这些物品。他咧嘴一笑。%SPEECH_ON%不会的，先生，当然不会。我保证过了。哦，队长，我保证了，嘿嘿嘿。%SPEECH_OFF%你让这个人把货物放进清单里，但先清洗干净。当他走开时，其他人悄悄地交换了眼色。似乎没有更多的阴谋游戏可玩了。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "有人可以注意一下那个人吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Killer.getImagePath());
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local cultist_candidates = [];
		local monk_candidates = [];
		local mercenary_candidates = [];
		local swordmaster_candidates = [];
		local minstrel_candidates = [];
		local killer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.cultist")
			{
				cultist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				monk_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.hedge_knight" || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.sellsword")
			{
				mercenary_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.swordmaster")
			{
				swordmaster_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.minstrel")
			{
				minstrel_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.killer_on_the_run")
			{
				killer_candidates.push(bro);
			}
		}

		local bro;

		if (anatomist_candidates.len() > 0)
		{
			bro = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
			this.m.Anatomist = bro;
			this.m.Talkers.push(bro);
		}

		if (cultist_candidates.len() > 0)
		{
			bro = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
			this.m.Cultist = bro;
			this.m.Talkers.push(bro);
		}

		if (monk_candidates.len() > 0)
		{
			bro = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
			this.m.Monk = bro;
			this.m.Talkers.push(bro);
		}

		if (mercenary_candidates.len() > 0)
		{
			bro = mercenary_candidates[this.Math.rand(0, mercenary_candidates.len() - 1)];
			this.m.Mercenary = bro;
			this.m.Talkers.push(bro);
		}

		if (swordmaster_candidates.len() > 0)
		{
			bro = swordmaster_candidates[this.Math.rand(0, swordmaster_candidates.len() - 1)];
			this.m.Swordmaster = bro;
			this.m.Talkers.push(bro);
		}

		if (minstrel_candidates.len() > 0)
		{
			bro = minstrel_candidates[this.Math.rand(0, minstrel_candidates.len() - 1)];

			do
			{
				this.m.OtherBro = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (this.m.OtherBro == null || this.m.OtherBro.getID() == bro.getID());

			this.m.Minstrel = bro;
			this.m.Talkers.push(bro);
		}

		if (killer_candidates.len() > 0)
		{
			bro = killer_candidates[this.Math.rand(0, killer_candidates.len() - 1)];
			this.m.Killer = bro;
			this.m.Talkers.push(bro);
		}

		if (this.m.Talkers.len() <= 0)
		{
			this.m.Score = 0;
		}
		else
		{
			this.m.Score = 3 * this.m.Talkers.len();
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist != null ? this.m.Anatomist.getNameOnly() : ""
		]);
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"mercenary",
			this.m.Mercenary != null ? this.m.Mercenary.getNameOnly() : ""
		]);
		_vars.push([
			"swordmaster",
			this.m.Swordmaster != null ? this.m.Swordmaster.getNameOnly() : ""
		]);
		_vars.push([
			"minstrel",
			this.m.Minstrel != null ? this.m.Minstrel.getNameOnly() : ""
		]);
		_vars.push([
			"othersellsword",
			this.m.OtherBro != null ? this.m.OtherBro.getNameOnly() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Talkers = [];
		this.m.Anatomist = null;
		this.m.Cultist = null;
		this.m.Monk = null;
		this.m.Mercenary = null;
		this.m.Swordmaster = null;
		this.m.Minstrel = null;
		this.m.OtherBro = null;
		this.m.Killer = null;
	}

});

