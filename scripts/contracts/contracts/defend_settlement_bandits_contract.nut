this.defend_settlement_bandits_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Reward = 0,
		Kidnapper = null,
		Militia = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.defend_settlement_bandits";
		this.m.Name = "保卫城镇";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 700 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保卫 %townname% 及其郊区免受掠夺"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local nearestBandits = this.Contract.getNearestLocationTo(this.Contract.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getSettlements());
				local nearestZombies = this.Contract.getNearestLocationTo(this.Contract.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());

				if (nearestZombies.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= 20 && nearestBandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) > 20)
				{
					this.Flags.set("IsUndead", true);
				}
				else
				{
					local r = this.Math.rand(1, 100);

					if (r <= 20)
					{
						this.Flags.set("IsKidnapping", true);
					}
					else if (r <= 40)
					{
						if (this.Contract.getDifficultyMult() >= 0.95)
						{
							this.Flags.set("IsMilitia", true);
						}
					}
					else if (r <= 50 || this.World.FactionManager.isUndeadScourge() && r <= 70)
					{
						if (nearestZombies.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= 20)
						{
							this.Flags.set("IsUndead", true);
						}
					}
				}

				local number = 1;

				if (this.Contract.getDifficultyMult() >= 0.95)
				{
					number = number + this.Math.rand(0, 1);
				}

				if (this.Contract.getDifficultyMult() >= 1.1)
				{
					number = number + 1;
				}

				local locations = this.Contract.m.Home.getAttachedLocations();
				local targets = [];

				foreach( l in locations )
				{
					if (l.isActive() && !l.isMilitary() && l.isUsable())
					{
						targets.push(l);
					}
				}

				number = this.Math.min(number, targets.len());
				this.Flags.set("ActiveLocations", targets.len());

				for( local i = 0; i != number; i = ++i )
				{
					local party;

					if (this.Flags.get("IsUndead"))
					{
						party = this.Contract.spawnEnemyPartyAtBase(this.Const.FactionType.Zombies, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else
					{
						party = this.Contract.spawnEnemyPartyAtBase(this.Const.FactionType.Bandits, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}

					party.setAttackableByAI(false);
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local t = this.Math.rand(0, targets.len() - 1);

					if (i > 0)
					{
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(4.0 * i);
						c.addOrder(wait);
					}

					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(targets[t].getTile());
					c.addOrder(move);
					local raid = this.new("scripts/ai/world/orders/raid_order");
					raid.setTime(40.0);
					raid.setTargetTile(targets[t].getTile());
					c.addOrder(raid);
					targets.remove(t);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(false);
			}

			function update()
			{
				if (this.Contract.m.UnitsSpawned.len() == 0 || this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyGone = true;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 1200.0)
						{
							isEnemyGone = false;
							break;
						}
					}

					if (isEnemyGone)
					{
						if (this.Flags.get("HadCombat"))
						{
							this.Contract.setScreen("ItsOver");
							this.World.Contracts.showActiveContract();
						}

						this.Contract.setState("Return");
						return;
					}
				}

				if (!this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyHere = false;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 700.0)
						{
							isEnemyHere = true;
							break;
						}
					}

					if (isEnemyHere)
					{
						this.Flags.set("IsEnemyHereDialogShown", true);

						foreach( id in this.Contract.m.UnitsSpawned )
						{
							local p = this.World.getEntityByID(id);

							if (p != null && p.isAlive())
							{
							}
						}

						if (this.Flags.get("IsUndead"))
						{
							this.Contract.setScreen("UndeadAttack");
						}
						else
						{
							this.Contract.setScreen("DefaultAttack");
						}

						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("IsKidnapping") && !this.Flags.get("IsKidnappingInProgress") && this.Contract.m.UnitsSpawned.len() == 1)
				{
					local p = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);

					if (p != null && p.isAlive() && !p.isHiddenToPlayer() && !p.getController().hasOrders())
					{
						local c = p.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
						this.Contract.m.Kidnapper = this.WeakTableRef(p);
						this.Flags.set("IsKidnappingInProgress", true);
						this.Flags.set("KidnappingTooLate", this.Time.getVirtualTimeF() + 60.0);
						this.Contract.setScreen("Kidnapping1");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Kidnapping");
					}
				}

				if (this.Flags.get("IsMilitia") && !this.Flags.get("IsMilitiaDialogShown"))
				{
					this.Flags.set("IsMilitiaDialogShown", true);
					this.Contract.setScreen("Militia1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

			function onCombatVictory( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

		});
		this.m.States.push({
			ID = "Kidnapping",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"营救被劫走的俘虏",
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(false);

				if (this.Contract.m.Kidnapper != null && !this.Contract.m.Kidnapper.isNull())
				{
					this.Contract.m.Kidnapper.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Kidnapper == null || this.Contract.m.Kidnapper.isNull() || !this.Contract.m.Kidnapper.isAlive())
				{
					if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() <= 5.0)
					{
						this.Flags.set("IsKidnapping", false);
						this.Contract.setScreen("Kidnapping2");
					}
					else
					{
						this.Contract.setScreen("Kidnapping3");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (this.Contract.m.Kidnapper.isHiddenToPlayer() && this.Time.getVirtualTimeF() > this.Flags.get("KidnappingTooLate"))
				{
					this.Contract.setScreen("Kidnapping3");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

			function onCombatVictory( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(true);

				if (this.Contract.m.Kidnapper != null && !this.Contract.m.Kidnapper.isNull())
				{
					this.Contract.m.Kidnapper.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local locations = this.Contract.m.Home.getAttachedLocations();
					local numLocations = 0;

					foreach( l in locations )
					{
						if (l.isActive() && !l.isMilitary() && l.isUsable())
						{
							numLocations = ++numLocations;
						}
					}

					if (numLocations == 0 || this.Flags.get("ActiveLocations") - numLocations >= 2)
					{
						if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
						{
							this.Contract.setScreen("Failure2");
						}
						else
						{
							this.Contract.setScreen("Failure1");
						}
					}
					else if (this.Flags.get("ActiveLocations") - numLocations >= 1)
					{
						if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
						{
							this.Contract.setScreen("Success4");
						}
						else
						{
							this.Contract.setScreen("Success2");
						}
					}
					else if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
					{
						this.Contract.setScreen("Success3");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer%在窗边看着外面，向你招手让你过去。%SPEECH_ON%看看那些人。%SPEECH_OFF%楼下有一群人挤在一起，哭哭啼啼。%SPEECH_ON%强盗一直在这一带游荡，人们相信他们将会大规模地攻击我们。%SPEECH_OFF%他拉上窗帘，然后去点蜡烛。他在点燃蜡烛时说话，口气急促。%SPEECH_ON%我们需要你来保护我们，雇佣兵。如果你能阻止这些强盗，你会得到高额的报酬。你有兴趣吗？%SPEECH_OFF% | 几个农民正在房间的外面游荡。你可以听到他们紧张的喊叫声。%employer%倒了一杯酒，手颤抖着喝了一小口。%SPEECH_ON%我来说得清楚一点。我们收到了很多报告，说强盗即将攻击这个城镇。如果你想知道，这些报告是通过死去的妇女和儿童传来的。显然，我们没有理由怀疑这些报告的严重性。那么问题来了，你能保护我们吗？ %SPEECH_OFF% | %employer%正在看他桌子上的一些文件。你坐下来，问他想要什么。%SPEECH_ON%你好，雇佣兵。我认为你会擅长处理这个问题。%SPEECH_OFF%你要求他直接点，他直接启齿。%SPEECH_ON%强盗在城镇外面烧了一些房屋和棚屋，有消息称他们正在准备一个更大、更猛烈的攻击。我需要你在这里阻止他们。你认为你能完成这个任务吗？%SPEECH_OFF% | %employer%正在看着他的书架，背对着你。他沉吟着说话。%SPEECH_ON%不多人能读这些书，真是遗憾。说不定如果他们能读，我们的问题就会消失。或者可能会变得更糟。%SPEECH_OFF%他摇了摇头，转过身来。%SPEECH_ON%我们有一群强盗即将降临在我们身上。我需要你，雇佣兵，来阻止他们。我的书肯定不会。如果酬劳合适，我保证会，你有兴趣吗？%SPEECH_OFF% | %employer%手里拿着两张纸，上面画着脸。%SPEECH_ON%我们这些天抓住了这两个人。绞死他们，把遗骸烧了。%SPEECH_OFF%你耸了耸肩。%SPEECH_ON%恭喜？%SPEECH_OFF%这个人不是很高兴。%SPEECH_ON%现在我们得到消息，说他们的强盗朋友要来向我们报仇！是的，我们需要你的帮助来击退他们。你有兴趣吗？%SPEECH_OFF% | %employer%在屋子里安顿好了，坐下来，用手揉着木框。这是一棵好的橡木树。一棵值得坐在上面的树。%SPEECH_ON%很高兴你感到舒适，雇佣兵，但我肯定不会。我们有很多，很多警告说，一大群强盗即将袭击我们的城镇。我们缺乏防御力量，但不缺乏克朗。显然，这就是你要来的地方。你有兴趣吗？%SPEECH_OFF% | %employer%一杯酒狠狠地摔在了墙上。它散开来，转动着，葡萄酒的斑点洒在你的脸上。%SPEECH_ON%流浪汉！强盗！劫掠者！永远没有尽头！%SPEECH_OFF%他不经意地递给了你一块餐巾。%SPEECH_ON%现在我得到消息，这些暴徒的大群人即将烧毁这个城镇！好吧，我有了一个方法来应对他们：你。你说，雇佣兵？你愿意保护我们吗？%SPEECH_OFF% | 几个悲伤的妇女在%employer%的房间外哭泣。他转向你。%SPEECH_ON%听到了吗？这就是强盗来到这里时会发生的事情。他们偷窃，他们强奸，他们杀人。%SPEECH_OFF%你点点头。毕竟，这就是强盗的方式。%SPEECH_ON%现在，蜜月村的一些农民说，这些暴徒正在准备一场大规模的攻击。你必须做点什么来帮助我们，雇佣兵。哦，当然我说“必须”，我真正的意思是我们会付钱给你来帮助我们......%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{%townname%为了他们的安全准备好付出多少代价？ | 这对你来说应该值不少克朗，对吧?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{恐怕你要一个人了。 | 我们有更重要的事情要做。 | 我祝你好运，但我们不会参与其中。}",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 60)
						{
							this.World.Contracts.removeContract(this.Contract);
							return 0;
						}
						else
						{
							return "Plea";
						}
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Plea",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_43.png[/img]{当你拒绝%employer%时，走出来发现一群农民站在外面。每个人都拿着一些奇怪的东西，这是凡人尽其所能所能拼凑出来的财富：鸡，廉价的项链，破旧的衣服，生锈的铁匠工具，财物清单不胜枚举。一个人走了出来，腋下夹着一只鸡。%SPEECH_ON%求求你了！你不能离开！你必须帮助我们！%SPEECH_OFF%%randombrother% 笑了笑，但你不得不承认，穷人们确实知道如何打动人心。也许你应该留下来帮忙？ | 当你离开%employer%时，走到外面，发现一个女人站在那里，身边有一群小孩在她脚下跑来跑去，还有一个宝宝在吸它的奶头。%SPEECH_ON%雇佣兵，拜托你，你不能这样离开我们！这个城镇需要你！孩子需要你！%SPEECH_OFF%她停了一下，然后放下了衬衫的另一边，露出了一种相当淫荡而诱人的诱惑。%SPEECH_ON%我需要你......%SPEECH_OFF%你赶紧抬起一只手，既是为了阻止她，也是为了擦拭你突然出现的汗水。也许帮助这对......可怜的人也不错？ | 在离开%townname%之前，一只小狗飞快地冲上来，又叫又舔你的靴子，而一个更小的孩子则在追逐，几乎顺着它的尾巴就撞上了。孩子扑倒在狗身上，抱紧了它蓬松的毛发。%SPEECH_ON%哦，{马利 | 耶拉 | 乔乔}，我非常爱你！%SPEECH_OFF%你脑海中出现了强盗屠杀小孩和宠物的画面。你有更好的事情要做，而狗继续舔孩子的脸，孩子看起来很开心。%SPEECH_ON%哈哈！我们会永远永远活着，不是吗？永远永远！%SPEECH_OFF%他妈的。 | 当你离开%employer%的住所时，一个男人走到你面前。%SPEECH_ON%先生，我听说你拒绝了那个家伙的提议。很遗憾，这就是我想说的一切。我还以为这个世界有很多好人，但我想我是错了。愿你一路顺风，并希望你在旅途中为我们祈祷。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = false,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{该死，我们不能让这些人死去。 | 好吧，好吧，我们不会离开 %townname%。至少让我们谈论一下报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{我相信你能挺过去的。让开。 | 我不会冒险去救一些挨饿的农民，况且不能让%companyname%冒险。}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "UndeadAttack",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_29.png[/img]{当你站岗时，一个疯狂的农民冲上来。他满脸丧气，喘不过气来。手扶着膝盖，他差点喘不出话来：%SPEECH_ON%死人……他们来了！%SPEECH_OFF%向他望去，你确实看到了一群相当苍白的生物在远处蹒跚而来。 | 这里没有土匪，但有不死亡者！当你在等待歹徒和罪犯们冲进小镇时，你看到了一群蹒跚而来的生物。目标可能改变，但合同不变——做好准备！ | 教堂的警报铃声响起。你听着它们，眺望远方。它们一直在响。当地的一个人站在你身边。%SPEECH_ON%一…… 二…… 三声…… 四…… %SPEECH_OFF%他开始出汗。然后，钟声响起，他的眼睛睁大了。%SPEECH_ON%不可能吧。%SPEECH_OFF%你询问他在害怕什么。他往后退了。%SPEECH_ON%死人又在复活！%SPEECH_OFF%太好了，就在你以为这个合同会很容易的时候。 | 不停地呻吟，蹒跚走来的不死亡者出现了。这里没有土匪——也许这些恶心的生物吃掉了他们——但合同没有作废：保护小镇！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DefaultAttack",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_07.png[/img]强盗已经出现！准备战斗，保护城镇！",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOver",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束，士兵们在喘息中闲逛。%employer%将会等着你回城。 | 战争结束后，你们查看着战场上的尸体。这是一个令人毛骨悚然的场面，但出于某种原因，它激励了你的能量。恶略的死亡群丘只是提醒你尚未向这可怕的世界屈服。像%employer%这样的人应该来看看，但他不会来，所以你得去找他。 | 战场上散布着肉和骨头，几乎无法从一个人的主人之间辨别。黑色的秃鹫盘旋在头顶上，尖端阴影的光环在死人身上起伏，它们等待哀悼者清理出来。%randombrother%来到你的身边，问他们是否应该开始返回%employer%了。你离开了战场的景象，点点头。 | 死亡让人产生一种和平的毁灭感。好像这是它们的自然状态，僵硬并永远失去了，他们的整个生命只不过是一个短暂而漏洞百出的末日事件。%randombrother%过来问你是否还好。说实话，你不太确定，只回答说是时候去见%employer%了。 | 扭曲畸形的尸体散布在地上，战斗使死亡无法统治如何最终安息。没有身体的头最安和，因为在战斗中，没有人类或野兽有时间真正砍掉脖子，它只是通过最快和最锋利的剑挥舞。你希望其中一部分可以用这种即时的终极方式去，但另一部分希望你有机会将你的杀手拉下去。\n\n%randombrother%来到你身边，询问是否有命令。你转身离开战场，告诉%companyname%准备好回去见%employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们回市政厅！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOverDidNothing",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_30.png[/img]烟雾弥漫在空气中，烟和燃烧的木头，燃烧的生计的腐蚀性气味。%townname%的人们将所有希望寄托在雇佣%companyname%上，这是致命的错误。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "计划走了偏路...",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]{在准备保卫%townname%的过程中，当地的民兵已经归附于你的一方。他们会遵从你的命令，并询问你将他们派往最需要的地方。 | 看起来当地的民兵已经加入了战斗！虽然这是一支杂乱无章的农民队伍，但是他们仍然会有所作为。现在的问题是，要将他们派往哪里？ | %townname% 的民兵已经加入了战斗！虽然是一支装备简陋、武器不好的部队，但是他们非常渴望保护家园。他们会遵从你的命令，并信任你将他们派往最需要的地方。 | 你并不是孤军奋战！%townname%的民兵已经加入了你们。他们热切希望参战，并询问你将他们派往哪里他们可以发挥最大的作用。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "排好队，你将听从我的指挥。",
					function getResult()
					{
						return "Militia2";
					}

				},
				{
					Text = "前往保卫%townname%的市政厅。",
					function getResult()
					{
						local home = this.Contract.m.Home;
						local party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(home.getTile(), home.getName() + " Militia", false, this.Const.World.Spawn.Militia, home.getResources() * 0.7);
						party.getSprite("banner").setBrush(home.getBanner());
						party.setDescription("勇敢的人用生命保卫家园。农夫、工匠、技工，但没有一个真正的士兵。");
						party.setFootprintType(this.Const.World.FootprintsType.Militia);
						this.Contract.m.Militia = this.WeakTableRef(party);
						local c = party.getController();
						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(home.getTile());
						guard.setTime(300.0);
						local despawn = this.new("scripts/ai/world/orders/despawn_order");
						c.addOrder(guard);
						c.addOrder(despawn);
						return 0;
					}

				},
				{
					Text = "去保卫%townname%的郊区。",
					function getResult()
					{
						local home = this.Contract.m.Home;
						local party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(home.getTile(), home.getName() + " Militia", false, this.Const.World.Spawn.Militia, home.getResources() * 0.7);
						party.getSprite("banner").setBrush(home.getBanner());
						party.setDescription("勇敢的人用生命保卫家园。农夫、工匠、技工，但没有一个真正的士兵。");
						party.setFootprintType(this.Const.World.FootprintsType.Militia);
						this.Contract.m.Militia = this.WeakTableRef(party);
						local c = party.getController();
						local locations = home.getAttachedLocations();
						local targets = [];

						foreach( l in locations )
						{
							if (l.isActive() && !l.isMilitary() && l.isUsable())
							{
								targets.push(l);
							}
						}

						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(targets[this.Math.rand(0, targets.len() - 1)].getTile());
						guard.setTime(300.0);
						local despawn = this.new("scripts/ai/world/orders/despawn_order");
						c.addOrder(guard);
						c.addOrder(despawn);
						return 0;
					}

				},
				{
					Text = "去躲起来，别挡路。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia2",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]现在你决定要指挥当地人，他们问你如何为即将到来的战斗武装自己。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿上弓，你会从后方进行射击。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest_ranged");
							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				},
				{
					Text = "拿上剑和盾，你将在前线战斗。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest");
							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				},
				{
					Text = "你们可以随意武装。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia;

							if (this.Math.rand(0, 1) == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest");
							}
							else
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest_ranged");
							}

							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "MilitiaVolunteer",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]{战斗结束后，一名参与防御的民兵亲自来找你，弯腰递上他的剑。%SPEECH_ON%队长，我与%townname%镇的时间已经结束，但%companyname%的能力真的是令人惊叹的。如果有机会，队长，我愿意和您以及您的士兵并肩作战。%SPEECH_OFF% | 随着战斗的结束，来自%townname%的一名民兵表示他愿意为%companyname%而战。部分原因是他对雇佣兵团的战斗印象深刻，部分原因是被征召到镇上的防御既没有经济效益也不健康。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "欢迎加入 %companyname%！",
					function getResult()
					{
						return 0;
					}

				},
				{
					Text = "这里不适合你。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping1",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_30.png[/img]{当你正在警戒着强盗时，一个农民走了过来，告诉你一群暴徒袭击附近，夺走了一群人质。你不敢相信。他们怎么能偷偷摸摸地干这事呢？这位平民也摇了摇头。 %SPEECH_ON%我还以为你们能帮助我们。你们怎么什么都没做？%SPEECH_OFF% 你问强盗们去了多远。 农民摇了摇头。看起来你们还有机会把他们救回来。 | 一个穿着破布，手拿破叉的男子跑到你的战团面前。他跌倒在你的脚边，绝望地哭泣。%SPEECH_ON%强盗袭击了！你们在哪？他们屠杀人民……焚烧了一些人……他们抓走了一些人质！请去救他们！%SPEECH_OFF% 你看着%randombrother%，点了点头。%SPEECH_ON%准备好你们的人，我们需要追捕这些强盗，在他们逃跑之前抓住他们。%SPEECH_OFF% | 你的视线扫视着地平线，寻找着流浪者或小偷的任何迹象或声响。突然间，%randombrother%带着一个女人走到你身边。她说了一个故事，说强盗已经袭击了，杀了大量农民，他们没有杀死的人就被他们带走了。雇佣兵点了点头。%SPEECH_ON%看起来他们溜过我们了，长官。%SPEECH_OFF%现在你只有一个选择-让这些人回来！ | 你站在%townname%附近，预计强盗的袭击。你以为这会很容易，但突然出现了一个疯狂的平民，说明情况并非如此。农民解释说，掠夺者和暴徒已经袭击了外围。他们屠杀了他们能够杀的人，然后带走了几个男人、女人和孩子。这人要么是醉酒了，要么是受到了惊吓，说话无力。%SPEECH_ON%请把他们找回来，好吗？%SPEECH_OFF% | 正在警戒着时，一些愤怒的农民沿着道路走来，带着愤怒的情绪围绕你旋转。%SPEECH_ON%我原以为我们雇你们来保护我们的！你们在哪里！%SPEECH_OFF%他们浑身沾满鲜血，有些只穿了一半衣服。一名妇女胸部裸露，太生气了，不在意这种不检点的行为。你问这群人在说什么。一个抱紧手杖的男人解释说，袭击者和暴徒已经袭击了附近的一个小村庄。他们杀了所有人，之后由于他们的血腥已得到了满足，他们尽可能带走了许多以人质为目标的人。\n\n你点了点头。%SPEECH_ON%我们会救他们回来的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "抓住他们！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你收起了剑，命令%randombrother%去释放囚犯。一群困惑的农民从皮绳，铁链和狗笼中被解救出来。他们感谢你及时的到来，以及你给予强盗的制裁。 | 强盗人人被杀。你命令战团去营救每个他们能找到的农民。他们欢聚一堂，互相拥抱，哭泣，为自己能活下来而疯狂地高兴。 | 杀完最后一个强盗，你命令战团去解救流浪汉抓走的人质。他们每个人依次感谢你，有些人亲吻你的手，有些人亲吻你的脚。你只告诉他们回到%townname%，你也会很快赶到。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "看起来这结束了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping3",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_53.png[/img]{不幸的是，土匪们带着人质逃跑了。愿神保佑那些可怜的灵魂。 | 你做不到——你救不了那些可怜的农民。现在只有神知道他们会发生什么。 | 可悲的是，掠夺者带着他们的人类货物逃跑了。那些可怜的人现在必须自谋生路。你听到的故事，告诉你他们将一无所获。 | 土匪们逃走了，他们的俘虏和他们在一起。你不知道那些人现在会发生什么事，但你知道那不是什么好事。奴役。酷刑。死亡。你不确定哪个是最糟糕的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{%townname%的人不会喜欢这个…… | 或许他们能被买回来……}",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到%employer%面前，一脸得意。%SPEECH_ON%任务完成了。%SPEECH_OFF%他点头，边倒酒边看着你，但并未真正赐酒。%SPEECH_ON%是的，镇上对你的帮助感激不尽。他们也做好了金钱上的奖励。%SPEECH_OFF%他向房间的一个角落招了招手，你看到一个装满克朗的袋子。%SPEECH_ON%%reward%克朗，我们之前商定过了。再次感谢你，佣兵。%SPEECH_OFF% | %employer%端着一杯酒欢迎你的回来。%SPEECH_ON%好好喝酒，佣兵，你赚到了。%SPEECH_OFF%这杯酒的味道很独特。傲慢，如果那能成为一种味道的话。你的雇主欣喜若狂地在办公桌周围转了几圈，庆祝你的成功。%SPEECH_ON%你兑现了你的承诺，保护了这个城镇！太棒了！%SPEECH_OFF%他点头，将酒杯向一个木箱子招手并说%SPEECH_ON%印象最深刻。%SPEECH_OFF%你打开箱子，发现里面装满克朗。 | %employer%欢迎你来到他的房间。%SPEECH_ON%你知道吗？我就从窗口看着这一切，或者说是看了大部分。好的部分，我想。%SPEECH_OFF%你扬起了一只眉毛。%SPEECH_ON%哦，别那样看着我。我并不觉得为喜欢我所看到的东西而感到内疚。我们还活着，不是吗？我们是好人。%SPEECH_OFF%另一只眉毛也随之而上。%SPEECH_ON%不管怎样，像承诺的一样付给你报酬。%SPEECH_OFF%那人递给你一只装满%reward%克朗的宝箱。 | 当你回到%employer%那里时，你发现他的房间几乎已经被打包好了，所有东西都准备好搬走了。你有些幽默地表达了一些关切。%SPEECH_ON%要出去走走吗？%SPEECH_OFF%那人坐到椅子上。%SPEECH_ON%我曾经怀疑你，佣兵。你能怪我吗？不过话说回来，你不应该质疑我支付报酬的能力。%SPEECH_OFF%他在桌子上挥了一下手。在角落里有一个口袋，里面塞满了硬币。%SPEECH_ON%像承诺的一样，%reward%克朗。%SPEECH_OFF% | 你进入房间后，%employer% 从椅子上站起身，虽然有些不可思议，但也非常诚恳地鞠躬，然后他指向窗外快乐的农民的喧闹声。%SPEECH_ON%你听到了吗？雇佣兵，这是你耕耘得来的。这里的人民现在爱你了。%SPEECH_OFF%，你点了点头，但平民的爱并不是你来这里的目的。%SPEECH_ON%我还赚到了什么？%SPEECH_OFF%，%employer% 微笑着。%SPEECH_ON%是点燃斗志的前锋。我敢打赌这是你的……优势。当然，你也赚到了这个。%SPEECH_OFF%他把一个木箱子放在桌子上，打开了它。黄金克朗的闪光温暖了你的内心。 | %employer% 正凝视着窗外，当你进来时。他几乎陶醉了，低头看着自己的手。你打断了他的思绪。%SPEECH_ON%想着我了吗？%SPEECH_OFF%他笑了笑，玩笑地捂住了自己的胸口。%SPEECH_ON%你真是我梦中的男人，雇佣兵。%SPEECH_OFF%他穿过房间，从书架上拿了一个箱子。他把它放在桌子上并打开了它。一堆金克朗在你面前闪耀。%employer% 微笑着。%SPEECH_ON%现在谁在做梦呢？%SPEECH_OFF% | 当你进入时，%employer%正坐在他的桌前。%SPEECH_ON%我看到了很多。杀戮，死亡。%SPEECH_OFF%你找了个座位。%SPEECH_ON%希望你享受了演出。不过看戏也是要付费的。%SPEECH_OFF%这个人点点头，拿出一个包袱递给你。%SPEECH_ON%我会为再次表演付款，但我不确定%townname%是否想让这件事发生。%SPEECH_OFF% }",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{%companyname%会好好利用这个。 | 辛苦工作的报酬。}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "保卫小镇抵御强盗");
						this.World.Contracts.finishActiveContract();

						if (this.Flags.get("IsUndead") && this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer%看见你回来了，指向他窗外。%SPEECH_ON%你看到了吗？远处那里。%SPEECH_OFF%你走到他身边。他问道。%SPEECH_ON%你看到了什么？%SPEECH_OFF%远处有浓烟。你告诉他这就是你看到的。%SPEECH_ON%对了，烟。我不是雇你来让土匪们制造狼烟的，懂吗？当然，城镇大部分地方还站立得起来……%SPEECH_OFF%他把一个挎包往你怀里一甩。%SPEECH_ON%做得好，雇佣兵。只是……还不够好。%SPEECH_OFF% | 你回到%employer%的身边。他看上去既高兴，又伤感，有点像醉汉又像清醒。这不是你想看到的表情。%SPEECH_ON%你干得好，雇佣兵。消息传开，你彻底击溃了那些土匪。消息也传开了，他们烧毁了我们的外围区域的一些地方。%SPEECH_OFF%你点点头，无法掩盖不能掩盖的事实。%SPEECH_ON%你会得到报酬，但是你必须明白，重建那些地区需要花费一定的费用。很明显，克朗要来自你的口袋……%SPEECH_OFF% | 当你回来的时候，%employer%伏在他的座位上。%SPEECH_ON%%townname%的大部分人都很高兴，但是有些人不是。你能猜到哪些人不是吗？%SPEECH_OFF%土匪们确实设法摧毁了郊区的一些地方，但这是一个修辞问题。%SPEECH_ON%我需要资金来帮助重建那些掠夺者设法占领的疆土。我相信你明白，为什么你会收到更少的薪水……%SPEECH_OFF%你耸了耸肩。事实就是如此。 | %employer%在他的书架旁。他拿起一本书，转身打开，一气呵成。他把书放到桌子上。%SPEECH_ON%那里有数字。我知道你看得懂，但这是什么意思：土匪们设法摧毁了这个城镇的部分地区，现在我需要金克朗来帮助重建。不幸的是，我手头没有那么多的金克朗。我相信你明白这种困境。%SPEECH_OFF%你点点头，说出了显而易见的事实。%SPEECH_ON%我的薪水要受到影响。%SPEECH_OFF%这个人点点头，在桌子上滑过一个打开的手，引起了你的注意，有一个挎包。争论薪水没有任何意义。你拿起袋子，离开了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor, "保卫小镇抵御强盗");
						this.World.Contracts.finishActiveContract();

						if (this.Flags.get("IsUndead") && this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到了%employer%那里，看起来自满得很。%SPEECH_ON%任务完成了。%SPEECH_OFF%他点了点头，一边斟着酒杯，一边不一定要把它递给你。%SPEECH_ON%是的，镇上非常感激你的帮助。他们也给了你……物质上的感激之情。%SPEECH_OFF%这个人指向房间的一个角落。你看见那儿有一个克朗的小包。%SPEECH_ON%正如我们约定的那样，%reward%个克朗。再次感谢你，佣兵。噢，对了，那些农民的事情真是遗憾。%SPEECH_OFF% | %employer%拿着酒杯欢迎你的归来。%SPEECH_ON%喝完吧，佣兵，你赢得了它。%SPEECH_OFF%酒味道有点儿……奇怪。像是自命不凡的味道。你的雇主围绕着办公桌转了一圈，高兴得咯咯直笑。%SPEECH_ON%你成功保护了镇子，就像你承诺的那样！我非常佩服。%SPEECH_OFF%他点头，向一个木箱子饶有兴致地挥了一下酒杯。%SPEECH_ON%非常佩服。%SPEECH_OFF%你打开箱子，发现里面塞满了黄金克朗。%SPEECH_ON%那些被绑架的农民真让人遗憾。我已经做些调整……%SPEECH_OFF% | %employer%欢迎你进入他的房间。%SPEECH_ON%你知道吗？我从窗户看到了一切，或者说看到了大部分。好的部分，我想。%SPEECH_OFF%你挑起眉毛。%SPEECH_ON%哦，别这样看着我。我并不因为享受所看到的东西而感到内疚。我们还活着，不是吗？我们是好人。%SPEECH_OFF%另一个眉毛也跟着上去了。%SPEECH_ON%无论如何，你的酬金如约兑现了。我听到有几个农民被掳走了。我做了一些扣除。这笔钱将用于幸存者。%SPEECH_OFF%这个人递上了一箱%reward%克朗。 | 当你回到%employer%那里时，你会发现他的房间几乎已经收拾好了，一切都准备好了可以走了。你有点幽默地表达了一些关切。%SPEECH_ON%准备去哪里吗？%SPEECH_OFF%那个人坐回了椅子上。%SPEECH_ON%我曾经怀疑过，雇佣兵，你能怪我吗？不过话说回来，你不需要怀疑我支付的能力。%SPEECH_OFF%他在桌子上挥了挥手。在角落里有一个小包，里面塞满了硬币。%SPEECH_ON%比约定的少几个克朗。你知道那些强盗掳走的农民会发生什么吗？是啊，我扣除你的酬金也是有原因的。%SPEECH_OFF% | 当你进入时，%employer% 从他的椅子上站起来。他有些难以置信地鞠躬，但也非常真诚。他把头转向窗户，那里是快乐的农民喃喃自语的喧嚣声。%SPEECH_ON%你听到了吗？雇佣兵，你赢得了这一切。这里的人们现在爱你了。%SPEECH_OFF%你点了点头，但普通人的爱并不是你来到这里的原因。%SPEECH_ON%还有什么是我赢得的吗？%SPEECH_OFF%%employer%微笑着。%SPEECH_ON%一个指挥官，那一定是给了你优势。当然，你也赢得了这个。少一些点。你让盗匪带走了那些农民的事情非常糟糕，不是吗？%SPEECH_OFF%他把一个木箱子放到他的桌子上并打开了它。闪耀的金克朗令你的心情愉悦。 | 当你进来的时候，%employer%正在窗外凝视。他几乎处于梦境状态，低头靠在手上。你打断了他的思绪。%SPEECH_ON%想起我了？%SPEECH_OFF%他笑了笑，玩笑地握紧了胸口。%SPEECH_ON%你真的是我的梦中情人，雇佣兵。%SPEECH_OFF%他穿过房间，从书架上取下一个箱子。他把它放在桌子上打开。一堆辉煌的克朗金币出现在你面前。%employer%露出了笑容，但也很快消失了。%SPEECH_ON%比你预期的要少一点？那些乡下人家庭的幸存亲属将得到这部分金币。我相信你能理解。%SPEECH_OFF% | 当你进来的时候，%employer%正坐在他的办公桌旁。%SPEECH_ON%我看到了很多，杀戮，死亡。%SPEECH_OFF%你坐下来。%SPEECH_ON%希望你喜欢这个表演。但是欣赏可不是免费的。%SPEECH_OFF%这个人点了点头，拿了一个小包递给你。%SPEECH_ON%我想再来一场表演，但我不确定%townname%想要那样做。当然了，那些被袭击者抓走的可怜人不想要他们得到的东西。%SPEECH_OFF%你看了一眼袋子，发现里面的克朗金币比预期要少。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor, "保卫小镇抵御强盗");
						this.World.Contracts.finishActiveContract();

						if (this.Flags.get("IsUndead") && this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success4",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer%通过窗户欢迎你的归来。%SPEECH_ON%你看到了吗？远处那里。%SPEECH_OFF%你走到他身边。他问道。%SPEECH_ON%你看到了什么？%SPEECH_OFF%地平线上有浓烟。你告诉他这就是你看到的。%SPEECH_OFF%对，浓烟。我不是雇你让那些土匪卷走了吗？当然......大部分城镇仍然站立着......%SPEECH_OFF%他把一个背包甩到你的胸口。%SPEECH_ON%干得好，雇佣兵。只是......不够好。还有那些可怜的农民被那些可恶的土匪带走真是太遗憾了。%SPEECH_OFF% | 你回到%employer%身边，他看起来既高兴又悲伤，不知道是醉了还是清醒。这不是你想看到的表情。%SPEECH_ON%做得好，雇佣兵。听说你把土匪们打得十分凶猛。也听说他们烧毁了我们的城外一些地方。%SPEECH_OFF%你点点头。没有必要掩盖你掩盖不了的事实。%SPEECH_ON%你会得到报酬，但是你必须了解这需要花费金钱来重建那些地区。那些你没能拯救的可怜人还要得到援助。显然，这些钱将从你的口袋里掏出来......%SPEECH_OFF% | 当你返回时，%employer%在他的椅子上。%SPEECH_ON%大部分%townname%的人都高兴，但少数人不高兴。你猜猜那些人是谁？%SPEECH_OFF%土匪们确实设法摧毁了城外的一些地区，但这是个修辞性问句。%SPEECH_ON%我需要资金来帮助重建那些掠夺者设法抢到的领土。我也需要一些钱来帮助那些你未能拯救的农民的幸存者。我相信你明白，为什么你将获得较少的报酬......%SPEECH_OFF%你耸耸肩。是什么就是什么吧。 | %employer%在书架旁边，他拿起一本书，一动作打开它。他把它放在桌子上。%SPEECH_ON%书上有数字。我想你肯定看不懂，但这是什么意思：土匪破坏了这个城镇的一部分，现在我需要钱来帮助重建。不幸的是，我手头没有那么多金币来做到这一点。我相信你明白这种困境。%SPEECH_OFF%你点点头，说了一个显而易见的事实。%SPEECH_ON%这会从我的工资中扣除。那些你让土匪们抱走的农民？他们有家人。幸存者。他们也会得到我们的“协议”一部分。%SPEECH_OFF%这个人点点头，将一只手从他的桌子上滑过去，引起了你对一个背包的注意。没必要争论工资。你拿了背包离开了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(0);
						this.World.Contracts.finishActiveContract();

						if (this.Flags.get("IsUndead") && this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{当你进入%employer%的房间时，他告诉你关上门。就在门闩发出声响的那一刻，他对你进行了一连串的骂人，你根本无法跟上。平静下来后，他的声音和说话的语言恢复了一些正常水平。%SPEECH_ON%所有我们城镇的外围都被摧毁了。你想，我究竟是为什么付你钱的？滚蛋！%SPEECH_OFF% | %employer%当你进入时在猛灌酒。他的窗外有愤怒的农民的声音。%SPEECH_ON%听到了吗？如果我付你的钱，他们会要我的命的，雇佣兵。你只有一个工作，一个！保护这个城镇。但你做不到。因此，你现在可以免费做一件事：快滚！%SPEECH_OFF% | %employer%把双手放在桌子上。%SPEECH_ON%说说，你到底想得到什么？我很惊讶你居然回到我这里来。半个城镇都在燃烧，另一半已经变成了灰烬。我雇佣你不是为了制造烟雾和废墟，雇佣兵。快滚！%SPEECH_OFF% | 当你回到%employer%的时候，他拿着一杯啤酒。他的手在颤抖。他的脸变红了。%SPEECH_ON%我现在一心只想把这个东西扔到你脸上！%SPEECH_OFF%以防万一，那个人一口气喝完了这杯酒。他将其猛然砸在桌子上。%SPEECH_ON%这个城镇期望你保护他们。但你没有。而强盗却像去旅游一样蜂拥而至外围！我不想让掠夺者得到享乐，雇佣兵。从这里滚蛋！%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{该死的农民！ | 我们需要要求更多的预付款... | 该死的！}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能成功抵御强盗进攻的城镇。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{当你进入%employer%的房间时，他告诉你关上门。就在卡搭一声时，这个人突然对你喋喋不休，你完全无法跟上他的激动节奏。镇静下来后，他的声音和语言回到了一定的正常水平。%SPEECH_ON%我们城外的每一处都被毁了。连人都被带到了老神明知道的哪里！我之前雇佣你干什么了？滚蛋吧。%SPEECH_OFF% | %employer%你进入时正在狂饮酒。窗外愤怒的农民发出了一阵嘈杂的嚎叫声。%SPEECH_ON%听到了吗？如果我付给你钱，他们会杀了我，佣兵。你的职责只有一个，保护这座城镇。但是你没能做到。可恶的是，你甚至没能救出那些被绑架的可怜农民！所以现在只有一件事是免费的：滚出我的视线。%SPEECH_OFF% | %employer%把手放在桌子上。%SPEECH_ON%你到底想在这里得到什么？我甚至对你回来感到惊讶。半个城镇都着火了，另一半已经变成了灰烬。幸存者告诉我他们的家人甚至被绑架了！你知道抢劫者抓到的人会发生什么吗？我不是雇佣你来制造烟雾和荒芜的，佣兵。走开吧。%SPEECH_OFF% | 当你回去找%employer%时，他正在拿着一杯麦芽酒。他的手在颤抖。他的脸变红了。%SPEECH_ON%我现在很想把这个倒在你的脸上。%SPEECH_OFF%为了防止自己的愤怒使自己冲动，他一口气喝完了酒。他重重地放在桌子上。%SPEECH_ON%这个城镇期望你来保护他们。相反，强盗们却像在休闲游又一样地涌上来。我不是为了让掠夺者得到快感而做这件事的，佣兵。滚蛋。%SPEECH_OFF% | %employer%当你走进他的房间时，他大声笑了起来。%SPEECH_ON%城外被毁了。%townname%的人民在骚动，至少那些还活着的人会生气。更何况，你还让我们的几个城镇居民被这些怪物抓走了！%SPEECH_OFF%他摇头，把手指向门口。%SPEECH_ON%我不知道你期望我付给你什么，但不是这个。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{该死的农民！ | 我们需要要求更多的预付款... | 该死的！}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能成功抵御强盗进攻的城镇。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"reward",
			this.m.Reward
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
			s.setValidForDays(4);
			this.m.SituationID = this.m.Home.addSituation(s);
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			this.m.Home.getSprite("selection").Visible = false;

			if (this.m.Kidnapper != null && !this.m.Kidnapper.isNull())
			{
				this.m.Kidnapper.getSprite("selection").Visible = false;
			}

			if (this.m.Militia != null && !this.m.Militia.isNull())
			{
				this.m.Militia.getController().clearOrders();
			}

			this.World.getGuestRoster().clear();
		}
	}

	function onIsValid()
	{
		local nearestBandits = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getSettlements());
		local nearestZombies = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());

		if (nearestZombies.getTile().getDistanceTo(this.m.Home.getTile()) > 20 && nearestBandits.getTile().getDistanceTo(this.m.Home.getTile()) > 20)
		{
			return false;
		}

		local locations = this.m.Home.getAttachedLocations();

		foreach( l in locations )
		{
			if (l.isUsable() && l.isActive() && !l.isMilitary())
			{
				return true;
			}
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.m.Flags.set("KidnapperID", this.m.Kidnapper != null && !this.m.Kidnapper.isNull() ? this.m.Kidnapper.getID() : 0);
		this.m.Flags.set("MilitiaID", this.m.Militia != null && !this.m.Militia.isNull() ? this.m.Militia.getID() : 0);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
		this.m.Kidnapper = this.WeakTableRef(this.World.getEntityByID(this.m.Flags.get("KidnapperID")));
		this.m.Militia = this.WeakTableRef(this.World.getEntityByID(this.m.Flags.get("MilitiaID")));
	}

});

