this.intercept_raiding_parties_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Objectives = [],
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.intercept_raiding_parties";
		this.m.Name = "拦截掠夺者";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local towns = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isIsolated() || s.isCoastal() || s.isMilitary() || !s.isDiscovered())
			{
				continue;
			}

			if (s.getActiveAttachedLocations().len() < 2)
			{
				continue;
			}

			if (this.World.getTileSquare(s.getTile().SquareCoords.X, s.getTile().SquareCoords.Y - 12).Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			towns.push(s);
		}

		towns.sort(function ( _a, _b )
		{
			if (_a.getTile().SquareCoords.Y < _b.getTile().SquareCoords.Y)
			{
				return -1;
			}
			else if (_a.getTile().SquareCoords.Y > _b.getTile().SquareCoords.Y)
			{
				return 1;
			}

			return 0;
		});
		this.m.Destination = this.WeakTableRef(towns[this.Math.rand(0, this.Math.min(1, towns.len() - 1))]);
		this.m.Payment.Pool = 1300 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("LastLocationDestroyed", "");
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"拦截所有的%objective%附近的南方劫掠者",
					"不要让他们烧了任何地点"
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
					this.Flags.set("IsAssassins", true);
				}
				else if (r <= 50)
				{
					this.Flags.set("IsSlavers", true);
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					this.Flags.set("IsThankfulVillagers", true);
				}

				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(-99.0, "在战争选择了阵营");
				}

				this.Contract.m.Destination.setLastSpawnTimeToNow();
				local locations = [];

				foreach( a in this.Contract.m.Destination.getActiveAttachedLocations() )
				{
					if (a.isUsable() && a.isActive())
					{
						locations.push(a);
					}
				}

				local cityState = cityStates[this.Math.rand(0, cityStates.len() - 1)];

				for( local i = 0; i < 2; i = ++i )
				{
					local r = this.Math.rand(0, locations.len() - 1);
					this.Contract.m.Objectives.push(locations[r].getID());
				}

				local g = this.Contract.getDifficultyMult() > 1.1 ? 3 : 2;

				for( local i = 0; i < g; i = ++i )
				{
					local tile = this.Contract.getTileToSpawnLocation(this.World.getTileSquare(this.Contract.m.Destination.getTile().SquareCoords.X, this.Contract.m.Destination.getTile().SquareCoords.Y - 12), 0, 10);
					local party;

					if (i == 0 && this.Flags.get("IsAssassins"))
					{
						party = cityState.spawnEntity(tile, "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(70, 90) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.Assassins, this.Math.rand(30, 40) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getFlags().set("IsAssassins", true);
					}
					else if (i == 0 && this.Flags.get("IsSlavers"))
					{
						party = cityState.spawnEntity(tile, "Slavers", true, this.Const.World.Spawn.Southern, this.Math.rand(60, 80) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.NorthernSlaves, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getFlags().set("IsSlavers", true);
					}
					else
					{
						party = cityState.spawnEntity(tile, "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 130) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + cityState.getBannerString());

						if (this.Math.rand(1, 100) <= 33)
						{
							this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.NorthernSlaves, this.Math.rand(10, 30));
						}
					}

					party.setDescription("忠于城邦的应征士兵。");
					party.setAttackableByAI(false);
					party.getLoot().Money = this.Math.rand(50, 200);
					party.getLoot().ArmorParts = this.Math.rand(0, 25);
					party.getLoot().Medicine = this.Math.rand(0, 3);
					party.getLoot().Ammo = this.Math.rand(0, 30);
					local r = this.Math.rand(1, 4);

					if (r <= 2)
					{
						party.addToInventory("supplies/rice_item");
					}
					else if (r == 3)
					{
						party.addToInventory("supplies/dates_item");
					}
					else if (r == 4)
					{
						party.addToInventory("supplies/dried_lamb_item");
					}

					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local wait = this.new("scripts/ai/world/orders/wait_order");
					wait.setTime(80.0 + i * 12.0);
					c.addOrder(wait);

					for( local j = 0; j < 2; j = ++j )
					{
						local raid = this.new("scripts/ai/world/orders/raid_order");
						raid.setTargetTile(j == 0 ? locations[0].getTile() : locations[1].getTile());
						raid.setTime(60.0);
						c.addOrder(raid);
					}

					this.Contract.m.UnitsSpawned.push(party.getID());
				}

				this.Flags.set("ObjectivesAlive", 2);
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
				}

				foreach( i, id in this.Contract.m.UnitsSpawned )
				{
					local p = this.World.getEntityByID(id);

					if (p != null && p.isAlive())
					{
						p.getSprite("selection").Visible = true;
						p.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
					}
				}
			}

			function update()
			{
				local alive = 0;

				foreach( i, id in this.Contract.m.Objectives )
				{
					local p = this.World.getEntityByID(id);

					if (p != null && p.isAlive())
					{
						if (p.isActive())
						{
							alive = ++alive;
						}
						else
						{
							this.Flags.set("LastLocationDestroyed", p.getRealName());
						}
					}
				}

				if (alive < this.Flags.get("ObjectivesAlive"))
				{
					this.Flags.set("ObjectivesAlive", alive);
					this.Contract.setScreen("LocationDestroyed");
					this.World.Contracts.showActiveContract();
				}
				else if (alive == 0 || this.Contract.m.UnitsSpawned.len() == 0)
				{
					if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < 4.0 && alive > 0)
					{
						if (this.Flags.get("IsThankfulVillagers") && this.Contract.isPlayerNear(this.Contract.m.Destination, 500))
						{
							this.Contract.setScreen("ThankfulVillagers");
						}
						else
						{
							this.Contract.setScreen("PartiesDefeated");
						}
					}
					else
					{
						this.Contract.setScreen("Lost");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p == null || !p.isAlive())
						{
							this.Contract.m.UnitsSpawned.remove(i);
							break;
						}
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerInitiated;

				if (!this.Flags.get("IsEngagementDialogShown"))
				{
					this.Flags.set("IsEngagementDialogShown", true);

					if (_dest.getFlags().has("IsAssassins"))
					{
						this.Contract.setScreen("Assassins");
					}
					else if (_dest.getFlags().has("IsSlavers"))
					{
						this.Contract.setScreen("Slavers");
					}
					else
					{
						this.Contract.setScreen("InterceptParty");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerInitiated, true, true);
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

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local alive = 0;

					foreach( id in this.Contract.m.Objectives )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.isActive())
						{
							alive = ++alive;
						}
					}

					if (alive == 0)
					{
						this.Contract.setScreen("Lost");
					}
					else if (alive == 1)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Success2");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%的房间又暗又安静。 要不是有几根闪烁的蜡烛和鸟叫这房间就是又黑又寂静的了。 站在阴影里，贵族开口说道。%SPEECH_ON%南方杂种持续向北方派出掠夺队。 这添了不少麻烦，你懂的，几个古铜色的狗杂种来来往往，掠夺，抢劫，杀人，强奸。 他们想让我分兵到后方，但我可不会让他们得逞。 这就是你在这的原因，佣兵。 我需要你去找到这些入侵过来的破坏者并杀光他们。 如果你能承担这个任务，报酬是 %reward% 克朗。%SPEECH_OFF% | 你看到 %employer% 正在与他的军官们说话。 他有两堆筹码，其中一个比另一个高得多。 他从高的拿出一些放在矮的上。%SPEECH_ON%那么如果我布置这么多呢？%SPEECH_OFF%军官们摇了摇头。%SPEECH_ON%那正是南方人想要的。 如果我们从前线调人，那么他们肯定会知道并借机发动进攻。%SPEECH_OFF%所有人突然看向你。%employer% 咧起嘴角。%SPEECH_ON%啊－哈，看来我们的救星正是一个雇佣兵！ 喔，我敢说一个佣兵可以为我们解决这件事。 那边那个，领头的，我需要些战士呆在 %townname% 附近并从南方破坏者和强盗手中保护他们。 你会在这个任务圆满完成后拿到 %reward% 克朗的报酬！%SPEECH_OFF%军官们看起来对于像让这样的佣兵你承包这份任务有些迟疑，但你感觉得到，局势并不乐观。 | 你被引导到 %employer%的图书馆，他正在翻阅数张卷轴。他举起其中一个。%SPEECH_ON%在这样的时节，你觉得我在读些什么？%SPEECH_OFF%你猜与军事有关。他摇起头来。%SPEECH_ON%农业问题。你知道的，我正在一场战争中。 但战争不止需要靠人战斗，还需要补给链，后勤，食物。 所有这些都是后方提供的。 南方的狗杂种同我们一样理解这种概念，并派出掠夺者和渗透者来摧毁后方。 来分散我，分散我的士兵们。 我需要你去根除这些杂种并保护我们的家乡，我们的商铺，我们的农场。 顺利完成，我会给予你 %reward% 克朗。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{这对我们来说也许正是合适的工作。 | 击退南方来的入侵者？ 战队在此响应号召！ | Very well. 让我们更深入地谈谈报酬问题。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。 | 这将占用我们太多的时间。}",
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
			ID = "LocationDestroyed",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{远处冒起浓烟。 尖叫声回响在云层之下，从浮动着轮廓的火中传出。 那是在 %location% 的 %objective%，很显然它正在被摧毁。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们必须在过份前阻止它。",
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
			ID = "InterceptParty",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_156.png[/img]{南方人看起来如同在地理过渡区般，混着他们自己的和北方人的服饰，还带着一箱箱夺来的战利品。 一个人穿着北方婚礼的裙子转着玩。 看起来就好像一队友好的旅行者在靠近，如果不是他们身上满是血迹与灰尘的话。战斗！ | 你找到了来北方的南方人掠夺队。 从他们身上的血迹判断，你敢打赌他们已经在郊区的民众间扫荡了出了一条混乱路线。战斗！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备接敌。",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "PartiesDefeated",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_87.png[/img]{你找到了最后一个还有一口气的南方人并抓住他的头发把他拎起来给所有人看。 农民与农夫之类看着你从喉咙切到脖子直到他的身体落下，头高高的举在你的手中。人群欢呼起来。%SPEECH_ON%我们的救星！%SPEECH_OFF%无疑 %employer% 会很高兴听到你的工作成果。 | 南方人被杀了，任何残存的幸存者被留给了当地人。 虐待，大量的鞭打，切鸡鸡和各类血腥创意。 但你对这些人不抱同情。%employer% 等着的报酬，倒让你更感点兴趣。 | 随着最后一批南方人死了后，你知道 %employer% 肯定会乐于支付你的报酬。 你离开时，你看到几个当地人正在破坏强盗们的尸体，如同这里和全世界其他地方的传统一样。 | 一声吓人的惨叫背叛着他之前对这世界的掌控感，最后的强盗死于了剑下。 他的战友被当地人拽来拽去，尸体要么被肢解或者点燃。 你看了一会，但最终还是回到了路上，毕竟 %employer% 还等着呢。 | 强盗中最幸运的是那些已经死了的，因为重伤的人没有被给予任何仁慈。 当地人和农场主涌入战场来夺取他们的被害者，有的甚至在为此交换克朗，然后被选中的强盗们被玷污，残害，并虐待。 你看不到任何人是被直接杀死的，实际上其中一例中，一个医师看起来只是在延长痛苦。 很壮观，但比起这更好的景象是 %employer% 往你的金库里放一大笔报酬的时候。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让伙计们准备好出发。",
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
			ID = "Lost",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_94.png[/img]{敌人不见了，但他们的工作已经完成。 浓烟弥漫在被烧成灰烬的建筑物周围，那些没有为了在南方卖而作为负债者被抓的人则死在了街上。\n\n回去找雇主没有什么意义了，因为你没什么机会为失败得到报酬。 最好去别的地方找新工作。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们失败了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能协助" + this.Contract.m.Destination.getName() + "拦截来自南方掠夺者。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Assassins",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_165.png[/img]{你找到一个农夫背上插着一把弯曲的匕首死在了路上。 没人会把那么好的匕首留在背后，正如你怀疑的，他的凶手仍在这里：一群南方刺客。 他们如同阴影般变换，他们锋利的钢刃随每一次晃动和转向发出反光。战斗！ | 一个女人快速跑向你，她破碎的裙子胡乱地摆动，双臂摇晃，眼睛放大，其中的白色如同猩红海滩上的贝壳般沁在红血中。 在她能说任何话之前她咕哝着在一瞬间倒在地上。 一把匕首在她的后脑勺上，更后方，一个黑衣的男人与一群刺客正站在一起！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Slavers",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_53.png[/img]{南方掠夺队看起来好像由世界各地的人组合出来的般。 在更近的观察下你才意识到是因为他们是奴隶主！ 奴隶与主人的大杂烩接近着 %companyname%，受过训练的与毫无训练的一起组成一排散乱的阵线。 你可以看到人群中有北方人的面孔，但可悲的是，他们是一个破碎的群体，他们宁愿拿起武器对抗战队，也不愿为自由而战。 | 你找到了南方人，但他们完全不是强盗－他们是奴隶主！ 他们带着一车车的女人和孩子，并在你发现的同时，奴隶主们匆忙的开始处决任何近期奴役的有威胁的人同时剩下的开始冲向 %companyname%。空气中弥漫着屠杀的气息，你肆无忌惮地向他们发起进攻！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "ThankfulVillagers",
			Title = "在 %objective%",
			Text = "[img]gfx/ui/events/event_79.png[/img]{你放倒了最后的南方掠夺者。 在你命令队伍收集任何有价值的东西时，几个村民带着他们自己的物品站了出来。%SPEECH_ON%我们以为一切都完了，但你出现了，我们的骑士。%SPEECH_OFF%尽管你不是一个骑士，你不会拒绝被称赞为骑士－以及骑士的奖励：村民们给了你礼物！ | 掠夺者解决了，你发现自己慢慢地被村民们包围。 他们看起来憔悴又害怕，但同时他们带着一篮篮的物品。 作为拯救了他们的礼物被交给了你。 他们看起来把你跟 %employer%的士兵们搞混了，但你都没想去展露你的雇佣兵身份。 你拿上礼物，甚至点了点帽子并说这只是你的工作，它确实是。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "被感谢的感觉很好。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				local p = this.Contract.m.Destination.getProduce();

				for( local i = 0; i < 2; i = ++i )
				{
					local item = this.new("scripts/items/" + p[this.Math.rand(0, p.len() - 1)]);
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
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 摆手让你进去，尽管没你所希望的欢迎那样的喜气。 他的语调透露出某种慈父般的失望。%SPEECH_ON%你解决了几个南方强盗。 不是很好，但也不坏。 我会按每个被阻止的队伍付你报酬，但我只希望你能做的更好。%SPEECH_OFF%你几乎想要道歉，但你知道你这一方的任何软弱迹象或许会导致吃亏并没有开口。 他支付了应得的 %reward% 克朗。 | %employer% 在你进入房间时带着几个卫兵，尽管人群中有几张脸有些破相。 他沉闷地说道。%SPEECH_ON%你尽力了，佣兵。 你不太可能能赶在所有的掠夺者前。 这我现在意识到了。 我，当然，会支付一些合理的报酬给你。 我知道我雇了错误的人，但我今天不会对此下决定。 有太多要重建了。 你的 %reward% 克朗，按谈好的以每一个被摧毁的掠夺队算。%SPEECH_OFF% |  你进入 %employer%的房间发现作为你报酬的 %reward% 克朗已经准备好放在桌上了。 他轻率的翻手指了指它。%SPEECH_ON%掠夺者来了，你解决了几个，剩下的则肆意烧杀劫掠了一番。 所以。拿上你 %reward% 克朗的报酬，佣兵。 它是按照你工作的质量来的，所以请你不要对发现叠起来的克朗矮了一点感到惊讶。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractPoor);
						this.World.Assets.addMoney(this.Math.round(this.Contract.m.Payment.getOnCompletion() / 2));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractPoor, "保卫了" + this.Contract.m.Destination.getName() + "拦截来自南方掠夺者。");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isHolyWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

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
			Text = "[img]gfx/ui/events/event_04.png[/img]{你发现 %employer% 不在他的作战室，而是在他的侧办公室里跟几个乱转的女士在一起。 她们在处理角落里的蜘蛛网，塞卷轴到书架里，或者打磨着家具。 而且她们都裸着，很自然地。 他张开手臂。%SPEECH_ON%我想着是时候庆祝一番，%townname% 被拯救了，被你这样的人拯救了，佣兵！%SPEECH_OFF%他喝醉了，女人们轻轻的在他在房间里转起来的途中躲避以免撞到他。%SPEECH_ON%现在…现在－嗝－现在我向你保证，那个，那个我不会赊着你的 %reward% 克朗。 都在这－嗝－和谈好的一样。 农民们很高兴，而且我也很高兴。非常高兴。%SPEECH_OFF%他挤了挤其中一个女人，她的反应就像一块斑驳的地毯一样活泼。 你拿上钱袋并离开，几个女士跟着你一起溜出了门，留下 %employer% 倒在地上恍惚地嘟哝着。 | 你发现 %employer% 不在他的作战室而在他的图书管理，里面可能书架比书还多。 但他看起来依然很自满。%SPEECH_ON%你的工作完成的很出色，佣兵。很漂亮。 当然，依然有些伤亡，但总体而言东西还在它们该在的地方而且那群南方杂碎都被赶走了。 在你的帮助下，我们的前线得以免于为保护后方变薄。 这儿，你说好的 %reward% 克朗。%SPEECH_OFF%当他移开，你看到他摆了一个新近打光滑了的头骨在架子上。 他带着儿童般的笑容指着它。%SPEECH_ON%是他们中的一个头骨。 我打算用它来喝酒，或者当尿壶。还没下决定。%SPEECH_OFF% | %employer% 坐在他摆了一个三个头骨叠出来的塔型的办公桌前。 他的手放在上面好像在拍狗头一样。 你注意到上面还有一条条血肉甚至头发在上面，漂白过程看来很仓促。 他开心的说道。%SPEECH_ON%因为你，我的士兵可以留在前线，佣兵。 解决那些强盗不仅拯救了这里许多人的生命，还可能制止了一系列多米诺中的第一颗倒下。 没有你的帮助，父亲，兄弟和儿子们可能得后撤去照顾他们的家庭然后这整场战争将会变得一团糟。%SPEECH_OFF%用他空出来的手，他向前推出一个包。%SPEECH_ON%你的 %reward% 克朗。相当分量正当所得的硬币，我得说。%SPEECH_OFF%他冷酷的笑起来然后立起头盯着骷髅。%SPEECH_ON%我想他们会赞同的，尽管我得说在这方面我将会代替他们发言。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "保卫了" + this.Contract.m.Destination.getName() + "拦截来自南方掠夺者。");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isHolyWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCriticalContract);
						}

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
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Destination.getName()
		]);
		_vars.push([
			"location",
			this.m.Flags.get("LastLocationDestroyed")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
			}

			foreach( id in this.m.UnitsSpawned )
			{
				local p = this.World.getEntityByID(id);

				if (p != null && p.isAlive())
				{
					p.getSprite("selection").Visible = false;
					p.setOnCombatWithPlayerCallback(null);
				}
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isHolyWar())
		{
			return false;
		}

		local f = this.World.FactionManager.getFaction(this.getFaction());

		foreach( s in f.getSettlements() )
		{
			if (s.isIsolated() || s.isCoastal() || s.isMilitary() || !s.isDiscovered())
			{
				continue;
			}

			if (s.getActiveAttachedLocations().len() < 2)
			{
				continue;
			}

			if (this.World.getTileSquare(s.getTile().SquareCoords.X, s.getTile().SquareCoords.Y - 12).Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			return true;
		}

		return false;
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

		_out.writeU8(this.m.Objectives.len());

		for( local i = 0; i < this.m.Objectives.len(); i = ++i )
		{
			_out.writeU32(this.m.Objectives[i]);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local numObjectives = _in.readU8();

		for( local i = 0; i < numObjectives; i = ++i )
		{
			this.m.Objectives.push(_in.readU32());
		}

		this.contract.onDeserialize(_in);
	}

});

