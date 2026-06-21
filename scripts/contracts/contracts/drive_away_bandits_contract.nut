this.drive_away_bandits_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Dude = null,
		Reward = 0,
		OriginalReward = 0
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.drive_away_bandits";
		this.m.Name = "驱赶强盗";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames[this.Math.rand(0, this.Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		local banditcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(this.m.Home.getTile());
		this.m.Destination = this.WeakTableRef(banditcamp);
		this.m.Flags.set("DestinationName", banditcamp.getName());
		this.m.Flags.set("RobberBaronName", this.generateName());
		this.m.Payment.Pool = 550 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"驱赶强盗于" + this.Flags.get("DestinationName") + "，位于%origin%的%direction%"
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
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setLastSpawnTimeToNow();

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditDefenders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.World.Assets.getBusinessReputation() >= 500 && this.Contract.getDifficultyMult() >= 0.95 && this.Math.rand(1, 100) <= 20)
				{
					this.Flags.set("IsRobberBaronPresent", true);

					if (this.World.Assets.getBusinessReputation() > 600 && this.Math.rand(1, 100) <= 50)
					{
						this.Flags.set("IsBountyHunterPresent", true);
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
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsRobberBaronDead"))
					{
						this.Contract.setScreen("RobberBaronDead");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Math.rand(1, 100) <= 10)
					{
						this.Contract.setScreen("Survivors1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Math.rand(1, 100) <= 10 && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
					{
						this.Contract.setScreen("Volunteer1");
						this.World.Contracts.showActiveContract();
					}

					this.Contract.setState("Return");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Flags.get("IsRobberBaronPresent"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("AttackRobberBaron");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.BanditTracks;
						properties.Entities.push({
							ID = this.Const.EntityType.BanditLeader,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/bandit_leader",
							Faction = _dest.getFaction(),
							Callback = this.onRobberBaronPlaced.bindenv(this)
						});
						properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog();
				}
			}

			function onRobberBaronPlaced( _entity, _tag )
			{
				_entity.getFlags().set("IsRobberBaron", true);
				_entity.setName(this.Flags.get("RobberBaronName"));
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().get("IsRobberBaron") == true)
				{
					this.Flags.set("IsRobberBaronDead", true);
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
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsRobberBaronDead"))
					{
						this.Contract.setScreen("Success2");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

					this.World.Contracts.showActiveContract();
				}

				if (this.Flags.get("IsRobberBaronDead") && this.Flags.get("IsBountyHunterPresent") && !this.TempFlags.get("IsBountyHunterTriggered") && this.World.Events.getLastBattleTime() + 7.0 < this.Time.getVirtualTimeF() && this.Math.rand(1, 1000) <= 2)
				{
					this.Contract.setScreen("BountyHunters1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBountyHunterRetreat"))
				{
					this.Contract.setScreen("BountyHunters3");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "BountyHunters")
				{
					this.Flags.set("IsBountyHunterPresent", false);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "BountyHunters")
				{
					this.Flags.set("IsBountyHunterPresent", false);
					this.Flags.set("IsBountyHunterRetreat", true);
					this.Flags.set("IsRobberBaronDead", false);
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
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer%愤怒地摇了摇头。%SPEECH_ON%土匪在这些地方横行太久了！我派了一个小伙子——%randomname%的儿子去找他们。你知道发生了什么吗？只有他的脑袋被送回来了。当然，那些愚蠢的土匪派了一个人来送它。我们抓住了他，审问了他……所以现在我们知道他们在哪里了。%SPEECH_OFF%那人靠在椅背上，双手交叉，沉思片刻。%SPEECH_ON%我没有足够的人手，但是我有克朗——你愿意帮我解决掉土匪吗？你出去杀了他们，我会支付报酬。%SPEECH_OFF% | %employer% 自己倒了一杯酒，看着杯子喝了一口，又继续倒了一点。他似乎一口气就把它灌下去了，之后打着饱嗝继续讲述。%SPEECH_ON%土匪杀了%randomname%全家！你能相信吗？我知道你不认识他们，但是他们在这些地方很受欢迎。我相信你已经能够想象要怎么做，我希望把这些土匪的问题解决掉。我花费一半的人力找到他们的营地，现在我已经准备好出一部分的克朗，让你去杀了他们。你感兴趣吗？%SPEECH_OFF% | %employer%正在窗前观望，他用手指轻敲着一杯饮料，思索着。%SPEECH_ON%土匪一直在偷走我们珍贵的牲畜，他们会在夜里进来，剪掉牛铃，悄无声息地离去。我知道，这些牲畜对你来说并不重要，但对我们这些人来说，一只小牛、一头奶牛或一头公牛都是财富。\n\n所以有天我让一个年轻人沿着动物足迹走出城镇，现在他告诉我这些土匪的具体位置。如你所料，我没有多余的人手去攻击这些流浪汉，但克朗，我可不缺。如果我在你的手心上放上铜板，你会不会愿意用钢剑对抗这些土匪呢？%SPEECH_OFF% | %employer%叹了口气，仿佛他已经厌倦了所有这些麻烦，就像他已经有很多次这样的谈话了一样。%SPEECH_ON%%randomname%，在这里地位相当重要的人物，说过这些土匪对他的女儿下过手。现在他担心他们下一步会做什么。幸运的是，他有相当的财富，可以轻松追踪这些土匪。如果我给你一个相当数目的报酬，你会多认真地用你的剑刺穿其中一两个土匪？%SPEECH_OFF% | %employer%坐到一个足够舒适容纳两人的椅子上。他来回晃动着一个杯子。%SPEECH_ON%强盗已经困扰了我们几个星期，昨天他们竟然试图放火烧一家酒馆。你能相信吗？谁会这样做？幸运的是我们及时扑灭了火，但情况在这里变得越来越糟。如果他们威胁到我们珍贵的饮料，他们下一步会做什么？幸运的是，我们找到了这些流浪汉藏身的地方。所以...是的，我看到了你的表情。这是个简单的任务，佣兵：我们希望你去杀掉那里的每一个强盗。你愿意和我们一起工作吗？%SPEECH_OFF% | 当你安顿下来后，%employer%一口喝完了一杯眼镜蛇酒，把杯子掷出窗外。你听到它的声响远远地回荡着。他转向你。%SPEECH_ON%就在大路上，强盗们围攻了我的马车并带走了所有的货物！他们留给了我生命，这还好，但是他们的所作所为令人倍感愤慨。我看到他们充满嘲笑的脸...听到他们的笑声...我觉得这是一条信息，他们不会放过我，因为我拒绝支付他们的“过路费”。嗯，现在我准备付一份“过路费”给你，佣兵。如果你去屠杀这些流浪汉，我会乐意地付给你一大笔钱。你怎么说？%SPEECH_OFF% | 当你开始坐下时，%employer%向你扔了一卷卷轴。它在你接到的时候展开了。你开始阅读，但%employer%仍然阐述着这个消息。%SPEECH_ON%来自%randomtown%的贸易商已经同意不再光顾%townname%，直到我们解决了我们的小山贼问题。它的历史相当简单，我相信你已经了解过山贼的手段，但这些该死的流浪汉一直在骚扰道路，抢劫押车和杀害商人。\n\n我知道他们的准确位置，我只需要一个有勇气和荣耀（或金子！）的人去杀了他们。那么，雇佣军，你怎么说？报个价，我们可以商量。%SPEECH_OFF% | 当你打招呼时，%employer%颤抖着。他几乎要被愤怒淹没了——或许他只是真的喝醉了。%SPEECH_ON%这个美丽城镇的市民正在挨饿。为什么？因为强盗们每天晚上潜入粮仓。如果我们抓住了他们，他们就会烧掉建筑物！现在我们不能再被动了....现在....我想通过杀死他们来保卫我们自己。%SPEECH_OFF%这个人摇晃了一会，好像要倒在桌子上。他定了定神，继续说。%SPEECH_ON%我想你去杀掉这些流浪汉，很明显。你只需要感兴趣...-嗝-...报个价就行。%SPEECH_OFF% | %employer%面色凝重地看着地面，他展开一卷卷轴，向你展示了一个脸孔。%SPEECH_ON%这是%randomname%，我们前几天抓到的一个土匪。他曾经率领一队流浪汉，日夜骚扰我们的城镇。问题是，他并不是一条蛇的头，而是九头蛇的其中一颗。斩草不除根，后患无穷。所以答案如何呢？当然是全部杀掉。这正是我想要你做的事，佣兵。你有兴趣吗？%SPEECH_OFF% | %employer%转向你，而你却找不到坐的地方。%SPEECH_ON%嘿，雇佣兵，你最后一次用你的剑砍下邪恶和残忍的人的血是什么时候？%SPEECH_OFF%他不再嘲讽，你意识到自己现在应该是站着的。%SPEECH_ON%我们在 %townname% 和一些当地的强盗发生争执。当地指的是我们这里，也就是说，他们的老鼠洞离这里不远。显然，我认为解决这个问题的答案是雇佣你们这些像你这样的，精装备的人。所以，这引起了你的兴趣，雇佣兵，还是我需要找更强壮的人来完成这个任务？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你愿意为此出多少克朗？ | %townname% 准备为他们的安全付出什么代价？ | 我们来谈谈价钱。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{不感兴趣。 | 我们有更重要的事情要做。 | 我祝你好运，但我们不会参与其中。}",
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
			ID = "AttackRobberBaron",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_54.png[/img]{在侦察强盗营地时，你注意到一个人的侧影，当地人几乎狂热地描述了他:那是%robberbaron%，这个引起恐慌的富豪嗑强盗。他有一大队凶残的手下。\n\n你敢打赌他的头颅值几个克朗。 | 你本不计划见他，但毫无疑问是这个男人本人：%robberbaron%在强盗的营地里。这个臭名昭著的杀手显然在探访他的一个罪犯分子，认真地在贼王周围走动，指着这个那个地指点江山，评价这个那个的质量。\n\n几个保镖紧随其后。你估计在他和其余强盗之间，大约有%totalenemy%人胡闹。 | 合同只是要消灭强盗，但是现在多了一个要求，这个要求更重：%robberbaron%，臭名昭著的杀手和原始路霸，在营地里。跟随着一个保镖，盗贼贵族似乎正在评估他的罪犯装备。\n\n你想知道%robberbaron%的头颅值多少克朗... | %robberbaron%。就是他，你知道。用望远镜盯着，你可以轻松地看到臭名昭著的富豪强盗的轮廓，他在强盗营地周围移动。虽然他不在你的计划中，也没有提到合同，但毫无疑问，如果你把他的头带回城镇，你会因麻烦而得到一些额外的回报。 | 在窥探强盗的营地时，你数了约%totalenemy%人在动，你发现了一个意料之外的角色:%robberbaron%，这个臭名昭著的强盗。这个人和他的保镖似乎在检查营地的状态。\n\n多么幸运啊!如果你能把他的头带回给雇主，你可能会得到一点小奖励。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "RobberBaronDead",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束后，你走向%robberbaron%的尸体，用剑快速地砍了两下，一刀肉，一刀骨。你钩住脖子上的肉，系上绳子，挂在腰间。 | 战斗结束后，你快速搜索并找到在死者中的%robberbaron%尸体。纵使面色苍白，他依然显得威武。你将他的头从身体上拔下，随手丢进麻袋里。你认为，如果你还能看见他的脸，他依然看上去威武无比。 | %robberbaron%倒在你脚下。你翻过他的身体，伸直了脖子，为你的剑提供更好的目标。你砍了两刀，将他的头迅速放入麻袋。 | 既然他死了，%robberbaron%突然让你想起了你认识的许多人。你没想那么多：几下快速的挥剑，你把他的头斩了下来，随手扔进一个袋子里。 | %robberbaron%打了一场漂亮的仗，而他的脖子又再一次证明了这一点，肌腱和骨头尚未从他的头脖上分离，你成功获得了悬赏金。 | 你拿起%robberbaron%的头。%randombrother%指着它说道：%SPEECH_ON%那是什么？那是%robberbaron%的……？%SPEECH_OFF%你摇了摇头。%SPEECH_ON%不，那家伙已经挂了。这只是额外的报酬而已。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们出发！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BountyHunters1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{返回领取契约时，几个人走上了路。其中一个人指向%robberbaron%的头。%SPEECH_ON%我们是这个地方最高薪水的赏金猎人，我相信你们抢了我们的活计。把头给我们，今晚所有人都可以安然入睡。%SPEECH_OFF%你笑了。%SPEECH_ON%你需要比这更强。%robberbaron%的头值很多克朗，我的朋友。%SPEECH_OFF%这些所谓的赏金猎人的领袖也对你大声笑了。他举起了一个沉甸甸的袋子。%SPEECH_ON%这里有%randomname%，这里是这个地方最想抓的家伙之一。还有这个......%SPEECH_OFF%他举起另一个袋子。%SPEECH_ON%是杀了他的人的头。明白了吗？所以把赏金交出来，我们就可以离开了。%SPEECH_OFF% | 一个人走上了路，挺直了身子，对着你摆出姿势。%SPEECH_ON%你好先生们。我相信你们中有人拿着%robberbaron%的头。%SPEECH_OFF%你点了点头。那个人微笑了。%SPEECH_ON%能请你友好地将它交给我吗？%SPEECH_OFF%你笑了，摇了摇头。那个人没有笑，他举起一只手，啪地一声响指。一群武装瓦解的人从附近的灌木丛中出来，摇曳着重金属的响声从路上传来。他们看起来像是行刑前夜一个男人的梦。他们的领袖露出了一丝布满金点的冷笑。%SPEECH_ON%我不会再问你一遍。%SPEECH_OFF% | 在与%randombrother%交谈时，一个响亮的喊声引起了你的注意。你抬头看到一群人挡住了你的路。他们手持各种武器和盔甲。他们的头儿走到前面，宣布他们是著名的赏金猎人。%SPEECH_ON%我们只希望得到%robberbaron%的头。%SPEECH_OFF%你耸了耸肩。%SPEECH_ON%我们杀了那个人，我们要得到他的头颅。现在请把路让开。%SPEECH_OFF%当你向前迈了一步时，赏金猎人们举起了武器。他们的领袖向你走了一步。%SPEECH_ON%这里有一个选择，可以让很多好人死去。我知道这不容易，但我建议你认真考虑。%SPEECH_OFF% | 一声尖啸吸引了你和你的人的注意。你转向路的一侧，看到一群人从一些灌木丛中走了出来。每个人拔出了武器，但这些陌生人没有再往前走一步。他们的头儿走了过来。他胸前挂着一个穿过他胸前的弹药带，它是他的杰作的总结。%SPEECH_ON%各位，你们好。我们是赏金猎人，如果你还不知道，我相信你拿着我们的悬赏之一。%SPEECH_OFF%你举起了%robberbaron%的头。%SPEECH_ON%你是说这个吗？%SPEECH_OFF%头目热情地笑了。%SPEECH_ON%当然。如果你能把它交给我，我和我的朋友们会很高兴的。%SPEECH_OFF%他拍打着剑柄，露出笑容。%SPEECH_ON%这只是商业的问题。我相信你明白的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那就拿这该死的头离开吧。",
					function getResult()
					{
						this.Flags.set("IsRobberBaronDead", false);
						this.Flags.set("IsBountyHunterPresent", false);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractPoor);
						return "BountyHunters2";
					}

				},
				{
					Text = "{要是你这么想要的话，你必须用鲜血来买单。 | 如果你想让你的头和这个一起，那么继续吧，试试你的运气。}",
					function getResult()
					{
						this.TempFlags.set("IsBountyHunterTriggered", true);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.BanditTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "BountyHunters";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BountyHunters, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BountyHunters2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_07.png[/img]你今天已经看了足够的流血，把头交给他们吧。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们继续前进吧，我们还需要收取报酬。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BountyHunters3",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_07.png[/img]赏金猎人对于%companyname%过于强大！为了不让你的士兵不必要的死去，你下令紧急撤退。不幸的是，在混乱中失去了%robberbaron%的头颅。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "噢，好吧。我们还有待领取的报酬。",
					function getResult()
					{
						this.Flags.set("IsBountyHunterRetreat", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Survivors1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{随着战斗接近尾声，一些敌人跪下请求饶恕。%randombrother%向你寻求下一步该怎么做。 | 战斗结束后，你的士兵会缉拿剩余的强盗。幸存者请求饶命。其中有一个看起来比较像孩子，而不是一个男人，但他是所有人中最安静的。 | 剩下的几个强盗放下武器请求饶恕，现在你开始想象在相反位置的情况下他们会怎样做。 | 战斗结束了，但决定还没做出：还有一些强盗从战斗中幸存下来。%randombrother%拿着剑立在一个囚犯身边，问你想做什么。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "割断他们的喉咙。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-1);
						return "Survivors2";
					}

				},
				{
					Text = "拿起武器，把他们赶走。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(2);
						return "Survivors3";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Survivors2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{慷慨是给天真幼稚之人的。你让俘虏们被屠杀。 | 你想起强盗屠杀无辜商人的次数。想法仅出自你脑海，你就下令处决这些俘虏。他们稍微抗议了一番，但很快就被剑和矛打断。 | 你转身离去。%SPEECH_ON%直接通过他们的脖子，快点。%SPEECH_OFF%雇佣兵们遵从命令，你很快就听到了垂死之人的哀嚎。根本不是什么快速。 | 你摇了摇头。俘虏们大声哭喊，但他们却已经被人砍杀和刺穿。幸运的人连察觉到自己的死亡都没来得及就已经被砍了头。那些稍微有些反抗的人一直在受苦。 | 仁慈需要时间。时间看看肩膀后面，时间考虑这是否是正确的决定。你没有时间。你没有仁慈。俘虏被处决了，而这根本就不需要花费多少时间。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们有更重要的事要做。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Survivors3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{今天已经有足够多的杀戮和死亡。你放了囚犯，拿走了他们的武器和盔甲，然后放他们走。 | 对盗贼和强盗的宽恕并不常见，所以当你释放囚犯时，他们几乎亲吻你的脚，好像与神有关。 | 你沉思了一会儿，然后点了点头。%SPEECH_ON%就这样吧。拿走他们的装备，然后放他们走。%SPEECH_OFF%囚犯被释放了，留下了他们所带的武器和盔甲。 | 你让强盗们脱下他们的衣服，只剩下内衣 - 如果他们真的有的话 - 然后让他们走了。%randombrother%在你看着一群半裸男人匆匆离开的同时在翻找剩下的装备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们不是为杀它们而收费的。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Volunteer1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束后，安静开始回归，你听到有人在喊叫。你朝着那里走去，发现一名囚犯被歹徒绑了起来。他嘴里和手上都套着绳子，你很快将其解开。他喘息着，虚弱地问道是否可以加入你的公司。 | 你在歹徒的营地发现了一名被绑架的囚犯。将他解救出来后，他解释说他来自%randomtown%，几天前被流浪汉绑架。他请求能否加入你的雇佣兵团。 | 翻找歹徒营地残留的物品，你发现了一名囚犯。将他解救出来后，他坐起身来，解释说他在前往%randomtown%寻求工作时被歹徒绑架。你想知道他是否能为你工作，取代被打败的雇佣兵团。 | 战斗结束后，留下了一个人。他不是歹徒，而是他们的囚犯。当你问他是谁时，他提到他来自%randomtown%，正在寻找工作。你问他是否能挥舞剑，他点了点头。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你不妨加入我们。",
					function getResult()
					{
						return "Volunteer2";
					}

				},
				{
					Text = "回家。",
					function getResult()
					{
						return "Volunteer3";
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx(this.Const.CharacterLaborerBackgrounds);

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Volunteer2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{这名男子加入了你的战团，融入了一群兄弟中，这些人似乎对他非常友好，尽管他们只是一群拿钱杀人的人。新雇的人员表示他对所有武器都很擅长，但你认为你应该决定他最擅长的是什么。 | 囚犯满脸笑容，你挥手让他加入。几位兄弟问应该给他什么武器，但你耸了耸肩，想着你自己会决定如何武装这个人。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "让我们为您找一把武器。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				this.World.getPlayerRoster().add(this.Contract.m.Dude);
				this.World.getTemporaryRoster().clear();
				this.Contract.m.Dude.onHired();
				this.Contract.m.Dude = null;
			}

		});
		this.m.Screens.push({
			ID = "Volunteer3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你摇了摇头。那个人皱了皱眉头。%SPEECH_ON%你确定吗？我很善于……%SPEECH_OFF%你打断了他。%SPEECH_ON%我确定。现在好好享受你的新自由吧，陌生人。%SPEECH_OFF% | 你观察了一下那个人，发现他不适合成为一名雇佣兵。%SPEECH_ON%我们感激你的提议，陌生人，但是雇佣兵生涯充满危险。回家和你的家人在一起，或者恢复你的工作和生活。%SPEECH_OFF% | 你已经有足够的人手来见缝插针了，虽然你很想替换%randombrother%，只是想看看这个人降职后的反应。然而，你会和那个囚犯握手并放他离开。虽然他有点失望，但他很感谢你解救他。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你已经可以出发了。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				this.World.getTemporaryRoster().clear();
				this.Contract.m.Dude = null;
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到了%townname%并与%employer%交谈，你的旅程经历很简单：你消灭了土匪。他点点头，面带微笑地交付了你支付的费用。%SPEECH_ON%干得好，夥计们。那些土匪给我们带来了很多麻烦。%SPEECH_OFF% | %employer%为你打开门，他手里拎着一个小包。%SPEECH_ON%你回来了，我就知道那些土匪死了。%SPEECH_OFF%你点点头。%employer%耸了耸肩。%SPEECH_ON%可能是吧，不过那些伤口不会骗人。好工作,自由雇佣军。当然，如果你在撒谎，我就找到你。%SPEECH_OFF% | 当你把一袋头颅放在桌子上时，%employer%笑了起来。%SPEECH_ON%为了证明你的任务已经完成，不必弄得满手血腥。我已经得到你成功的消息了–这片土地上的鸟传播得很快，是不是？你的酬劳在角落里。%SPEECH_OFF% | 你报告完成后，%employer%用手帕擦了擦额头。%SPEECH_ON%他们全部死了？你不知道你给我减轻了多少负担，自由雇佣兵。你的克朗，一如既往地承诺。%SPEECH_OFF%他在桌子上放了一个小包，你很快地接过来。 | %employer%喝了一口酒，点头赞许。%SPEECH_ON%你知道吗，我不喜欢你们这种人，但你们做得非常好，雇佣兵。在你来之前，%randomname%就告诉我所有的土匪都已经被杀了。他描述的方式非常出色。好的，克朗已经准备好了。%SPEECH_OFF%他拍了一下桌子上的一个小包。%SPEECH_ON%这是你应得的回报。%SPEECH_OFF% | %employer%向后靠在椅子上，双手交叉放在膝盖上。%SPEECH_ON%很多人不喜欢雇佣兵，也许是因为你们会毁掉整个村庄，只为赚更多的钱。但我承认你们做得很好。%SPEECH_OFF%他指了一下房间的一个角落，那里有一个木箱还没有打开。%SPEECH_ON%一切都在那里，如果你需要，我不会介意你去数数。%SPEECH_OFF%你数，发现的确没问题。 | %employer%的桌子上满是脏兮兮和展开的卷轴，他露出温柔的笑容，好像他正在对着一堆宝藏诉说。%SPEECH_ON%贸易协议！贸易协议到处都是！快乐的农民！快乐的家庭！每个人都很开心！啊，太棒了。当然，对于你来说也是好事，自由佣兵，因为你的口袋变得更重了！%SPEECH_OFF%这个人把一个小钱包扔给你，然后又扔了一个，再扔一个。%SPEECH_ON%我本来想用一个更大的小包付钱的，但是这样也挺有意思。%SPEECH_OFF%他调皮地扔了一个小钱袋，而你则轻松自如地抓住了它，如同一个拥有新鲜血液的男人一样毫不在乎。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "摧毁了强盗营地");
						this.World.Contracts.finishActiveContract();
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你将罪犯的头颅扔在%employer%的桌子上，冷笑着指着它。%SPEECH_ON%那是%robberbaron%。%SPEECH_OFF%%employer%站起来，揭开盖在奖杯上的麻布袋，点了点头。%SPEECH_ON%没错，就是他。我猜你会因此得到额外的奖励。%SPEECH_OFF%你因为杀了强盗并摧毁了周围许多团伙的领导而获得了%reward%克朗的丰厚报酬。 | %employer%在你提着一个头的时候走进他的房间，他后退着。幸运的是，头发上并没有流血。%SPEECH_ON%这是%robberbaron%的头。或者我该说是过去式？%SPEECH_OFF%%employer%缓慢地站起来，打量了一下。%SPEECH_ON%用过去式是正确的，你不仅摧毁了强盗的巢穴，还带来了他们的领袖的头颅。干得好，佣兵，你会得到额外的奖励。%SPEECH_OFF%男人拿出一个装有%original_reward%克朗的小包，然后从自己身上拿出一个钱袋扔向你。 | 你举起%robberbaron%的头，眼神滑向滴着血丝的头发。%employer%的脸上露出缓慢的笑容。%SPEECH_ON%你知道你干了什么吗，佣兵？你知道你通过从他的肩膀上拿下那个人的头给这些地方带来了多少安慰吗？你会得到比你预期的更多的报酬！原始任务的%original_reward%克朗和......%SPEECH_OFF%男人在桌子上放了一个厚实的钱袋。%SPEECH_ON%还有一些额外的奖金，因为你一直在承担着那份额外的负荷。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "摧毁了强盗营地");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() * 2;
				this.Contract.m.OriginalReward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"reward",
			this.m.Reward
		]);
		_vars.push([
			"original_reward",
			this.m.OriginalReward
		]);
		_vars.push([
			"robberbaron",
			this.m.Flags.get("RobberBaronName")
		]);
		_vars.push([
			"totalenemy",
			this.m.Destination != null && !this.m.Destination.isNull() ? this.beautifyNumber(this.m.Destination.getTroops().len()) : 0
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			return true;
		}
		else
		{
			return true;
		}
	}

	function onSerialize( _out )
	{
		_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		_in.readI32();
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

