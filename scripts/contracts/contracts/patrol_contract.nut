this.patrol_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Location1 = null,
		Location2 = null,
		NextObjective = null,
		Dude = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.patrol";
		this.m.Name = "巡逻";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
		this.m.MakeAllSpawnsResetOrdersOnceDiscovered = true;
		this.m.DifficultyMult = 1.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local settlements = clone this.World.FactionManager.getFaction(this.m.Faction).getSettlements();
		local i = 0;

		while (i < settlements.len())
		{
			local s = settlements[i];

			if (s.isIsolatedFromRoads() || !s.isDiscovered() || s.getID() == this.m.Home.getID())
			{
				settlements.remove(i);
				continue;
			}

			i = ++i;
		}

		this.m.Location1 = this.WeakTableRef(this.getNearestLocationTo(this.m.Home, settlements, true));
		this.m.Location2 = this.WeakTableRef(this.getNearestLocationTo(this.m.Location1, settlements, true));
		this.m.Payment.Pool = 750 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Payment.Count = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Count = 0.75;
			this.m.Payment.Completion = 0.25;
		}
		else
		{
			this.m.Payment.Count = 1.0;
		}

		local maximumHeads = [
			20,
			25,
			30,
			35
		];
		this.m.Payment.MaxCount = maximumHeads[this.Math.rand(0, maximumHeads.len() - 1)];
		this.m.Flags.set("HeadsCollected", 0);
		this.m.Flags.set("StartDay", 0);
		this.m.Flags.set("LastUpdateDay", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				this.Contract.m.BulletpointsObjectives = [
					"巡逻到 " + this.Contract.m.Location1.getName(),
					"巡逻到 " + this.Contract.m.Location2.getName(),
					"巡逻到 " + this.Contract.m.Home.getName()
				];
				this.Contract.m.BulletpointsObjectives.push("在%days%天内返回");

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
				this.Flags.set("EnemiesAtWaypoint1", this.Math.rand(1, 100) <= 25 * this.Math.pow(this.Contract.getDifficultyMult(), 2));
				this.Flags.set("EnemiesAtWaypoint2", this.Math.rand(1, 100) <= 25 * this.Math.pow(this.Contract.getDifficultyMult(), 2) + (this.Flags.get("EnemiesAtWaypoint1") ? 0 : 50));
				this.Flags.set("EnemiesAtLocation3", this.Math.rand(1, 100) <= 25 * this.Math.pow(this.Contract.getDifficultyMult(), 2) + (this.Flags.get("EnemiesAtWaypoint2") ? 0 : 100));
				this.Flags.set("StartDay", this.World.getTime().Days);

				if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().get("Betrayed"))
				{
					this.Flags.set("IsBetrayal", this.Math.rand(1, 100) <= 75);
				}
				else
				{
					local r = this.Math.rand(1, 100);

					if (r <= 10)
					{
						if (this.World.FactionManager.isGreenskinInvasion())
						{
							this.Flags.set("IsCrucifiedMan", true);
						}
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
				this.Contract.m.Location1.getSprite("selection").Visible = true;
				this.Contract.m.Location2.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.NextObjective = this.Contract.m.Location1;
				this.Contract.m.BulletpointsObjectives = [
					"巡逻到 " + this.Contract.m.Location1.getName()
				];

				if (this.Contract.m.Payment.Count != 0)
				{
					this.Contract.m.BulletpointsObjectives.push("每一个你在路上收集的头颅都会得到报酬 (%killcount%/%maxcount%)");
				}

				this.Contract.m.BulletpointsObjectives.push("在%days%天内返回");
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Location1))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("EnemiesAtWaypoint1"))
				{
					if (this.Contract.spawnEnemies())
					{
						this.Flags.set("EnemiesAtWaypoint1", false);
					}
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				this.Contract.addKillCount(_actor, _killer);
			}

			function onCombatVictory( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Location2",
			function start()
			{
				this.Contract.m.Location1.getSprite("selection").Visible = false;
				this.Contract.m.Location2.getSprite("selection").Visible = true;
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.NextObjective = this.Contract.m.Location2;
				this.Contract.m.BulletpointsObjectives = [
					"巡逻到 " + this.Contract.m.Location2.getName()
				];

				if (this.Contract.m.Payment.Count != 0)
				{
					this.Contract.m.BulletpointsObjectives.push("每一个你在路上收集的头颅都会得到报酬 (%killcount%/%maxcount%)");
				}

				this.Contract.m.BulletpointsObjectives.push("在%days%天内返回");
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Location2))
				{
					this.Contract.setScreen("Success2");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("EnemiesAtWaypoint2"))
				{
					if (this.Contract.spawnEnemies())
					{
						this.Flags.set("EnemiesAtWaypoint2", false);
					}
				}

				if (this.Flags.get("IsCrucifiedMan") && !this.TempFlags.get("IsCrucifiedManShown") && this.World.State.getPlayer().getTile().HasRoad && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
				{
					this.TempFlags.set("IsCrucifiedManShown", true);
					this.Contract.setScreen("CrucifiedA");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsCrucifiedManWon"))
				{
					this.Flags.set("IsCrucifiedManWon", false);

					if (this.Math.rand(1, 100) <= 50)
					{
						this.Contract.setScreen("CrucifiedE_AftermathGood");
					}
					else
					{
						this.Contract.setScreen("CrucifiedE_AftermathBad");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				this.Contract.addKillCount(_actor, _killer);
			}

			function onCombatVictory( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);

				if (_combatID == "CrucifiedMan")
				{
					this.Flags.set("IsCrucifiedManWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.Location1.getSprite("selection").Visible = false;
				this.Contract.m.Location2.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.NextObjective = this.Contract.m.Home;
				this.Contract.m.BulletpointsObjectives = [
					"巡逻到 " + this.Contract.m.Home.getName()
				];

				if (this.Contract.m.Payment.Count != 0)
				{
					this.Contract.m.BulletpointsObjectives.push("每一个你在路上收集的头颅都会得到报酬 (%killcount%/%maxcount%)");
				}

				this.Contract.m.BulletpointsObjectives.push("在%days%天内返回");
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
					{
						this.Contract.setScreen("Failure1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("HeadsCollected") != 0)
					{
						this.Contract.setScreen("Success3");
					}
					else
					{
						this.Contract.setScreen("Success4");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("EnemiesAtWaypoint3"))
				{
					if (this.Contract.spawnEnemies())
					{
						this.Flags.set("EnemiesAtWaypoint3", false);
					}
				}

				if (this.Flags.get("IsCrucifiedMan") && !this.TempFlags.get("IsCrucifiedManShown") && this.World.State.getPlayer().getTile().HasRoad && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
				{
					this.TempFlags.set("IsCrucifiedManShown", true);
					this.Contract.setScreen("CrucifiedA");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsCrucifiedManWon"))
				{
					this.Flags.set("IsCrucifiedManWon", false);

					if (this.Math.rand(1, 100) <= 50)
					{
						this.Contract.setScreen("CrucifiedE_AftermathGood");
					}
					else
					{
						this.Contract.setScreen("CrucifiedE_AftermathBad");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				this.Contract.addKillCount(_actor, _killer);
			}

			function onCombatVictory( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);

				if (_combatID == "CrucifiedMan")
				{
					this.Flags.set("IsCrucifiedManWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationPerHead);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%向其中一把椅子的方向举起了一只严厉的手。你坐下了。%SPEECH_ON%这个地区不安全。商人们抱怨路上有强盗和其他威胁。%SPEECH_OFF%他低下头，揉了揉太阳穴。%SPEECH_ON%由于我的所有人都已经很忙，所以我需要你巡逻这个区域。前往%location1%，然后继续到%location2%，再在%days%天内回到这里。如果你遇到任何威胁，确保将其处理掉。我不会支付你在树林中散步的钱，雇佣兵。你将按你带给我的首级来获得报酬。%SPEECH_OFF% | %employer%低声翻阅着地图，他的眼睛像老鹰一样扫视着匆忙奔走的老鼠群。他似乎无法集中注意力。%SPEECH_ON%我的士兵分散到了各个地方。在这。在那。还有那边。这张地图上的这一部分连名字都没有，但他们也在那里。他们不在这里和这里。这就是你的任务，雇佣兵。%SPEECH_OFF% 他停顿了一下，抬头看着你。%SPEECH_ON% 我需要你去巡逻%location1%和%location2%之间的领地，杀死那些认为这条路是他们的人或动物。我相信你知道这种类型的人。但我不是让你去散步的，佣兵。把你打到的每一颗头颅在%days%天内都带回来，我会按每个头颅支付你的报酬。%SPEECH_OFF% | %employer%喝了一口酒，打了个嗝。他似乎很烦恼。%SPEECH_ON% 我通常不会请佣兵来为我巡逻，但我的大部分士兵当前都在别的地方忙碌着。这是一个很简单的任务：去%location1%，然后到%location2%，再在%days%天内返回这里。一路上，杀死对这片土地上的居民构成威胁的每个人和野兽。但一定要确保收集到他们的头颅：我将按照战利品的数量支付你的报酬，而不是按你走的路程。%SPEECH_OFF% | %employer%狡黠地笑了。%SPEECH_ON%我可不仅仅为你的表现付钱，还会根据你搜集到的头颅数量付款。这个前景对你感兴趣吗？因为现在我需要你在%location1%和%location2%的土地上巡逻。你到处走走，杀死一些东西，然后在%days%天内带着你搜集到的头颅回到我这儿。\n\n我会支付你杀死的人的报酬。让我知道你的想法。%SPEECH_OFF% | %employer%在地图上指着一个地方.%SPEECH_ON%我需要你去这里。%SPEECH_OFF%他的手指移动到另一个位置.%SPEECH_ON%然后去这里。一个漫长的巡逻。你可以杀死任何认为自己拥有这些道路的人，但不包括那些姓 %noblehousename% 的人。但务必带回他们的头颅。我不是请你去度假的，只要你在%days%天内返回，我会根据你带来的每个头颅支付报酬。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "我们在说多少？",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "这并不值得我去跑腿。",
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
			ID = "CrucifiedA",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_02.png[/img]%randombrother% 给你带回来了一份侦察报告。%SPEECH_ON%在前面一些被烧焦的村庄里。我看到了一个尸体的肚子被砍成两半。 腿也不见了。他的狗却一直的守在那里。 一直不愿意离开。怎么也哄不动它。 并且还有一头驴死在树上。 在它眼睑的末端贯穿着一根笔直的长矛。%SPEECH_OFF%他顿了顿，想了一下，然后打了一个响指。%SPEECH_ON%哦对！我差点忘了。那边山的另一侧还有一个被钉住家伙。 他还活着。只不过一直在不停地惨叫，但我依旧保持着清醒。 毕竟，面对一个陌生人痛苦的悲鸣并不是件容易的事情。%SPEECH_OFF%",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "啊这。那咱们去看看这个被钉住的家伙。",
					function getResult()
					{
						return "CrucifiedB";
					}

				},
				{
					Text = "没什么需要采取行动的。报告不错。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("IsCrucifiedMan", false);
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedB",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_02.png[/img]你决定冒险去看看那个被钉着的家伙。\n\n 你登上了附近的一座小山，在山坡上往下看。 就像那个佣兵说的那样。 那里确实有个男人被钉在山坡的尽头。 他无力地在那里晃动着，即使是站在你所处的位置也能听到他不间断的悲鸣。%randombrother% 询问要做什么。",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "我们去放他下来。",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50 && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return "CrucifiedC";
						}
						else
						{
							return "CrucifiedD";
						}
					}

				},
				{
					Text = "这显然是个陷阱。让我们等等。",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "CrucifiedE";
						}
						else
						{
							return "CrucifiedF";
						}
					}

				},
				{
					Text = "我们走吧。这事有点不对劲。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedC",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_02.png[/img]你开始担心，会不会因为丢下这个可怜的家伙并让他接受悲惨命运的事实，从而导致你晚上睡不好安稳觉。 你和你的战队开始往山坡的方向走去。 因为你担心有人会伏击你们，所以你们救援的进展速度并没有想象中的那么快，不过貌似没有别的东西在说话。 当你们靠近那个被钉着的男人时他开始歪嘴笑了。%SPEECH_ON%放我下来吧，我发誓会用我的余生来为你而战，我发誓！%SPEECH_OFF%佣兵们拔出了他们的武器不断地顶着那些钉子，并通过不断地扭动木桩从而让这个男人重获自由。 他从那个木桩上滑了下来，当被你的雇佣兵们牢牢接住后，他被缓缓地放在草地上。 在他不停地用水往自己肚子里灌的同时，他说道。%SPEECH_ON%是那些绿皮这样对我的。 他们发现了我是村子里最后一个生还者，然后他们估计是想在我身上多找一些乐子而不是简单的用斧子劈我的脸。 所以直到你们出现之前，我都一直希望的是后者。 虽然我目前的身体还不是太好，但是我尊敬的先生啊，我将会很快地恢复过来并以我的最后最珍贵的财产，也就是以我的名字发誓，我一定会为你赴汤蹈火，我会为你战斗直到死亡或最后的胜利！%SPEECH_OFF%",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "很少有人能在这样的恐怖中幸存下来。 欢迎加入战队。",
					function getResult()
					{
						this.World.getPlayerRoster().add(this.Contract.m.Dude);
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude.onHired();
						this.Contract.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "战队不适合你。",
					function getResult()
					{
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude = null;
						return 0;
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx(this.Const.CharacterVillageBackgrounds);
				this.Contract.m.Dude.getBackground().m.RawDescription = "你把被钉在十字架上的 %name% 从行刑中拉了下来 他发誓效忠你，直到他生命的终结或你最后的胜利。";
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.getSkills().removeByID("trait.disloyal");
				this.Contract.m.Dude.getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
				this.Contract.m.Dude.setHitpoints(1);

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedD",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_67.png[/img]如果你把这个可怜的家伙就这么丢在这儿的话，那么恐怕你今晚也别想睡好了。 你带这战队冲下山坡去救那个家伙，并暗自希望这样做能给自己积点阴德。 当你逐渐靠近时，那个被钉着的男人疲惫地露出微笑。%SPEECH_ON%谢谢你，陌生人！谢谢你谢谢你谢谢－%SPEECH_OFF%突然，他被一根令人作呕，发出“铮”的标枪劈开了胸膛，并深深的贯穿他的整个身体，最后嵌入进他被钉着的木板中。 你迅速的转身回头看，发现有绿皮不断的从附近的灌木丛里冒了出来。 该死，一直都是个陷阱！拿起武器！",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "事件(Event)";
						properties.Music = this.Const.Music.GoblinsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.EnemyBanners = [
							"banner_goblins_03"
						];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(90, 110), this.Const.Faction.Enemy);
						this.World.Contracts.startScriptedCombat(properties, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedE",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_07.png[/img]你决定等一会儿。 当你正一边坐着，一边听着那个半死不活的家伙的哀嚎声开始逐渐越来越小的时候，%randombrother% 突然晃了晃了你的肩膀并朝着一个方向指过去。 有几个强盗正朝着那个被钉着的家伙直径走来。 他们到了那儿后开始聊了一会儿天。 然后其中一个强盗拔出了匕首，刺进了那个可怜的家伙的脚趾里。 他的哀嚎瞬间提高了很多。 惹得其中一个强盗哈哈大笑，并快活地转了几圈。 但不一会儿他突然停了下来。好像张嘴说了些什么。 又伸手向你的方向指了指。你们被发现了！ 你随即对 %companyname% 下令，趁这帮老屁眼们还没组成阵形前对他们冲锋！",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "CrucifiedMan";
						properties.Music = this.Const.Music.GoblinsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.EnemyBanners = [
							"banner_bandits_03"
						];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.BanditRaiders, this.Math.rand(90, 110), this.Const.Faction.Enemy);
						this.World.Contracts.startScriptedCombat(properties, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedE_AftermathGood",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]令人震惊的是，那个被钉着的男人依然在战斗结束后存活了下来。 他不断地用沙哑地腔调对你叫唤，但可以听出他只是一直在简单地重复“救救我”。 你叫兄弟们放他下来。 但他一落地就倒下不起，不过他又突然颠簸地爬了起来并抓着你。%SPEECH_ON%谢谢你，陌生人。非常感谢。 那些兽人…他们席卷了这里…然后又来了一帮强盗抢劫了这里剩下的物资…但是你，还有你们跟那帮人完全不一样。 谢谢你！如你所见，现在的我已经一无所有了，但我仍有力气去杀了那些夺走我一切的杂种。 我是 %crucifiedman%，这名字是我仅存的财产了，如果你能赏我个脸并赐予我声誉，我在此发誓，我的剑将永远为你挥舞，直到我死或为你带来最终的胜利。%SPEECH_OFF%",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "很少有人能在这样的恐怖中幸存下来。 欢迎加入战队。",
					function getResult()
					{
						this.World.getPlayerRoster().add(this.Contract.m.Dude);
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude.onHired();
						this.Contract.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "战队不适合你。",
					function getResult()
					{
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude = null;
						return 0;
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx(this.Const.CharacterVillageBackgrounds);
				this.Contract.m.Dude.getBackground().m.RawDescription = "你把被钉在十字架上的 %name% 从行刑中拉了下来 他发誓效忠你，直到他生命的终结或你最后的胜利。";
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.getSkills().removeByID("trait.disloyal");
				this.Contract.m.Dude.getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
				this.Contract.m.Dude.setHitpoints(1);

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedE_AftermathBad",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]那些强盗们都被干翻了后，你想去瞧一下那个被钉着的男人，查看一下他的状态如何。 他没有活下来。 但你发现他身上啥都没有，于是你搜刮了这些强盗的东西之后，带领着 %companyname% 重返至原先的小道上。",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "安息吧。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CrucifiedF",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_02.png[/img]你决定等一会儿。 那个半死不活的男人现在在生死线之间徘徊。 他的嚎叫越来越小声了，虽然还算挺好听的，但对于一个快死的人来说并不是什么好事。 过了一小会儿，%randombrother% 站到了你的面前，建议战队去看看那个家伙的情况。 你想了想，认为现在那个男人旁边设埋伏的几率非常小。 你带着战队沿着山坡快步跑到被钉着的男人身边。 他的下巴抵着胸膛，眼睛半张半闭，一滴混杂着血液的口水粘液像一条线一样，从他的嘴唇旁落了下来。 你看了看他，身无分文，于是你命令 %companyname% 重返至原先的小道上。",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "安息吧。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isOffendedByViolence() && !bro.getBackground().isCombatBackground())
					{
						bro.worsenMood(0.5, "你让一个被钉在十字架上的人慢慢死去");

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
			ID = "Success1",
			Title = "在%location1%...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你顺利到达了 %location1% 并带着伙计们进行休整。 在他们休息的时候，你开始清点团队的物资，并确保没有一件东西被弄丢。 不一会儿，你就带领着你的战队继续前进了。 | 你们在 %location1% 停了下来，这是巡逻落脚点的第一站，你准备让你的伙计们休息一会儿。 因为考虑到接下来还有更长的路要走，所以开始寻思要不要在这儿弄点补给之类的。 | 巡逻的第一阶段结束了。 但你打算继续向前出发。 你跟你的伙计们说了一声后他们就开始止不住的抱怨太累。 你又跟他们讲，给他们发工资不是为了听他们发牢骚的，但是他们嘴臭的更厉害了。 | 你到达了巡逻的第一个落脚点，准备让伙计们休息几分钟，并用这一点时间来清点一下团队的物资。 巡逻路程只完成了三分之一。 你开始寻思在离开这儿之前有没有必要再多屯点装备来以防万一。 | 你安全的到达了 %location1% 并且大部分情况下都很安全。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "我们继续前进。",
					function getResult()
					{
						this.Contract.setState("Location2");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Math.rand(1, 100) <= 33)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/safe_roads_situation"), 2, this.Contract.m.Location1, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "在%location2%...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%location2% 就如它所说的在这里。 你叫伙计们去多休息一会儿，同时计划着巡逻路程的最后一段该怎么走。 | 你巡逻到了 %location2%，并且听到了大部分对佣兵的流言蜚语以及看到了市民对你们投出了满腹狐疑的目光。 你仍还有另一段路要走，所以在这里补充物资倒是一个不错的选择。 | 你的伙计们很快的散进了 %location2%的酒馆里。 而你则开始简单地清点了一下你的物资，同时觉得在这里补给一下也未尝不可。 没一会儿，你漫不经心地往小酒馆那儿昏暗的灯光处瞟了一眼，想着自己要不要也去一起跟伙计们喝上一口呢，对吧。 | 到达了 %location2%，%randombrother% 向你提议是否需要在回到 %employer% 之前，在这里多买一些物资。其实你老早就想到这一点了，只不过你还是夸了一下这位兄弟想出来的好点子，来满足他干活的积极性。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "我们继续前进。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Math.rand(1, 100) <= 33)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/safe_roads_situation"), 2, this.Contract.m.Location2, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Success3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% 觉得你能回来是一件不可思议的事情。 接着他就走到一旁，开始默默地数着克朗，在准备给你报酬的时候，又问了问你在巡逻中收集了多少颗“头”。 当你报告说杀了 %killcount%，他噘起了嘴，并点了点头。%SPEECH_ON%足够好了。%SPEECH_OFF%然后，那人往钱袋里塞了些克朗并递给了你。 | 当你回到 %employer% 身边时，你看到这个家伙深深地坐进了在一张巨大的椅子里，好像他需要所有的空间来支撑他的高贵，富裕和骄傲。\n\n你上前一步，跟他说明巡逻的路上杀了 %killcount%。 并且你特别着重讲到了关于砍杀方面的事情，毕竟这一部分是你得到酬劳多少的主体因素。%employer% 点了点头，让他的手下把说好的克朗塞进一个袋子里，并最终给你递了过来。 | %employer% 站在窗边，大口喝着葡萄酒，而且他似乎还盯着下面几个正在做园艺的女子。 但他并没有回头看你，而是直接问你在巡逻途中杀了多少个人。%SPEECH_ON%%killcount%.%SPEECH_OFF%贵族轻声笑着。%SPEECH_ON%看上去你做得还挺轻松的嘛。%SPEECH_OFF%他打了打响指，但仍然没有正视你。 他的一个手下从旁边走了过来，手里拿着一个袋子。 你接过了它，然后转身就走了。 | %employer% 把你邀请进房的时候他还正在阅读文件。 不过他还是很好奇你在巡逻的时候杀了多少人。 你报告说 %killcount%，他一边哼着歌，一边在一张纸上做了些记录。 接着他又点了点头，踢开了旁边的一个箱子，然后开始把里面的克朗捞进一个袋子里。 然后头也不抬的把袋子递给了你，并告诉你现在就得离开。 | 当你回来的时候，发现 %employer%的住处正举办着一场宴会。 你在一帮喝醉酒的上流人士之间一阵穿梭之后找到了那个人。 他看着你，吼出来的嗓音盖过了现场的音乐和人群的嘈杂声，大声地问你在巡逻的时候杀了多少人。 在这种场合来这样提问倒是挺令人匪夷所思，但更令你吃惊的是，当你大声喊出你杀了 %killcount% 个人时，似乎这对于这场宴会来说并没有任何不妥的影响。 %employer% 耸耸肩，转身离开了，慢慢地溜进宴会的人群中去。 当你尝试想去追他讨要报酬的时候，突然一个人挡住了你的去路，把一袋钱猛地一下子推进你的胸上。%SPEECH_ON%你的报酬，雇佣兵。现在，请你好好看看那边的那扇门。 人们已经开始注意到你了，他们来这里不是为了让自己感到不舒服的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "今天的行军够了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "在领地内巡逻");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});

				if (this.Math.rand(1, 100) <= 33)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/safe_roads_situation"), 2, this.Contract.m.Home, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Success4",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你空着手回到了 %employer% 那里。他开始不断地打量着你的全身，尤其是在寻找那些本该带回来的头颅。%SPEECH_ON%真的吗？什么都没发生吗？%SPEECH_OFF%你没有做任何反应。那人抿了抿嘴，然后耸耸肩。%SPEECH_ON%啊，见鬼，好吧…%SPEECH_OFF%他看着你，低声笑得几乎要吐了。%SPEECH_ON%很有趣，我想。%SPEECH_OFF% | %employer% 打量着你全身上下所有的部位。%SPEECH_ON%头在哪里，佣兵？ 你确定没有忘记收集那些…？%SPEECH_OFF%你解释说在巡逻的路上什么情况也没发生。那人挑了挑眉。%SPEECH_ON%什么都没有？这…算了…再见。%SPEECH_OFF% | 你空着手回到了 %employer% 那里。 他盯着你就好像你手里少了些…货。%SPEECH_ON%这算啥？我本来他妈要给你付钱的人头去哪儿了？%SPEECH_OFF%耸耸肩，你解释道巡逻的路上一路平安，没有任何情况发生。%employer% 一边喝着酒一边听到你说的消息，差点噎住了。%SPEECH_ON%等等，真的吗？我是说，我想这很好，但是该死的…没想到就是这样。 我觉得，呃，我猜你也是什么都不知道。%SPEECH_OFF%你们互相盯着对方看。 一只鸟咕咕叫着打破了这个沉默。 那人走到一旁，抿了一口酒，然后往窗外瞥了一眼。%SPEECH_ON%那么…今天的天气也挺不错的，对吧？%SPEECH_OFF%你翻了翻白眼。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "今天的行军够了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictory);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractPoor, "在领地内巡逻");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Contract.m.Payment.getOnCompletion() > 0)
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你花了太长的时间来完成你的巡逻任务。 导致合同失败了。 | 一个受雇于 %employer% 的人拿着通知走了过来。 上面说你的巡逻是需要速度的，而不是让你散步。 导致合同失败了。 | 你到底在想什么，想尽可能多的收集人头？ 你的雇主，%employer%，他是否会买你这帐还是很值得怀疑的。 他只给你这么几天时间来完成这个任务也是有原因的好吧。导致失败了。}",
			Image = "",
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "该死的合同！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "在执行巡逻任务时闲逛");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function addKillCount( _actor, _killer )
	{
		if (_killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return;
		}

		if (this.m.Flags.get("HeadsCollected") >= this.m.Payment.MaxCount)
		{
			return;
		}

		if (_actor.getXPValue() == 0)
		{
			return;
		}

		if (_actor.getType() == this.Const.EntityType.GoblinWolfrider || _actor.getType() == this.Const.EntityType.Wardog || _actor.getType() == this.Const.EntityType.Warhound || _actor.getType() == this.Const.EntityType.SpiderEggs || this.isKindOf(_actor, "lindwurm_tail"))
		{
			return;
		}

		if (!_actor.isAlliedWithPlayer() && !_actor.isAlliedWith(this.m.Faction) && !_actor.isResurrected())
		{
			this.m.Flags.set("HeadsCollected", this.m.Flags.get("HeadsCollected") + 1);
		}
	}

	function spawnEnemies()
	{
		if (this.m.Flags.get("HeadsCollected") >= this.m.Payment.MaxCount)
		{
			return false;
		}

		local tries = 0;
		local myTile = this.m.NextObjective.getTile();
		local tile;

		while (tries++ < 10)
		{
			local tile = this.getTileToSpawnLocation(myTile, 7, 11);

			if (tile.getDistanceTo(this.World.State.getPlayer().getTile()) <= 6)
			{
				continue;
			}

			local nearest_bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(tile);
			local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(tile);
			local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(tile);
			local nearest_barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians) != null ? this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getNearestSettlement(tile) : null;
			local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits) != null ? this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(tile) : null;

			if (nearest_bandits == null && nearest_goblins == null && nearest_orcs == null && nearest_barbarians == null && nearest_nomads == null)
			{
				this.logInfo("没有找到敌人的基地");
				return false;
			}

			local bandits_dist = nearest_bandits != null ? nearest_bandits.getTile().getDistanceTo(tile) + this.Math.rand(0, 10) : 9000;
			local goblins_dist = nearest_goblins != null ? nearest_goblins.getTile().getDistanceTo(tile) + this.Math.rand(0, 10) : 9000;
			local orcs_dist = nearest_orcs != null ? nearest_orcs.getTile().getDistanceTo(tile) + this.Math.rand(0, 10) : 9000;
			local barbarians_dist = nearest_barbarians != null ? nearest_barbarians.getTile().getDistanceTo(tile) + this.Math.rand(0, 10) : 9000;
			local nomads_dist = nearest_nomads != null ? nearest_nomads.getTile().getDistanceTo(tile) + this.Math.rand(0, 10) : 9000;
			local party;
			local origin;

			if (bandits_dist <= goblins_dist && bandits_dist <= orcs_dist && bandits_dist <= barbarians_dist && bandits_dist <= nomads_dist)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Brigands", false, this.Const.World.Spawn.BanditRaiders, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Brigand Hunters", false, this.Const.World.Spawn.BanditRoamers, 80 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}

				party.setDescription("一支粗暴而强悍的强盗队伍在捕食弱者。");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
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

				origin = nearest_bandits;
			}
			else if (goblins_dist <= bandits_dist && goblins_dist <= orcs_dist && goblins_dist <= barbarians_dist && goblins_dist <= nomads_dist)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Goblin Raiders", false, this.Const.World.Spawn.GoblinRaiders, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Goblin Scouts", false, this.Const.World.Spawn.GoblinScouts, 80 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}

				party.setDescription("一群淘气的哥布林，小而狡猾，不可低估。");
				party.setFootprintType(this.Const.World.FootprintsType.Goblins);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 2);
				party.getLoot().Ammo = this.Math.rand(0, 30);

				if (this.Math.rand(1, 100) <= 75)
				{
					local loot = [
						"supplies/strange_meat_item",
						"supplies/roots_and_berries_item",
						"supplies/pickled_mushrooms_item"
					];
					party.addToInventory(loot[this.Math.rand(0, loot.len() - 1)]);
				}

				if (this.Math.rand(1, 100) <= 33)
				{
					local loot = [
						"loot/goblin_carved_ivory_iconographs_item",
						"loot/goblin_minted_coins_item",
						"loot/goblin_rank_insignia_item"
					];
					party.addToInventory(loot[this.Math.rand(0, loot.len() - 1)]);
				}

				origin = nearest_goblins;
			}
			else if (barbarians_dist <= goblins_dist && barbarians_dist <= bandits_dist && barbarians_dist <= orcs_dist && barbarians_dist <= nomads_dist)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).spawnEntity(tile, "Barbarians", false, this.Const.World.Spawn.Barbarians, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				party.setDescription("一支野蛮部落的战团。");
				party.setFootprintType(this.Const.World.FootprintsType.Barbarians);
				party.getLoot().Money = this.Math.rand(0, 50);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 5);
				party.getLoot().Ammo = this.Math.rand(0, 30);

				if (this.Math.rand(1, 100) <= 50)
				{
					party.addToInventory("loot/bone_figurines_item");
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					party.addToInventory("loot/bead_necklace_item");
				}

				local r = this.Math.rand(2, 5);

				if (r == 2)
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

				origin = nearest_barbarians;
			}
			else if (nomads_dist <= barbarians_dist && nomads_dist <= goblins_dist && nomads_dist <= bandits_dist && nomads_dist <= orcs_dist)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).spawnEntity(tile, "Nomads", false, this.Const.World.Spawn.NomadRaiders, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				party.setDescription("一群沙漠掠夺者捕食任何试图穿越沙海的人。");
				party.setFootprintType(this.Const.World.FootprintsType.Nomads);
				party.getLoot().Money = this.Math.rand(50, 200);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 2);
				party.getLoot().Ammo = this.Math.rand(0, 20);
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/dates_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/rice_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/dried_lamb_item");
				}

				origin = nearest_nomads;
			}
			else
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Orc Scouts", false, this.Const.World.Spawn.OrcScouts, 80 * this.getDifficultyMult() * this.getScaledDifficultyMult());
				}

				party.setDescription("一群凶残的兽人，绿皮肤，高耸于任何人之上。");
				party.setFootprintType(this.Const.World.FootprintsType.Orcs);
				party.getLoot().ArmorParts = this.Math.rand(0, 25);
				party.getLoot().Ammo = this.Math.rand(0, 10);
				party.addToInventory("supplies/strange_meat_item");
				origin = nearest_orcs;
			}

			party.getSprite("banner").setBrush(origin.getBanner());
			party.setAttackableByAI(false);
			party.setAlwaysAttackPlayer(true);
			local c = party.getController();
			local intercept = this.new("scripts/ai/world/orders/intercept_order");
			intercept.setTarget(this.World.State.getPlayer());
			c.addOrder(intercept);
			this.m.UnitsSpawned.push(party.getID());
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location1",
			this.m.Location1.getName()
		]);
		_vars.push([
			"location2",
			this.m.Location2.getName()
		]);
		_vars.push([
			"killcount",
			this.m.Flags.get("HeadsCollected")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
		_vars.push([
			"days",
			5 - (this.World.getTime().Days - this.m.Flags.get("StartDay"))
		]);
		_vars.push([
			"crucifiedman",
			this.m.Dude != null ? this.m.Dude.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Location1 != null)
			{
				this.m.Location1.getSprite("selection").Visible = false;
			}

			if (this.m.Location2 != null)
			{
				this.m.Location2.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Location1 == null || this.m.Location1.isNull() || !this.m.Location1.isAlive())
			{
				return false;
			}

			if (this.m.Location2 == null || this.m.Location2.isNull() || !this.m.Location2.isAlive())
			{
				return false;
			}

			return true;
		}
		else
		{
			if (this.World.FactionManager.getFaction(this.m.Faction).getSettlements().len() < 3)
			{
				return false;
			}

			return true;
		}
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Location1 != null && !this.m.Location1.isNull() && _tile.ID == this.m.Location1.getTile().ID)
		{
			return true;
		}

		if (this.m.Location2 != null && !this.m.Location2.isNull() && _tile.ID == this.m.Location2.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Location1 != null)
		{
			_out.writeU32(this.m.Location1.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Location2 != null)
		{
			_out.writeU32(this.m.Location2.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local location1 = _in.readU32();

		if (location1 != 0)
		{
			this.m.Location1 = this.WeakTableRef(this.World.getEntityByID(location1));
		}

		local location2 = _in.readU32();

		if (location2 != 0)
		{
			this.m.Location2 = this.WeakTableRef(this.World.getEntityByID(location2));
		}

		this.contract.onDeserialize(_in);
	}

});

