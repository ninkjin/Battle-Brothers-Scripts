this.hunting_serpents_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_serpents";
		this.m.Name = "狩猎大蛇";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
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
					"追捕附近绿洲的大蛇于 " + this.Contract.m.Home.getName()
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					if (this.Const.DLC.Lindwurm && this.Contract.getDifficultyMult() >= 1.15 && this.World.getTime().Days >= 30)
					{
						this.Flags.set("IsLindwurm", true);
					}
				}
				else if (r <= 20)
				{
					this.Flags.set("IsCaravan", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				local disallowedTerrain = [];

				for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
				{
					if (i == this.Const.World.TerrainType.Oasis)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local mapSize = this.World.getMapSize();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 14, disallowedTerrain);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Serpents", false, this.Const.World.Spawn.Serpents, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("巨大的蛇正扭动着前行。");
				party.setFootprintType(this.Const.World.FootprintsType.Serpents);
				party.setAttackableByAI(false);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(999999);
				c.addOrder(wait);
				this.Contract.m.Home.setLastSpawnTimeToNow();
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
				}

				this.Contract.m.BulletpointsObjectives = [
					"追捕%direction%湿地里的大蛇于" + this.Contract.m.Home.getName()
				];
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsCaravan"))
					{
						this.Contract.setScreen("Caravan2");
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Contract.isPlayerNear(this.Contract.m.Target, 700) && this.Math.rand(1, 100) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsLindwurm"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Lindwurm");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.BeastsTracks;
						properties.EnemyBanners.push(this.Contract.m.Target.getBanner());
						properties.Entities.push({
							ID = this.Const.EntityType.Lindwurm,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/enemies/lindwurm",
							Faction = this.Const.Faction.Enemy
						});
						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else if (this.Flags.get("IsCaravan"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Caravan1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local f = this.Contract.m.Home.getFaction();
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "HuntingSerpentsCaravan";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.EnemyBanners.push(this.Contract.m.Target.getBanner());
						properties.Entities.push({
							ID = this.Const.EntityType.CaravanDonkey,
							Variant = 0,
							Row = 3,
							Script = "scripts/entity/tactical/objective/donkey",
							Faction = f
						});

						for( local i = 0; i < 2; i = ++i )
						{
							properties.Entities.push({
								ID = this.Const.EntityType.CaravanHand,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/humans/conscript",
								Faction = f
							});
						}

						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getType() == this.Const.EntityType.CaravanDonkey && _combatID == "HuntingSerpentsCaravan")
				{
					this.Flags.set("IsCaravan", false);
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
					this.Contract.setScreen("Success");
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 欢迎您进入他的房间，这里是一片荣华富贵的景象，大量的奢侈品如丝绸，毛皮，女人，还有宝石。如此多的宝石。%SPEECH_ON%逐币者，也差不多是你过来的时候了。 我们有个经济问题需要解决。 大蛇正袭扰着 %direction% 边湿地附近的居民。 但更重要的是，我们想要这些大蛇的鳞片。 他们充当最好的…%SPEECH_OFF%他吻着他的双手。%SPEECH_ON%包和鞋子的材料。看看这些女人，她们不想要这些鳞片吗？%SPEECH_OFF%女人看着她们的手并互相讨论着。 维齐尔拍拍手。%SPEECH_ON%手提包，我的甜心们，美丽，温和，大蛇鳞做的手提包！ 是的，笑。很好。 看到了吗？有多难？好了，逐币者。 %reward% 克朗来换取那些鳞片。 这样的价格，你愿意接这个活吗？%SPEECH_OFF% | 你发现 %employer% 抚摸着一只野生的粉羽长黑腿的高个子鸟。 他正喂它蛐蛐，而鸟看起来不怎么在乎。%SPEECH_ON%啊，我糟蹋你了，小可爱。%SPEECH_OFF%他开始喂这奇怪生物长长的银色的鱼，从一个金水桶里活着抓出来的。 他没有看你一眼只盯着鸟一条条地吞着鱼说道。%SPEECH_ON%我们得到消息大蛇出现在了 %direction% 的湿地里。 上述大蛇的鳞片有很高的价值，不在于金钱，当然，而是于我们的品味。 我们想要你去那里把上述鳞片赶到包里并用你的小短腿走回来。%SPEECH_OFF%他竖起一根指头，竖得更高，然后指向他脚底的地板砖。%SPEECH_ON%而作为补偿，我们会付你 %reward% 克朗。%SPEECH_OFF%粉毛的鸟理起自己的毛，似乎正看着你而不是它的看管者。 | %employer% 坐在看起来是桑拿的壁架上，但他的脚埋在一群躺在某种室内水渠的女人们手里。 她们正用着芦苇来呼吸，从你视角判断她们正在按摩他的脚。 荒诞的景象，但维齐尔像对你一样对此毫不在意。%SPEECH_ON%啊逐币者来了。 我们想要，我们一直想要，大蛇的鳞片用以装饰我们的奢侈品。 这些鳞片可以在大蛇身上找到，而它们，哼，好，可以在 %direction% 找到。 在，哼啊啊，湿地里。%SPEECH_OFF%他后仰并短暂的将脚趾抬出水。 扭动着它们，他看向你。%SPEECH_ON%报酬是 %reward% 克朗，你接受这又好又公平的提议吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我很感兴趣。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 这不是我们要找的那类工作。}",
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
			ID = "Banter",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_161.png[/img]{你发现了一长条干瘪的鳞片，粗到可以把你的手臂伸过去，视觉和感觉上都很令人不安。大蛇无疑不会离这些空壳很远。 | 一个嘴里嚼着绿色烟草的人挡住了你。他腰带别着把匕首，柄以蛇皮制成，末端则刻着一颗金制蛇头。%SPEECH_ON%你是大蛇猎人，是吗？我本打算自己动手的，你也见到我的气势和匕首了，但是到头来，我现在更喜欢看别人干活。我就说这么多，它们很近了，那些小蛇。%SPEECH_OFF%你尽快和他告了别。 | 几个儿童在沼泽池子里玩耍，泥巴沾满了膝盖手肘之类的地方。他们看向你问道你想干什么。当你说明你的目的，孩子们笑了起来。%SPEECH_ON%大蛇！它们都是些小意思！你们根本没什么好担忧的。%SPEECH_OFF% | 你发现一堆蛇皮缠绕在一块湿地的树干上。那些大蛇无疑是用了这块树桩来帮助褪皮。至于鳞片的尺寸，每一片都远大于一支箭头，这足够证明大蛇不远了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "睁大眼睛。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_169.png[/img]{最后一条大蛇也被消灭了。你踩在它的头上，然后抬起脚才意识到踩得其实是尾巴。你顺着蛇身找到它的头部并干净利落的斩下它的头。 现在它不再摇摆滑动使得事情简单多了。%employer%会想看到你带着头和所有的鳞片回去的。 | 你环绕着战场一条一条的把蛇丢到袋子里，袋子因它们的体积而膨胀。而且就算死了，它们依旧看起来是在袋子里互相扭动着。收集了所有的大蛇，你准备回去找 %employer%。 | 大蛇都死了，从它们静止的状态可以明显地看出。但为了确保万无一失，你绕了一圈把它们的头都切了下来。 足够确信没东西能承受如此伤害幸存下来，你把大蛇丢进袋子里并准备回去找 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "赶紧结束这件事吧，我们还有克朗要拿。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Lindwurm",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_129.png[/img]你最先看到的一条大蛇看起来围着一颗湿地里的倒树。 当你接近那条蛇时，你意识到有几条别的蛇在附近。 然后你意识到它们围绕的不是树：它的腰晃动翻转过来，你看到了鳞片，如同你手一样大，在光中闪耀，而林德虫仰起头转过来，它尖锐浑黑的眼睛眯起聚焦，然后它张开下颚嘶吼一声，湿地的水面随着它的低吼激起阵阵波浪。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "一只林德虫！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Caravan1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_149.png[/img]{商队通常不会驻扎在湿地，所以你在这里见到一支卫兵跑来跑去的商队时有点意外。 一开始你想他们在卸货，或许他们是群来到藏宝处的土匪，但随着你靠近你看到一个卫兵被一条卷曲、充满杀意的蛇缠起并倒下。 另一个卫兵转过身来，一条大蛇的大嘴咬在他的头上。商人们被攻击了！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保护他们！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Caravan2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_169.png[/img]{战斗结束，商队头领亲自找到了你。%SPEECH_ON%我向你表示感谢，逐币者。 你或许是个金币的奴隶，但你的锁链上不无我们都渴望拥有的东西，行善的意识。%SPEECH_OFF%好吧，你只是来这里找大蛇的，救下商队什么的只不过是偶然巧合，他们也不过是让那些怪物从你的人身上转移注意力的活饵。当你正要告诉他这些时，他手里拿着一包财宝打断了你。%SPEECH_ON%作为你干预的报酬，逐币者。 愿你通往金币的道路更加金光闪耀。%SPEECH_OFF%点着头，你同他握手然后便开始收集大蛇的鳞片。商人问他能不能拿一片，但你把手放在剑柄上告诉他这可不是什么贸易站。他也听懂了。}",
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
			],
			function start()
			{
				local e = this.Math.rand(1, 2);

				for( local i = 0; i < e; i = ++i )
				{
					local item;
					local r = this.Math.rand(1, 3);

					switch(r)
					{
					case 1:
						item = this.new("scripts/items/trade/spices_item");
						break;

					case 2:
						item = this.new("scripts/items/trade/silk_item");
						break;

					case 3:
						item = this.new("scripts/items/trade/incense_item");
						break;
					}

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + item.getName()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_162.png[/img]{一大群女人涌向了你。 她们人太多了，而前往 %employer% 房间的门时隐时现，在一片窸窣的丝巾，来回飘荡的羽毛，闪亮的珠宝，还有你见过的最顺滑的头发大片的旋转，跳跃。 还有一个分外分神的响声。\n\n 你基本上就是被抢走的鳞片而且，毕竟在维齐尔的地盘，没怎么反抗这强抢行为。 随着你人们傻笑着散开，一个年纪大得多的女人留在了现场。 她举着一袋克朗，你的报酬。%SPEECH_ON%维齐尔不想和你说话，逐币者。 他认为这是自降身段。%SPEECH_OFF%你问她和你见面是否是自降身段。她点了点头。%SPEECH_ON%是的，但我比起在维齐尔身下更愿意干点活。 祝你今天愉快，逐币者，并愿你通往硬币的道路金光闪耀。%SPEECH_OFF% | 你在一大群帮手的帮助下分发了大蛇们的鳞片。 维齐尔听着她们的命令，他眼神尖锐的从房间后部一直盯着。 随着她们离开，他抬起手开始拍手。 四个助手赶过来带着一个袋子。 你想这是给你额外奖励的惊喜，但是当他们交给你时你完全可以一手拿起。 你越过盖子看到维齐尔蠢笑着。 你收下了 %reward_completion% 克朗并告别。 | 在维齐尔的地盘上，大蛇们的鳞片并没有在你的手里呆多久。 你见到一系列助手全部赶到他身边来解除你的负担。 维齐尔他本人就在附近，你就知道，或许从哪个窗户或者大门正看着。 但你没见到他。 你只见到他的硬币，在一个害羞的助手交给你的袋子里的 %reward_completion% 克朗。%SPEECH_ON%从我们的陛下而来，向阁下而去。%SPEECH_OFF%仆人说着，然后他踏着小碎步离开了，就这样跑了。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "猎杀了一些巨大的蛇");
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0 && this.Math.rand(1, 100) <= 50)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/moving_sands_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setAttackableByAI(true);
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
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

