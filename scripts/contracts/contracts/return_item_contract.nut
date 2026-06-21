this.return_item_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.return_item";
		this.m.Name = "取回物品";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local items = [
			"珍稀硬币收藏品",
			"仪式手杖",
			"丰产神像",
			"黄金护身符",
			"奥秘知识之书",
			"密码箱",
			"恶魔雕像",
			"水晶颅骨"
		];
		local r = this.Math.rand(0, items.len() - 1);
		this.m.Flags.set("Item", items[r]);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追踪%townname%附近的足迹",
					"归还%item%给%townname%。"
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
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					if (this.Contract.getDifficultyMult() >= 0.95)
					{
						this.Flags.set("IsNecromancer", true);
					}
				}
				else if (r <= 30)
				{
					this.Flags.set("IsCounterOffer", true);
					this.Flags.set("Bribe", this.Contract.beautifyNumber(this.Contract.m.Payment.getOnCompletion() * this.Math.rand(100, 300) * 0.01));
				}
				else
				{
					this.Flags.set("IsBandits", true);
				}

				this.Flags.set("StartDay", this.World.getTime().Days);
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, [
					this.Const.World.TerrainType.Mountains
				]);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Thieves", false, this.Const.World.Spawn.BanditRaiders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一群盗贼和土匪。");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
				party.setAttackableByAI(false);
				party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				party.setFootprintSizeOverride(0.75);
				this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_bandits_0" + this.Math.rand(1, 6));
				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追踪%townname% %direction%的足迹",
					"归还%item%给%townname%。"
				];

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					if (this.Flags.get("IsCounterOffer"))
					{
						this.Contract.setScreen("CounterOffer1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("BattleDone");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
				}
				else if (this.World.getTime().Days - this.Flags.get("StartDay") >= 3 && this.Contract.m.Target.isHiddenToPlayer())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					if (this.Flags.get("IsNecromancer"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Necromancer");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Bandits");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"归还%item%给%townname%。"
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% 不安地走来走去，一边解释是什么困扰着他。%SPEECH_ON%我这里发生了一桩明目张胆的盗窃！ 可恶 的强盗偷走了我的 %itemLower%，这对我来说有着不可估量的价值。 我请求你去追捕那些盗贼并把它带回来。%SPEECH_OFF%他压低音量到一个更固执的语调。%SPEECH_ON%你不仅会拿到不少报酬，你还会让 %townname% 的人民安心！%SPEECH_OFF% | %employer% 阅读着许多卷轴中的一卷。 他愤怒的把它丢到另一堆里。%SPEECH_ON%%townname% 的人民非常愤怒。你知道有个强盗，可能还有其他的流浪汉，成功偷了我的 %itemLower%。那件神器对我来说有着不可估量的价值！还有…当然对于人民也是。%SPEECH_OFF%你耸耸肩。%SPEECH_ON%所以你想要我替你去把它夺回来？%SPEECH_OFF%他指出手指。%SPEECH_ON%没错，聪明佣兵！这就是我想要你做的。 跟随那些贼的足迹并夺回属于我的…城镇的东西！%SPEECH_OFF% | %employer% 手里拿着个苹果转过身来。 他看来有点烦躁，就好像他想要点别的比如值钱的首饰又或者更好吃的水果。%SPEECH_ON%你曾经失去过你爱的东西吗？%SPEECH_OFF%你耸耸肩答道。%SPEECH_ON%有个女孩…%SPEECH_OFF%这人摇了摇头。%SPEECH_ON%不，不是女人。 更重要的。因为我有！盗贼偷了我的%itemLower%。他们怎么绕过我的卫兵的，好吧，我也不知道。但是我知道如果我派你去抓他们我就可以拿回我的东西。 我说的对吗？又或者我对你的服务质量有什么误解？%SPEECH_OFF% | 一条狗在 %employer% 脚边打瞌睡。他向前靠来抚摸狗耳朵后面。%SPEECH_ON%我听说你很擅长找人，佣兵。还有…解决问题。%SPEECH_OFF%你点头，毕竟确实如此。%SPEECH_ON%好…很好…我有个任务给你。一个简单的任务。 有件对我而言很有价值的东西被偷了，我的 %itemLower%。我需要你去追踪那些小偷，然后很显然，杀了他们，然后把它拿回来。%SPEECH_OFF% | 一只鸟立在 %employer%的窗户上， 他坐着指向鸟。%SPEECH_ON%我寻思他们或许就是这么进来的，我是说强盗。我想他们肯定从窗户摸进来然后出去的。他们就是这么带走我的 %itemLower%。%SPEECH_OFF%他慢慢站起走过房间。 他蹲下来，准备好扑向鸟，但是它在他动之前就逃走了。%SPEECH_ON%Damn.%SPEECH_OFF%他回到椅子上，好像他未遂的抓鸟行动让他流了很多汗一样擦手。%SPEECH_ON%我的任务很简单，佣兵。 把我的财产拿回来。还有如果你不介意的话，杀了强盗。%SPEECH_OFF% | 灰尘覆盖了 %employer%的桌子，但是上面有个地方看起来更干净点。他示意向那个点。%SPEECH_ON%那是我的 %itemLower% 曾经摆着的地方。如果你看不到它，它就是不见了。%SPEECH_OFF%你点头。它看起来确实不见了。%SPEECH_ON%带走它的盗贼应该很好追踪。 晚上这些强盗思考的的还行，但是他们在白天犯了很多错。 脚印，铺张的消费…你应该很轻松就能追踪到他们。%SPEECH_OFF%他用坚毅的眼神看着你。%SPEECH_ON%你明白吗，雇佣兵？ 我想要你去夺回我的财产。 我想要把它放在他该摆的地方。 而且…我想要这些盗贼去死。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{这对你值多少钱？ | 我们来谈谈酬劳。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我不这么认为。}",
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
			ID = "Bandits",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_80.png[/img]{强盗！跟你的雇主猜的一样。 他们看起来很害怕，或许知道 %employer% 花了大价钱雇来的怒火要降临在他们身上。 | 啊，小偷显然是人－一群普通的流浪汉和强盗。 他们准备战斗而你命令你的手下开始进攻。 | 你跟上了一群强盗正拖着你雇主的财产。 他们对于你找到他们很震惊而且没有花时间试图谈判-他们武装起来而你命令 %companyname% 开始冲锋。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Necromancer",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_76.png[/img]{这里有强盗，正如预期的那样，但是他们正在把 %itemLower% 交给一个穿着深色破烂衣服的人。 你的存在，毫不意外的，中止了交易并且强盗和阴森的人都拿起了武器。 | 你看到强盗把 %employer%的财产交易给一个看起来像是亡灵巫师的人！ 或许他想要它来对雇主家族施什么邪恶巫术。 某种程度上来说，这不是那么坏…但是，他花钱雇你是来干活的。冲锋！ | %employer%的财产被强盗卖给了一个惨败的黑衣人！ 他在那些人面前瞪着你，他呆滞的黑眼瞬间聚焦在了你的战队上。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, {
							Type = this.Const.World.Spawn.Troops.Necromancer
						});
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CounterOffer1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_76.png[/img]{你从剑上擦下血然后前去取回物品。 随着你弯腰捡它，你看到一个人在远处看你。 他走过来，他的双手被长袖盖住握在一起。%SPEECH_ON%看来你杀了我的主人的手下。%SPEECH_OFF%收起剑，你点头。他继续道。%SPEECH_ON%我的主人花了笔大价钱来获得那个宝物。 看起来他雇的人不再能够收钱了，或许我可以直接跟你谈。 我会给你 %bribe% 克朗买下它。%SPEECH_OFF%这…是不少钱。%employer%，或许对于你接受不会很高兴… | 战斗后，一个人从林线出现，拍手。%SPEECH_ON%我给了这些人不少钱，但是看起来我应该付给你。 现在这些强盗都死了，我可以这么做！%SPEECH_OFF%在你用剑刺穿他之前，你告诉他快点说到点上。 他向宝物示意。%SPEECH_ON%我会付你 %bribe% 克朗买下它。 这些钱本来是要给盗贼的，还有再加上一点。怎么样？%SPEECH_OFF%%employer% 不会默默接受你的背叛，但是钱不少… | 战斗结束了，你捡起 %itemLower% 检查它。 这真的值得这么多人命吗？%SPEECH_ON%我知道你在想什么，佣兵。%SPEECH_OFF%声音传来。 你拔剑指向不知从哪里冒出来的陌生人。%SPEECH_ON%你在想，会不会有什么人付你一大笔钱去偷那个宝物？ 如果那个人给我非常大一笔钱会怎么样？ 或许...比雇你来取回它的人更多的钱。%SPEECH_OFF%你放下武器并点头。%SPEECH_ON%有趣的想法。%SPEECH_OFF%他微笑着。%SPEECH_ON%%bribe% 克朗。这是我愿意付你的钱。 那是盗贼的部分还有额外加的。 不错的交易。 当然，你的雇主会非常不开心，但是…好吧，这里不是我在做决定。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我一眼就能认出好生意。 把克朗拿过来。",
					function getResult()
					{
						this.updateAchievement("NeverTrustAMercenary", 1, 1);
						return "CounterOffer2";
					}

				},
				{
					Text = "我们被雇来夺回它，而且我们正要这么做。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CounterOffer2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_76.png[/img]你把 %itemLower% 交出去然后陌生人递给你一个非常沉重的袋子。 交易完成了。 可以确信 %employer%，你的雇主对你不会有什么好脸色。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好酬劳。",
					function getResult()
					{
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没能归还被盗的 " + this.Flags.get("Item"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "BattleDone",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束，你从敌人手中取回了 %itemLower% 并准备回去找 %employer%。他显然会很高兴看到你成功返回！ | 那些偷了 %itemLower% 的小偷都死了，而且你找到了它。%employer% 对你的工作成果肯定会很开心。 | 好，你找到了那些为偷窃 %itemLower% 负责的小偷并解决了他们。 现在你只需要把 %itemLower% 交回 %employer%的手上收取报酬！ | 战斗结束了而且 %itemLower% 很轻易的就在你的敌人尸体间找到了。 你应该把它还给 %employer% 拿取你应得的报酬！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们去收钱吧。",
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
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 从你手中拿回了 %itemLower%，紧紧的抱着好像是他孩子一般。 他的眼睛泪汪汪的看着他的宝物。%SPEECH_ON%谢谢你，佣兵。这对我意味着很多…我是说，额，城镇。 我们感谢你！%SPEECH_OFF%你盯着他停下来。 他的眼睛看向房间的角落。%SPEECH_ON%我们的…谢意，佣兵…%SPEECH_OFF%卫兵打开一个大木箱。 你数了数克朗然后离开了。 | 当你回去找 %employer% 时他在耍笼子里的一只鸟。%SPEECH_ON%啊，佣兵回来了…然后呢？%SPEECH_OFF%你举起宝物然后把它放在他的办公桌上。 他拿起它，旋转，点头，然后收了起来。%SPEECH_ON%好极了。然后为了弥补你的麻烦…%SPEECH_OFF%他向一个装满克朗的箱子挥手。 | %employer% 把他的腿放在两只狗身上，一只压着另一只。%SPEECH_ON%这些野兽可以撕了我的喉咙，但是…看看他们。 这怎么发生的？ 我甚至没有训练他们。别人做的。 我对他们是陌生人但是他们就这么让我压着。%SPEECH_OFF%你把宝物放在他的桌子上滑过去。 他前倾，收下它，然后放在他办公桌下。 当他手回来，他手里有一个袋子。 他丢它过来。%SPEECH_ON%如同我们谈好的。干得好，佣兵。%SPEECH_OFF% | 在你进入 %employer%的房间时，许多的守卫在围着他。 有一瞬，你怀疑自己碰巧撞上了场兵变，但是他们散开了，留下骰子和卡片。%employer% 招手叫你进去。%SPEECH_ON%来，来。我刚刚丢了很多克朗，佣兵。 或许你带了些能够缓和我痛苦的东西…？%SPEECH_OFF%你拿出 %itemLower% 握在手中。 他小心的收下它。%SPEECH_ON%好…非常好…你的报酬，当然，在这里。%SPEECH_OFF%他递过来一袋克朗后坐在椅子上转过身去。 他看起来太过沉浸与宝物以致没有再说什么。 | %employer% 笑着看你回来。%SPEECH_ON%佣兵，佣兵，你能告诉我你成功了吗？%SPEECH_OFF%你拿出宝物并把它放在桌上。%SPEECH_ON%Sure.%SPEECH_OFF%他从椅子上弹起来拿走了它。 他转身面对你，冷静下来。%SPEECH_ON%好。你干的很好。 非常好。%reward_completion% 克朗，如同约定的。%SPEECH_OFF%他递过来一袋硬币。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "归还被盗的 " + this.Flags.get("Item"));
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
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_75.png[/img]{你伏身地面，手摸了摸，让一些灰尘从你的手指中过滤。 但是只有土－没有路过它的脚印。 实际上，你已经有一段时间没看到脚印了。%randombrother% 靠近你，蹲下来耸肩。%SPEECH_ON%先生，我想我们跟丢了。%SPEECH_OFF%你点头。%employer% 不会很高兴，但事实就是这样。 | 你跟着偷 %itemLower% 的人足迹好一段时间，但是线索断了。 你经过的路人不知道任何事情，而且地面上没有可以追踪的足迹。 不管怎么说，%itemLower% 丢了。%employer% 对此不会满意的。 | 一个足迹放时间长了就会被另一个覆盖。 然后另一个。还有另一个。 你花了很长时间追踪偷了 %itemLower% 的盗贼而世界的线路，一如既往的繁忙，覆盖了他们的足迹。 你现在没机会找到他们了而且 %employer% 会非常生气。 | %itemLower%的盗贼们的足迹消失了。 最后一组足迹把你带到了一个农庄，而且他们看起来不像是小偷，他们也不认识上述人。%employer% 对于丢失他的物品不会很开心，但是你现在也做不了什么。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "该死的合同！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没能归还被盗的 " + this.Flags.get("Item"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
		_vars.push([
			"item",
			this.m.Flags.get("Item")
		]);
		_vars.push([
			"itemLower",
			this.m.Flags.get("Item").tolower()
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

