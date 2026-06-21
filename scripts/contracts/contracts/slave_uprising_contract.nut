this.slave_uprising_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsEscortUpdated = false,
		IsPlayerAttacking = false
	},
	function setLocation( _l )
	{
		this.m.Destination = this.WeakTableRef(_l);
	}

	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(70, 105) * 0.01;
		this.m.Type = "contract.slave_uprising";
		this.m.Name = "奴隶起义";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 450 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("SpartacusName", this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)] + " " + this.Const.Strings.SouthernNamesLast[this.Math.rand(0, this.Const.Strings.SouthernNamesLast.len() - 1)]);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"镇压%townname%附近%location%的负债者起义"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsOutlaws", true);
					this.Contract.m.Destination.setActive(false);
					this.Contract.m.Destination.spawnFireAndSmoke();
				}
				else if (r <= 40)
				{
					this.Flags.set("IsSpartacus", true);
				}
				else if (r <= 60)
				{
					this.Flags.set("IsFleeing", true);
				}
				else
				{
					this.Flags.set("IsFightingBack", true);
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"镇压%townname%附近%location%的负债者起义"
				];
				this.Contract.m.Destination.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setOnEnterCallback(this.onDestinationEntered.bindenv(this));
			}

			function update()
			{
				if (this.Flags.get("IsVictory"))
				{
					if (this.Flags.get("IsSpartacus"))
					{
						this.Contract.setScreen("Spartacus4");
					}
					else if (this.Flags.get("IsFightingBack"))
					{
						this.Contract.setScreen("FightingBack2");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function onDestinationEntered( _dest )
			{
				if (this.Flags.get("IsFleeing"))
				{
					this.Contract.setScreen("Fleeing1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsOutlaws"))
				{
					this.Contract.setScreen("Outlaws1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsSpartacus"))
				{
					this.Contract.setScreen("Spartacus1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsFightingBack"))
				{
					this.Contract.setScreen("FightingBack1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "SlaveUprisingContract")
				{
					this.Flags.set("IsVictory", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_Outlaws",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追捕%townname%附近那些已经沦为土匪的负债者"
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Destination.setOnEnterCallback(null);
				this.Contract.m.Home.getSprite("selection").Visible = false;

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					this.Contract.setScreen("Outlaws3");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerInitiated;
				this.World.Contracts.showCombatDialog();
			}

		});
		this.m.States.push({
			ID = "Running_Fleeing",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追捕那些逃离%townname%的负债者"
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Destination.setOnEnterCallback(null);
				this.Contract.m.Home.getSprite("selection").Visible = false;

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					this.Contract.setScreen("Fleeing3");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerInitiated;

				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Fleeing2");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog();
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回 %townname%"
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Destination.setOnEnterCallback(null);
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 通常在深思熟虑，在由顾问和维齐尔组成的漩涡中思考，这里的每个人都用手指的啪啪声和地图上咄咄逼人的点来互相咨询。 尽管这看上去如此奇怪，但仍有一个小仆人穿过了人群，拿着一张卷轴来到你面前。 他巧妙地解释道，那些欠了金主一大笔钱的人发起暴动的地方在 %townname%的 %location%。%SPEECH_ON%这些逐币者要求社会福利。 如果你想参与恢复有关各方的规范，并为了改善债主和金主们的利益，请拿着这支笔，在卷轴上划上一个乂。%SPEECH_OFF%你们相互对视。 接着他叹了口气，轻轻敲了一下卷轴。%SPEECH_ON%这是付给你们的报酬，如果你接受的话。%reward% 克朗。%SPEECH_OFF% | 当你接近 %employer%的房间时一对护卫用他们的戟把拦下了。 这引起了喊叫和匆忙的脚步声甚至又把那个仆人引了过来。%SPEECH_ON%警卫！这些衣着邋遢的旅行者只是个逐币者。 很抱歉，逐币者，我们非常紧张，因为维齐尔可能需要你的帮助：这些负债者已经在 %location% 的 %townname% 发生了一场暴动。起义很可能会从那里蔓延开来。%SPEECH_OFF%仆人拿出一本书卷递给你。 上面写着，%reward% 克朗等待着那些可以镇压负债者反抗的人，卷轴上还有 %townname% 的各种维齐尔的标志。 | %townname% 的维齐尔待在他们的作战室里，气氛比平时更加紧张。 但你仍被当在外面，不能接近他们。 你不知道过了多久，但这时大金主们已经从房间里出来了。 他们互相交谈，不时点头，然后递给了仆人一张卷轴。 你看着仆人朝你冲过来。 然后把它递给你，然后从又再次一遍重复了他的话。%SPEECH_ON%负债者的人已经超过了他们的主人，从那里接管了 %location%。%reward% 克朗已经准备好放在了官邸的保险箱中，只要你能粉碎这帮狂妄自大的人。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{他们没有机会。 | 我们会给以后要这么做的人做个榜样。 | 我们会重新夺取 %location%。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我不这么认为。 | 我们不会去跟昔日的奴隶战斗。}",
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
			ID = "FightingBack1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{在 %location% 的负债者看到你的队伍，你希望你们手上的武器助于阻止他们继续做任何他们所追求的自由美梦。 但令你惊奇的是，他们并没有放下武器，反而开始聚在一起与你对峙。 他们看上去弱不禁风，但聚集在一起使得这群人有了许多声势。 | 你发现那些负债者已经清楚地明白你为什么会在这里。 主事者的安排，你自己武装到牙齿，从城里来，负债者带着他们捡的东西，逃避着他们的枷锁。 他们完全是一个乱七八糟，可悲的集会，但你很清楚，尽管他们缺少武器，但没有什么能弥补他们的欲望。 如果不是一种磨砺的效果，自由的滋味也算不了什么。 | 如前所述，奴隶们现在已经占据了 %location% 并用他们能找到的任何东西武装自己。 一见到你，他们就匆匆忙忙地开始组建阵型，尽管他们缺乏训练、纪律、食物和其他很多东西。 然而，他们所拥有的信念，是不想再次回到他们原来的地方，那里可能和任何钢铁一样锋利和危险。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "摧毁他们！",
					function getResult()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.OrientalBanditTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.Template[0] = "tactical.desert_camp";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
						p.LocationTemplate.CutDownTrees = true;
						p.Tile = tile;
						p.CombatID = "SlaveUprisingContract";
						p.TerrainTemplate = "tactical.desert";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.NomadRaiders, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Slaves, 55 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FightingBack2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{起义被镇压了。 在死亡中，奴隶们的脸看起来确实有些宽慰，似乎所有事情的结局都比生活在锁链中的残酷无情要好。%employer% 和维齐尔将等待你的返回。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们的工作完成了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Outlaws1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_176.png[/img]{你到达%location%后发现它被烧成了废墟并遭到了洗劫。一个幸存者从一个被烧黑的建筑物中磕磕绊绊地走了出来。他解释说，债务人设置在每一个可用的人身上，强奸妇女，杀害儿童，偷走了所有有价值的东西，然后分散到内陆地区。 | 债务人的起义早已离开了%location%，留下了毁灭和死亡的痕迹。一些幸存者正在捡拾自己的东西。那些还能说话的人谈到了恐怖，债务人基本上像野蛮人一样袭击了这个区域，杀戮、抢劫、掠夺。一个蒙着眼睛的男人说他听到他们谈论着要前往乡下并在那里分散开来。%SPEECH_ON%他们现在只是简单的强盗。尝过鲜血的动物，对他们来说，再也没有回到安全的禁锢链之中。他们已经失去了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们当下就去追捕他们。",
					function getResult()
					{
						this.World.uncoverFogOfWar(this.Contract.m.Target.getPos(), 400.0);
						this.World.getCamera().moveTo(this.Contract.m.Target);
						this.Contract.setState("Running_Outlaws");
						return 0;
					}

				}
			],
			function start()
			{
				local cityTile = this.Contract.m.Home.getTile();
				local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(cityTile);
				local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Home.getTile(), 9, 15);
				local party = this.World.FactionManager.getFaction(nearest_nomads.getFaction()).spawnEntity(tile, "Indebted", false, this.Const.World.Spawn.NomadRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一群沦为土匪的负债者。");
				party.setFootprintType(this.Const.World.FootprintsType.Nomads);
				party.getSprite("banner").setBrush(nearest_nomads.getBanner());
				party.getSprite("body").setBrush("figure_nomad_03");
				this.Contract.m.UnitsSpawned.push(party);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
				party.setAttackableByAI(false);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(8);
				roam.setMaxRange(12);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
			}

		});
		this.m.Screens.push({
			ID = "Outlaws3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{你看着一名奴隶的尸体，他的身体被前世的劳作所塑造，但在他的手中和脖子上却有着被盗的武器和战利品。在一种残忍的想法中，你发现如果他们除了自由没有别的理想的话，打倒他们会更容易。但正是他们的贪婪和欲望使他们变得更加危险。但是，他们已经死了。对于欠债者来说，无论他们有多高的目标，%townname%的宰相们都会感到高兴。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们的工作完成了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Spartacus1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_166.png[/img]{你发现那些负债者坐在沙漠的岩石中，他们没有因为你们的到来而站起来。 相反，一个人向你走来。 他身材魁梧，你能感觉到他是来谈判的，他全身肌肉就是很好的外交辞令。%SPEECH_ON%逐币者，我就知道你们会来的。 我的名字是 %spartacus%，我是这群想要逃离鸟笼寻找自由的鸟儿们所选举出的领导者，他们想要自由的飞翔。 你们从镀金者指示的道路来到我们这里，在看不见的金链的指引下，对你们不能保障的诺言，正是基于这些保证的协议，在这些一方的安排上，你们要来杀了我们或者俘虏我们。是这样吗？%SPEECH_OFF%你点了点头。%spartacus% 也跟着点了点头。%SPEECH_ON%没错。在我们履行承诺，掌控自己的命运之前，你依旧是王权的奴隶。但在我谈判的时候，我将尽量用对你有利的方式。%SPEECH_OFF%男子跪下来，%SPEECH_ON%我是一个失去家族，历史和房产的继承人。这些人，这些男人，现在是我的家人。但是，在我的以前的生活中，我有一些你可能会觉得有价值的东西。%SPEECH_OFF%他拿出一张纸。%SPEECH_ON%让我们走，并在这张纸上写下你在其他地方找不到的宝藏位置。如果你攻击我们，我将把我的家族最后的传家宝带到坟墓里，最后一口气喘着子不是为了这些失落的财富，而是为了呼吸自由之火，火焰在我的肺中闪耀，这种痛比任何锁链的舒适度更能让我喘息。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我同意你的条件。 你应该有你的自由。",
					function getResult()
					{
						return "Spartacus2";
					}

				},
				{
					Text = "这只是生意。 你的小叛乱就要被粉碎了。",
					function getResult()
					{
						return "Spartacus3";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Spartacus2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_166.png[/img]{你把手伸出来。%spartacus% 笑了，他说。%SPEECH_ON%的确是。%SPEECH_OFF%他举起一支铅笔，铅笔尖上有一些黑色的粉状碎末。 他指着远处的一块石头。%SPEECH_ON%只有当我们的人离开时，我才会在那里写下我的传家宝的位置。 现在我能看出你是否以为我在说谎。 但这种不确定性是正是自由的代价，不是吗？ 不确定的未来何去何从，但要自己动手。 这才是真正的自由。 鸟笼的舒适是为那些不想飞翔的鸟儿而设的，逐币者。 愿你在镀金者道路上的旅行如我们的第一步一样富有成效。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "尽情享受你们的自由吧。",
					function getResult()
					{
						local bases = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
						local location;
						local lowest_distance = 9000;

						foreach( b in bases )
						{
							if (!b.getLoot().isEmpty() && !b.getFlags().get("IsEventLocation"))
							{
								local d = b.getTile().getDistanceTo(this.Contract.m.Home.getTile()) + this.Math.rand(1, 5);

								if (d < lowest_distance)
								{
									location = b;
									lowest_distance = d;
								}
							}
						}

						if (location == null)
						{
							bases = this.World.EntityManager.getLocations();

							foreach( b in bases )
							{
								if (!b.getLoot().isEmpty() && !b.getFlags().get("IsEventLocation") && !b.isAlliedWithPlayer() && b.isLocationType(this.Const.World.LocationType.Lair))
								{
									local d = b.getTile().getDistanceTo(this.Contract.m.Home.getTile()) + this.Math.rand(1, 5);

									if (d < lowest_distance)
									{
										location = b;
										lowest_distance = d;
									}
								}
							}
						}

						this.World.uncoverFogOfWar(location.getTile().Pos, 700.0);
						location.getFlags().set("IsEventLocation", true);
						location.setDiscovered(true);
						this.World.getCamera().moveTo(location);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationMajorOffense, "站在起义的负债者一边");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Spartacus3",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_166.png[/img]{%spartacus% 伸出手来，但你却没有伸出你的手。 相反，你拔出你的剑。 叛军首领点了点头。%SPEECH_ON%好的。你被禁止离开金钱的牢笼，我明白了，被召唤到闪闪发光的镀金者的道路上，他们如此迫切地奴役你，你被俘虏了，以至于当鸟笼打开时，你也不会张开你的翅膀，而是仅仅停留在主人的手指上跳一跳。 希望这场战斗对我们都好，逐币者。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.OrientalBanditTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.Template[0] = "tactical.desert_camp";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
						p.LocationTemplate.CutDownTrees = true;
						p.Tile = tile;
						p.CombatID = "SlaveUprisingContract";
						p.TerrainTemplate = "tactical.desert";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.NomadRaiders, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Slaves, 55 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Spartacus4",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{你站在 %spartacus% 的身边。尽管他热爱自由，但这位可敬的叛军领袖在他最后的解放时刻并没有微笑。 他那扭曲的脸上的伤痕和皱纹透露出一阵哀伤。 但是他的眼睛中央。那里有一个火花，凝视着天空。 这时一个影子突然穿过他的眼睛，你抬头看向天空，以为是一只鸟，但什么也没有。 当你再往下看的时候，火花已经熄灭，死人仅仅只是一个死人。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们的工作完成了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Fleeing1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_59.png[/img]{你发现了一堆灼热的脚镣，摸起来很烫。 一位老人伸手指向北方。%SPEECH_ON%那些人朝那边走去了。%SPEECH_OFF%你很好奇，你问他为什么要把这些负债者的行踪供出来。他微笑着说。%SPEECH_ON%我也有我的工作需要完成，有时候维齐尔会借给我一些东西。 单凭我自己的双手很难完成一项好任务。%SPEECH_OFF% | 你遇到一条长长的沙地、泥土和灌木丛，它们显然受到了北行的人的干扰。 在被踩踏的乱七八糟的小路上你找到了一个镣铐，很明显，看来指向他们行踪的证据你拿到了。 负债者已经转向北方，你得把他们找出来。 | 接着你又在沙漠灌木丛中找到了一个枷锁。 一位老人从杯子里啜饮着水，咕哝着指向北方。%SPEECH_ON%那些乌合之众的负债者就是这样。 如果你能设法把他们带回维齐尔那里，麻烦为我说句好话。 给我找来几个人帮我打水。 从来没有自由人给我打水。%SPEECH_OFF%你不会为任何人说一句好话，但无论如何还是要谢谢他，然后向北走。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们当下就去追捕他们。",
					function getResult()
					{
						this.World.uncoverFogOfWar(this.Contract.m.Target.getPos(), 400.0);
						this.World.getCamera().moveTo(this.Contract.m.Target);
						this.Contract.setState("Running_Fleeing");
						return 0;
					}

				}
			],
			function start()
			{
				local cityTile = this.Contract.m.Home.getTile();
				local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(cityTile);
				local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Home.getTile(), 9, 15);
				local party = this.World.FactionManager.getFaction(nearest_nomads.getFaction()).spawnEntity(tile, "Indebted", false, this.Const.World.Spawn.Slaves, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一群负债者。");
				party.setFootprintType(this.Const.World.FootprintsType.Nomads);
				party.getSprite("banner").setBrush("banner_deserters");
				this.Contract.m.UnitsSpawned.push(party);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				local c = party.getController();
				local randomVillage;
				local northernmostY = 0;

				for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
				{
					local v = this.World.EntityManager.getSettlements()[i];

					if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
					{
						northernmostY = v.getTile().SquareCoords.Y;
						randomVillage = v;
					}
				}

				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(randomVillage.getTile());
				c.addOrder(move);
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Destination.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Nomads, 0.75);
			}

		});
		this.m.Screens.push({
			ID = "Fleeing2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_59.png[/img]{你终于追上那些负债者。 他们现在走的是崎岖的道路，他们所经过的荒凉的地形使他们身上留下了各种各样的印记。 但他们走到这一步就绝不会放弃：所有的人一看到你就马上武装起来，组成了阵型。 | 负债者现在已经处于绝望的状态，只要旅途给了他们自由的呼吸，他们就用精神和身体付出了代价。 那些晒得黝黑、四面楚歌、衣衫褴褛的人，眼睛睁得大大的，疲惫不堪地走近来。 你从狂野的目光中知道他们已经没有退路了。 他们会在路上或别的地方决一死战。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "摧毁他们！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Fleeing3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{总而言之，了结这些负债者是件简单的事。 所有的幸存者都清楚自己既然无法获得自由，那么就宁愿选择钢铁般的死亡。 在他们的皮肤里，你不确定你是否会做出任何不同的选择。 你收集你能收集到的证据，并准备好回去给 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们的工作完成了。",
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{你发现这次 %employer% 没有在后宫玩乐或在葡萄酒中游泳。 相反，你发现他正在散步，手拿着一个空鸟笼。 他闷闷不乐地说，他最喜欢的鸟飞了出来，飞走了。%SPEECH_ON%别以为我是个愚蠢的人，逐币者，我知道你可能会发现我的宠物和我的负债者有相似之处。 不过如果你这么认为的话，请随意。 但你这样想是目光短浅的。 我可以让我的鸟自由飞翔，但对这个世界来说，除了被吃掉之外没有任何用处。 但这并不是一种自由，逐币者，人都要学会去承担出生时命运赋予它的责任。 他们的自由是从厄运中逃脱出来的，是对于我命运的一种逃避，是许多同类都无法获得的逃脱。%SPEECH_OFF%维齐尔打了个响指，一个仆人似乎不知从哪里出现了。 他递给你一包硬币。 你抬头一看，维齐尔放下笼子，走开了。 | %employer% 处在他的四肢之中，用卫兵的话来说，就是“最爱的后宫。” 他伸出嘴，你感觉到他的眼睛从出汗的膝盖的缝隙里盯着你看，虽然没有真正的证据。%SPEECH_ON%胜利的逐币者回来用他疲惫的目光欣赏我最好的商品。 我的侦察兵说，正是这样，你没有充分利用把那些狂妄自大的负债者，他们的死会被重新制作成一种新的实用工具，一个由你亲手写的友好的场景，逐币者，作为对所有其他负债者的警告。%SPEECH_OFF%维齐尔瞬间消失，然后又出现在一个女人的大腿之间。%SPEECH_ON%仆人！付钱给逐币者。%SPEECH_OFF%两个瘦骨嶙峋的男孩背着一个小箱子，把它放在你的脚边。 它很重，而且没有人帮你搬。 | 一个戴着锁链的人在 %employer%的房间外和你见面。 他每只胳膊上都系着一条链子。 一根链子挂在墙上，另一根链子穿过地板到一箱克朗上。 两条链条都用锁固定。 这个人拿着箱子的钥匙。 他紧紧盯着你，咬牙切齿，手指紧捏着钥匙，最终他松开了钥匙，大口的吸气。 他最后蹲下，打开了箱子的锁，你拿起它，后退一步。 奴隶把钥匙放在胸前，他瞥了一眼另一把锁，他把手放在钥匙上，低下头，然后传来一种声音，你不知道是什么声音。 一个警卫告诉他在把你领出去之前不要出声。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "克朗就是克朗。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-2);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "镇压一场负债起义。");
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
			"location",
			this.m.Destination.getRealName()
		]);
		_vars.push([
			"spartacus",
			this.m.Flags.get("SpartacusName")
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/slave_revolt_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnEnterCallback(null);
			}

			if (this.m.Target != null && !this.m.Target.isNull())
			{
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
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

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
		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(location));
		}

		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

