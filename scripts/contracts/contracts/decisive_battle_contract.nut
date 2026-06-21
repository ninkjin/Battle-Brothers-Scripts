this.decisive_battle_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Warcamp = null,
		WarcampTile = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.decisive_battle";
		this.m.Name = "决战";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
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

		if (this.m.WarcampTile == null)
		{
			local settlements = this.World.EntityManager.getSettlements();
			local lowest_distance = 99999;
			local best_settlement;
			local myTile = this.m.Home.getTile();

			foreach( s in settlements )
			{
				if (this.World.FactionManager.isAllied(this.getFaction(), s.getFaction()))
				{
					continue;
				}

				local d = s.getTile().getDistanceTo(myTile);

				if (d < lowest_distance)
				{
					lowest_distance = d;
					best_settlement = s;
				}
			}

			this.m.WarcampTile = myTile.getTileBetweenThisAnd(best_settlement.getTile());
			this.m.Flags.set("EnemyNobleHouse", best_settlement.getOwner().getID());
		}

		this.m.Flags.set("CommanderName", this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]);
		this.m.Payment.Pool = 1600 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		this.m.Flags.set("RequisitionCost", this.beautifyNumber(this.m.Payment.Pool * 0.25));
		this.m.Flags.set("Bribe", this.beautifyNumber(this.m.Payment.Pool * 0.35));
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"移动到军营并向%commander%报到",
					"协助正规军对抗 %feudfamily%"
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
				this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).addPlayerRelation(-99.0, "在战争选择了阵营");

				if (this.Contract.m.WarcampTile == null)
				{
					local settlements = this.World.EntityManager.getSettlements();
					local lowest_distance = 99999;
					local best_settlement;
					local myTile = this.Contract.m.Home.getTile();

					foreach( s in settlements )
					{
						if (this.World.FactionManager.isAllied(this.Contract.getFaction(), s.getFaction()))
						{
							continue;
						}

						local d = s.getTile().getDistanceTo(myTile);

						if (d < lowest_distance)
						{
							lowest_distance = d;
							best_settlement = s;
						}
					}

					this.Contract.m.WarcampTile = myTile.getTileBetweenThisAnd(best_settlement.getTile());
				}

				local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.WarcampTile, 1, 12, [
					this.Const.World.TerrainType.Shore,
					this.Const.World.TerrainType.Ocean,
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Forest,
					this.Const.World.TerrainType.LeaveForest,
					this.Const.World.TerrainType.SnowyForest,
					this.Const.World.TerrainType.AutumnForest,
					this.Const.World.TerrainType.Swamp
				], false, false, true);
				tile.clear();
				this.Contract.m.WarcampTile = tile;
				this.Contract.m.Warcamp = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/noble_camp_location", tile.Coords));
				this.Contract.m.Warcamp.onSpawned();
				this.Contract.m.Warcamp.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall());
				this.Contract.m.Warcamp.setFaction(this.Contract.getFaction());
				this.Contract.m.Warcamp.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Warcamp.getTile().Pos, 500.0);
				local r = this.Math.rand(1, 100);

				if (r <= 40)
				{
					this.Flags.set("IsScoutsSighted", true);
				}
				else
				{
					this.Flags.set("IsRequisitionSupplies", true);
					r = this.Math.rand(1, 100);

					if (r <= 33)
					{
						this.Flags.set("IsAmbush", true);
					}
					else if (r <= 66)
					{
						this.Flags.set("IsUnrulyFarmers", true);
					}
					else
					{
						this.Flags.set("IsCooperativeFarmers", true);
					}
				}

				r = this.Math.rand(1, 100);

				if (r <= 40)
				{
					if (this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getSettlements().len() >= 2)
					{
						this.Flags.set("IsInterceptSupplies", true);
						local myTile = this.Contract.m.Warcamp.getTile();
						local settlements = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getSettlements();
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

						this.Flags.set("InterceptSuppliesStart", best_start.getID());
						this.Flags.set("InterceptSuppliesDest", best_dest.getID());
					}
				}
				else if (r <= 80)
				{
					this.Flags.set("IsDeserters", true);
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
					"移动到军营并向%commander%报到"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Warcamp) && !this.Flags.get("IsWarcampDay1Shown"))
				{
					this.Flags.set("IsWarcampDay1Shown", true);
					this.Contract.setScreen("WarcampDay1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_WaitForNextDay",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在军营里待命，等待被召唤"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Warcamp))
				{
					if (this.World.getTime().Days > this.Flags.get("LastDay"))
					{
						if (this.Flags.get("NextDay") == 2)
						{
							this.Contract.setScreen("WarcampDay2");
						}
						else
						{
							this.Contract.setScreen("WarcampDay3");
						}

						this.World.Contracts.showActiveContract();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_Scouts",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"拦截 %feudfamily% 的侦察兵，他们最后在军营的 %direction%被发现",
					"不要让任何人活着逃脱"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onCombatWithScouts.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsScoutsFailed"))
					{
						this.Contract.setScreen("ScoutsEscaped");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("ScoutsCaught");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("IsScoutsRetreat"))
				{
					this.Flags.set("IsScoutsRetreat", false);
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
					this.Contract.setScreen("ScoutsEscaped");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithScouts( _dest, _isPlayerAttacking = true )
			{
				local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				properties.CombatID = "Scouts";
				properties.Music = this.Const.Music.NobleTracks;
				properties.EnemyBanners = [
					this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall()
				];
				this.World.Contracts.startScriptedCombat(properties, _isPlayerAttacking, true, true);
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_combatID == "Scouts")
				{
					this.Flags.set("IsScoutsFailed", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Scouts")
				{
					this.Flags.set("IsScoutsRetreat", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_ReturnAfterScouts",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"回到军营"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Warcamp) && !this.Flags.get("IsReportAfterScoutsShown"))
				{
					this.Flags.set("IsReportAfterScoutsShown", true);
					this.Contract.setScreen("WarcampDay1End");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Requisition",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在军营%direction%的%objective%处获取补给。"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Destination) && !this.TempFlags.get("IsReportAfterRequisitionShown"))
				{
					this.TempFlags.set("IsReportAfterRequisitionShown", true);
					this.Contract.setScreen("RequisitionSupplies2");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsRequisitionRetreat") && !this.Flags.get("IsRequisitionCombatDone"))
				{
					this.Flags.set("IsRequisitionCombatDone", true);
					this.Contract.setScreen("BeatenByFarmers");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsRequisitionVictory") && !this.Flags.get("IsRequisitionCombatDone"))
				{
					this.Flags.set("IsRequisitionCombatDone", true);
					this.Contract.setScreen("PoorFarmers");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Ambush" || _combatID == "TakeItByForce")
				{
					this.Flags.set("IsRequisitionRetreat", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Ambush" || _combatID == "TakeItByForce")
				{
					this.Flags.set("IsRequisitionVictory", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_ReturnAfterRequisition",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"回到军营"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = true;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Warcamp))
				{
					if (this.Flags.get("IsInterceptSupplies") || this.Flags.get("IsDeserters"))
					{
						this.Contract.setScreen("WarcampDay1End");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("WarcampDay2End");
						this.World.Contracts.showActiveContract();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_InterceptSupplies",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"拦截从%supply_start%到%supply_dest%的补给队。"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setVisibleInFogOfWar(true);
				}
			}

			function update()
			{
				if (this.Flags.get("IsInterceptSuppliesSuccess"))
				{
					this.Contract.setScreen("SuppliesIntercepted");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.m.Destination == null || this.Contract.m.Destination != null && this.Contract.m.Destination.isNull())
				{
					this.Flags.set("IsInterceptSuppliesFailure", true);
					this.Contract.setScreen("SuppliesReachedEnemy");
					this.World.Contracts.showActiveContract();
				}
			}

			function onPartyDestroyed( _party )
			{
				if (_party.getFlags().has("ContractSupplies"))
				{
					this.Flags.set("IsInterceptSuppliesSuccess", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_ReturnAfterIntercept",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"回到军营"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = true;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Warcamp))
				{
					this.Contract.setScreen("WarcampDay2End");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Deserters",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"沿着脚印追寻逃兵逃兵",
					"要么说服他们回来，要么杀了他们"
				];

				if (this.Contract.m.Warcamp != null && !this.Contract.m.Warcamp.isNull())
				{
					this.Contract.m.Warcamp.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Flags.get("IsDesertersFailed"))
				{
					if (this.Contract.m.Destination != null)
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
					}

					this.Contract.setState("Running_ReturnAfterIntercept");
				}
				else if (this.Contract.m.Destination == null || this.Contract.m.Destination != null && this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("DesertersAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerNear(this.Contract.m.Destination, this.Const.World.CombatSettings.CombatPlayerDistance / 2) && !this.TempFlags.get("IsDeserterApproachShown"))
				{
					this.TempFlags.set("IsDeserterApproachShown", true);
					this.Contract.setScreen("Deserters2");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Deserters")
				{
					this.Flags.set("IsDesertersFailed", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_FinalBattle",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"为 %noblehouse% 赢得战斗"
				];
			}

			function update()
			{
				if (this.Flags.get("IsFinalBattleLost") && !this.Flags.get("IsFinalBattleLostShown"))
				{
					this.Flags.set("IsFinalBattleLostShown", true);
					this.Contract.m.Warcamp.die();
					this.Contract.m.Warcamp = null;
					this.Contract.setScreen("BattleLost");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsFinalBattleWon") && !this.Flags.get("IsFinalBattleWonShown"))
				{
					this.Flags.set("IsFinalBattleWonShown", true);
					this.Contract.m.Warcamp.die();
					this.Contract.m.Warcamp = null;
					this.Contract.setScreen("BattleWon");
					this.World.Contracts.showActiveContract();
				}
				else if (!this.TempFlags.get("IsFinalBattleStarted"))
				{
					this.TempFlags.set("IsFinalBattleStarted", true);
					local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Warcamp.getTile(), 3, 12, [
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Ocean,
						this.Const.World.TerrainType.Mountains,
						this.Const.World.TerrainType.Forest,
						this.Const.World.TerrainType.LeaveForest,
						this.Const.World.TerrainType.SnowyForest,
						this.Const.World.TerrainType.AutumnForest,
						this.Const.World.TerrainType.Swamp,
						this.Const.World.TerrainType.Hills
					], false);
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "FinalBattle";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.Entities = [];
					p.AllyBanners = [
						this.World.Assets.getBanner(),
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
					];
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall()
					];
					local allyStrength = 90;

					if (this.Flags.get("IsRequisitionFailure"))
					{
						allyStrength = allyStrength - 20;
					}

					if (this.Flags.get("IsDesertersFailed"))
					{
						allyStrength = allyStrength - 20;
					}

					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, allyStrength * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.getFaction(),
						Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract)
					});
					local enemyStrength = 150;

					if (this.Flags.get("IsScoutsFailed"))
					{
						enemyStrength = enemyStrength + 25;
					}

					if (this.Flags.get("IsInterceptSuppliesFailure"))
					{
						enemyStrength = enemyStrength + 25;
					}

					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, enemyStrength * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyNobleHouse"));
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 60 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyNobleHouse"));
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = this.Const.DLC.Wildmen && this.Contract.getDifficultyMult() >= 1.15 ? 1 : 0,
						Name = this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)],
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Flags.get("EnemyNobleHouse"),
						Callback = null
					});
					this.Contract.setState("Running_FinalBattle");
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "FinalBattle")
				{
					this.Flags.set("IsFinalBattleLost", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "FinalBattle")
				{
					this.Flags.set("IsFinalBattleWon", true);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName() + "得到你的报酬。"
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer%邀请你进入房间。他穿着盔甲，尽管他的指挥官们似乎试图说服他不要进行实际战斗。不管怎样，他还是热情地欢迎了你，并迅速解释了他需要你做的事情。%SPEECH_ON%我们即将结束这场愚蠢的战争。我的主要部队正在%direction%集结，我需要你前往那里并与%commander%会面，他会给你安排工作。如果你帮助我们扭转战局，你将会得到丰厚的报酬，雇佣兵。%SPEECH_OFF% | 你走进%employer%的房间，看到他正在喂一面%feudfamily%的旗帜给一些狗，这些狼狗凶狠地咬着旗帜。%employer%抬起头看着你。%SPEECH_ON%啊，雇佣兵。很高兴你终于来了。我需要你去拜访%commander%，位于我们%direction%的区域。我们正准备开始这该死的战争的最后阶段，我相信像你这样的人可以帮助加速战争的结束。除此之外，我不能告诉你将会发生什么，但通常这些战争都会有令人惊叹的结局。你的报酬也将是惊人的。%SPEECH_OFF% | 你走进%employer%的房间，发现他被他的将军们包围着。他们正在围观一张大量标识相互对抗的地图。贵族看着你。%SPEECH_ON%啊，雇佣兵。我需要你去这里。%SPEECH_OFF%他在地图上放下一根棒子。%SPEECH_ON%并会见%commander%。我们正在准备终结这场战争，你的帮助至关重要。%SPEECH_OFF%你点了点头，但还没有离开。这个人皱起了眉头，竖起了一根手指头。%SPEECH_ON%哦，对了，你的帮助会得到报酬！不要对此产生任何误解。%SPEECH_OFF% | 你无法进入%employer%的房间。相反，他的其中一名指挥官在外面等你，并给你一份合同和一张地图。他解释说，一场大战即将到来，而你的帮助是必要的。如果你选择接受，你需要去找%direction%的%commander%，并听候进一步的指示。 | 在%employer%的房间外一名守卫挡住了你的去路。他盯了会儿你身上%companyname%的图章，然后开始跟你说话。%SPEECH_ON%我应该把这个交给你。%SPEECH_OFF%他将一卷卷轴狠狠地甩在了你的胸前。这份文件表明一场终结战争的战斗即将来临，如果你选择帮忙，你需要前往%commander%的营地听候进一步的指示。你询问应该是与他还是%employer%讨价还价。守卫咽下口水，脸颊上滑下了一颗汗珠。%SPEECH_ON%如果你一定要讨价还价，你可以试着和我谈判。%SPEECH_OFF% | %employer%迎接你并带你到他的私人训犬师那里。狗乖乖地坐着，当他走过它们的时候，他主宰式地轻轻抚摸着它们的头顶。%SPEECH_ON%%commander%正在领导我的士兵向%direction%前进，并向我报告说可能会有一场大战。%SPEECH_OFF%贵族停下脚步，转向你。%SPEECH_ON%他认为这场战争可能会结束与%feudfamily%的战争，因此我想让你去那里帮忙，只要可以结束这场恶斗。%SPEECH_OFF% | 你在一个满是将军的房间里与%employer%见面。他的指挥官们怀疑地看着你，但是这个人邀请你到一个角落里私下谈话。%SPEECH_ON%不要理会他们。现在快去，我的军队正在%commander%的领导下，离这里只有%direction%。我需要你去见他，以获取进一步的指示。我的指挥官们认为，最后一战可能很快就会降临，我们需要所有可以得到的帮助。如果这场战斗确实能结束这场战争，你会得到相应的报酬。%SPEECH_OFF% | 一个卫兵让你进入%employer%的房间，你发现那里的人被争吵的将军包围着。他们彼此争吵，打翻了地图上的战争标志，把战斗计划的安排搞得一团糟。%employer%站起来与你举行会面。%SPEECH_ON%不要理会噪音。这些人都很紧张，因为我们很有可能即将结束与%feudfamily%的这场该死的战争。%commander%和我的大部分军队正在%direction%休息。他已经召集尽可能多的增援，包括雇佣军。如果你去那里，帮忙结束这场该死的战争，那么你会得到最多的回报，雇佣兵。%SPEECH_OFF% | %employer%带你到了一些猪圈外，你在那里发现猪正在啃着一具尸体。附近，几只山羊在大吃%feudfamily%的一面旗帜。%employer%转过头带着灿烂的笑容对你说。%SPEECH_ON%你是间谍，这些事你懂的。不管怎样，%commander%已经向我汇报说他认为最后一场与%feudfamily%的战斗可能即将来临。他请求我们提供所有可能的援助，而我打算派遣援兵。如果你前往那里，会见他并照他的要求行事，你会得到丰厚的报酬。%SPEECH_OFF% | 你会见了%employer%的卫兵，他将你亲自带到了那个人身边。他坐在一个看起来像是远离世间烦恼的角落，手书间快熄灭的蜡烛和他手中的一本书相伴。他一边翻页，一边说道。%SPEECH_ON%你好，雇佣兵。我的指挥官%commander%告诉我，%feudfamily%的军队可能在集结。他相信我们有机会一劳永逸地结束这场战争。%SPEECH_OFF%这位贵族舔了舔拇指，缓缓翻了一页。他继续说道。%SPEECH_ON%我想让你去加入他。当然，你的报酬将会与你的贡献相应，我相信那肯定不少。%SPEECH_OFF% | %employer%的一个卫兵带你去了一座塔的顶端，那里是贵族本人。他看着你。%SPEECH_ON%不错的景色，不是吗？%SPEECH_OFF%你四周环顾，大地一望无垠，人群变得小小的，来来往往。一辆小驴拉的马车从塔下嘎吱作响地进入%townname%，进行生意。你耸了耸肩。%employer%点了点头。%SPEECH_ON%我以为你会喜欢这样的景色，但我想一位商人不会在谈生意时想这些。亲爱的雇佣兵，现在是做生意的时候。我的指挥官之一报告说，%feudfamily%的军队正在汇合。他认为我们有可能在一场大决战中结束这场战争。你明白吗？%SPEECH_OFF%你点了点头。他继续说道。%SPEECH_ON%如果一切按计划进行，你会按照你的服务获得报酬。雇佣兵，我不知道你是否曾经帮忙结束过一场战争，但许多人都愿意付出天价来换取这样的服务。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "一场伟大的战斗，你说呢？",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{我不会把 %companyname% 交给其他人指挥。 | 我不得不谢绝。 | 我们还有别的地方要去。}",
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
			ID = "WarcampDay1",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{你到达了大本营，这里更像是一个帐篷城市，你找到了队长%commander%。他欢迎你进入他的帐篷，这个地方更像是一个地图城市，他正在监视他的军队在哪里，以及他认为%feudfamily%的军队可能在哪里。%SPEECH_ON%欢迎，雇佣兵。你来得正是时候。%SPEECH_OFF% | %commander%的战营里充满了无聊的士兵。他们在煮炖菜或玩纸牌游戏。最令人兴奋的事情是一场甲虫和蠕虫之间的战斗，两个“对手”并不特别感兴趣。%commander%本人欢迎你，带你进入他的帐篷，布满了地图和其他计划工具。 | 你走进%commander%的帐篷，发现一群不太热情的人。有人呼喊道。%SPEECH_ON%你们不是我们要求的女人。%SPEECH_OFF%士兵们大笑起来。%randombrother%大声回击。%SPEECH_ON%你们的母亲先照顾了我们。%SPEECH_OFF%可预料的是，双方都开始拔出武器。%commander%自己出面干预，防止战斗爆发。他带你去了他的帐篷。%SPEECH_ON%很高兴你在这里，虽然如果我们要赢这场混蛋的战争，你的人可以少惹麻烦。%SPEECH_OFF% | 你来到%commander%的营地，发现士兵们正在为甲虫比赛加油助威。甲虫沿着稻草堆制成的赛道跑了一半，然后开始互相攻击。士兵们的欢呼声更响了。%commander%从人群中找到了你，带你去了他的帐篷。%SPEECH_ON%我很高兴你来了，雇佣兵。我现在有事要让你做。%SPEECH_OFF% | 到达%commander%的战营，你会发现士兵们正在为一个半裸女人骑驴欢呼。这对夫妇迅速消失在一个帐篷里，帐篷很快就挤满了男人。%randombrother%问能否去。你说你也去，当然可以。就在这时，%commander%抓住了你。他带你去了他的指挥帐篷。%SPEECH_ON%相信我，你不想看到那个场景。%SPEECH_OFF%你并不相信他。 | %commander%的战营已经把这片土地变成了泥潭。他们砍倒了附近的所有树木，用一些质量低劣的房子代替了它们，这些房子随着泥潭的变化而急剧倾斜。帐篷延伸到你的视野所及的地方。火堆沿途涌动，像白天星光闪耀的地方一样。 你在他的帐篷里与%commander%会面，他的帐篷里摆满了地图和等待命令的中尉。 | 战营里充满了铿锵的声音。铁匠修理装备，厨师煮沸着他们所谓的食物，而士兵们则为他们的帐篷钉桩。你在他的帐篷里会见%commander%。在他那所有金属声的喧嚣中失窃，却同时被他的中尉们的争论所取代。他摇了摇头。%SPEECH_ON%大规模的战斗来临时，人们变得紧张。不要在意他们的争吵。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你需要 %companyname% 做什么？",
					function getResult()
					{
						if (this.Flags.get("IsScoutsSighted"))
						{
							return "ScoutsSighted";
						}
						else
						{
							return "RequisitionSupplies1";
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WarcampDay1End",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{你回到战营，下令让你的士兵休息。 谁知道明天会发生什么。 | %commander%的命令已经完成，但明天肯定还有更多事情。 趁还能休息，好好休息吧！ | 战营和你离开时一样。 你不知道这是好事还是坏事。 明天会有更多事情要处理，所以你命令%companyname%休息。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好好休息，我们很快就会再次被召唤。",
					function getResult()
					{
						this.Flags.set("LastDay", this.World.getTime().Days);
						this.Flags.set("NextDay", 2);
						this.Contract.setState("Running_WaitForNextDay");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ScoutsSighted",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_54.png[/img]%commander%解释了情况。%SPEECH_ON%{我们的侦查兵发现了他们的侦查兵。不幸的是，我没有武装我的侦察兵进行战斗，所以他们请求帮助。 敌人位于离这里%direction%的地方。杀掉他们所有人，%feudfamily%将不会得知我们军队的行动。 | 我的几个开路者在离这里不远的%direction%发现了一些%feudfamily%的侦察兵。他们正在四处搜寻我们的主力军，但他们找不到，因为你们将前往那里将他们全部杀死。清楚吗？ | %feudfamily%的侦查兵已被发现，在离这里%direction%的地方。在他们发现我们或报告过去几天了解到的任何事情之前，我需要你们前往并将他们全部杀死。 | 在战争中，信息就是力量。我最近获得了有关%feudfamily%侦察兵正在离这里%direction%徘徊的信息。如果我能了解他们的情况，然后破坏他们了解我们的情况，那么我们对即将到来的战斗获得了相当大的优势。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "战团马上出发。",
					function getResult()
					{
						this.Contract.setState("Running_Scouts");
						return 0;
					}

				}
			],
			function start()
			{
				local playerTile = this.Contract.m.Warcamp.getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 8);
				local party = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).spawnEntity(tile, "Scouts", false, this.Const.World.Spawn.Noble, 60 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
				party.setDescription("为地方领主服务的专业士兵。");
				party.setFootprintType(this.Const.World.FootprintsType.Nobles);
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

				this.Contract.m.Destination = this.WeakTableRef(party);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Warcamp);
				roam.setMinRange(4);
				roam.setMaxRange(9);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
			}

		});
		this.m.Screens.push({
			ID = "ScoutsEscaped",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{很不幸，一些侦察兵设法在战斗中溜走了。他们收集的任何信息现在都在%feudfamily%手中。 | 全都该死！一些侦察兵设法逃脱，毫无疑问会回到%feudfamily%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.Contract.setState("Running_ReturnAfterScouts");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ScoutsCaught",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{所有侦察兵都被杀害了。他们所了解的信息随之而亡，而这会对即将来临的战斗产生很大的帮助。 | 侦察兵死了，他们所学到的一切都随之而亡。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.setState("Running_ReturnAfterScouts");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "RequisitionSupplies1",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{%commander% 叹了口气并开始说话。%SPEECH_ON%我并不是想浪费你的才能，雇佣兵，但我需要有人去征集军用口粮。我们的供应已经所剩无几，需要尽一切可能获取帮助。%SPEECH_OFF%嘿，如果你能得到报酬，那就不是对你的侮辱。 | %commander% 把一片干叶放在嘴里，叉起手臂。%SPEECH_ON%该死，我知道你来这里打仗。我知道你是来杀人并得到高额报酬的。但现在，我的军队需要吃饭，而要吃饭，我需要有人出去获取食物。%SPEECH_OFF%他走到一张地图旁，指着上面的位置。%SPEECH_ON%我需要你去见这些农民并装载他们的食品。他们会等着你的，所以不应该有任何问题。把这当做战斗前的轻松一天，好吗？%SPEECH_OFF% | %commander% 指着一张展开的地图上放着的一卷卷宣传册。下面有一些数字，而数字会越来越少。%SPEECH_ON%我们的口粮供应已经所剩无几。我们通常通过拜访%direction%的农民来征集粮食存储。我需要你去那里并取得更多的粮食。他们会等着你的，所以不应该有任何问题。%SPEECH_OFF% | 你看着盘子里放着的一块干面包。盘子旁边有肉，已经半吃半被苍蝇吃掉了。一只吃饱了的健康狗在角落里摇着尾巴。%commander% 走到一张地图旁边。%SPEECH_ON%我们的食物存储已经非常短缺。如果我的士兵饿了肚子，他们就不会战斗，如果他们不战斗，我们就会失败！%SPEECH_OFF% 你点了点头。逻辑是对的。他继续说道。%SPEECH_ON%我们已经从%direction%的农民那里取得食物一段时间了。我需要你去那里并执行同样的任务。我的护卫将为你列出所需采购清单。农民们不会反对你的，他们知道如果反对会发生什么。%SPEECH_OFF% | 你看到帐篷的一个角落里有一个勤奋的人。他用一支干羽毛笔沿着一张卷轴慢慢的写着，一边摇头。突然，他站起身来，把一页纸递给了%commander%。指挥官点了几下头，然后看着你。%SPEECH_ON%这可能对一些雇佣兵来说有些低贱，但我需要%companyname%去到%direction%的农场“获取”他们的食物。这不是我们的军队第一次向这些农民提出要求。上次我们去的时候，他们试图抵制，但是，教训就是这样得来的。我的秘书会写下我们所需的一切。把这当做一天在市场上购物吧。%SPEECH_OFF% 指挥官嘿嘿一笑。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "战团将在一小时内出动。",
					function getResult()
					{
						this.Contract.setState("Running_Requisition");
						return 0;
					}

				}
			],
			function start()
			{
				local settlements = this.World.EntityManager.getSettlements();
				local lowest_distance = 99999;
				local best_location;
				local myTile = this.Contract.m.Warcamp.getTile();

				foreach( s in settlements )
				{
					foreach( l in s.getAttachedLocations() )
					{
						if (l.getTypeID() == "attached_location.wheat_fields" || l.getTypeID() == "attached_location.pig_farm")
						{
							local d = myTile.getDistanceTo(l.getTile());

							if (d < lowest_distance)
							{
								lowest_distance = d;
								best_location = l;
							}
						}
					}
				}

				best_location.setActive(true);
				this.Contract.m.Destination = this.WeakTableRef(best_location);
			}

		});
		this.m.Screens.push({
			ID = "RequisitionSupplies2",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_72.png[/img]{农舍就在附近。一片庄稼海洋就在你们面前，随着风声荡漾。%randombrother% 用手穿过麦田。%randombrother2% 在他的肩膀上拍了一拳。%SPEECH_ON%你想让我们带回家吗？手放开。%SPEECH_OFF%雇佣兵揉着肩膀，然后打了回去.%SPEECH_ON%见鬼，我的手到哪都行，问问你妈吧。%SPEECH_OFF%拳击声迅速增加，田连同这美好的场景一并破碎。 | 农舍在远处。庄稼田随着风声轻轻摇曳，像平静的海浪一样。农工们用大镰刀穿过田野，一群人用叉子抬起残留的庄稼。驴子带着推车穿过崎岖的地形。 | 农场坐落在群山之间，土壤太好了，不足以阻挡农作物的生长。每一片田地都有农芥，农工们用闪闪发光的大镰刀和叉子在田间穿梭。在远处，你看到农场的主人们站在一起。他们看起来很生气，但很少有人会在%companyname%的面前保持愤怒。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们来这里是为了什么。",
					function getResult()
					{
						if (this.Flags.get("IsAmbush"))
						{
							return "Ambush";
						}
						else if (this.Flags.get("IsUnrulyFarmers"))
						{
							return "UnrulyFarmers";
						}
						else
						{
							return "CooperativeFarmers";
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Ambush",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_10.png[/img]{当你接近农民时，突然从你的两侧传来一声喊叫，然后一群手持精良武器的人跳了出来。这是一场伏击！ | 你正在接近农家小屋，满载食物的车开始倒退。随着它们往后移动，它们慢慢地暴露了一支武器精良的队伍。农民们迅速离开。%randombrother%拔出武器。%SPEECH_ON% 这是一场伏击！ %SPEECH_OFF% | 你接近食品车。当%randombrother%走向前方并卸下其中一个车厢的掩盖物时，农民们让开了。车里什么都没有。突然，一支箭向车厢侧面猛然撞击发出木质咔嚓声。农民们躲了下来，手持精良武器的人从两侧涌入。这是一场伏击！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Ambush";
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						local n = 0;

						do
						{
							n = this.Math.rand(1, this.Const.PlayerBanners.len());
						}
						while (n == this.World.Assets.getBannerID());

						p.Entities = [];
						p.EnemyBanners = [
							this.Const.PlayerBanners[n - 1],
							"banner_noble_11"
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "UnrulyFarmers",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_43.png[/img]你走到农民那里，他们开始反抗。他们的领袖抱臂摇头。%SPEECH_ON%{看啊，我这些人已经把车都装好了。我们可以半路而会，你知道吗？因为我们和任何人一样都有家人要养活和欠债。你付给我们%cost%克朗，我们就让这事到%commander%那里结束。 | 你们是雇佣兵，对吧？那你们应该比大多数人更明白金钱的必要性。我们是简单的农民，不是钱庄家。我们只要求得到一点补偿。你付给我们%cost%克朗，我们就给你食物。那份协议我们还是有些亏本的，但我仍然认为这是公平的。 | 你们穿着俗气的衣服上来，以为能把我们吓住。我说%commander%已经拿走太多东西了，是时候让他像其他人一样为自己的食物买单了！所以这是个交易。我会以%cost%克朗的价格卖给你食物，我认为这很公平。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你忘了你的位置，农夫。 你想让我们强行拿走吗？",
					function getResult()
					{
						return "TakeItByForce";
					}

				},
				{
					Text = "我懂。 你会得到你 %cost% 克朗，我们将得到补给。",
					function getResult()
					{
						return "PayCompensation";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BeatenByFarmers",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_22.png[/img]伏击太强了！你带着还能站立的人撤退。%commander%的士兵们现在不得不更加节制，而%companyname%在这里的失败消息无疑会传开。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.Flags.set("IsRequisitionFailure", true);
						this.Contract.setState("Running_ReturnAfterRequisition");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "PoorFarmers",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{农民和他们雇佣的剑客们都被镇压了。其中一个农工，肚子挂在外面，向后踢腿，乞求宽恕，当你靠近准备杀死他时。你摇了摇头。%SPEECH_ON%孩子，这就是你们的归宿。%SPEECH_OFF%剑刃轻松地切过他的喉咙。他咯咯作响，但很快就结束了。你命令人们收集食物，准备返回给%commander%。 | 农民和他们雇佣的伏击队已经被杀个干净。你命令人们收集粮食。%commander%和他的士兵应该会很高兴看到你的回来。 | 食物上有一些血迹，但是用一点水就能擦掉。%commander%的士兵会欣赏你在这里所做的工作。 | %randombrother%拿起一个假装死亡的农民，割破了他的喉咙。那人咳嗽着，扭动着从佣兵的手中挣脱出来。他跳过来，朝着一个货车，把血吐在食物上。你大声喊道。%SPEECH_ON%该死，把他带下去！%SPEECH_OFF%这个农民很快就被处置了，但运输货物毫无疑问已经毁了。你摇了摇头。%SPEECH_ON%给那些东西盖上一块毯子。或许没人会注意到。%SPEECH_OFF% | 取得食物需要比你预期的更多的工作，但现在一切都在你的掌握中。你把农田的所有权交给了一个穿着羊皮鞋的贫穷农工。%SPEECH_ON%不要忘记你的主人在这里所发生的事情，因为这肯定也会发生在你的身上，知道了吗？%SPEECH_OFF%孩子迅速点了点头。你命令%companyname%准备返回给%commander%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "一群笨蛋。",
					function getResult()
					{
						this.Flags.set("RequisitionSuccess", true);
						this.Contract.setState("Running_ReturnAfterRequisition");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CooperativeFarmers",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{农民们热情地欢迎你。%SPEECH_ON%让我猜猜，%commander%派你们来的吧？%SPEECH_OFF% 你点点头。农民吐了口痰，也点了点头。%SPEECH_ON%好吧。你们在这里应该不会遇到麻烦。伙计们，帮他们上路。%SPEECH_OFF% 佣兵带着农产品准备归还给%commander%，农业工人们出来帮忙，为旅途做好了准备。 | 你见到了这些农民的领袖，他握了握你的手。%SPEECH_ON% %commander%的小鸟告诉我，他派了佣兵，但你们的队伍比我见过的任何一家公司都要强。我的手下会帮你们把货装上马车，让你们上路。%SPEECH_OFF% | 农民们开始加载马车，当你走近的时候。他们的领袖上前一步。%SPEECH_ON%我不喜欢做这件事，但我更喜欢呆在这个田野上，而不是坐在某个战争营地里等死在我不关心的战争里。我会让我的人帮助你们将这些货物装上马车，让你们走好自己的路。当你见到%commander%的时候，请替我说句好话，好吗？我想继续做农民。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我相信 %noblehouse% 会很感激的。",
					function getResult()
					{
						this.Flags.set("RequisitionSuccess", true);
						this.Contract.setState("Running_ReturnAfterRequisition");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TakeItByForce",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你拔出了剑。农民们退后了一步，一阵抓起长柄叉的哗啦声响彻整个队列。他们的领袖吐了口唾沫，拭了拭嘴角。%SPEECH_ON%见祖宗了？那我们就陪你们走一趟。%SPEECH_OFF% | 你摇了摇头。%SPEECH_ON%不必了。交出粮食，否则我们就动手了。%SPEECH_OFF%农民挥舞着手中的工具，他的手下慢慢地开始拾起武器。他点了点头。%SPEECH_ON%我们是农民，混子。早在很久很久以前，天谴就已经选择了我们。%SPEECH_OFF% | 你来到这里不是为了谈判。%SPEECH_ON%不会有任何补偿的。%commander%派我们来这里是为了……%SPEECH_OFF%农民嘲笑道。%SPEECH_ON%指挥官派来的一些哈巴狗。算了，小狗狗，让我们看看你们的狗叫还是咬人有力。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们快点。",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "TakeItByForce";
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities = [];
						p.EnemyBanners = [
							"banner_noble_11"
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Peasants, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "PayCompensation",
			Title = "在农场…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{你觉得没有必要杀一些只是想过日子的可怜农民。你交出了克朗，警告农民小心交易。%SPEECH_ON%并不是每个人都像我这么善良想和你做生意。%SPEECH_OFF%农民转过头来，露出了一道从头皮一直到肩膀的长疤。%SPEECH_ON%我很清楚。感谢你的考虑，雇佣兵。%SPEECH_OFF% | 除非有人付给你钱杀这些农民，你才会去干这项工作。%commander%没这么做。你同意了农民的要求，他们的领袖与你握手。%SPEECH_ON%谢谢你，佣兵。很少能看到一个愿意让步的人。我曾认为你是个野蛮人，但显然你是个有才智的人。%SPEECH_OFF% | 你不是要来这里屠杀一些可怜的农民的。你同意了这个人的条件。他感谢你不是要来这里屠杀一些可怜的农民。然而，%randombrother% 悄悄地说他不是来这里……你大声叫他闭嘴并开始装载车辆。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们快点回到军营。",
					function getResult()
					{
						this.Flags.set("RequisitionSuccess", true);
						this.Contract.setState("Running_ReturnAfterRequisition");
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(-this.Flags.get("RequisitionCost"));
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("RequisitionCost") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "WarcampDay2",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{早晨的阳光透过帐篷，落在你的眼睛上，提醒你又有一天要面对。 | 你穿上靴子，拍走了过夜休息的蜘蛛。 | 帐篷外，一只公鸡大声地让每个人都知道它是一个真正的混蛋。你不情愿地起床。 | 你在又一个崭新的一天中醒来。太棒了。 | 你像死人一样睡觉，也像死人一样醒来。太阳光线斜射进帐篷是如此刺眼，无法再回去睡觉，门帘太远了无法拉上。去你的，你会起床的。 | 早上好。一个充满了千般懊悔的时刻。}\n一个年轻的男孩拿着一卷卷轴站在你的帐篷外。他展开，艰难地阅读着。%SPEECH_ON%{你的...指挥官...要求见你。 | %commander%想见你，快去吧。 | 先生，这张纸让我告诉你，你...应该...去见指挥官。还有很多，但如果我试着把它念完，我们会在这里呆一整天。 | 所以，是这样的，我其实是看不懂的，但我想指挥官想见你。 | 让我看看，这封信...我知道这封信...这是字母“I”，我想剩下的句子都是些我看不懂的东西。看，去找指挥官吧。我想那就是他想要的。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候去拜访指挥官了…",
					function getResult()
					{
						if (this.Flags.get("IsInterceptSupplies"))
						{
							return "InterceptSupplies";
						}
						else
						{
							return "Deserters1";
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "InterceptSupplies",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]你在帐篷中会见了队长%commander%。他看起来相当兴奋。一个机敏而神秘的男子站在他身边。队长匆忙地说道。%SPEECH_ON%{据我手下的小禽兽报告说，一批装备正在运往%feudfamily%军队。如果我们能够拦截并摧毁它，他们在未来将无法做好准备！ | 你好，雇佣兵。我的间谍告诉我%feudfamily%家族有一个非常需要的装备运往他们的营地。我需要你前去摧毁它。 | 间谍不是最棒的吗？看看这个小家伙，他告诉我，先生，%feudfamily%将有大量物资到达。武器、盔甲、食品等等。我说，我知道一个可以利用这个消息的人：你！去找到这批货物并摧毁它。 | 战斗往往在实际发生前就已经决定胜负，你知道这点，对吧？我的小间谍告诉我%feudfamily%有一批武器和盔甲运来。如果你能成功摧毁它，那么他们的军队在开阔地上作战时将毫无准备。 | 你知道吗？我曾经在战斗中不用动剑就赢得了胜利。我设法拦截了一批物资，导致我的敌人完全没有准备去进行战斗，所以他们选择了投降。我这位小间谍告诉我%feudfamily%也有一批同样的装备正在运来。虽然它不能结束战争，但是如果你能接手并摧毁这批装备，将会对我们产生巨大的帮助。 | 你知道吗，一支没有装备的军队根本称不上军队。%feudfamily%家族的军队物资短缺。事实上，他们还没有发起攻击，是因为他们正在等待更多的武器和盔甲到来！好的，我的小间谍已经发现了那批货物。我希望你去摧毁它。 | 我有个极好的消息要告诉你，佣兵。%feudfamily%正在等待武器和盔甲的到来——我们也确切地知道它们来自哪里。我需要你去做一件很明显的事：摧毁那批物资，在敌人还没反应过来之前重创他。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "战团马上出发。",
					function getResult()
					{
						this.Contract.setState("Running_InterceptSupplies");
						return 0;
					}

				}
			],
			function start()
			{
				local startTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesStart")).getTile();
				local destTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesDest")).getTile();
				local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
				local party = enemyFaction.spawnEntity(startTile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("base").Visible = false;
				party.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
				party.setMirrored(true);
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
				party.setDescription("一个带有武装护卫的商队，在定居点之间运输着值得保护的东西。");
				party.setFootprintType(this.Const.World.FootprintsType.Caravan);
				party.getFlags().set("IsCaravan", true);
				party.setAttackableByAI(false);
				party.getFlags().add("ContractSupplies");
				this.Contract.m.Destination = this.WeakTableRef(party);
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
				move.setDestination(destTile);
				move.setRoadsOnly(true);
				local despawn = this.new("scripts/ai/world/orders/despawn_order");
				c.addOrder(move);
				c.addOrder(despawn);
			}

		});
		this.m.Screens.push({
			ID = "SuppliesReachedEnemy",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{你未能摧毁护送队。显然，所有的货物都已经被送到了%feudfamily%的军队，这将使接下来的战斗更加艰难。 | 护送队没有被摧毁。毋庸置疑，%feudfamily%的军队在接下来的大战中将近乎满员。 | 唉，该死，护送队没有被摧毁。现在%feudfamily%的军队将为即将到来的战斗做好充分的准备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们应该回到营地…",
					function getResult()
					{
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SuppliesIntercepted",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你原本希望能从大篷车中掠夺尽可能多的东西，但护卫们在一切可以被盗走之前就把所有的东西都点燃了。这很不幸，但最重要的是%feudfamily%的军队没有得到所有这些装备。 | 你摧毁了大篷车上很多货物，而那些没有毁灭的也是护卫们自己点燃的，以防止装备落入敌手。%commander%会对这些结果感到非常高兴。 | 这场战斗非常激烈，但你成功地消灭了大篷车护卫。不幸的是，这支部队采取了焦土政策，他们在获得控制之前就焚毁了每一辆马车。他们知道不能让所有这些装备落入敌人手中。尽管如此，%commander%和他的士兵们肯定会对这个消息感到满意。 | 在对护卫进行激烈战斗后，%companyname%全部消灭了他们。至少你这样认为：在战斗中，其中一名护卫设法逃脱并采取了焦土政策。每一辆马车都被点燃了。显然，如果%feudfamily%不能得到这些装备，那么其他人也不能。虽然这很烦人，但这是明智的。尽管如此，%commander%和他的部下仍然会欣赏这个消息。 | 大篷车已经成为废墟。你原本希望能捕获这些车辆并为自己取走这些装备，但其中一名护卫设法将它们全部点燃，无疑是为了防止这等装备落入敌手的手中。不管怎样，%feudfamily%的军队肯定已经被削弱了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "在接下来的战斗中，还有一个问题需要解决。",
					function getResult()
					{
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Deserters1",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{你刚好进入%commander%的帐篷，看到一根蜡烛在你脸边飞过。它的烛芯嗖地一声落在泥里，你看着桌子也跟着倒下，所有的地图都飞了起来。红着脸的%commander%站在残局前，双手叉腰，喘着气调整自己。他向你解释。%SPEECH_ON%叛逃者!他们竟然叛逃了！在我一生中最重要的战斗前夕，我甚至不能保持我的该死的手下在身边。看啊，我不能让这个军队分崩离析。我需要你去找那些逃兵，把他们带回来交给我。如果他们拒绝回来，就杀了他们。哨兵说有一个人看到他们往%direction%去了。走，快点！%SPEECH_OFF% | 当你正要进入%commander%的帐篷时，一个人从里面冲出来。%commander%从帐篷中冲出来，将他摔进泥里，抓住他的衣领像撕烂布娃娃一样把他拎了起来。%SPEECH_ON%他们去哪里了？我发誓老祖宗，如果你不老老实实回答我，我会让你求生不得求死不能！%SPEECH_OFF%那个男人大喊大叫着指着。%SPEECH_ON%往%direction%走，我发誓！%SPEECH_OFF%%commander%扔下那个人，由两个警卫押着他迅速离开。指挥官站直了身子，揉揉头发。%SPEECH_ON%雇佣兵，我的几个手下认为离开营地是最好的选择。找到他们。把他们带回来。明白？%SPEECH_OFF%你点了点头，但问如果这些人拒绝回来怎么办。指挥官耸了耸肩。%SPEECH_ON%当然是全都屠杀掉了。%SPEECH_OFF% | 你走进%commander%的帐篷，发现他正在离开一个坐着的男人。指挥官手里拿着钳子，钳子夹住一个白牙齿。你注意到那个坐着的人已经昏迷过去，头歪着，嘴里滴着血。%commander%把钳子扔在桌子上，用红肿的手揉了揉头发。%SPEECH_ON%我的几个手下叛逃了。我不能冒这个险，这样的时候，即将开始的战斗，我不能亲自麻烦。我的这位朋友，当他还清醒的时候，告诉我他们的同伴向%direction%逃窜。去，雇佣兵，把那些逃跑的人带回来。%SPEECH_OFF%在你离开之前，你问他如果这些逃兵拒绝回来怎么办。指挥官盯着你。%SPEECH_ON%你觉得呢？杀了他们所有人！%SPEECH_OFF% | 你发现%commander%正在思考着地图。他的手指将桌子变成了紧张状态，腿发出吱吱声。他看了看你，目光闪烁，激烈的怒气一闪而过。%SPEECH_ON%我的几个手下留意到逃兵在军队%direction%逃跑。去，抓回他们。%SPEECH_OFF%你问他想活抓回他们吗。他点了点头。%SPEECH_ON%我希望他们活着回来，这样我可以更好地告诉他们什么是离开我的军队的代价。当然，如果他们绝对不回来，那就杀了他们。这也是不离开军队的一个好教训，你不同意吗？%SPEECH_OFF% | %commander%把他的一位中尉绑在帐篷的柱子上。指挥官拿着一根长棍子，用力甩它击打中尉的胸口和两腿。那个男人哭喊着打转，只有背部还未遭到袭击。当中尉转回来的时候，他瘀紫的脸正在呼吸着昏迷。\n\n%commander%扔下了棍子，开始拔出手指上的碎片。%SPEECH_ON%你来了，雇佣兵。我的几个手下叛逃了，我需要你去找他们。把他们带回来，活着的话就把他们带回来，如果他们拒绝回来，就杀了他们。我这个朋友告诉我，他们往%direction%跑了。希望他说的是真的。 %SPEECH_OFF%你也希望他说的是真的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "战团将在一小时内出发。",
					function getResult()
					{
						this.Contract.setState("Running_Deserters");
						return 0;
					}

				}
			],
			function start()
			{
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, [
					this.Const.World.TerrainType.Shore,
					this.Const.World.TerrainType.Mountains
				]);
				local party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(tile, "Deserters", false, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush("banner_deserters");
				party.setFootprintType(this.Const.World.FootprintsType.Nobles);
				party.setAttackableByAI(false);
				party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				party.setFootprintSizeOverride(0.75);
				this.Const.World.Common.addFootprintsFromTo(playerTile, party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Nobles, 0.75);
				this.Contract.m.Destination = this.WeakTableRef(party);
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
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
			}

		});
		this.m.Screens.push({
			ID = "Deserters2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{你走近逃兵们在篝火旁嬉戏，其中一个绝望地对烟熏火燎的余烬踢踏。他看到你后停下来，其他的逃兵们也跟着他的视线看向你。%SPEECH_ON%我们才不会回去，你可以告诉%commander%去死。%SPEECH_OFF% | 当你出现在逃兵们的聚会中时，他们正在争吵。其中一个人朝后一躍%SPEECH_ON%你是%commander%派来的吧？告诉他去死。%SPEECH_OFF%另一个人挥动他的拳头%SPEECH_ON%没错，我们才不会回去呢！%SPEECH_OFF%毫无疑问，他们是一个难以控制的团体。 | %randombrother%指着一群站在路标前的人。他们正在争执得太吵，以至于没有注意到你的靠近。你清了清喉咙，同时也让这些人转到了你的方向。一个人退后一步%SPEECH_ON%那个可恶的指挥官派了雇佣兵来追我们？%SPEECH_OFF%你点点头，并解释道他们应该回到营地加入战斗。另外一个逃兵摇摇头%SPEECH_ON%回去？你滚!我们才不会回去呢！你可以告诉指挥官这些。%SPEECH_OFF% | 在发现逃兵们在分享一袋羊毛袋里的食物时，他们停下了活动。其中一个尝试一口吞下食物导致呛咳。其他人没有任何举动。呛咳者慌乱地四处求助，面部发紫。他的腿在羊毛袋上来回打着，食物四处飞溅。你点点头%SPEECH_ON%帮一下你的同伴吧。%SPEECH_OFF%逃兵们迅速跑到呛咳者身边，清除掉刺激他的食物。他终于呼吸到了空气。你开始讲述%commander%对你说的话，但逃兵中的一个打断了你的话%SPEECH_ON%不，我们不会回去。这场战争浪费无益，我们不想参与。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这就是你想成为的人吗？ 不会保卫自己土地的懦夫？",
					function getResult()
					{
						return this.Math.rand(1, 100) <= 50 ? "DesertersAcceptMotivation" : "DesertersRefuseMotivation";
					}

				},
				{
					Text = "你的选择很简单。 为你的主而战，或死在这里。",
					function getResult()
					{
						return this.Math.rand(1, 100) <= 50 ? "DesertersAcceptThreats" : "DesertersRefuseThreats";
					}

				},
				{
					Text = "让我们实话实说。 如果你回来的话，这里有 %bribe% 克朗。",
					function getResult()
					{
						return "DesertersAcceptBribe";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DesertersAcceptBribe",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{你拿出一个袋子，放进%bribe%克朗。%SPEECH_ON%我会亲自支付你们回到战营。%commander%对你们大为光火，不要有丝毫怀疑，但他需要每一个人。如果你们在即将到来的战斗中为他而战，我毫不怀疑他会原谅你们这个小错误。%SPEECH_OFF% | 你给了这些逃兵%bribe%克朗。士兵们相互看了看，然后跟你说话。%SPEECH_ON%指挥官把我们都送上绞刑架时，金钱有什么用呢？%SPEECH_OFF%你点点头回答。%SPEECH_ON%好问题，但%commander%不是傻瓜。他需要在即将到来的战斗中集齐所有的人。在那场战斗中证明自己，你们这场可怜的别扭就会被忘记。%SPEECH_OFF%}{逃兵们思考了一下，最终同意跟你回去。 | 逃兵们商量了一阵，达成了某种共识。在一片喧嚣声中，他们的领袖走了出来。%SPEECH_ON%尽管存在一些反对意见，但我们同意跟你回到战营。我希望我不会后悔。%SPEECH_OFF% | 短暂的讨论过后，逃兵们进行了投票。虽然不是一致的，但他们达成了协议：他们将和你一起回到%commander%那里。 | 逃兵们争论接下来该怎么办。不可避免地，这又到了一场投票的时候。可预见的是，结果是平局的。随后，这些人同意抛硬币：正面的话，他们回战营，反面则离开。领袖掷了硬币，所有人都看着它旋转和闪耀。硬币正面朝上。他们每个人看到这个结果都叹了一口气，好像机会和幸运让他们从一个超出自己选择外的巨大责任中解脱出来。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这将在接下来的战斗中帮助我们。",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(-this.Flags.get("Bribe"));
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("Bribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "DesertersAcceptThreats",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{%bigdog%走上前来，将武器随意地挥动在肩膀上。他点点头。%SPEECH_ON%你们害怕%commander%，我知道。你们了解他，了解他的脾气和能力。问题是......%SPEECH_OFF%雇佣军咧嘴一笑，狡猾的笑容在他的刀光中映衬得很清楚。%SPEECH_ON%你们认识我吗？%SPEECH_OFF% | 当%bigdog%大声吹口哨时，逃兵们似乎已经准备好离开了。%SPEECH_ON%嘿, 你们这些玩意，我的指挥官给了你们一个命令。%SPEECH_OFF%其中一名逃兵嗤之以鼻。%SPEECH_ON%是吗？他不是我们的指挥官，所以你可以把那条命令塞到你的屁股里。%SPEECH_OFF%%bigdog%拔出一把巨大的刀，把它插在地上。他用手按住刀柄的顶部。%SPEECH_ON%你害怕%commander%，这很正常。但你们要继续这么装逼，我的朋友，我们就会看到你们应该真正害怕的指挥官是谁。%SPEECH_OFF% | 逃兵们转身离开。 %bigdog%拔出一把巨刃，发出锵锵的响声。慢慢地，逃兵们转向。%bigdog%微笑着。%SPEECH_ON%你们中有没有人尿过裤子?%SPEECH_OFF%其中一名逃兵摇了摇头。%SPEECH_ON%嘿，伙计，别拿那话跟我说。%SPEECH_OFF%%bigdog%抢过他的刀，将刀尖指向逃兵。%SPEECH_ON%哦，你想让我闭嘴？继续对我这样说话，这里就没有人会说话了。%SPEECH_OFF%}{逃兵们斟酌了一下，最终同意回来跟你们一起走。 | 逃兵们密谋着，达成某种协议。大家散开后，他们的领袖走了过来。%SPEECH_ON%尽管有些人反对，但我们同意回到战队的营地。我希望我不会后悔。%SPEECH_OFF% | 经过一段时间的讨论，逃兵们达成了一致，他们将和你一起回到%commander%那里。 | 逃兵们争论着下一步该怎么办。不可避免地，他们进行了投票。可预见的是，票数打成了平局。然后，这些人同意抛硬币：正面朝上，他们回到营地；反面朝上，他们离开。他们的领袖掷硬币，所有士兵都看着它翻转和闪闪发亮。硬币落在了正面。他们每个人看到硬币落地的那一刻都叹了口气，仿佛机会和命运减轻了他们超出自己选择的巨大责任。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你做了正确的决定。",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						this.Contract.m.Dude = null;
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local candidates = [];

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.player"))
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.brute") || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.hedge_knight" || bro.getBackground().getID() == "background.brawler")
					{
						candidates.push(bro);
					}
				}

				if (candidates.len() == 0)
				{
					candidates = brothers;
				}

				this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DesertersAcceptMotivation",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{当逃兵们转身离开时，%motivator%走上前去，清了清嗓子。%SPEECH_ON%你们准备这就这样溜之大吉吗？像一群没有骨气的软蛋？我知道你们的感受。我知道你们认为没有参加这场战争或为了某个自以为是的贵族而冒险并不值得。那没错。但几年后当你在膝上轻轻摇晃着玩耍的孙子，他会问你关于你参加战争的问题。但你必须对那个小男孩撒谎。%SPEECH_OFF% | %motivator%将手指放在嘴唇上，发出一声尖叫。逃兵们朝他走过来，他开始讲话。%SPEECH_ON%你们准备好要故意让自己承担这个责任吗？等到那时，你将会告诉你的孩子们什么呢？你是一个不称职的逃兵，把同志留在了战场上送死？无疑，你的离开会导致许多人失去生命，你的缺席将产生你无法想象的后果！%SPEECH_OFF% | %motivator% 喊着叛军们。%SPEECH_ON%好吧，你们现在走。放下你们的旗帜，别再称之为战役了。那么当 %feudfamily% 赢得了这场战争，你们会怎么样呢？%SPEECH_OFF%其中一个叛军耸耸肩。%SPEECH_ON%他们不认识我，我要回去找我的家人和农场。%SPEECH_OFF%%motivator% 笑着摇头。%SPEECH_ON%这就是你的想法？当这些外国打手拜访你家、看见你的妻子、看见你的孩子时，你打算怎么办？你知道吗，这场战争到底是为了什么？你就这么傻吗？到时候你会变成无家可归的流浪汉！%SPEECH_OFF%}{叛军们思索一番，并最终同意跟你回到战营。 | 叛军们聚在一起商量了一下，达成了某种共识。他们的领袖迈步向前。%SPEECH_ON%虽然有人反对，但我们同意与你一同回到战营。我希望我不会后悔。%SPEECH_OFF% | 经过一段时间的讨论，叛军们进行了投票。虽然意见不是一致的，但他们达成了一致意见：他们将跟你一起回到%commander%。 | 逃兵们在讨论下一步应该怎么做。最终，他们开了一个投票。不出所料，投票结果是平局。接着，他们决定抛克朗：正面则返回营地，反面则离开。指挥官掷了硬币，所有人都看着硬币翻转、闪烁。硬币最终是正面朝上。所有人都松了一口气，仿佛是凭借运气和命运解除了一项极为沉重的责任，而那与他们的选择并无多大关系。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你做了正确的决定。",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						this.Contract.m.Dude = null;
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local highest_bravery = 0;
				local best;

				foreach( bro in brothers )
				{
					if (bro.getCurrentProperties().getBravery() > highest_bravery)
					{
						best = bro;
					}
				}

				this.Contract.m.Dude = best;
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DesertersRefuseThreats",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{%bigdog%迈步上前，轻松地挥舞着肩上的武器。他点了点头。%SPEECH_ON%你害怕%commander%，我明白。你认识他，你知道他的脾气和他的能力。问题是……%SPEECH_OFF%那个佣兵露出了狡黠的笑容，他的刀锋泛着亮光。%SPEECH_ON%你认识我吗？%SPEECH_OFF% | 逃兵们看起来准备要走了，这时%bigdog%大声吹哨。%SPEECH_ON%嘿，你们这些混蛋，我的队长给了你们命令。%SPEECH_OFF%其中一个逃兵嘲笑起来。%SPEECH_ON%是吗？他不是我们的队长，所以你可以拿那个命令塞到你的屁股里去。%SPEECH_OFF%%bigdog%拔出一把巨大的刀，插在地上。他把手放在剑柄上。%SPEECH_ON%你害怕%commander%，那很好。但你继续做这个小混蛋，我的朋友，我们将会看到真正应该害怕的是哪个队长。%SPEECH_OFF% | 逃兵们转身离开。%bigdog%拔出一把巨剑敲响其盔甲。慢慢地，逃兵们转过身来。%bigdog%微笑着。%SPEECH_ON%你们里面有人尿过裤子吗？%SPEECH_OFF%其中一名逃兵摇了摇头。%SPEECH_ON%嘿，伙计，别说这种话。%SPEECH_OFF%%bigdog%抓起他的剑，将剑尖指向逃兵。%SPEECH_ON%哦，你想让我闭嘴？继续这样说话，这里很快就没有人说话了。%SPEECH_OFF%}{逃兵们无法在彼此之间做出决定，于是他们进行了投票。选择继续逃跑的人数占了多数。他们的领袖告诉你这个民主结果，并向你告别。%commander%不会高兴，但你拔出剑告诉这些士兵只有一条路可走。领袖转身，拔出剑点头示意。%SPEECH_ON%好的，我猜你不是来这里听我们说再见的。准备战斗，士兵们。%SPEECH_OFF% | %commander%将不高兴，但逃兵拒绝回来。他们认为没有理由再次跳入混战之中。你告诉他们的领袖祝好。他感谢你，但随后迅速沉默，与其余的%companyname%一起拔出武器。领袖叹了口气。%SPEECH_ON%是啊，我就知道事情会这样。%SPEECH_OFF%你点了点头。%SPEECH_ON%没关系。我不在乎你做什么，但这是一桩商业事务，我们必须把它完成。%SPEECH_OFF% | 逃兵们无法做出决定, 于是他们求助于机会：他们的领袖拿出一枚硬币并将其抛向空中。 正面则回到营地，反面则继续逃亡。 硬币落在反面。 逃兵们松了一口气。 他们的领袖拍了拍你的肩膀。%SPEECH_ON%命运已经决定了我们的命运.%SPEECH_OFF% 你点了点头，拔出剑，战团其他人紧跟着你。%SPEECH_ON%当我们杀光你们的时候，你们要记住这一点。%SPEECH_OFF% 领袖微笑着拔出了他的剑。%SPEECH_ON%没关系，我们宁可死在自由的门前，也不愿意回到那个苦力中心。%SPEECH_OFF% | 队长礼貌地拒绝了回去的要求。%SPEECH_ON%雇佣兵，我们不是轻易选择了这条路的。我们不会回去的。%SPEECH_OFF%你下令%companyname%拔出武器。逃兵的队长叹了口气，但理解地点了点头。%SPEECH_ON%我想我们选择了这条路，我们准备在这里死去，走我们想走的路，而不是在外面被狗命令着死去。现在，这是我们的整个世界。%SPEECH_OFF%你耸了耸肩回道。%SPEECH_ON%对我们来说只是业务上的事。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们把事情了解了吧……",
					function getResult()
					{
						this.Contract.m.Dude = null;
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos(), true);
						p.CombatID = "Deserters";
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.TemporaryEnemies = [
							this.Contract.getFaction()
						];
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							"banner_deserters"
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local candidates = [];

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.player"))
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.brute") || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.hedge_knight" || bro.getBackground().getID() == "background.brawler")
					{
						candidates.push(bro);
					}
				}

				if (candidates.len() == 0)
				{
					candidates = brothers;
				}

				this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DesertersRefuseMotivation",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_88.png[/img]{当逃兵要离开时，%motivator%挺身而出，清了清嗓子。%SPEECH_ON%那就是你们的打算吗？你们要像一群软弱无力的家伙一样逃避你们的责任吗？我知道你们的感受。我知道你们认为这场战争没有意义，或者冒险去为一些完全不了解你们所经历的高傲贵族牺牲。那很公平。但是你们将来会醒来，抱着你们的孙子，他会问你们有关战争的问题。而你们将不得不对那个小男孩撒谎。%SPEECH_OFF% | %motivator%把手指放在嘴唇上，发出了一声清脆的哨声。逃兵们转向他，他开始讲话。%SPEECH_ON%那就是你打算负担的重任吗？当你的孩子问到你为什么当时背叛同伴而导致他们死亡时，你会告诉他们什么呢？毫无疑问，你的离去将导致无辜之人的死亡。你们的离开将产生你们无法衡量的后果！%SPEECH_OFF% | %motivator%呼唤逃兵。%SPEECH_ON%好吧，现在你们离开。您可以扔下你们的旗帜，结束这次出征。那么当%feudfamily%获胜时，会发生什么呢？%SPEECH_OFF% 一个逃兵耸了耸肩。%SPEECH_ON%他们不认识我。我会回家种地养家。%SPEECH_OFF% %motivator%笑了，摇了摇头。%SPEECH_ON%是吗？当这些外来人看到你的妻子，看到你的孩子时，你会怎么办？确切地说，你认为这场战争是为了什么？这里将没有你可以回去的家，你这个蠢货！%SPEECH_OFF%}{逃兵们无法做出决定，于是通过投票，选择继续逃跑。他们的领袖告诉您这个民主的结果并给您告别。%commander%不会高兴，但您取出剑告诉逃兵只有另一条路可走。领袖转身，拔出剑点头示意。%SPEECH_ON%好的，我想你们不是跋山涉水走到这里，只是为了听我们说再见。准备行动吧，战友们。%SPEECH_OFF% | %commander%会不满，但逃兵拒绝回来。他们认为没有理由重新投入战争。您祝福他们的领袖好运。他感谢您，但随后沉默，因为您拔出武器，其余的%companyname%紧随其后。领袖叹了口气。%SPEECH_ON%是啊，我就知道会这样。%SPEECH_OFF%您点了点头。%SPEECH_ON%没有个人恩怨。我不管你们做什么，但这里是商业上的问题，我们必须把它看到最后。%SPEECH_OFF% | 逃兵们无法做出决定，于是转向机会：他们的领袖掏出硬币，将其抛向空中。正面他们回到营地，反面他们继续离开。硬币落在反面。逃兵们集体松了口气。领袖拍了拍你的肩膀。%SPEECH_ON%命运已经决定了我们的命运。%SPEECH_OFF%你点头，拔出剑，其他公司紧随其后。%SPEECH_ON%在我们杀死你们的时候，要记得这一点。%SPEECH_OFF%领袖微笑着，拔出了他的剑。%SPEECH_ON%没关系。我们宁愿在自由的门前死，也不愿回到那个压迫的生活中。%SPEECH_OFF% | 领袖礼貌地拒绝回去。%SPEECH_ON%我们并不轻易选择这条路，雇佣兵。我们不会回来的。%SPEECH_OFF%你命令%companyname%拔出武器。逃兵的领袖叹了口气，但理解地点了点头。%SPEECH_ON%我想这就是它的前程。我们曾经谈过这件事，我们已经准备好在这里死亡，走自己想去的路，而不是在外面按照某个人的命令死亡。这是我们现在的世界。%SPEECH_OFF%你耸了耸肩回应。%SPEECH_ON%对我们来说，这只是生意。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们把事情了解了吧……",
					function getResult()
					{
						this.Contract.m.Dude = null;
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos(), true);
						p.CombatID = "Deserters";
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.TemporaryEnemies = [
							this.Contract.getFaction()
						];
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							"banner_deserters"
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local highest_bravery = 0;
				local best;

				foreach( bro in brothers )
				{
					if (bro.getCurrentProperties().getBravery() > highest_bravery)
					{
						best = bro;
					}
				}

				this.Contract.m.Dude = best;
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DesertersAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{%randombrother%在一具尸体的袍子上擦拭着他的刀。%SPEECH_ON%可惜，他们以那种方式死去。他们本可以活下去，他们有选择的权利。%SPEECH_OFF%你耸耸肩回答道。%SPEECH_ON%他们四面楚歌，只是将我们选为了执行者。%SPEECH_OFF% | 叛逃者们在你身边死去，其中一个在爬行，试图远离%commander%的军队。你蹲在他身旁，手握匕首等着解决他。他笑了。%SPEECH_ON%别弄脏你的匕首，佣兵。给我时间。这就是我拥有的一切。%SPEECH_OFF%他的下巴上流出一道血痕，眼睛紧盯着前方，他慢慢地沉入地面。你站起来告诉战团准备离开。 | 最后一个叛逃者被发现靠在一块石头上，他的手垂在身旁，掌心朝上，像乞丐一样。他的胸口和腿上流着血，地面上也渐渐积累着。他盯着血。%SPEECH_ON%谢谢你问，佣兵。我很好。%SPEECH_OFF%你告诉他你什么都没说。他看着你，真的感到困惑。%SPEECH_ON%你没说过吗？那好吧。%SPEECH_OFF%一刹那之后，他倒向一侧，面部呆滞，象征着他的死亡。 | 有些人喜欢戏谑命运。当一切选择和自由都被剥夺时，唯一能做的就是嘲笑这种残忍的命运。每个逃兵死时都带着满足而无憾的表情。 | 最后一个活着的逃兵仰望天空。他挥动着一只手。%SPEECH_ON%该死，我只是想看到一只。%SPEECH_OFF%你问他他想看什么，他大笑起来，很快被一阵剧痛打断了。%SPEECH_ON%一只鸟。噢，那有一只。它很大，很美。%SPEECH_OFF%他指着天空，你往上看，一只秃鹫正在盘旋。回头再看这个人，他已经死了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "很不幸，但这必须要做。",
					function getResult()
					{
						this.Contract.setState("Running_ReturnAfterIntercept");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WarcampDay2End",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_96.png[/img]{%commander%告诉你明天是大日子，你回到你的帐篷休息。 | 你回到%commander%那里告诉他这个消息。他相当沉默，他的思维沉浸在明天即将到来的大规模决战中。这一天结束了，你决定安心等待明天的到来。 | 你向%commander%报告，但他几乎没有什么反应。他几乎生活在他的战地地图中。%SPEECH_ON%明天见，雇佣兵。好好休息，因为你会需要它的。%SPEECH_OFF% | %commander%欢迎你进入他的帐篷，但似乎忽略了你的报告。相反，他专注于他的地图，并在与他的中尉们继续争论明天的战斗计划。你决定安心睡觉。 | %commander%点头对你的报告，但实际上并没有真正关注你。一张战地地图铺在桌子上，他的眼睛聚焦在上面。你理解：明天是大战，他有更重要的事情要考虑。你决定去安心睡觉。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "今晚好好休息，明天的战斗就要开始了！",
					function getResult()
					{
						this.Flags.set("LastDay", this.World.getTime().Days);
						this.Flags.set("NextDay", 3);
						this.Contract.setState("Running_WaitForNextDay");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WarcampDay3",
			Title = "在军营…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{%commander%走到士兵们的集合地。有些人脸上疲惫不堪，整晚没有睡觉。其他人仍然颤抖。他们的队长呼唤他们。%SPEECH_ON%你们害怕吗？害怕吗？没关系。如果你们不害怕，我反而会有点担心。%SPEECH_OFF%零散的笑声提升了士气。他继续说：%SPEECH_ON%但现在我要求你们不是害怕自己的生命，而是害怕你们的同胞、你们的家人的生命！为了他们，我们今天战斗！让我们为自己明天担忧，在今天做个男人！%SPEECH_OFF%笑声变成了欢呼声。 | [%commander%]在士兵面前检阅了他的部队，步兵、弓箭手、预备队，他们都在刺骨的寒风中挺立。指挥官审视着他们。%SPEECH_ON%我知道你们在想什么，“为什么要为这个失败者而战，如果他真的那么高尚，为何不站在他的骏马上呢？”%SPEECH_OFF% 士兵们发笑，缓解了些许紧张。[%commander%]接着说%SPEECH_ON% 呵，无论外表多么猥琐难看，我喜欢和勇敢的人们一起奋战杀敌。在那里，男人们，我会和你们并肩作战，拼到底，战到最后，因为这就是战士的职责！%SPEECH_OFF% 士兵们举起手臂欢呼，他们的队长转身，手持剑高高举起。 %SPEECH_ON%现在跟我来，我们将向[%feudfamily%]展示何谓男儿本色！%SPEECH_OFF% | [%commander%]率领着他五花八门的军队赶往战场。走上战线，指挥官开始演讲。%SPEECH_ON%你们中有些人看起来疲惫不堪，是紧张吗？我也是！一夜未眠。%SPEECH_OFF%这使得士兵们中的一些人松了一口气。知道你并不孤单，无论是肉体上还是精神上。他接着说道。%SPEECH_ON%但是今天，为了这场战斗，我清醒着。我不能错过这场战斗。所以，摆脱睡意，男人们，今天我们要向那些%feudfamily%混蛋表明，他们当初不该离床。%SPEECH_OFF% | [%commander%]面对他的准备战斗的士兵们演讲，但你没有倾听。相反，你在准备你的士兵迎接即将到来的战斗。 | %commander%向他的士兵走去，用激励人心的话语来鼓舞他们。你听到过很多次了。实际上，这些话语是从一些古老的卷轴上流传下来的吗？一位激励演讲者的精神被代代传承下来吗？%randombrother%走上前来，笑着说：%SPEECH_ON%我知道那个指挥官说些空话，但我仍然觉得自己应该做几个俯卧撑。%SPEECH_OFF%大笑着，你告诉那个人去排队跟其他队员一起训练。他反驳道：%SPEECH_ON%会有一次演讲吗？%SPEECH_OFF%当他转身离开时，你推了他一把。 | [%commander%]走来走去视察他的战线。他来到一个如此害怕以至于铠甲格格作响的男孩跟前。%SPEECH_ON%你让我想起了我自己，孩子，你知道吗？你认为我没有经历过你正在经历的吗？嘿，冷静点，因为有一天你可能会像我一样。%SPEECH_OFF%男孩眼中闪烁着新的光芒，他稳住了身子，坚定地点了点头。指挥官提高声音，命令士兵们为了他们一生中最重要的战斗做好准备。 | %commander%沿着他的部队走过去，扬声大喊这场战斗是他们人生中最重要的事件。你并不那么确定，但可以确定的是许多人将会永远经历不了这场战斗。战争的残酷并不是最好的激励方式，你不做声。 | %commander%为他的士兵们做好了准备，发表了一个宏伟重要的演讲，讲到了贵族之间的战争。这很有说服力。这必须有力，这样那些没有从战斗中获得任何好处的人才会去死。 | [%commander%将军]来到士兵面前讲话。他穿戴着华丽的战斗服，像沙滩上的珍珠一般屹立在士兵中间。他解释说他们必须赢得这场战斗，因为输掉它可能会失去整个战争。你认为他是在说任何话都可以使士兵投入战斗。你肯定没准备为了那些脆弱的贵族而战且丧命，因为一些追求荣誉的指挥官从政治灵魂中获得灵感。不过，这种态度也是你成为雇佣兵的原因。 | 战争真是一件可怕的事情。一个人怎么才能将它卖给另一个人呢？[%commander%将军]尽力而为，从各个方面作出演讲。首先，他说这是一个光荣的事情。然后他说，这里有许多士兵，无疑会增加其他倒霉蛋死亡的几率。人多力量大！然后他争论说，输掉这场战斗可能意味着失去他们的妻子，孩子，国家。最后一个理由似乎最有用，因为士兵们咆哮着愤怒和斗志。在欢呼的士兵人群中，你能轻易地发现那些愤世嫉俗和同性恋者。 | [%commander%]用沉重而有力的语气对他的士兵说道。%SPEECH_ON%啊，你们中的一些人看起来非常兴奋。迫不及待地想屠戮%feudfamily%家族的人？我知道那种感觉。%SPEECH_OFF%有些紧张的笑声。指挥官继续说道。%SPEECH_ON%牢记你们的家人，士兵们，因为他们一定在这一天依赖着我们！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "兄弟们，向前看，有一场战斗要打赢！",
					function getResult()
					{
						this.Contract.setState("Running_FinalBattle");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BattleLost",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_86.png[/img]{到处都是尸体。%commander%的轮廓高出尸体之上，他的盔甲闪闪发光，是一个肉体毁坏的光辉包围。%employer%毫无疑问会为这里的战斗失败感到难过，但是现在已经无可奈何。 | 战斗失败了！%commander%的士兵们已经死了，只有零星的幸存者，指挥官本人也已经倒下。秃鹫已经在头顶盘旋，%feudfamily%的人正在不断地搜查想要装死的人。你迅速地聚集了%companyname%的余部准备撤退。%employer%毫无疑问会对这里的结果感到震惊，但现在已经无能为力。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不是每一场战斗都能赢…",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "输掉了一场重要的战斗");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BattleWon",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_87.png[/img]{你获得了胜利，很好，你和%commander%的士兵们一起。战斗已经达成了胜利，这才是最重要的。你穿过尸体准备回去见你的雇主。 | 堆积如山的尸体。秃鹫在山上啄食着残肢。伤员乞求援助。在一个外人的眼里，这里并没有赢家。然而，%commander%却带着灿烂的笑容走了过来。%SPEECH_ON%{干得好，佣兵！你应该回去见你的雇主并告诉他这里所发生的。 | 好啊，是佣兵啊。我不确定你是否能挺过去。你应该回去见你的雇主并告诉他这里所发生的。}%SPEECH_OFF% | 一个受伤的男人在你的脚下乞求着。你不能确定他是不是%commander%的士兵或敌人。突然，一把矛头窜出来，从他的头部刺穿，使他的眼睛永远处于斜视。你看着凶手用得意的表情用手上的矛捏住，然后指了指你。%SPEECH_ON%你就是那个佣兵对吧？%commander%让我告诉你，你应该回去见你的雇主。这听起来对吗？%SPEECH_OFF%你点了点头。尸体堆里传出一阵呻吟声。那个男人拾起他的矛，用剩下的手拍了拍你的肩膀。%SPEECH_ON%好了，回到战斗吧！%SPEECH_OFF% | 战斗结束后，你看到%commander%在喊叫，并开始解下他的盔甲和内衣。他展示着他的伤口，屈服，以至于他们已经像新鲜切割过的水果那样裂开。他命令他的士兵也这样做，并把每一个人都摆过来，让他看看他们的背部。%SPEECH_ON%你看，像我们这样优秀的战士，我们在这里，还有这里和这里都带着伤口...%SPEECH_OFF%他指着他身体的每个部位，然后又指着他的背部。%SPEECH_ON%但是没有人在这里带着受伤。因为我们一直朝前冲进，从不后退！难道不是吗？%SPEECH_OFF%士兵们欢呼，虽然有些人脚下不稳，鲜血从他们的伤口中流出。你无视戏剧性，聚集了%companyname%的人。你的雇主一定会很高兴听到这里的结果，这是你真正关心的。 | %commander%战斗后向你打招呼。他浑身沾满了鲜血，好像切了谁的头，在流泻着喷涌的鲜血。他的微笑闪耀着白色的牙齿。%SPEECH_ON%这才是好的战斗。%SPEECH_OFF%你问他如果他输了会怎样。他笑了。%SPEECH_ON%哦，你是个怀疑论者？不，我没有打算在这里输，如果我输了，我也不想活着看到自己的失败。%SPEECH_OFF%你点了点头并回答道。%SPEECH_ON%很少有人能还活着看到他最大的失败。和你一起作战很不错，指挥官，但是我必须回到你的雇主那里了。%SPEECH_OFF%指挥官点了点头，然后转过身去，大声喊着让人给他拿一条毛巾。 | 你发现%commander%跪在一名受伤的敌方士兵身边。他用匕首穿过那可怜的男人的胸口，反复来回地刮着盔甲。指挥官看着你。%SPEECH_ON%你认为呢，佣兵？我应该让他活着吗？%SPEECH_OFF%囚犯盯着你，他向前突出了头，用力眨了眨眼睛。你想这应该是一个“是”。你耸了耸肩。%SPEECH_ON%这不在我能决定的范围内。听着，和你一起战斗很愉快，但我必须回到你的雇主那里了。%SPEECH_OFF%%commander%点了点头。%SPEECH_ON%那么再见了。%SPEECH_OFF%当你离开时，指挥官仍然弯着腰，坐在他的囚犯旁边，把刀片来回移动，哐哐哐。 | 你发现%commander%正朝一名受伤的男子的胸部扎着一把匕首。倒下的敌人因疼痛而抽搐，但很快就消失了，几秒钟内就不动了。鲜血的喷溅随刀子的拔出而来，指挥官在裤脚上擦了擦。%SPEECH_ON%直达心脏，快速简便。还有什么比这更好的吗？%SPEECH_OFF%你点点头，告诉指挥官你去见你的雇主领取报酬。 | 你看到%commander%和士兵队伍在战场上四处走动，杀死他们发现的任何受伤的敌人。%randombrother%问我们是否应该向指挥官报告。你摇了摇头。%SPEECH_ON%不，我们要向你的雇主报告。去你妈的这个地方，让我们回去领钱吧。%SPEECH_OFF% | 战场上到处都是死人和那些希望他们也是死人的人。%commander%的士兵们开始收集受伤的人并杀死任何他们找到的敌人。指挥官本人拍了拍你的肩膀，一粒血块溅在你的面颊上。%SPEECH_ON%干得好，佣兵。我不确定你的人是否能够兑现他们的诺言，但你们做到了。我相信你的雇主会很高兴看到你的。%SPEECH_OFF% | 你四处找寻%companyname%的人。%commander%走到你面前，用一块布擦拭着一把剑，鲜血在上面流淌。%SPEECH_ON%这么快就离开了？%SPEECH_OFF%你点了点头。%SPEECH_ON%你的雇主是付我们的工资的人，所以我们去找他。%SPEECH_OFF%指挥官把他的武器插回剑鞘里，点了点头。%SPEECH_ON%有道理，和你一起作战很愉快，佣兵。抱歉我不能留下你，伙计们都得继续追求财富吧？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						local faction = this.World.FactionManager.getFaction(this.Contract.getFaction());
						local settlements = faction.getSettlements();
						local origin = settlements[this.Math.rand(0, settlements.len() - 1)];
						local party = faction.spawnEntity(this.World.State.getPlayer().getTile(), origin.getName() + " Company", true, this.Const.World.Spawn.Noble, 150);
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + faction.getBannerString());
						party.setDescription("为地方领主服务的专业士兵。");
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你发现%employer%已经喝得烂醉如泥，一只杯子压在嘴唇上，在喝之前说话。%SPEECH_ON%啊，天哪，你回来了。%SPEECH_OFF%他咽下饮料，杯子掉了。你很快向他报告了你的成功。尽管他喝得烂醉，但他还是笑了起来，看起来很困惑。%SPEECH_ON%然后就完成了。胜利是我的。这就是我想要的。我希望没有太多人因为我想要的事而死。%SPEECH_OFF%他笑了起来。他的一个卫兵递给你一个小包并把你赶出了房间。 | %employer%拿着一个小包欢迎你到来。%SPEECH_ON%{胜利是我们的，谢谢你的帮助。 | 你在那里做的真是太棒了，雇佣兵。胜利属于我们，而我们的胜利也有一部分得归功于你。你的%reward_completion% 克朗就在这里。 | 是什么，%reward_completion% 克朗吗？为了打败那支军队，为了让我们更接近结束这场战争，这算得上是微不足道的代价。 | 我的小鸟告诉我你在那里做得很好，雇佣兵。当然，他们还告诉我，%feudfamily% 的军队正在撤退。我还能期望什么呢？按照约定，这是你的%reward_completion%克朗。}%SPEECH_OFF% | 你看到%employer%正在向他的指挥官吩咐任务。他看见你后，迅速朝你这边指了指。%SPEECH_ON%看这个人，他是一个能够完成任务的人。卫兵们！拿给他 %reward_completion% 克朗。真是懊恼啊，我多么愿意让我的狗做到他干得那么好！%SPEECH_OFF% | %employer%在他的花园里对一群女人讲笑话。你走向她们，浑身浸泡在血液和泥土中。女人们吃惊地后退。%employer%哈哈大笑。%SPEECH_ON%啊，佣兵回来了！你真是个能够征服女人的人。我多么想给你们中的一位优秀女人，但是我担心她们的父亲会把你的蛋蛋割了。%SPEECH_OFF%其中一个女人抚摸自己的胸口。%SPEECH_ON%如果他想的话，他可以碰我。%SPEECH_OFF%%employer%再次大笑。%SPEECH_ON%哦，亲爱的，你是不是已经让不少男人陷入麻烦了？各位女士们，请你们告诉我的卫兵拿来 %reward_completion% 克朗的提包。%SPEECH_OFF% | 你发现%employer%正在试图训练他的猫握手。%SPEECH_ON%瞧这小东西，它甚至不敢看我的眼睛！而且每当我喂它，它都表现得好像这是我应该做的一样。我甚至可以把这只该死的小东西踢出窗外！%SPEECH_OFF%你回应道。%SPEECH_ON%它会着陆在两只脚上。%SPEECH_OFF%贵族点了点头。%SPEECH_ON%这是最该死的部分。%SPEECH_OFF%你的雇主拿起这只具有弹性的猫并将它扔出了窗外。他拍了拍手，然后交给你一个装有 %reward_completion%克朗的小包。%SPEECH_ON%如果我看起来有点心不在焉，请原谅。你在那里做得很好，%feudfamily%的军队正在撤退，我现在实在是求之不得更多了。%SPEECH_OFF% | 你发现%employer%正在为他的指挥官中的一员举行一个即兴审判。你不确定争论的是什么，但指挥官的下巴高高扬起，态度不屈。审判结束后，他受到了粗暴对待并被带到外面。%employer%向你招手。%SPEECH_ON%{谢谢你，雇佣军。胜利属于我们，如果没有你的帮助，我不确定情况会是怎样的。当然，你的%reward_completion%克朗奖励，正如我们商定的。 | 他拒绝了我的命令，这就是现实。但是，你的表现非常出色！你将获得%reward_completion%克朗，正如我们商定的。 | 那个人不肯为我而战。他说他不会对抗为敌方而战的同父异母兄弟。真是胡说八道。好了，佣兵，你干得好。根据承诺，你有 %reward_completion% 克朗的报酬。}%SPEECH_OFF% | 你回到一个指挥官群中的 %employer% 那里。%SPEECH_ON%{感谢你，佣兵。胜利现在属于我们。和我们约定一样，给你 %reward_completion% 克朗作为奖励。 | 战争还在继续，但由于你，它或许快要结束了。你赚的 %reward_completion% 克朗不虚此行，佣兵。}%SPEECH_OFF% | %employer% 的一个守卫阻拦了你，拿着一个袋子装着 %reward_completion% 克朗很快地把它交了给你。%SPEECH_ON%我主告诉我，你在战斗中表现不错。%SPEECH_OFF%守卫看着周围，感到尴尬。%SPEECH_ON%这...这就是我该说的全部了。%SPEECH_OFF% | %employer% 欢迎你来到他的战争室，这里空无一人。%SPEECH_ON%真好能见到你，佣兵。正如你所知，%feudfamily% 的军队已经在撤退了。谁知道如果没有你我们能否成功。我们和你约定的 %reward_completion% 克朗就归你了。%SPEECH_OFF% | %employer% 正在喂养一只高大、看起来有点傻的鸟。你从未见过这样比例的鸟，因此保持距离。一位娱乐的贵族一边谈话，一边让这只动物吃东西。%SPEECH_ON%这里没有什么可怕的，佣兵。只是为了让你知道，我已经听到了你的所作所为。%feudfamily%的军队正在撤退，因此我们正在逐步结束这场该死的战争。朝那边的警卫看去，拿着小提包的那个人，那里有你 %reward_completion% 克朗的奖金。%SPEECH_OFF%你走了之后，鸟拍打着翅膀，发出尖叫声。 | 你发现 %employer% 正在人工池塘边晃荡。他用温柔的手捉蛤蟆。这些黏糊糊的小动物扭来扭去，跳跃着逃离他的手。%SPEECH_ON%胜利属于我们。我认为这是一项干得不错的工作，佣兵。我给了你一个巨大的机会，你真的……把握住了它。%SPEECH_OFF%你看起来一定很尴尬，因为这位贵族迅速站起身，用裤子擦拭手。 %SPEECH_ON%哈，这还不错，是吧？好了，那边的警卫拿着%reward_completion%克朗的奖金等着你了。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "赢得了一场重要的战斗");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isCivilWar())
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

	function onCommanderPlaced( _entity, _tag )
	{
		_entity.setName(this.m.Flags.get("CommanderName"));
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.World.FactionManager.getFaction(this.getFaction()).getName()
		]);
		_vars.push([
			"feudfamily",
			this.World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse")).getName()
		]);
		_vars.push([
			"commander",
			this.m.Flags.get("CommanderName")
		]);
		_vars.push([
			"objective",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"cost",
			this.m.Flags.get("RequisitionCost")
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);

		if (this.m.Flags.get("IsInterceptSupplies"))
		{
			_vars.push([
				"supply_start",
				this.World.getEntityByID(this.m.Flags.get("InterceptSuppliesStart")).getName()
			]);
			_vars.push([
				"supply_dest",
				this.World.getEntityByID(this.m.Flags.get("InterceptSuppliesDest")).getName()
			]);
		}

		if (this.m.Dude != null)
		{
			_vars.push([
				"bigdog",
				this.m.Dude.getName()
			]);
			_vars.push([
				"motivator",
				this.m.Dude.getName()
			]);
		}

		if (this.m.Destination == null)
		{
			_vars.push([
				"direction",
				this.m.WarcampTile == null ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.WarcampTile)]
			]);
		}
		else
		{
			_vars.push([
				"direction",
				this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
			]);
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

			if (this.m.Warcamp != null && !this.m.Warcamp.isNull())
			{
				this.m.Warcamp.die();
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isCivilWar())
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

		if (this.m.Warcamp != null && !this.m.Warcamp.isNull())
		{
			_out.writeU32(this.m.Warcamp.getID());
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

		local warcamp = _in.readU32();

		if (warcamp != 0)
		{
			this.m.Warcamp = this.WeakTableRef(this.World.getEntityByID(warcamp));
		}

		this.contract.onDeserialize(_in);
	}

});

