this.hold_chokepoint_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hold_chokepoint";
		this.m.Name = "坚守要塞";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local enemies = [];

		foreach( n in nobles )
		{
			if (n.getFlags().get("IsHolyWarParticipant"))
			{
				enemies.push(n);
			}
		}

		this.m.Flags.set("EnemyID", enemies[this.Math.rand(0, enemies.len() - 1)].getID());
		local locations = this.World.EntityManager.getLocations();
		local candidates = [];

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.abandoned_fortress")
			{
				candidates.push(v);
			}
		}

		local closest;
		local closest_dist = 9000;

		foreach( c in candidates )
		{
			local d = this.m.Home.getTile().getDistanceTo(c.getTile()) + this.Math.rand(0, 5);

			if (d < closest_dist)
			{
				closest = c;
				closest_dist = d;
			}
		}

		this.m.Destination = this.WeakTableRef(closest);
		this.m.Payment.Pool = 1400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		this.m.Flags.set("Wave", 0);
		this.m.Flags.set("WavesDefeated", 0);
		this.m.Flags.set("WaitUntil", 0.0);
		this.m.Flags.set("MapSeed", this.Time.getRealTime());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"移动到废弃的要塞，防御北方的入侵"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					if (this.Contract.getDifficultyMult() <= 1.05)
					{
						this.Flags.set("IsEnemyRetreating", true);
					}
				}

				if (r <= 40)
				{
					this.Flags.set("IsReinforcements", true);
				}
				else if (r <= 70)
				{
					this.Flags.set("IsUltimatum", true);
				}

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

				foreach( n in nobles )
				{
					if (n.getFlags().get("IsHolyWarParticipant"))
					{
						n.addPlayerRelation(-99.0, "在战争选择了阵营");
					}
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
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
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					this.Contract.setScreen("Arrive");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Defend",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"利用废弃的堡垒来防御北方的入侵",
					"不要走得太远"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsFailure") || !this.Contract.isPlayerNear(this.Contract.m.Destination, 600))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("Wave") > this.Flags.get("WavesDefeated") && (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()))
				{
					this.Flags.increment("WavesDefeated", 1);
					this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(3, 6));

					if (this.Flags.get("WavesDefeated") == 1)
					{
						this.Contract.setScreen("Waiting1");
					}
					else if (this.Flags.get("WavesDefeated") == 2)
					{
						this.Contract.setScreen("Waiting2");
					}
					else if (this.Flags.get("WavesDefeated") == 3)
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("WaitUntil") > 0 && this.Time.getVirtualTimeF() >= this.Flags.get("WaitUntil"))
				{
					this.Flags.set("WaitUntil", 0.0);
					this.Flags.set("IsWaveShown", false);

					if (this.Flags.getAsInt("Wave") == 2 && this.Flags.get("IsEnemyRetreating"))
					{
						this.Contract.setScreen("EnemyRetreats");
						this.World.Contracts.showActiveContract();
						return;
					}
					else if (this.Flags.getAsInt("Wave") == 2 && this.Flags.get("IsUltimatum"))
					{
						this.Contract.setScreen("Ultimatum1");
						this.World.Contracts.showActiveContract();
						return;
					}
					else
					{
						this.Flags.increment("Wave", 1);
						local enemyNobleHouse = this.World.FactionManager.getFaction(this.Flags.get("EnemyID"));
						local candidates = [];

						foreach( s in enemyNobleHouse.getSettlements() )
						{
							if (s.isMilitary())
							{
								candidates.push(s);
							}
						}

						local mapSize = this.World.getMapSize();
						local o = this.Contract.m.Destination.getTile().SquareCoords;
						local tiles = [];

						for( local x = o.X - 3; x < o.X + 3; x = ++x )
						{
							for( local y = o.Y + 3; y <= o.Y + 6; y = ++y )
							{
								if (!this.World.isValidTileSquare(x, y))
								{
								}
								else
								{
									local tile = this.World.getTileSquare(x, y);

									if (tile.Type == this.Const.World.TerrainType.Ocean)
									{
									}
									else
									{
										local s = this.Math.rand(0, 3);

										if (tile.Type == this.Const.World.TerrainType.Mountains)
										{
											s = s - 10;
										}

										if (tile.HasRoad)
										{
											s = s + 10;
										}

										tiles.push({
											Tile = tile,
											Score = s
										});
									}
								}
							}
						}

						tiles.sort(function ( _a, _b )
						{
							if (_a.Score > _b.Score)
							{
								return -1;
							}
							else if (_a.Score < _b.Score)
							{
								return 1;
							}

							return 0;
						});
						local party = enemyNobleHouse.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Noble, (this.Math.rand(100, 120) + this.Flags.get("Wave") * 10 + (this.Flags.get("IsAlliedReinforcements") ? 50 : 0)) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyNobleHouse.getBannerString());
						party.setDescription("为地方领主服务的专业士兵。");
						party.getLoot().Money = this.Math.rand(50, 200);
						party.getLoot().ArmorParts = this.Math.rand(0, 25);
						party.getLoot().Medicine = this.Math.rand(0, 3);
						party.getLoot().Ammo = this.Math.rand(0, 30);
						local r = this.Math.rand(1, 4);

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

						local c = party.getController();
						local attack = this.new("scripts/ai/world/orders/attack_zone_order");
						attack.setTargetTile(this.Contract.m.Destination.getTile());
						c.addOrder(attack);
						local move = this.new("scripts/ai/world/orders/move_order");
						move.setDestination(this.Contract.m.Destination.getTile());
						c.addOrder(move);
						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(this.Contract.m.Destination.getTile());
						guard.setTime(240.0);
						c.addOrder(guard);
						party.setAttackableByAI(false);
						party.setAlwaysAttackPlayer(true);
						party.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
						this.Contract.m.Target = this.WeakTableRef(party);
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerInitiated;

				if (!this.Flags.get("IsWaveShown"))
				{
					this.Flags.set("IsWaveShown", true);

					if (this.Flags.getAsInt("Wave") == 3 && this.Flags.get("IsReinforcements"))
					{
						this.Contract.setScreen("Reinforcements");
					}
					else
					{
						this.Contract.setScreen("Wave" + this.Flags.get("Wave"));
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "HoldChokepoint";
					p.Music = this.Const.Music.NobleTracks;

					if (this.Contract.isPlayerAt(this.Contract.m.Destination))
					{
						_isPlayerInitiated = false;
						p.MapSeed = this.Flags.getAsInt("MapSeed");
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.LocationTemplate.ShiftX = -4;

						if (this.Flags.get("IsAlliedReinforcements"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
							p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
						}
					}

					this.World.Contracts.startScriptedCombat(p, _isPlayerInitiated, true, true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "HoldChokepoint")
				{
					this.Flags.set("IsFailure", true);
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
					if (this.Flags.getAsInt("WavesDefeated") <= 2 && !this.Flags.get("IsEnemyRetreating"))
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 被他的军人们围了起来。 他们穿着各种浮夸的衣服，让你觉得他们有点不适合参加战争。 不过，虽然穿的像只鸟似的，其中一个指挥官拿着张地图把你带到边上并简明的说道。%SPEECH_ON%逐币者，我们需要你去一座在 %direction% 的被废弃的要塞。 我们有一个联队的士兵正在前往那里，但他们没法赶在北方野蛮人前到那里。 范围内，你是最近的。 去那儿并守到我们的士兵出现。 工事已经破败了，但我相信你这样狡猾的人就靠点石头也办得到的。%reward% 克朗会在你成功活着完成任务后时候给你。%SPEECH_OFF% | %employer% 坐在一个坐垫上，面前铺着一张巨大的地毯。 穿着华丽的军官们坐在边上的角落里，每一个都拿着一根长木棍推着些木块。 在地毯的长边上几个地毯工匠仍在往地图上添加着什么，从你的了解来看应该是北方的区域。 维齐尔看到了你并远远的对你说。%SPEECH_ON%逐币者，%direction% 有一座要塞。 一座破败的堡垒，有人说现在不过是一片碎砖，但是古人们把它建在那里是有个好理由的：它有重要的战略意义。 尽管我的士兵正快速前往那里，他们无法在北方人的部队前赶到那里。 一群不洁的野蛮人，但你得承认他们快速进军的诡计是很有效。 所以，我需要你去占领要塞并坚守到我的军队到达。%SPEECH_OFF%他举起一张纸，上面又一个你可以轻易理解的数字：%reward% 克朗。 | 一个非常高的着军装的人阻止了你进入 %employer%的房间。 可以听到维齐尔正在和他的后宫缠绵，但这和你无关。 军官拍了张卷轴到你胸上。%SPEECH_ON%古人们在 %direction% 修了一座要塞。 它破败至今，像一切事物一样被时间摧残了，但是这个地方仍然有战略意义。 我们正让一队士兵前去那里，但我们的侦察兵报告说北方杂种也清楚它的重要性并会在我们之前赶到。 这就是你派上用场的地方了。%reward% 克朗，去占领并坚守到援军抵达。 一旦战况缓和，你就可以回来拿一份不菲的报酬。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{听起来像是 %companyname% 可以做的事情。 | 我们来谈谈我们为此得到的报酬。 | 我们能守住要塞抵御异教者的入侵。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。 | 我不会冒险让战队守住一个废墟。}",
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
			ID = "Arrive",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_167.png[/img]{要塞看起来熟悉而又反常。 尽管破败到变成一堆堆的碎砖碎石，你还是会不由地感觉到墙壁中的威严。 在更里面的地方，破败的军械库和遗弃的食堂边，有些更奇特的结构：匆忙立起的防御，远离岗位的最后一战的痕迹。 很难说这里发生过什么，或者什么时候，但现在它是 %companyname%的临时住所了。\n\n 你走到有垛口的墙边，往外看。 看起来你刚好赶上了：北方人已经在接近，一排轮廓像蚂蚁越过山丘一样正越过地平线。 | 关于这座堡垒是古代帝国遗迹的传言看来是对的：它的建筑即相同又相异。 你理解这些墙的用途，但你不确定上面的符号有什么含义。 就连一些房间的建筑结构，角落里扫出来的那些令人难以置信的砖砌漩涡状物体，不像你见过的任何东西。 你不确定这是否能产生什么战术优势又或者它的建造者这么设计有别的目的。\n\n但是没有时间去钻研这地方的历史了，你来这里只是为了把它变成一个哨所。 而且看起来时候到了：一波北方人翻过地平线正径直冲向你！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "所有人，准备好！",
					function getResult()
					{
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(5, 8));
						this.Contract.setState("Running_Defend");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Wave1",
			Title = "战斗之前…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{北方人的先锋到了。 你跳到墙上叫 %companyname% 准备好战斗。 佣兵们跃起，进入岗位并准备起武器。 同时，北方人装备的哐当声随他们靠近越发响亮。 第一支箭无害似的滑入了要塞，轻轻的暗示着一场血腥战斗即将到来。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Wave2",
			Title = "战斗之前…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{%randombrother% 大喊一声，你冲到墙边。 战场上布置着一支北方人的重装步兵大队。 也许他们已经了解到，摆在他们面前的是 %companyname%，他们需要更认真地对待这件事。 并不是说额外的谨慎可以拯救他们。 面对 %companyname% 只有一个结果，你忍不住向接近中的攻击队列咧嘴露出了邀请似的坏笑。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Wave3",
			Title = "战斗之前…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{北方人再次接近。 他们像鲷鱼在盐水里一样穿过曾经战友的尸体，一个由人和材料打成的黑暗的结点，黑黑的并且被那些敢于进犯的人染出来的血红泥土衬出的轮廓。 老鼠已经在啃食散步各处的死者，还有环绕的秃鹫。 你举起武器并命令手下准备好面对最好是最后一场的战斗。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Waiting1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_167.png[/img]{第一波攻势被击退了。 你短暂的考虑了下要不要用尸体去堵住墙上的窟窿，但你不想引来老鼠和它们可能带来的疫病。 简短的几声命令，你让尸体都堆到墙的外面并让手下为下场攻击做好准备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备迎接他们的下一次进攻！",
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
			ID = "Waiting2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_167.png[/img]{%companyname% 几乎开始看起来像你刚招募他们时一样：被世界践踏与殴打过那样。 但是在战队度过的这段时间让他们成为了更强的人。 尽管精疲力竭，但疲劳没有磨灭训练、威望和名声。 当时候来时，%companyname% 将准备好迎接下次攻击。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "还可能有更多要来。",
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
			ID = "Failure",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_87.png[/img]{你已经看够了。 维齐尔的任务是坚守一段时间，不是坐在这等死。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不值得为此失去整个战队…",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "未能防御住北方入侵者的防御工事。");
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
			ID = "EnemyRetreats",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_168.png[/img]{随着尸体堆积成山，苍蝇嗡嗡直响，还有黑云般盘旋的大群秃鹫，看起来北方人受够了。 一声号角吹出低沉软弱的声音，然后人们放下武器转身回他们来的方向去了。 同时，一个侦察兵从南方赶来说 %employer%的士兵很快就会到。 看起来你可以回去找雇主了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们做到了！",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnAllies();
			}

		});
		this.m.Screens.push({
			ID = "Reinforcements",
			Title = "战斗之前…",
			Text = "[img]gfx/ui/events/event_164.png[/img]{北方人再次接近。 他们像鲷鱼在盐水里一样穿过曾经战友的尸体，一个由人和材料打成的黑暗的结点，黑黑的并且被那些敢于进犯的人染出来的血红泥土衬出的轮廓。 在你举起武器给手下发令时，更多人出现在了地平线上。 你的心里阴沉了一阵，知道你发现他们带着 %employer%的旗帜！ 维齐尔的人到了！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "终于，一点帮助！",
					function getResult()
					{
						this.Flags.set("IsAlliedReinforcements", true);
						this.Flags.set("IsReinforcements", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Ultimatum1",
			Title = "在你等待时…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{一声刺耳的号角吸引了你的注意。 你前去防御工事的顶端并看到下面有一个带着贵族颜色的使者。 他孤身一人，但他的嗓音如同一整支战伍。%SPEECH_ON%尔佣兵求宽恕乎？ 尔佣兵求明日否，或次冬春乎？ 尔佣兵求生否，然…%SPEECH_OFF%你对他喊回去让他少扯淡。 他清清嗓子。%SPEECH_ON%贵族们想要做个交易。 立刻离开这片区域然后你将被放出一条生路。 不仅如此，我们认为你们的石板打蜡了，离开这里就把石板瓦熔化干净。 %companyname% 与北方之间的所有敌对行为将由北方令状撤销。 当然，这需要你接受这个提议。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你的提议可以接受。",
					function getResult()
					{
						return "Ultimatum2";
					}

				},
				{
					Text = "让你和你的蜡见鬼去吧！",
					function getResult()
					{
						return "Ultimatum3";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsArrived", true);
			}

		});
		this.m.Screens.push({
			ID = "Ultimatum2",
			Title = "在你等待时…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{你接受了交易。 几个手下发了点牢骚，其他人则感到宽心，尽管如此都好好藏起来以免引起你的怀疑。 %companyname%“合法的”放弃了这个地方，而北方人占领了它。 你被交予了几份正式文件，上面带着所有北方家族和人物的签名，还有他们的正式印章。 它会让你在北方领土里平安无事，尽管你无疑为这份权利失去了南方人的好感。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "对于战队而言这是最好的办法。",
					function getResult()
					{
						local f = this.World.FactionManager.getFaction(this.Contract.getFaction());
						f.addPlayerRelation(-f.getPlayerRelation(), "在战争中改变了立场");
						f.getFlags().set("Betrayed", true);
						local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

						foreach( n in nobles )
						{
							n.addPlayerRelationEx(50.0 - n.getPlayerRelation(), "在战争中改变了立场");
							n.makeSettlementsFriendlyToPlayer();
						}

						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
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
			ID = "Ultimatum3",
			Title = "在你等待时…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{你告诉使者回去找他的指挥官。他点头。%SPEECH_ON%也许你的勇气获得旧神们的赞赏，它可动摇不了北方的力量。%SPEECH_OFF%信使鞠躬并告别了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备迎接他们的下一次攻击。",
					function getResult()
					{
						this.Flags.set("IsUltimatum", false);
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(3, 6));
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
			Text = "[img]gfx/ui/events/event_168.png[/img]{尸体散落在战场上，有时候堆到三或四个高。 %companyname% 的手下走在尸体间搜刮他们能找到的一切，伴随着乌鸦，秃鹫，老鼠，猫，狗，狼，一个过于危险不宜靠近的野人，还有一群看起来觉得这个地方足够暖和而从迁徙中停下来的鹅。 维齐尔的人也到了并换了岗，所以你得自己迁徙回去找 %employer% 拿报酬了。 | 空气中有一股潮湿的停滞感还有刺鼻的铜味。 这里的杀戮如此激烈以致这里的土地变成了一片血与肉的沼泽。 尸体躺在各种方向，有时候堆在另一个上面。 有时候你听到什么人在呻吟，但是死的人太多了搜寻幸存者恐怕也是浪费时间。%employer%的手下很快就会来替换你，意味着是时候回去找维齐尔拿报酬了。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们做到了！",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnAllies();
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 在你离他王座不远的地方止住了你。 他打了个响指然后一个仆人走上前，但是维齐尔笑着举起手。%SPEECH_ON%不，等一下。让女人们中的一个来。 她。最丑的那个。%SPEECH_OFF%他指向他的后宫，然后女士们分开来直到一个女人被孤立出来。 她如此美丽以致你想她能在北方换来一座城堡。 她从仆人手里拿下那包克朗并在你面前伏下。%employer% 坏笑起来。%SPEECH_ON%你的任务是坚守要塞直到我的手下到。 但是，你选择娘娘腔的临阵脱逃。 幸运的是，我的人，真男人们，到了地方从北方人手里夺回了它并且把它设成了一个枢纽。 停止盯着那个小妾了，逐币者！ 你的眼只允许盯着地面或者你的报酬。 我建议你拿上你的硬币并且在镀金者的光芒在你脚下燃起火前离开我的视线。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "守卫要塞抵抗北方人");
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
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你向 %employer% 汇报了事情的经过。 一片笑容慢慢的在维齐尔的脸上露出。%SPEECH_ON%天啊，我的军官派你去的？ 那个要塞分文不值。 谁会做这种诡计？ 我会想斩首为此负责的人，但是呢，多少来着，%reward_completion% 克朗？ 它对我而言没什么。 我曾经花了更多钱请北方的小丑来亲自跟我讲笑话，而他们的幽默感最多只能用贫瘠来形容。 拿上你的金子离开我的住所，逐币者。%SPEECH_OFF% | 当你回去找 %employer% 时，你找不到他。 与之相对，他的一个军官把你带到一边并为你的服务表示感谢。%SPEECH_ON%在我们和老鼠们之间，并且确保这些话从来没有说过，还有这些长廊里找不到老鼠，如果我的队伍里有你这样的人会让我心中燃起自己来当征服者的欲望。 唉，我手下的士兵对我就像沙漠里的一撮沙般有用。 这是你的报酬，克朗－，战士。%SPEECH_OFF%他交过来一包 %reward_completion% 克朗。 另一个军官开始沿着走廊走过来，然后你面前的人拍到了你的肩上，他的面容突然没有一丝幽默或亲善。%SPEECH_ON%滚吧，逐币者，你的报酬都在这儿了而且我们不想再从你嘴里听到一声讨价还价！%SPEECH_OFF% | 你走进维齐尔的大厅却只找到一个人孤身扫着大理石地板。 他的扫帚的条刮到你的靴子上停了下来而他也抬起了头。%SPEECH_ON%啊。他们跟我说过你这样身份的人要来。%SPEECH_OFF%他放下扫帚，它的柄可能比他脆弱的身躯还要粗壮。 他走到一个桌子边打开一个宝箱里面一盘一盘的金子，其中一盘装着 %reward_completion% 克朗。 你问他维齐尔怎么会把这么多硬币给他看管。 他拿起他的扫把并笑道。%SPEECH_ON%如果我给自己偷了些克朗，我能跑多远呢？ 它很沉。我没法全部拿上。 所以我可以拿一点？不。 我没有任何物质资产。 就像镀金者的目光使花儿绽放，我手掌中的金币也会找出我的窃行。 我绝对跑不远的。 这里就是我的岗位，然后这是你的。%SPEECH_OFF%你拿上了硬币，但是又问他怎么知道你是那个佣兵。 他的扫帚又剐蹭着停了下来，汗珠从脸颊上缓慢流下。 在他回答前，你拿着克朗走了。 | %employer% 跟他的议会在一起。 这场穿丝戴银，抚摸着大胡子的人们的罕见聚会以蔑视迎接了你。 你大声声称要塞已经守住并被南方士兵掌控。 一切噪音都停息了而你的声音回响在大理石长廊里并且每一个仆人还有议会都停了下来。%employer% 站起来。%SPEECH_ON%仆人，去拿给这摇舌头狗的硬币。%SPEECH_OFF%其中一个议员吐了口唾沫，而一个被项圈困住的儿童快速的清理了它。%SPEECH_ON%他在要塞的时候应该把工资汇了。 他怎么胆敢在这房间里呼吸。%SPEECH_OFF%仆人赶到你身边带着一袋 %reward_completion% 克朗。 维齐尔摇了摇手。%SPEECH_ON%滚，逐币者。我每天都有很多人要雇，而你不在他们之中。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "守卫要塞抵抗北方人");
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

	function spawnAllies()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local mapSize = this.World.getMapSize();
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 3; x < o.X + 3; x = ++x )
		{
			for( local y = o.Y - 6; y <= o.Y - 3; y = ++y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local party = cityState.spawnEntity(tiles[0].Tile, "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + cityState.getBannerString());
		party.setDescription("忠于城邦的应征士兵。");
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
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"employerfaction",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
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

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isHolyWar())
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
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

