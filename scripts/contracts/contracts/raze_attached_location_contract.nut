this.raze_attached_location_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Settlement = null
	},
	function setSettlement( _s )
	{
		this.m.Flags.set("SettlementName", _s.getName());
		this.m.Settlement = this.WeakTableRef(_s);
	}

	function setLocation( _l )
	{
		this.m.Destination = this.WeakTableRef(_l);
		this.m.Flags.set("DestinationName", _l.getName());
	}

	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = 0.85;
		this.m.Type = "contract.raze_attached_location";
		this.m.Name = "夷平地点";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		local s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];
		this.m.Destination = this.WeakTableRef(s.getAttachedLocations()[this.Math.rand(0, s.getAttachedLocations().len() - 1)]);
		this.m.Flags.set("PeasantsEscaped", 0);
		this.m.Flags.set("IsDone", false);
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 600 * this.getPaymentMult() * this.getDifficultyMult() * this.getReputationToPaymentMult();

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
					"摧毁了" + this.Flags.get("DestinationName") + "附近" + this.Flags.get("SettlementName")
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
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().get("Betrayed") && this.Math.rand(1, 100) <= 75)
				{
					this.Flags.set("IsBetrayal", true);
				}
				else
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Peasants, this.Math.rand(90, 150));

					if (this.Math.rand(1, 100) <= 25)
					{
						this.Flags.set("IsMilitiaPresent", true);
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Militia, this.Math.min(300, 80 * this.Contract.getScaledDifficultyMult()));
					}
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setFaction(this.Const.Faction.Enemy);
					this.Contract.m.Destination.setAttackable(true);
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsDone"))
				{
					if (this.Flags.get("IsBetrayal"))
					{
						this.Contract.setScreen("Betrayal2");
					}
					else
					{
						this.Contract.setScreen("Done");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onEntityPlaced( _entity, _tag )
			{
				if (_entity.getFlags().has("peasant") && this.Math.rand(1, 100) <= 75)
				{
					_entity.setMoraleState(this.Const.MoraleState.Fleeing);
					_entity.getBaseProperties().Bravery = 0;
					_entity.getSkills().update();
					_entity.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
				}

				if (_entity.getFlags().has("peasant") || _entity.getFlags().has("militia"))
				{
					_entity.setFaction(this.Const.Faction.Enemy);
					_entity.getSprite("socket").setBrush("bust_base_militia");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Contract.m.Destination.getTroops().len() == 0)
				{
					this.onCombatVictory("RazeLocation");
					return;
				}
				else if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);

					if (this.Flags.get("IsBetrayal"))
					{
						this.Contract.setScreen("Betrayal1");
					}
					else if (this.Flags.get("IsMilitiaPresent"))
					{
						this.Contract.setScreen("MilitiaAttack");
					}
					else
					{
						this.Contract.setScreen("DefaultAttack");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.Contract.m.Destination.getPos());
					p.CombatID = "RazeLocation";
					p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
					p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;
					p.PlayerDeploymentType = this.Flags.get("IsEncircled") ? this.Const.Tactical.DeploymentType.Circle : this.Const.Tactical.DeploymentType.Edge;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
					p.Music = this.Const.Music.CivilianTracks;
					p.IsAutoAssigningBases = false;

					foreach( e in p.Entities )
					{
						e.Callback <- this.onEntityPlaced.bindenv(this);
					}

					p.EnemyBanners = [
						"banner_noble_11"
					];
					this.World.Contracts.startScriptedCombat(p, true, true, true);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_actor.getFlags().has("peasant"))
				{
					this.Flags.set("PeasantsEscaped", this.Flags.get("PeasantsEscaped") + 1);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Contract.m.Destination.setActive(false);
					this.Contract.m.Destination.spawnFireAndSmoke();
					this.Flags.set("IsDone", true);
				}
				else if (_combatID == "Defend")
				{
					this.Flags.set("IsDone", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Flags.set("PeasantsEscaped", 100);
				}
				else if (_combatID == "Defend")
				{
					this.Flags.set("IsDone", true);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				this.Contract.m.Destination.setFaction(this.Contract.m.Destination.getSettlement().getFaction());
				this.Contract.m.Destination.clearTroops();
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("PeasantsEscaped") == 0)
					{
						this.Contract.setScreen("Success1");
					}
					else if (this.Math.rand(1, 100) >= this.Flags.get("PeasantsEscaped") * 10)
					{
						this.Contract.setScreen("Success2");
					}
					else
					{
						this.Contract.setScreen("Failure1");
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
			Text = "[img]gfx/ui/events/event_61.png[/img]{%employer% 卷起他的丝绸袖子捏了捏手。%SPEECH_ON%我希望我可以相信你办好一件我的家族不能有所牵连的事。%SPEECH_OFF%你点头装的好像个经常被要求保密的佣兵似的。他接着说。%SPEECH_ON%%settlementname% 太软弱了难以自保，以致人们在嚷嚷着加强守备以范贼寇。 我们 %noblehousename% 是唯一能够提供他们想要的安全的家族。 不幸的，当地议会看不到这一点。 相信他们自己能保护手下的人民。 让我们告诉他们犯了个错。\n\n 我想要你烧了 %location% 那里在 %settlementname% 附近，还有杀几个农民。 让它看起来像强盗干的。 我知道你很了解他们的工作。现在…%SPEECH_OFF%%employer% 贴到你耳边。%SPEECH_ON%…让我说清楚而且你听清楚。 不能留下幸存者让他们知道谁真正袭击了他们。 一个都不留！明白？很好。事成之后回来找我。%SPEECH_OFF% | %employer% 盯着一堆卷轴突然发火全部甩到地上。%SPEECH_ON%%settlementname% 的议会认为他们可以保护自己免于贼寇，但我知道他们不行。 我知道他们需要我的保护！ 而且我给他们的价钱是多么合理…%SPEECH_OFF%他冷静下来，看到了你。%SPEECH_ON%我有想法了。我知道该怎么做。 你…你熟悉强盗的办事风格，对吧？当然。 那么要不要你…去 %location% 那里在 %settlementname% 郊外，并且…做点强盗会做的事情。 当然，让它看起来确实是强盗做的…在那之后，那个镇子肯定会接受我的提议！ 然后他们就安全了！%SPEECH_OFF% | %employer% 弓起手，拇指紧按额头。 他长叹一口气。%SPEECH_ON%我试着跟 %settlementname% 的家伙打交道几年了，但我开始认为我得用点更更出格的办法来达成目的。 那里的议会不愿意花钱让我保护他们的村子因为他们认为自己能搞定。 他们说已经平安无事好一段时间了。 所以如果…他们没有呢？ 如果你去那儿，当然穿成个强盗的样子，并且告诉他们没有 %noblehousename% 的帮助没人是安全的！ 当然，你不能告诉任何人这里发生的一点小谈话…你说如何，佣兵？%SPEECH_OFF% | %employer% 盯着窗外，你找了个板凳坐下。%SPEECH_ON%站起来，佣兵。我不喜欢低声向下说话，会让我放大嗓门而且我要跟你说的东西不适合那样讨论。%SPEECH_OFF%你站起身耳朵贴过去。%SPEECH_ON%%settlementname% 拒绝接受我的保护。 他们想自力更生。 这下他们不仅会停止向 %noblehousename% 交税，他们还羞辱了我们。 如果这个村子拒绝被保护，其他人呢？ 我需要你“当”个强盗，去那儿，告诉他们没有 %noblehousename% 会发生什么！ 当然，保密是最重要的。 我说的这些话不能离开这个房间。%SPEECH_OFF% | %employer% 把个苹果都擦毛了，用大拇指硬刮下了苹果皮。%SPEECH_ON%我父亲曾经跟我说，如果你的名字听起来就不被尊敬，那你就没有名字。 不幸的，%settlementname% 不尊敬 %noblehousename%。他们拒绝接受我的保护并且羞辱了我的家族。 我要你去报复他们。 我要你去那里，不是作为雇佣兵而是作为强盗，告诉他们这世上没有 %noblehousename%的保护会遭遇什么。 当然，你必须做的干净利落，佣兵。 你不能告诉任何人我们这个房间里说的话。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈价钱。 | 你愿意为此出多少克朗？ | 报酬如何？ | 只要价钱合适，什么都办得到。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{那不是我们的工作。 | 这种活不要找 %companyname%。}",
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
			ID = "DefaultAttack",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_16.png[/img]{你到达了 %location%。农民们都在这，就像你猜的那样。 这会像在桶里叉鱼那样简单。 现在唯一的问题是，怎么个做法？ | %location% 比你想的更安详。 几个农民溜达着，拿着镰刀和锄头一边闲聊着这个那个。 你听到他们因为一个笑话传出的小声。 真遗憾他们这一天接下来恐怕不会这么有趣。 | 你穿过些高草好观察 %location%。几个农民在散步，完全不知毁灭像猫一样藏在他们小村庄外的草里。 仔细观察了整个区域，你开始计划下一步。 | %location% 很安静，对于将要被毁灭而言太安静了。 这个世界的残酷令你本能产生抗拒，但是你提醒自己这件事会让你大赚一笔。 这让它好了一点。 | 杀害无辜从来不是你的风格。 并不是你做不到，只是其简单程度总是让你不屑一顾。 就像杀一条没腿的狗，或踩死一只盲青蛙。 但是从没有人花这么多钱来让你给些杂种狗安眠。 真讽刺，这些农民可能还没狗安全。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "包围他们！",
					function getResult()
					{
						this.Flags.set("IsEncircled", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				},
				{
					Text = "从一侧扫荡！",
					function getResult()
					{
						this.Flags.set("IsEncircled", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "MilitiaAttack",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_141.png[/img]{你到达 %location% 马上告诉你的人趴下。 农民们在，但是还有民兵。 这不是交易的一部分而且你必须重新判断情况。 | 随着你靠近 %location%，%randombrother% 回来报告侦查结果。 很显然，那里不止有农民。 几个民兵在现场。 如果你要上，你就得跟他们也打一场。现在怎么办？ | 民兵！他们完全不是计划中的一部分！ 如果你要继续，你就得像对付农民那样一起对付了。 是时候仔细思考这件事… | 什么？你看到群民兵在 %location% 周围巡逻。现在你得做点实际战斗来完成你的任务了。 | 随着你准备进攻 %location%，%randombrother% 指出远处有什么东西。 眯着眼，你聚焦到一群看起来像是民兵的人。 这不是合同的一部分！ 你依然可以进攻，但是这下会有些抵抗了…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "包围他们！",
					function getResult()
					{
						this.Flags.set("IsEncircled", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				},
				{
					Text = "从一侧扫荡！",
					function getResult()
					{
						this.Flags.set("IsEncircled", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Done",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_02.png[/img]{洗劫成功。 你拿上火把到这里，留下一片废墟。 | 随着你越过和穿过农民们的尸体你闻到空气中残留着的一股铜味。 你点头确定你的所作所为然后看向 %randombrother% 下了命令。%SPEECH_ON%烧光。%SPEECH_OFF% | 他们比预期的多反抗了一些，但是最终你杀光了他们。 或者至少你希望你做到了。 不希望事做一半，你接着点燃了所有看得到的房子。 | 你毁灭了 %location%。它的居民被杀死，房子被点燃。 以任何佣兵的标准一个顺利的工作日。 | 到处都是死人而且他们逝去的味道已经变质。 不想忍受恶臭，你赶快点燃了 %location% 离开了。 | …于是“抵抗”被压制了。 这里几个尸体，那里几个尸体。 你希望你把他们都干掉了。 剩下的只是把一切都烧成灰并离开。 | 好吧，这就是你来这里干的。 你让手下把尸体摆好以显得“提供信息”，然后让其他几个佣兵烧了所有建筑物。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们完事了。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Settlement, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Betrayal1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你来到%location%，却被一群重兵武装的人迎了上来。其中一人走出来，拇指钩在系剑的腰带上。%SPEECH_ON%哦，哦，你真的很愚蠢。%employer%的记性可不小，他可没有忘记你上次背叛了%faction%。把这看作是对你的回敬吧。%SPEECH_OFF%突然间，中尉背后的所有人都向前冲了过来。拿起武器，这是一个伏击！ | 你走进%location%，但村民们似乎做好了准备：你看到窗户关闭，门关上。就在你即将下令队伍开始屠杀时，一群男子从建筑物后面走出来。\n\n他们...比一群俗人带着更多的武器。实际上，他们扛着%employer%的旗帜。恍然大悟，你意识到你被设局了，就在这时这些人开始冲锋，你迅速命令手下们准备战斗。 | 当你走出%location%时，一个手持兵器、身披盔甲的男子迎面走来，看上去十分开心，一边向你微笑一边说%SPEECH_ON%晚上好，雇佣兵们。%employer%问候你们。%SPEECH_OFF%就在这时，一群人从路边蜂拥而出，这是一个伏击！那个可恶的贵族背叛了你们！ | 你踏进%location%，但迎接你的只有一阵沉闷的孤风声，在陈旧的木构工艺间回荡。你想你被人耍了，便拔出了剑。%SPEECH_ON%好主意。%SPEECH_OFF%声音来自一幢建筑物，一个男人拔出了自己的剑走了出来。一群身着%faction%颜色的武装士兵紧随其后排列整齐，他们的队伍展开以便更好地观察你的战团。%SPEECH_ON%我会享受从你冰冷的手中夺下那把剑的过程。%SPEECH_OFF%你耸耸肩问为什么要设陷阱陷害你们。%SPEECH_ON%%employer%不会忘记那些欺骗他或他的房屋的人。这就是你需要知道的全部了。像我在这里说什么也没有用，当你被杀死时。%SPEECH_OFF%准备战斗吧，这是一次伏击！ | %location%已经空了。你的士兵们搜查了建筑物，却没有发现任何人。突然，几个人拥挤在你身后的路上，该组的中尉走上前来，心怀不轨。他手持一块刺绣着%employer%标志的布。%SPEECH_ON%异常的安静，不是吗？如果你想知道我为什么在这里，那是因为我要偿还欠%faction%的债务。你们曾经许诺完成一项任务，但最终并没有兑现承诺。现在你们要死了。%SPEECH_OFF%你拔出剑，闪亮的刀身对准中尉。%SPEECH_ON%看起来%faction%又要失约了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", false);
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.CombatID = "Defend";
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
						p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Music = this.Const.Music.NobleTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 150 * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Betrayal2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你在你腿上抹去了剑上的血并收回鞘内。 伏击者死了，扭曲成这样那样的姿势。%randombrother% 走过来问你现在怎么办。 看起来 %faction% 不会是最友善的人了。 | 你将伏击者的尸体从你剑上踹开。 看起来 %faction% 现在起不会是最友善的人了。 也许下一次，当我同意为这些人做点什么的时候，我真的做到了。 | 好吧，非常明显，这里学到的是不要接一个你完成不了的活。 这块土地上的人们对那些不守承诺的人可真不怎么友好… | 你背叛了 %faction%，但是不要在这事上钻牛角尖。 他们也背叛了你，这才是最重要的！ 未来，你最好注意着点他们和任何带着他们旗帜的人。 | %employer%，从你脚下的士兵尸体判断，看来不再喜欢你了。 如果你要猜的话，这是因为你以前做了些什么－失败，背叛，背后说坏话，睡了一个贵族的女儿？ 这些全部都被你回想起来寻思着。 重要的是你们两个之间的裂缝不会轻易修复了。 你最好看着点 %faction%的人一段时间。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "去他们的！",
					function getResult()
					{
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_61.png[/img]{你回到 %employer% 告诉了他消息。 你坐下点头。%SPEECH_ON%全部？%SPEECH_OFF%你看了看四周。%SPEECH_ON%你听到什么来过吗？%SPEECH_OFF%%employer% 笑着摇摇头。%SPEECH_ON%只有一些糟糕透顶的消息，当然。可恶的强盗。%SPEECH_OFF%他打了个响指然后一个人看起来从黑暗中冒出来一样支付了你的报酬。 | %employer% 欢迎着你回来，给了你一杯酒。 对于一个刚刚下令滥杀无辜的人而言他笑的很热情。%SPEECH_ON%好我从风里听到声说 %location% 被摧毁了的。%SPEECH_OFF%You nod.%SPEECH_ON%强盗，哏？%SPEECH_OFF%%employer% 笑了。他递给你一袋克朗。%SPEECH_ON%确实是强盗。%SPEECH_OFF% | %location% 被摧毁了，你回来告诉 %employer% 这个消息。 几个本地人站在他边上，所以你交出“消息”说“强盗”攻击了那个地方。 他点头，很焦急，但是灵巧的一摆手递给你一袋克朗。 然后他转向当地人，说必须对强盗问题采取措施… | 你把你的成功告诉了 %employer%。 他笑了笑，然后把一群平民叫到他身边。 他声明“强盗”摧毁了 %location% 而且他得征点税来解决这个新问题。 当他说完话，他转身又塞了一袋克朗到你外套下。 | 你进入 %employer%的房子。 一个女人在他身边哭泣。 当你看向他，他摇头。 点着头，你告诉了他“新闻。”%SPEECH_ON%呃…强盗…摧毁了 %location%。%SPEECH_OFF%%employer% nods solemnly.%SPEECH_ON%是的，是我知道。 这边的寡妇已经告诉了我一切。 不幸的消息。非常的不幸。%SPEECH_OFF%他的其中一个手下在你离开时交给了你一袋克朗。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{诚实的工作得到诚实的报酬。 | 克朗就是克朗。}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess);
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_61.png[/img]{你进入 %townname% 发现了一些熟悉的农民站在 %employer% 边上。害怕他们会认出你，你躲在视线外。 他们哭喊道强盗摧毁了 %location%。%employer% 看起来很焦急。%SPEECH_ON%是吗？噢，这太糟了！ 我会调查这件事的。 不要害怕，各位，我会保护你们的！%SPEECH_OFF%他刚说完话，其中一个卫兵偷偷递给你一袋克朗。 | 你进入 %employer%的房间发现几个满身是血的农民围着他的办公桌。 你在他们交谈和离开时躲了起来。%employer% 招手叫你进去。%SPEECH_ON%强盗。他们说是强盗干的。 完美。你的报酬就在角落里。%SPEECH_OFF% | %employer% 带着笑容欢迎你回来。%SPEECH_ON%有些幸存者。%SPEECH_OFF%他扫去你的忧虑。%SPEECH_ON%他们认为是强盗干的。 流浪汉的掠夺行为。 你不需要担心什么。你的报酬…%SPEECH_OFF%他从办公桌上滑过来一个袋子。 你拿上它点头。%SPEECH_ON%很高兴和你做生意。%SPEECH_OFF% | %employer% 在你回来时从办公桌上扇下一个卷轴。%SPEECH_ON%你留了些幸存者！但是…没事。 They think brigands were responsible.%SPEECH_OFF%你把手放在剑把上瞟了眼 %employer%的卫兵们。%SPEECH_ON%我还期待着全额报酬。%SPEECH_OFF%%employer% 挥挥手指向办公桌上的袋子。%SPEECH_ON%当然。但是下次我要你做什么，我期待你完全照做，明白吗？%SPEECH_OFF% | 一大群农民保卫了 %employer%。你有一刻寻思他们是不是要吊死他，但是他赶走了他们。 随着他看着他们转弯，他解释道他们是 %location% 来的幸存者。在你准备说话前，他扫去了你的担忧。%SPEECH_ON%他们依然认为是强盗干的，但我对于这个结果不是很开心。 这本有可能会变得非常糟，对于我们而言。特别是对我。%SPEECH_OFF%你点头并问他是不是想要这几个幸存者死，保万无一失。%employer% 摇摇头。%SPEECH_ON%No, no need for that. 这是和你约定的报酬，佣兵。 下次，记住，确保按我说的做。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{诚实的工作得到诚实的报酬。 | 克朗就是克朗。}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictory);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractPoor, "履行了合同");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_43.png[/img]{随着你进入 %employer%的房间他转身把一个带绘画的卷轴拍在桌上。%SPEECH_ON%认得这个人吗？%SPEECH_OFF%你捡起它。 潦草画下的脸出奇的像你自己的。%employer% 后靠下去。%SPEECH_ON%他们知道是有人雇了人去干掉那里。 在我让我的人砍了你之前给我滚。%SPEECH_OFF% | %SPEECH_ON%幸存者！幸存者！我说了什么，“不留活口”，我相信我说过，对吗？%SPEECH_OFF%你点头，%employer% 用指关节按住他的办公桌。%SPEECH_ON%那么为什么我从跑来的农民们听说是雇佣兵袭击了他们？ 死人不会说话，但谁会？谁说话，佣兵？%SPEECH_OFF%你原地不动。%SPEECH_ON%幸存者。%SPEECH_OFF%%employer% 指向门。%SPEECH_ON%好了。现在滚出我的视线。%SPEECH_OFF% | 你点头听 %employer% 告诉你消息：几个农 民跑了并且传开来说摧毁 %location% 的人是“雇来的”。但你在寻思…%SPEECH_ON%我们还能留下所有找到的装备吗？%SPEECH_OFF%%employer% laughs.%SPEECH_ON%你能随心所欲的留下你找到的，但你不会从我口袋里拿走一个克朗。 离开这里，佣兵。%SPEECH_OFF% | 不幸的是，似乎有几个农民在屠杀中幸存了下来。 他们告诉了 %employer% 非常特别的细节，不用说是全副武装的并且满怀恶意的人们摧毁了 %location%。不是强盗，而是佣兵。 你本应该杀光他们，不留幸存者，但是现在…好吧，现在你拿不到报酬了。 | %employer% 坐在你对面，握住拳，他的脸发红。 他问他要怎么提高税率去防范强盗，当所有人认为是被雇来的佣兵摧毁了 %location%。你问他想说什么而他直截了当的跟你说了：几个农民存活了下来，你个蠢货。 留下幸存者不是工作的一部分，看来，现在 %employer%的钱也不会是你钱包的一部分了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "恐怕不会欢迎我们了 %settlementname% …",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
						this.Contract.m.Destination.getSettlement().getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationAttacked, "掠夺了" + this.Flags.get("DestinationName"));
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"settlementname",
			this.m.Flags.get("SettlementName")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setFaction(this.m.Destination.getSettlement().getFaction());
				this.m.Destination.setOnCombatWithPlayerCallback(null);
				this.m.Destination.setAttackable(false);
				this.m.Destination.clearTroops();
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return false;
		}

		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isActive())
		{
			return false;
		}

		if (this.m.Settlement == null || this.m.Settlement.isNull())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Settlement != null && !this.m.Settlement.isNull())
		{
			_out.writeU32(this.m.Settlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local dest = _in.readU32();

		if (dest != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(dest));
		}

		local settlement = _in.readU32();

		if (settlement != 0)
		{
			this.m.Settlement = this.WeakTableRef(this.World.getEntityByID(settlement));
		}

		this.contract.onDeserialize(_in);
	}

});

