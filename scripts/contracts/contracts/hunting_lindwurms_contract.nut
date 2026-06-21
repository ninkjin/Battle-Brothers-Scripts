this.hunting_lindwurms_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_unholds";
		this.m.Name = "狩猎林德虫";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(95, 135) * 0.01;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 800 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Bribe", this.Math.rand(300, 600));
		this.m.Flags.set("MerchantsDead", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追捕城镇附近的林德虫于 " + this.Contract.m.Home.getName()
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

				if (r <= 10)
				{
					this.Flags.set("IsAnimalActivist", true);
				}
				else if (r <= 25)
				{
					this.Flags.set("IsBeastFight", true);
				}
				else if (r <= 35)
				{
					this.Flags.set("IsMerchantInDistress", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, [
					this.Const.World.TerrainType.Mountains
				]);
				local nearTile = this.Contract.getTileToSpawnLocation(playerTile, 4, 7);
				local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Lindwurm", false, this.Const.World.Spawn.Lindwurm, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("林德虫，一种无翼双足龙，形似巨蛇。");
				party.setFootprintType(this.Const.World.FootprintsType.Lindwurms);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Lindwurms, 0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(2);
				roam.setMaxRange(8);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
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
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsMerchantInDistress"))
					{
						if (this.Flags.get("MerchantsDead") < 5)
						{
							this.Contract.setScreen("MerchantDistressSuccess");
						}
						else
						{
							this.Contract.setScreen("MerchantDistressFailure");
						}
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 15.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsBeastFight"))
				{
					this.Contract.setScreen("BeastFight");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsMerchantInDistress"))
				{
					this.Contract.setScreen("MerchantDistress");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAnimalActivist"))
				{
					this.Contract.setScreen("AnimalActivist");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_combatID != "Lindwurms")
				{
					return;
				}

				if (_actor.getType() == this.Const.EntityType.CaravanDonkey || _actor.getType() == this.Const.EntityType.CaravanHand)
				{
					this.Flags.increment("MerchantsDead");
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
					if (this.Flags.get("BribeAccepted") && this.Math.rand(1, 100) <= 40)
					{
						this.Contract.setScreen("Failure");
					}
					else
					{
						this.Contract.setScreen("Success");
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
			Text = "[img]gfx/ui/events/event_77.png[/img]{%employer% 正盯着一个篮子里的什么东西。 几个农民在角落里略显紧张的挠着头。 你问道怎么回事。 你的潜在雇主把你带到篮子边，里面有一条蛇在滑动。 很温顺，而且颜色的排列方式并没有表明它的腹部带有毒素。 你跟他说出了你的判断。 他耸耸肩盖上了盖子。%SPEECH_ON%打算杀了吃的来着，用它的皮来给一把匕首做鞘。 我需要你做的是去找一只比这个大得多的蛇。 我是说林德沃姆，佣兵。大家伙。 游荡着，在一片腹地以我的人民为食。 你有自信解决这个状况吗？%SPEECH_OFF% | 你发现 %employer% 正在一座蛛网比知识还多的个人图书馆里翻来覆去。 他看起来注意到了你并问你知不知道林德沃姆是什么。 在你能回答前他转过身来，手里拿着个卷轴。%SPEECH_ON%我需要你去一片腹地。 我们手上正面临着几只这样的怪物。 它们正在屠杀农夫，小贩。 可恶，这中间有些人还挺受欢迎的。 我想你正是我们需要的人，来解决这些野兽。有兴趣吗？%SPEECH_OFF%你看到他的卷轴展开了一些，露出一张袒胸露乳的女人的粗糙绘画。 他赶紧把它卷了起来收到背后。他笑起来。%SPEECH_ON%额，考虑下？%SPEECH_OFF% | 一排农民站在 %employer%的门前。 你插了他们所有人的队，当几个人提出抗议时你握住了你的剑柄。%employer% 冲出来介入。%SPEECH_ON%放松点，放松点伙计们。 这是我想请的雇佣兵。 先生，请，让我解释这急躁情绪的缘由。 林德沃姆在郊区破坏着一切所以我们需要一个魁梧的佣兵，像你这样的，去杀了它们。有兴趣吗？%SPEECH_OFF%之前愤怒的人们现在正像看救世主一样看着你。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你要我们完成的可真是份大差事。 | 与这样的敌人作战，我希望有个好价钱。 | 我希望你给我报酬得有点份量。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{听起来你需要的是英雄和蠢货。 | 它不值得冒险。 | 我不这么认为。}",
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
			Text = "[img]gfx/ui/events/event_66.png[/img]{%randombrother% 用他的武器踮起了一片鳞皮。 他摆了摆它，皮质发出刺耳的剐蹭声。 你让他别玩了并提高警惕。 林德沃姆无疑很近了。 | %randombrother% 说他曾经听说一个林德沃姆杀了人却不吃的故事。%SPEECH_ON%没错。他们说它吐出口绿水然后他就这么化的只剩靴子了。 听说那看起来像片糊糊一样。%SPEECH_OFF%令人作呕的故事，但应该很能让伙计们保持注意力。 这些林德沃姆不会很远了。 | 追寻着踪迹，草地被压成一条蛇形的图案两边各有多个洞。%randombrother% 蹲在图案前。%SPEECH_ON%一个抓不住地的犁或者就是我们在找的家伙。%SPEECH_OFF%你点头。林德沃姆不远了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "当心！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_129.png[/img]{你检查地图时 %randombrother% 喊了起来。 抬起头，你看到几只林德沃姆从地面上一个洞中冒了出来，大片的尘土从它们身边泄下。 它们压低躯体贴近地面冲向了 %companyname%。你拔出你的剑并命令伙计们组成阵型。 | 战队来到了个洞口排着的一排巨石前。 但随着你靠近，石头被弹起并在半空中翻腾，数条腿涌出，爬出来的毫无疑问是林德沃姆。 你看着这些野兽扭着摆了摆灰用喉咙发出低沉的咽声，后退了几步。 它们转向你，眨着眼，并开始慵懒的前进，好像你的雇佣兵们不过是一点小麻烦。 你命令战队组成阵型。 怪物们，或许感到你更有威胁，突然冲了起来，响亮的嘶嘶发着声以令人意外的速度滑过地面。 | %companyname% 走向一个每一步都传出骨头碎裂声的山坡。%randombrother% 嘘了一声并指向丘顶。 几只林德沃姆正蜷缩着。 看起来注意到你的视线，怪物们伸展开来并慢步走下坡，一些半弯着好像孩子滚下山丘一般。 它们的颚咔嗒的拍打着，长舌从眼中舔走尘土，总的来说比起杀人怪物更像群正在梦游的小动物。 但是它们落足平地时一瞬便冲了起来，它们蛇一般的形态滑过骨场，碾碎的骨粉随着它们行进扬起。 拔出剑，你赶紧命令伙计们进入阵型。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnimalActivist",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_17.png[/img]{你发现这群林德沃姆围着地上挖出来的一个坑滑动，在你可以进入战斗前一个人用人发出的嘶嘶声打断了你。 他看起来好像好几天没刮胡子了，两个肩膀上都挎着一个大袋子，以及一条头带把它的头发集起成一团灌木丛一样。 除了外表憔悴，他还没有武器。 你问他想干什么。 他用匆促而压低的语气说道。%SPEECH_ON%你是来这杀这些林德沃姆的？%SPEECH_OFF%型似蛇的怪物们在远处滑动着，看起来像小猫小狗一样玩耍着。 你点头并告诉他说它们杀了人而且你被雇来杀了它们。 他咬了咬嘴唇。%SPEECH_ON% 看到它们鳞片映出的辉光了吗？ 那是它们特有的，而且它们是濒危物种。 这些是稀有林德沃姆，先生，而且它们的灭绝对这个世界会是个巨大损害。 要不我给你 %bribe% 克朗然后，额，你是被人雇来的，对吧？ 所以你也拿上这个。%SPEECH_OFF%他从袋子里掏出一件巨大，粗糙的林德沃姆皮衣并提出交给你。%SPEECH_ON%告诉你的雇主你找到并杀死了林德沃姆并给他看看这个。 他们注意不到区别的。 而且如果你在寻思背叛我，让我说清楚，我看起来有点疯但实际上我更痴狂。 而且像我这样的疯子，如果没点本事，可没法一路活着跟踪这些巨大，棒极了，美丽的林德沃姆，懂了吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "滚开，蠢货。 我们还有野兽要杀。",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				},
				{
					Text = "好的，我接受你的提议。",
					function getResult()
					{
						return "AnimalActivistAccept";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsAnimalActivist", false);
			}

		});
		this.m.Screens.push({
			ID = "AnimalActivistAccept",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_17.png[/img]{在你看来这里的林德沃姆们并不真的是你的麻烦，你只是被雇来解决它们。 而且你还可能拿到两份报酬，如果那个保护林德沃姆的疯子的皮衣骗到了 %employer%。\n\n你接受了交易。 那个蠢货谢谢你并意外的拥抱了你。 他闻起来糟糕透顶而且他的头发变得如此蓬乱油腻以致小虫子都在那挖出坑来并且能看到正盯着你。 一只迷你蜥蜴在黏糊糊的发杆间游走并抓住了其中一只虫子。 你推开他并愿他好运，不论他在做什么。 他竖起大拇指和粉红指头并摆起手。%SPEECH_ON%你，先生，非常有正义感。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "正义感。 Right.",
					function getResult()
					{
						local bribe = this.Flags.get("Bribe");
						this.World.Assets.addMoney(bribe);

						if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
						{
							this.Contract.m.Target.getSprite("selection").Visible = false;
							this.Contract.m.Target.setOnCombatWithPlayerCallback(null);
							this.Contract.m.Target.die();
							this.Contract.m.Target = null;
						}

						this.Flags.set("BribeAccepted", true);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				local bribe = this.Flags.get("Bribe");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + bribe + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "BeastFight",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_129.png[/img]{灰尘正如云涌般从远方的一个洞口冒出。 随着你靠近，你听到林德沃姆的嘶嘶声还有别的完全不同东西断断续续的低吼声。%SPEECH_ON%看啊，老大！%SPEECH_OFF%%randombrother% 指向洞口的边缘。 两只食尸鬼正在与一只林德沃姆缠斗，一只扒在尾巴上被甩来甩去，另一只正徒手和它的头搏斗以免被咬。 怪物们正在互相残杀！\n\n摇了摇头，你拔出你的剑命令伙计们组成阵型。 看来这场战斗要打得鸡飞狗跳了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不知道这是好还是坏。",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Lindwurms";
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Ghouls, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistress",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{你察觉到一个商人和他的载重货车沿着路靠近。 载重货车的后方被掀起，一同起飞的还有飞得像布娃娃一样的商队成员。 一缕绿色的条纹在商队后面滑动着而另一条抄到了侧面。 商人转身跳进了载重货车里，这时林德沃姆们正展开进攻。 这些无疑正式你在找的生物。 在你的号令下，%companyname% 极速前进，可能还来得及救下这个商队。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "攻击！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Lindwurms";
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						p.Entities.push({
							ID = this.Const.EntityType.CaravanDonkey,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/objective/donkey",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanDonkey,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/objective/donkey",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.CaravanHand,
							Variant = 0,
							Row = -1,
							Script = "scripts/entity/tactical/humans/caravan_hand",
							Faction = this.Const.Faction.PlayerAnimals,
							Callback = null
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "撤退！",
					function getResult()
					{
						this.Flags.set("IsMerchantInDistress", false);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistressSuccess",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_41.png[/img]{The battle is over. 你让手下剥了几条林德沃姆的皮同时走过去跟商人谈谈。 他弯腰致谢并轻吻了你没有戒指的手指。%SPEECH_ON%谢谢你，先生，太感谢了！ 噢，我的载重货车！我的货物！%SPEECH_OFF%他的眼睛转向了他商队的残骸。 他瘫倒再地，膝盖埋入废墟，摇摇头。%SPEECH_ON%我希望我有东西能拿来报答你，陌生人，但是什么都没了。%SPEECH_OFF%但之后他竖起了根指头。 他跃起脚尖并问你有没有张地图。 你给他看了看你的地图，而他拿出了根羽管笔。%SPEECH_ON%这儿，我知道一个传说有很多宝藏的地方。 我不知道真实与否，但是谣言属实那将是千缠万贯。%SPEECH_OFF%很好，如果是的话。不论如何，你向商人的慷慨表达了谢意并愿他在接下来的路程中好运。 至于 %companyname%，该回去找 %employer% 拿报酬了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们哪天该去那地方参观一下。",
					function getResult()
					{
						this.Contract.setState("Return");
						local bases = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
						local candidates_location = [];

						foreach( b in bases )
						{
							if (!b.getLoot().isEmpty() && !b.isLocationType(this.Const.World.LocationType.Unique) && !b.getFlags().get("IsEventLocation"))
							{
								candidates_location.push(b);
							}
						}

						if (candidates_location.len() == 0)
						{
							return 0;
						}

						local location = candidates_location[this.Math.rand(0, candidates_location.len() - 1)];
						this.World.uncoverFogOfWar(location.getTile().Pos, 700.0);
						location.getFlags().set("IsEventLocation", true);
						location.setDiscovered(true);
						this.World.getCamera().moveTo(location);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "MerchantDistressFailure",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{The battle is over. 你让半队伙计们去剥林德沃姆好回去给 %employer% 看看。 另一半搜寻着商队的残骸。 没有什么值得注意的发现，金子都没有。 一切有价值的东西都在战斗中被敲碎了。 商人自己被分成了两半并且腿落在相当一段距离外，口袋翻出来，空空荡荡的，%randombrother% 蹲在遗体边。他点着头。%SPEECH_ON%好吧，这真是个遗憾的结局。 破碎，而且破产。%SPEECH_OFF%你点头回应然后唤伙计们打好包。 是时候回去找雇主拿报酬了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少我们了结了那些野兽。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_130.png[/img]{与林德沃姆战斗就好像用黄油刀往一篮子毒蛇里去捅。 他们像从什么别的世界来的一样战斗，嘶嘶着，喷吐着还有撕咬着，但是它们斗不过 %companyname%的决心和技巧。 你让伙计们剥去这些生物的头皮和皮肤，好准备回报 %employer% 拿丰厚的报酬。 | 林德沃姆们在一番激斗后倒下了。 战队人员保持距离捅了捅尸体，以确认这些杂种真的死了。 几只发着咕哝声挣扎了一下，但也不过是最后的苟延残喘而已。 你命令剥解这些过度生长的蜥蜴。%employer% 总会想要看点证据的。 | 你蹲在一条林德沃姆边用手抚过它的皮肤。 你寻思，以这些鳞片长度和锋利程度，足以在卡入夹缝区里的时候把你的手指切断。 之后你插着腰站到头边上望向它的喉里，用手测量了下它的牙齿，另一边用剑试探了下它的食道。%randombrother% 走到你身边问他们接下来做点什么。 你从林德沃姆的喉咙里拔出剑，擦干净，并把它收回个正常的剑鞘里。 你命令伙计们从这几只野兽身上剥点皮并准备回头去找 %employer%。 | 战斗结束，你下令把林德沃姆剥了皮并搜刮一切值钱的东西。 没过多久，战场上充满了蜥蜴们的恶臭，这些过大的蜥蜴开始被剥离曾经保护它们的鳞片。 它们恶心，泛光的肌肉结构显露出来，曾经不可一世的怪物正裸露且显得脆弱着。%randombrother% 哼了一声并用衣袖遮住了他的鼻子。 他向他的杰作点头。%SPEECH_ON%就是个普通物种，不过是比正常的大一点。%SPEECH_OFF%没错。你命令伙计们集齐收集好的东西并准备回去找 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们做到了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_77.png[/img]{你拽着些林德沃姆皮肉走进 %employer%的房间。 他从他的办公桌上抬起头，审视着鳞片还有一长桶蛇皮，接着看了看你，又看了看他的出纳员并点了点头。 出纳员拿出一袋克朗并交了过来。%employer% 回到了他之前的工作中，一边用羽管笔写着字边跟你说道。%SPEECH_ON%干得好，佣兵。这些杂种的报告完全停止增加了，所以我想这些钱花的物有所值。 留下皮。我有个人可以用它做几双好靴子。%SPEECH_OFF%搞半天 %companyname% 只是在为这蠢货整双新靴子？ 你摇摇头并表示告别。 | %employer% 迎接了你，还有你拽着的又长，又糙，鳞片状，刮着地板的林德沃姆皮。 你把它抛过地板，它像件硬皮大衣一样弹了弹。这位镇长点了点头。%SPEECH_ON%干得非常，非常好，先生！ 太棒了。你的报酬，如同约定的。%SPEECH_OFF%他递给你一个沉沉地装着克朗的袋子。 | %employer% 正烤着火取暖。 他坐在椅子上转过身来看到了你带过来的林德沃姆皮肉。这位镇长点了点头。%SPEECH_ON%干得不错，佣兵。 我很好奇，这些蜥蜴杂种四肢会长回来吗？ 我听说一些爬行动物会这种诡计。%SPEECH_OFF%你耸耸肩说，杀死他已经尽了剑所能及的科学探索精神。%employer% 咬了咬嘴唇。%SPEECH_ON%啊。好。你的报酬就在那个角落里，谈好的价钱。%SPEECH_OFF%他回身转向篝火，他在毛毯里调整到舒服的姿势并从冒着蒸汽的杯子里抿了一口。 | %employer% 在外面被一群嘈杂的农民们围着。 你大声盖过人群并展示出你带来的林德沃姆皮。 人群安静了一阵，互相窸窸窣窣着，然后再次大叫了起来。 你咬着嘴唇并用手肘从人群中打出一条路来并要求拿到你说好的报酬。%employer% 喊人们散开来给他点呼吸空间。 两个卫兵紧紧的站在一边，他教给你一个皮袋。%SPEECH_ON%干得好，佣兵。如果不全可以回来杀了我。 我不会介意的，在这该死的日子。%SPEECH_OFF%随着你拿上袋子离开，一个农民用手指着镇长说道。%SPEECH_ON%我跟你说，那个该死的狗杂种，我所谓的“好邻居”，偷了我的鸟而且如果他不把它们还回来我就把他家农场点咯！%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除镇上的林德虫");
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
		this.m.Screens.push({
			ID = "Failure",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你发现 %employer% 在他的房间里，而且充满了卫兵。 不确认怎么回事，你向这位镇长展示了林德沃姆的皮肉并要求拿到报酬。 他的手拍了一下然后像锯木锯一样向前展开。%SPEECH_ON%我不认为这是那玩意，佣兵。 我不知道你从哪弄来你带着的那个皮衣，而且相信我，我看得出来它旧的像屎一样而不是什么新剥下来的，更重要的是我依然在收到大蜥蜴摧毁农场的报告所以如果你不介意，请自觉离开城镇，在我放另一种掠食者找你之前。%SPEECH_OFF%深吸一口气，你看了看卫兵们。 他们人太多了。%employer% 叹了口气。%SPEECH_ON%如果你想保护你的荣誉，不要这么做。 我好不容易才说服这些家伙不在你踏入门的一刻伏击你。 我这么做是出于我仅存的一点尊重。 不要浪费它，哼？%SPEECH_OFF%行吧。事已至此而且你不论如何只能怪自己。 你关上门离开了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "不足为奇。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 2, "试图骗取镇上的钱");
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
			this.m.Flags.get("Bribe")
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
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
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setAttackableByAI(true);
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
				this.m.Target.getController().getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
				this.m.Target.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
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

