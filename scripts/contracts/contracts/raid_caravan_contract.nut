this.raid_caravan_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		LastCombatTime = 0.0
	},
	function setEnemyNobleHouse( _h )
	{
		this.m.Flags.set("EnemyNobleHouse", _h.getID());
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.raid_caravan";
		this.m.Name = "掠夺商队";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 800 * this.getPaymentMult() * this.getDifficultyMult() * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		local myTile = this.World.State.getPlayer().getTile();
		local enemyFaction = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse"));
		local settlements = enemyFaction.getSettlements();
		local lowest_distance = 99999;
		local highest_distance = 0;
		local best_start;
		local best_dest;

		foreach( s in settlements )
		{
			if (s.isIsolated())
			{
				continue;
			}

			local d = s.getTile().getDistanceTo(myTile);

			if (d < lowest_distance)
			{
				lowest_distance = d;
				best_dest = s;
			}

			if (d > highest_distance)
			{
				highest_distance = d;
				best_start = s;
			}
		}

		this.m.Flags.set("InterceptStart", best_start.getID());
		this.m.Flags.set("InterceptDest", best_dest.getID());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"掠夺从%start%到%dest%的商队",
					"返回 %townname%"
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
				this.Flags.set("Survivors", 0);

				if (r <= 10)
				{
					this.Flags.set("IsBribe", true);
					this.Flags.set("Bribe1", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
					this.Flags.set("Bribe2", this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * (this.Math.rand(70, 150) * 0.01)));
				}
				else if (r <= 15)
				{
					if (this.Contract.getDifficultyMult() >= 1.0)
					{
						this.Flags.set("IsSwordmaster", true);
					}
				}
				else if (r <= 20)
				{
					if (this.Contract.getDifficultyMult() >= 1.0)
					{
						this.Flags.set("IsUndeadSurprise", true);
					}
				}
				else if (r <= 25)
				{
					this.Flags.set("IsWomenAndChildren", true);
				}
				else if (r <= 35)
				{
					this.Flags.set("IsCompromisingPapers", true);
				}

				local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
				local best_start = this.World.getEntityByID(this.Flags.get("InterceptStart"));
				local best_dest = this.World.getEntityByID(this.Flags.get("InterceptDest"));
				local party = enemyFaction.spawnEntity(best_start.getTile(), "Caravan", false, this.Const.World.Spawn.NobleCaravan, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("base").Visible = false;
				party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
				party.setMirrored(true);
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
				party.setDescription("一支有武装护卫的商队正在两个定居点之间运输值得保护的物品。");
				party.setFootprintType(this.Const.World.FootprintsType.Caravan);
				party.getFlags().set("IsCaravan", true);
				party.setAttackableByAI(false);
				party.getFlags().add("ContractCaravan");
				this.Contract.m.Target = this.WeakTableRef(party);
				this.Contract.m.UnitsSpawned.push(party);
				party.getLoot().Money = this.Math.rand(50, 100);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 2);
				party.getLoot().Ammo = this.Math.rand(0, 20);
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/roots_and_berries_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/dried_fruits_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/ground_grains_item");
				}
				else if (r == 5)
				{
					party.addToInventory("supplies/pickled_mushrooms_item");
				}

				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(best_dest.getTile());
				move.setRoadsOnly(true);
				local despawn = this.new("scripts/ai/world/orders/despawn_order");
				c.addOrder(move);
				c.addOrder(despawn);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
					this.Contract.m.Target.setVisibleInFogOfWar(true);
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					if (this.Flags.get("IsWomenAndChildren"))
					{
						this.Contract.setScreen("WomenAndChildren1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsCompromisingPapers"))
					{
						this.Contract.setScreen("CompromisingPapers1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setState("Return");
					}
				}
				else if (this.Contract.isEntityAt(this.Contract.m.Target, this.World.getEntityByID(this.Flags.get("InterceptDest"))))
				{
					this.Contract.setScreen("Failure3");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Target))
				{
					this.onTargetAttacked(this.Contract.m.Target, false);
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);

					if (this.Flags.get("IsBribe"))
					{
						this.Contract.setScreen("Bribe1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSwordmaster"))
					{
						this.Contract.setScreen("Swordmaster");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsUndeadSurprise"))
					{
						this.Contract.setScreen("UndeadSurprise");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.onTargetAttacked(_dest, true);
					}
				}
				else if (this.Time.getVirtualTimeF() >= this.Contract.m.LastCombatTime + 5.0)
				{
					local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
					enemyFaction.setIsTemporaryEnemy(true);
					this.Contract.m.LastCombatTime = this.Time.getVirtualTimeF();
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (!_actor.isNonCombatant() && _actor.getFaction() == this.Flags.get("EnemyNobleHouse") && this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("Survivors", this.Flags.get("Survivors") + 1);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Contract.m.LastCombatTime = this.Time.getVirtualTimeF();
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回 %townname%"
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsCompromisingPapers"))
					{
						if (this.Flags.get("IsExtorting"))
						{
							this.Contract.setScreen("CompromisingPapers2");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Contract.setScreen("CompromisingPapers3");
							this.World.Contracts.showActiveContract();
						}
					}
					else if (this.Flags.get("Survivors") == 0)
					{
						this.Contract.setScreen("Success1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Math.rand(1, 100) > this.Flags.get("Survivors") * 15)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("Failure2");
						this.World.Contracts.showActiveContract();
					}
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{你就座时 %employer% 展开了张地图在你面前。 他的手指划过一条潦草画下的道路。%SPEECH_ON%这条路上有一个商队。 我需要人去攻击他，但是等等！%SPEECH_OFF%他举起手指。%SPEECH_ON%我需要它看起来像是强盗干的。 不能让任何人知道它的毁灭是我下的命令，明白吗？%SPEECH_OFF% | %employer% 解释道他需要一个商队被摧毁。 你问他为什么，准确的回答，一个他这样的贵族会放出这样一个工作，但他对细节支支吾吾。 他的主要需求很简单，摧毁商队并把那里的所有人都杀死。 必须让现场看起来像是 {强盗 | 破坏者 | 流浪汉 | 绿皮} 干的，不然他的声誉可能被玷污。%SPEECH_ON%你听清楚最后一段了吗，佣兵？ 你当然听清楚了。 你是个聪明人，对吧？%SPEECH_OFF% | 你就座时 %employer% 从书架上拿出一本大书并在你面前打开它。 它的宽度覆盖了整张桌子并且书页上绘画着非常详细的地图。 贵族指向地形图上的一根线。%SPEECH_ON%那是我需要摧毁的商队的路线。 不要问我更多问题，我只是要它被摧毁。 现在，我的唯一要求就是你把它伪装的像是强盗干的，好吗？ 不能让人知道我发出了这个命令。 你能做到吗？%SPEECH_OFF% | %employer% 握手欢迎你，但是当你试图收回手的时候他紧紧的抓住了你。%SPEECH_ON%我现在要说的话不能传到这个屋子外，懂吗？%SPEECH_OFF%你点头后他松开了手。%SPEECH_ON%很好。我需要一个商队被摧毁，但是…不能让人知道是你，雇佣兵干的。 如果他们知道了，他们很轻松就能查到我头上来。 I need it to look like the work of brigands. 不留活口，好吗？%SPEECH_OFF%你耸耸肩好像在说，“轻轻松松。”%SPEECH_ON%很好，那么交易达成？%SPEECH_OFF% | 随着在 %employer%的书房里就座，一个陌生人跟着你走进来跟贵族说悄悄话。 然后，就那样，神秘男子转身离开了。%employer% 站起来给他自己倒了杯葡萄酒。 他没有给你任何东西。%SPEECH_ON%我需要一个商队被摧毁，但我需要这件事带有一定秘密的完成。 不能让人知道我，%employer%，告诉你去干这件事。 不，它得是强盗干的，那些杂种…懂吗？ 你理解了吗？理解了就让我们谈谈价钱。%SPEECH_OFF% | 随着你就座，%employer% 询问到你有多了解强盗的工作。 你说他们的生活和你的并没有那么大区别，只是你更聪明而且能让那些会给你比抢劫屁民更有赚头的工作的人注意到而已。%employer% 点头。%SPEECH_ON%很好，因为我需要你装一天强盗并摧毁一个商队。 不留活口。 不留任何人知道是你，雇佣兵，干的。 明白了吗？如果你懂了，让我们谈谈价钱。%SPEECH_OFF%}",
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
			ID = "Bribe1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{随着你靠近商队，其中一个守卫注意到了你，所有人都掏出了武器。 一个人，呼喊着举手跑过来，要所有人放下武器。 他手中有个袋子，沉甸甸的装着 %bribe% 克朗，并且说你可以拿走它只要你让他们走。 你大声寻思为什么不在杀了他们之后拿走这些钱。他耸耸肩。%SPEECH_ON%这显然会省掉你“杀掉”我们的麻烦，毕竟我们不会这么一打就会倒下。 拿了钱走吧，佣兵。%SPEECH_OFF% | 随着你的人靠近商队，其中一个守卫看到你吹响号角，向其他人发出了警告。 很快，整队护卫站在了你面前，准备好战斗。 车队领头穿过他们的战线，举起他的手。%SPEECH_ON%别动武器，伙计们！ 佣兵，我想跟你做个交易。 你把这袋 %bribe% 克朗拿走这样就没人会死在这里。%SPEECH_OFF%你张嘴回应，但是他举起根手指继续说着。%SPEECH_ON%哇哦，好好想想，雇佣兵。 你没有先发优势了，而且我雇用的这些人来保护这些载重货车是有充分理由的－他们是杀手，就像你一样。%SPEECH_OFF% | 随着你的人接近，商队的毁灭看来近在咫尺。 不幸的，你看到其中一个佣兵走错了一步，踩到一根滑动的树干使他摔下了一个小山坡。 噪音足够响亮到警报整个车队而且你看着武装守卫涌出来面对你。 他们的军官跑到两个战帮间，他的手伸到空中。%SPEECH_ON%等等。就等等。在我们开始杀戮之前，我们谈谈，好吗？ 我这里有 %bribe% 克朗。%SPEECH_OFF%他举起一个袋子并向你晃了晃。%SPEECH_ON%你拿上这个，离开，就这样分道扬镳。 没必要自相残杀，对吧？ 我得说这是个很好的交易，佣兵，特别是看你现在没有优势了－这会是男人间的正面交锋。 你怎么说？%SPEECH_OFF% | 就在你认为你的人要开始攻击商队的时候，一个看守看着载重货车的人发现了他们。 快速跑到铃铛前，他发出了警告，就在 %randombrother% 打破他的头骨前。 不幸的，一大片守卫的同行冲出来，举着武器。 他们的领袖站在他们身边，召回冲锋命令。%SPEECH_ON%吼，伙计们！不是现在。 让我们在这个节点上，或许，讨论一个更…不暴力的方式。%SPEECH_OFF%他瞥了一眼倒在地上的守卫。%SPEECH_ON%好吧，至少为我们剩下的人。 我这手里有 %bribe% 克朗。 你的了，伏击者，刺客，不论你怎么称呼自己，只要你拿上它离开。 而且我建议你这么做－你没有优势了而且我花了很多钱雇这些人保护我，明白了吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{So be it. 把克朗拿过来。 | 合理的价格，我们接受。}",
					function getResult()
					{
						return "Bribe2";
					}

				},
				{
					Text = "无关个人恩怨，但这个商队必须被摧毁。 连你一起。",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Bribe2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{随着你开始离开，商队头领抓住了你的手臂。%SPEECH_ON%嘿，我很好奇一些事情，而且我打赌你一定有什么东西可以满足我的好奇心。%SPEECH_OFF%你生气的甩开他抓住的你的手臂。 他抱歉，但是很快开始问问题。%SPEECH_ON%我想知道谁派的你。 %bribe2% 克朗来向我透露这个消息怎么样？%SPEECH_OFF% | 商队头领在你可以离开前抓住你。%SPEECH_ON%我在寻思些事情，佣兵，而我知道你有答案：谁派的你？%SPEECH_OFF%你看向周围。他笑着拍了拍你的肩。%SPEECH_ON%显然，我不会免费接受你的回答。 那个袋子里再加 %bribe2% 克朗怎么样？ 只要几个词来组成一个他们称为“名字。” 你来给我这个名字怎么样，雇佣兵。%SPEECH_OFF% | 领头在你离开前叫住你。 他叉着手臂，脚无意识的踢着石头。%SPEECH_ON%你知道的，我还不能让你离开。 这里有一个相关信息我想要了解并且我愿意给那个袋子里加 %bribe2% 克朗来知道上述信息。%SPEECH_OFF%你看向四周，确认没有埋伏等着你。 然后转身面向他点头。%SPEECH_ON%你想知道谁派的我。%SPEECH_OFF%领头笑着拍拍手。%SPEECH_ON%小子，你学的可真快！ 当然！我想知道！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{那么把克朗拿过来。 | 非常好，毕竟这个节点上也没什么区别了。 | 一个好交易刚刚变的更好了。}",
					function getResult()
					{
						return "Bribe3";
					}

				},
				{
					Text = "我不会这么背叛我们的声誉，我们这就走了。",
					function getResult()
					{
						return "Bribe4";
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(this.Flags.get("Bribe1"));
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
				this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe1") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Bribe3",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{你收下了额外的克朗，放起来，给了领头人名字：%employer%。他的舌头弹起来好像某种有毒坚果。%SPEECH_ON%%employer%。%employer%！好，他啊。%employer%，就好像什么…好吧，我不会用我突然涌现的脏话欲望拖住你。 我向你表示感谢，佣兵，向你道别。%SPEECH_OFF%你点头离开了。 | 夺下额外的克朗，你告诉领头人今天的特别词：%employer%。他听到后破口大小并且重复点头好像他一直都知道一样。%SPEECH_ON%做得好，佣兵。 真是特别的一天，不是吗？ 一开始你来这里是想用剑刺穿我，但几分钟后，我们就这样友好地告别了。 一个杰出的生意人。 真遗憾你选择把这种天赋用在利刃上而不是笔上。再见并保重。%SPEECH_OFF% | {得盎，进磅。 | 得寸，进里。} 你接受他的提议并透露出 %employer%的事情。 商队头领郑重地点头。%SPEECH_ON%你知道的，我们生意人不像你一样拿着武器，但相信我，我们一样致命。 好运，佣兵。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不需要杀任何人就能收到报酬。 我可以适应这个。",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(this.Flags.get("Bribe2"));
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
				this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", true);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe2") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Bribe4",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{你告诉他滚。 他已经足够幸运了。 他点头，表示认同，但他紧张的表情告诉了你一切你需要知道的。 | 你摇了摇头。%SPEECH_ON%那我得放你们走，这我做不到。 我还需要 %employer% 的工作，懂吗？%SPEECH_OFF%The man nods.%SPEECH_ON%聪明的决策，尽管对我的不幸，显然。 但是是的，我理解你，佣兵。 愿旧神陪伴你的旅途。 当我们再次见面，希望情形会更好！%SPEECH_OFF% | 背叛 %employer% 可能不是最好的注意并且你告诉了他这些。他点头，表示理解。%SPEECH_ON%好，好吧。我不能责备你保留这些底牌，但我还是希望你能展示它们。好运，雇佣兵。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们走！",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Swordmaster",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_35.png[/img]{在准备袭击商队时，%randombrother% 来到你身旁并指向其中一个在车队上坐着的人。%SPEECH_ON%知道那是谁吗？%SPEECH_OFF%你摇了摇头。%SPEECH_ON%That's %swordmaster%.%SPEECH_OFF%你眯着眼看更清楚，你只看到一个普通人。 雇佣兵解释道他是一个有名的剑术大师并杀了无数的人。 他挠挠鼻头并且吐了口唾沫。%SPEECH_ON%还想进攻吗？%SPEECH_OFF% | 你用望远镜观察着商队发现了一张熟悉的脸：%swordmaster%。几年前你在 %randomtown% 的斗技大会里见过他。 如果你记得没错，他一只手绑在背上赢得了那场比赛。 任何在马下面对他的人都被快速的击杀了，展示出绝佳的剑术。 这个家伙很危险并且应该小心靠近。 | 侦查着车队，你看到张见过的脸。%randombrother% 靠近你，用刀抠着指甲缝。%SPEECH_ON%那是剑术大师，%swordmaster%。 他今年已经杀了二十个人。%SPEECH_OFF%你身后传来声音。%SPEECH_ON%我听说是五十！或许六十。 四十五如果我们更实际点…%SPEECH_OFF%哼，看起来商队护卫里有个最危险的敌人…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, {
							Type = this.Const.World.Spawn.Troops.Swordmaster
						}, true, this.Contract.getDifficultyMult() >= 1.1 ? 5 : 0);
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "UndeadSurprise",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_29.png[/img]{跟着攻击命令，你的手下冲过了草坪。 商队护卫跑向你，但他们看起来很害怕。 在他们后面跟着一大群五颜六色的生物。 可以说这将会是一场最奇异的交汇… | 随着 %companyname% 跑向商队，武器在手，几个人停下来指出车队另一头有支更大的队伍在靠近。 停下来仔细看了看，你意识到有一大群亡灵正在向这里汇集！ | 好吧，看来这不会像你想的那样简单：随着你的人开始发起攻击，%randombrother% 发现了一大群毛骨悚然的亡灵正从另一头靠近！ 亡灵或者即将死亡，这不重要。 你到这来是替 %employer% 办事的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos(), true);
						p.CombatID = "UndeadSurprise";
						p.Music = this.Const.Music.UndeadTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.TemporaryEnemies = [
							this.Flags.get("EnemyNobleHouse")
						];
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							enemyFaction.getBannerSmall(),
							this.Const.ZombieBanners[0]
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Necromancer, 100 * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WomenAndChildren1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你的手下清理着现场任何生还者，这时 %randombrother% 带着一群女人和小孩在身后找到你。 你举起剑问怎么回事。%SPEECH_ON%看样子他们带着家庭一起。 你想让我们怎么做？%SPEECH_OFF%如果你让他们走，他们很有可能泄露你的所作所为。 如果你杀了他们，好吧，这种行为恐怕能让任何人的精神受到重压… | 赢得了胜利，你的手下散开来收集战利品并确保每个商队护卫都死了。 不幸的，不是所有人都死了－而且不全是成年人。 一群女人和孩子从废墟中出现，像受伤的败犬一样懦弱的缓慢靠近着。 其中几个身上都是血，其他的都从战斗中被保护了下来。%randombrother% 问该怎么做。%SPEECH_ON%我们大概应该让他们走因为，好吧，看看他们。 但是…他们可能走漏风声。 你知道女人和她们的大嘴巴。%SPEECH_OFF%雇佣兵紧张的笑着。 其中一个女人抱紧他的胸口。%SPEECH_ON%我们不会告诉任何人，我们保证！%SPEECH_OFF% | 战斗结束了，你找到了一群女人和小孩在商队的废墟中。 他们缓慢的走过来，看起来知道如果他们逃跑只会给你一个追杀的理由。 其中一个女人，抱着一个婴儿在她胸口，恳求道。%SPEECH_ON%求你了，你已经给了我们这么多痛苦。 我们的父亲，丈夫，兄弟，你把他们全杀了。 这还不够吗？让我们走吧。%SPEECH_OFF%%randombrother% spits.%SPEECH_ON%这帮孩子看到我们做了什么。 他们会长大，记着它。 而这些女人，好吧，她们会告诉所有人。 她们总这么做。%SPEECH_OFF%他看向你，暗示向一把半竖的利刃。%SPEECH_ON%你想让我们做什么，先生？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们的工作要求不留活口，这也是我们得做的。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						return "WomenAndChildren2";
					}

				},
				{
					Text = "见鬼去吧－让他们走。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(2);
						this.Flags.set("Survivors", this.Flags.get("Survivors") + 3);
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WomenAndChildren2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你点头示意 %randombrother%。他走上前去，手里拿着武器，快速地砍下一个女人的头。 血如泉涌，她的孩子们被血弄住了眼睛，以至于看看不到向他来的下一刃。  惨叫随着你的手下一刀一刀穿过恐惧的人群慢慢减少成零星的呜咽声。 你的手下再次确认了他们的工作直到受害者都安静了下来。 | 你的手轻轻一挥，下达了命令。%randombrother% 花了不到一瞬间一刀刺穿了一个孩子的脸，连同刺中了他身后的母亲的子宫，然后向上一划，夺走了她的生命。 剩下的人也出动了，有的迟疑还有的带着些许敬畏执行着。\n\n 随着恐怖的哭号，你感到有些的佣兵挥舞着武器只是为了让这种噪音离开他们的脑海。 暴力吞噬了一切，一场疯狂的放纵，你不知道是人类某种行为的顶点亦或是另一种行为的最低点，因为一切含义都消失了而形容这种暴行的词汇你在你的语言，祖先的语言还是超过你眼前这片黯淡的终焉中都无法找到。 它就是一个事件。 | 不幸的，没人可以幸存。 你喊出命令而雇佣兵们开始了工作。 一个女人靠近，看起来听错了并问哪条路去最近的城镇。%randombrother% 对她头上一次猛击回应了她。 恐惧的孩子们随风逃散让你回想起过去狩猎兔子的时光。 跑的最快的雇佣兵们追了上去而剩下的留下来解决了他们的家长。 这真是一副凄惨的景象。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好吧，这不是一份漂亮的工作，但那正是我们得到报酬的原因。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CompromisingPapers1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{随着商队燃烧，你的手下在残骸中搜刮着。%randombrother% 带着些纸找到你。%SPEECH_ON%这些可能有点意思，长官。%SPEECH_OFF%你打开其中一卷读了读。 看起来 %employer% 又一个非常，非常不可告人的动机来特别攻击这个车队。 如果有些人知道了这些信息真会是相当遗憾… | 载重货车仍然在燃烧，你走到一个木箱前把它踢开了。 卷轴冒了出来，展开来随风飘散。 你抓住其中一张读了读。 这是一份有关 %employer%的领地收入－或者欠收－报告。 看起来本来是要暴露出他的财务问题。 你可以，如果你想，用这个对付他… | 你在商队的废墟中找到一盒纸。 其中一个卷轴显示了一个关于 %employer% 的东西，他很可能知道这个东西会放在载重货车中一起旅行的。 这肯定是他要你来干这活的原因…它可以被用来攻击他。 你不认为他会想到你能找到它。 毕竟，你只是个愚蠢的佣兵…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "把它们和其他的一起烧了。",
					function getResult()
					{
						this.Flags.set("IsCompromisingPapers", false);
						this.Contract.setState("Return");
						return 0;
					}

				},
				{
					Text = "我们会把它交给我们的雇主以表忠诚。",
					function getResult()
					{
						this.Flags.set("IsCompromisingPapers", true);
						this.Contract.setState("Return");
						return 0;
					}

				},
				{
					Text = "我们的雇主得多付我们钱才能得到这些。",
					function getResult()
					{
						this.Flags.set("IsCompromisingPapers", true);
						this.Flags.set("IsExtorting", true);
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CompromisingPapers2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_63.png[/img]{你回到 %employer% 举起了文件。 他几乎立刻认出来一份卷轴上的一个印章。%SPEECH_ON%什么…这些是什么？%SPEECH_OFF%放下文件，刚要解释，他冲上来，试图从你手上抢下它们。 你后退使他没有得逞。 他挺起身，看起来为了挽回点镇定。%SPEECH_ON%好吧佣兵。我知道会发生什么。 你想要多少？%SPEECH_OFF%关上门，你们两个谈好了价钱。 | %employer% 欢迎你归来，手里拿着两杯酒转身，但他的笑容很快淡去了。%SPEECH_ON%你手里的是什么？ 你从哪里搞到那玩意的？%SPEECH_OFF%你把这份证明有罪的文件收起并点头，回答道。%SPEECH_ON%我想你知道我从哪拿到的。 而且我认为你知道接下来会发生什么。 现在…让我们谈谈生意，怎么样？%SPEECH_OFF%他喝下了一杯，然后另一杯。%SPEECH_ON%是的。好吧。关上门，好吗？%SPEECH_OFF% | 你走进 %employer%的房间把证明有罪的文件丢在了他的办公桌上。 他看着他们然后笑道。%SPEECH_ON%好蠢的错误！%SPEECH_OFF%他揉起了文件藏到桌子底下。 你回以大笑并拿出了另一串卷轴。%SPEECH_ON%你以为我有多蠢？%SPEECH_OFF%他快速拿出揉成一团的文件看看。 他意识到你只留了一页在里面，其余都是空的。 坏笑着，你指出基本规则。%SPEECH_ON%现在我知道这些对你有多重要，让我们谈谈生意好让它们都回到你这里，怎么样？%SPEECH_OFF%他坐下点头，面露难堪。 他取出来一个死人钱袋，装满克朗，并把它放在办公桌上，之后向入口示意。%SPEECH_ON%请，关上门。%SPEECH_OFF% | 当你回来时，%employer% 马上认出来你带着的文件上的印章。 他屋内有几个守卫，但很快就被他赶出去了，叫他们去花园里赶兔子。 他关上门面向你。%SPEECH_ON%我看得出来我暴露了。%SPEECH_OFF%你点头。他咬了咬嘴唇回以点头。%SPEECH_ON%那么好吧。纸上的内容不能离开这个房间。 你想要多少？%SPEECH_OFF%你举起一条腿在他的桌上就座，把文件放在身边拍着手。坏笑着，你回答道。%SPEECH_ON%一切的价值都取决于买方愿意付出多少，对不对，贵族？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "最终报酬不错。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail * 2, "敲诈勒索");
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
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() * 2 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "CompromisingPapers3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_63.png[/img]{你回到 %employer% 而他转向你，看起来很生气。%SPEECH_ON%你知道人们在谈论你做了什么，对吗？%SPEECH_OFF%微笑着，你举起证明有罪的文件。%SPEECH_ON%你想让他们换过来讨论这个吗？%SPEECH_OFF%他倒抽一口气，坐回椅子上。%SPEECH_ON%好吧，你要勒索我是吗？%SPEECH_OFF%你把文件放在桌上摇了摇手。%SPEECH_ON%我想过，但是我更倾向于不因为这次握着点美味就去咬喂食的手。%SPEECH_OFF% | %employer% 唤你进入他的房间。%SPEECH_ON%屁民们都在讨论你。 那个商队里有人还活着并且在诉说他们的遭遇。%SPEECH_OFF%你点头表示认同。%SPEECH_ON%这很好理解。%SPEECH_OFF%他咕哝着想要指指点点，但你指向了证明有罪的文件。 他带着不安的安静打量了一下。%SPEECH_ON%我…我明白了…你想要更多钱吗？%SPEECH_OFF%你把文件丢给他。%SPEECH_ON%不。你原谅我，我原谅你。够公平，对吧？%SPEECH_OFF%他急匆匆地把文件藏到大衣里点头。 | 你发现 %employer% 正在照料花园。 几个守卫在不远处站岗，并且你怀疑逗留在场的其中一个农民也是便衣警卫。%SPEECH_ON%佣兵！很高兴见到你，除了一件微小的事情。%SPEECH_OFF%他让你靠近并降低音量。%SPEECH_ON%你让几个商队的人逃跑了。 我记得这不是交易的一部分。%SPEECH_OFF%你举起证明有罪的文件。%SPEECH_ON%我也记得这不是交易的一部分。%SPEECH_OFF%%employer% 极力后退，然后回到常态以免卫兵起疑心。%SPEECH_ON%好吧，我拿走这些，然后我忘掉整个让该死的人活下来的约定，好吗？%SPEECH_OFF%你交出文件。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "来之不易的克朗。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "使用取得的文件妥协");
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
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到 %employer% 报告你的成功。 他热情的欢迎了你－沉重的一袋克朗。%SPEECH_ON%做得好佣兵。你有没有，呃，看到些什么东西？%SPEECH_OFF%一个奇怪的问题，但你没有追问。 你告诉他一切就如结果一样。 他点头快速道谢后回到了工作中。 | %employer% 在你回来时站在窗边。 他在喝着一杯葡萄酒，在杯子里和嘴里晃着。%SPEECH_ON%我的小鸟们告诉我商队被摧毁了。 它们唱的歌，是真的吗？%SPEECH_OFF%你点头并告诉他消息。 他交过来一箱克朗，感谢你的服务并回到窗边。 你离开前注意到他侧脸微微上扬的嘴角。 | %employer% 在你回来时正抚摸着他的狗。 他的手在毛发间颤抖。%SPEECH_ON%我想车队被摧毁了？%SPEECH_OFF%你告诉他细节。 他点头，但他的手停了下来。%SPEECH_ON%你有没有…找到些有意思的东西？%SPEECH_OFF%你思考了一下，但是没有什么不寻常的东西。 他微笑着再次抚摸他的狗。%SPEECH_ON%谢谢你的服务，佣兵。%SPEECH_OFF% | %employer% 在你回来时正在写着什么。 他匆忙放下羽毛笔站起身。%SPEECH_ON%所以它被摧毁了？商队，我是说。%SPEECH_OFF%你报告了你“服务”的结果。他大笑着拍起手。%SPEECH_ON%好极了！太棒了，佣兵！ 你不知道你帮了我多大一个忙。 当然，你的报酬，如同约定的…%SPEECH_OFF%他递过来 %reward_completion% 克朗的袋子。分文不差，但你寻思为什么他为这么平常的事情这么高兴…你是不是错过了什么？ | %employer% 在你回来时正跟他的议员交谈。 他赶走他们。 不寻常的景象－看着这些权力人物给个佣兵让道。 你腰板挺得更直了一点，报告了商队毁灭的消息。%SPEECH_ON%谢谢你，佣兵。这就是我在等着的消息。 还有的你报酬，当然…%SPEECH_OFF%他把一个木制宝箱放到办公桌上并推了过来。 它足够沉重以致留下了划痕。%SPEECH_ON%%reward_completion% 克朗，如同我们谈好的。%SPEECH_OFF%你很好奇为什么贵族会支开议员来跟佣兵单独对话，但决定不要深究。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "摧毁了一个商队");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{你回来找到 %employer% 坐在办公桌边，手弓在面前，他的大拇指字面意义的压在他的额头。 他的双手向前放下开始说话。%SPEECH_ON%你让…他们活下来了…%SPEECH_OFF%你举起手指纠正他：不是所有人。%SPEECH_ON%旧神的永夜啊，我他么雇你是为了什么啊？%SPEECH_OFF%他停下来，然后耸耸肩。%SPEECH_ON%好吧，我会给你一半的报酬。 毕竟，你还是摧毁了车队，我得承认。%SPEECH_OFF% | %employer% 把条腿翘在办公桌上欢迎你回来，他的泥巴鞋底滴着脏水迎接你。%SPEECH_ON%所以，雇佣兵，解释给我听我雇你去干什么？%SPEECH_OFF%他甩手好像在说，“继续。”你说你被雇来摧毁一个商队并不留一个幸存者。 他竖起一根手指。%SPEECH_ON%重复那最后一段。%SPEECH_OFF%你照做了。他笑了，满意的，然后这笑容变坏，指出你的失败。%SPEECH_ON%好，你没有达到我的要求。 这没问题。你还是做了…一部分，我想。 商队确实被摧毁了…%SPEECH_OFF%他耸耸肩给你一个袋子。 这是你应得的一半。 你想这比没有好。 | %employer% 在你回来时正跟他的卫兵说话。 他唤走他们，尽管一个留在外面的走廊里，他的眼睛几乎要伸到后脑勺来时不时检查你。 你拉出 %employer%的一个椅子，但他叫你就这么站着。%SPEECH_ON%这会很简短的。你没有做到我要求的全部内容，佣兵。 人们在谈论，谈论你。 如果你杀了所有的目击者他们怎么会在谈论呢？ 有点好奇，不是吗？ 我想这是因为你没有杀光目击者，这意味着你没有按我说的做。%SPEECH_OFF%他暂停，用指关节蹭了蹭额头。%SPEECH_ON%好吧，这是我要做的。 我会给你一半的报酬。 一半给你摧毁了商队，一半给我因为我得花钱掩盖。 希望这适合你。%SPEECH_OFF%守卫偷偷走进来。 你点头拿走了报酬。 | %employer% waves you in. 他身边站着一个看着随时准备遍故事的书记员。 你的雇主叉起手臂。%SPEECH_ON%人们在谈论你干的事情…%SPEECH_OFF%他向书记员示意，意外的，他还没有写字。%SPEECH_ON%我不得不花点钱来封些口，明白吗？ 这意味着你只会拿到一半的报酬。%SPEECH_OFF%老书记员笑了。 你注意到他手指上的戒指。 看起来是新铸的。%employer% 几乎在怒视他，但是书记员没有写下任何东西所以你觉得这是件好事。 你拿上你的报酬告别。 | 一群坏笑着的人在你回来时正从 %employer%的房间里走出来。 他要你关上门并马上开口了。%SPEECH_ON%认识这些面孔吗？他们知道你干了什么。 你知道让他们闭嘴花了多少克朗吗？ 你知道这些克朗从哪来吗？%SPEECH_OFF%你耸耸肩，他继续道。%SPEECH_ON%你的报酬，当然。 你只会拿到一半。 你理解为什么吗？%SPEECH_OFF%你点头。生意就是生意。 随着你转身离开，%employer% 抓住你。%SPEECH_ON%而且不要胆敢去想干掉他们拿回你的另一半报酬，佣兵！%SPEECH_OFF%Damn.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "可能更糟…",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能做到在摧毁商队时不让任何人逃脱");
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
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() / 2 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你回来发现 %employer% 坐在他的办公桌边上，前臂立起，他的大拇指深深掐入额头。 放下手，他开始说。%SPEECH_ON%你让…他们活下来了…%SPEECH_OFF%你举起手指纠正他：不是所有人。%SPEECH_ON%旧神的永夜啊，我他么雇你是为了什么啊？%SPEECH_OFF%他停了一刻，然后愤怒。%SPEECH_ON%我在乎这个？ 你放跑的人足够让这个旮旯角落里的村子都讨论了起来。 在我叫守卫把你带出去之前，自己滚。%SPEECH_OFF% | %employer% 把条腿翘在办公桌上用鞋底欢迎你回来。 你注意到他靴子上有血。%SPEECH_ON%所以，雇佣兵，解释给我听我雇你去干什么？%SPEECH_OFF%他甩手好像在说，“继续。”你说你被雇来摧毁一个商队并不留一个幸存者。 他竖起一根手指。%SPEECH_ON%重复那最后一段。%SPEECH_OFF%你照做了。他笑起来，非常满意。%SPEECH_ON%好，你没有达到我的要求。 还在这站着干什么？ 要我叫守卫来还是你自己走出去？ 因为你和我不再有什么生意了。%SPEECH_OFF% | %employer% 在你回来时正跟他的卫兵说话。 他赶走了几个，留下了个头最大的几个。 他上下打量你。\n\n你拉出 %employer%的一个椅子，但他叫你就这么站着。%SPEECH_ON%这会很简短的。你没有做到我要求的全部内容，佣兵。 人们在谈论，谈论你。 如果你杀了所有的目击者他们怎么会在谈论呢？ 有点好奇，不是吗？ 我记得，死证人是不会说话的，这让我相信这些证人活得好好的。 真有趣，因为这不是我花钱让你去做的事情。 现在趁我叫这边的卫兵拔剑穿过你身子前你自己转身给我滚？%SPEECH_OFF% | %employer% waves you in. 他身边站着一个看着随时准备遍故事的书记员。 你的雇主叉起手臂。%SPEECH_ON%人们在谈论你干的事情…%SPEECH_OFF%他向书记员示意，意外的，他还没有写字。%SPEECH_ON%我不得不花点钱来封些口，明白吗？ 这意味着你只会拿到一半的报酬。%SPEECH_OFF%老书记员笑了。 你注意到他手指上的戒指。 看起来是新铸的。%employer% 几乎在怒视他，但是书记员没有写下任何东西所以你觉得这是件好事。 你拿上你的报酬告别。 | 一群坏笑着的人在你回来时正从 %employer%的房间里走出来。 他叫你随手关门，但一个卫兵赶着进来了。 他和 %employer% 说了点悄悄话以及瞟了一眼，看着你关上了门。 你的雇主开门见山的说了。%SPEECH_ON%认识那帮刚出去的人吗？ 他们知道你干了什么。 你知道让他们闭嘴花了多少克朗吗？ 你知道这些克朗从哪来吗？%SPEECH_OFF%你耸耸肩，他继续道。%SPEECH_ON%你的报酬，当然。 为了封他们所有人的口可花了我不少钱。%SPEECH_OFF%你点头。生意就是生意，你得承认，你将一无所得。 随着你转身离开，%employer% 抓住你。%SPEECH_ON%并且想都不要想着去杀他们来拿回你的佣金，佣兵！%SPEECH_OFF%Damn.}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能做到在摧毁商队时不让任何人逃脱");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure3",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_75.png[/img]{在等待商队的时候，一对旅行者从车队应该去的地方走了过来。 他们详细地描述了一辆货车，毫无疑问，那就是你要找的。 最好不要回去找 %employer%。 | 路人的传闻暗示着你要追杀的商队溜到目的地了。 战队不应该再自讨苦吃的回去找 %employer%。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能摧毁商队");
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
			"bribe",
			this.m.Flags.get("Bribe1")
		]);
		_vars.push([
			"bribe2",
			this.m.Flags.get("Bribe2")
		]);
		_vars.push([
			"start",
			this.World.getEntityByID(this.m.Flags.get("InterceptStart")).getName()
		]);
		_vars.push([
			"dest",
			this.World.getEntityByID(this.m.Flags.get("InterceptDest")).getName()
		]);
		_vars.push([
			"swordmaster",
			this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
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
		if (this.World.FactionManager.isGreaterEvil())
		{
			return false;
		}

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

