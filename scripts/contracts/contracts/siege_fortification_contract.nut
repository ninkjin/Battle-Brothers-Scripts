this.siege_fortification_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Allies = []
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

		this.m.Type = "contract.siege_fortification";
		this.m.Name = "围攻城池";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
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

		this.m.Flags.set("ObjectiveName", this.m.Origin.getName());
		this.m.Flags.set("RivalHouseID", this.m.Origin.getOwner().getID());
		this.m.Flags.set("RivalHouse", this.m.Origin.getOwner().getName());
		this.m.Flags.set("WaitUntil", 0.0);
		this.m.Name = "围攻" + this.m.Origin.getName();
		this.m.Flags.set("CommanderName", this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]);
		this.m.Payment.Pool = 1550 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"前往%direction%的%objective%",
					"帮助围城"
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
				this.Contract.m.Origin.getOwner().addPlayerRelation(-99.0, "在战争选择了阵营");
				local r = this.Math.rand(1, 100);

				if (r <= 50)
				{
					this.Flags.set("IsTakingAction", true);
					local r = this.Math.rand(1, 100);

					if (r <= 50)
					{
						this.Flags.set("IsAssaultTheGate", true);
					}
					else if (r <= 80)
					{
						this.Flags.set("IsBurnTheCastle", true);
					}
					else
					{
						this.Flags.set("IsPlayerDecision", true);
					}
				}
				else
				{
					this.Flags.set("IsMaintainingSiege", true);
					r = this.Math.rand(1, 100);

					if (r <= 25)
					{
						this.Flags.set("IsNighttimeEncounter", true);
					}
					else
					{
						this.Flags.set("IsReliefAttack", true);
						r = this.Math.rand(1, 100);

						if (r <= 40)
						{
							this.Flags.set("IsSurrender", true);
						}
						else
						{
							this.Flags.set("IsDefendersSallyForth", true);
						}
					}
				}

				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					if (!this.Flags.get("IsSecretPassage") && !this.Flags.get("IsSurrender"))
					{
						this.Flags.set("IsPrisoners", true);
					}
				}

				this.Contract.spawnSiege();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.isPlayerNear(this.Contract.m.Origin, 300))
				{
					this.Contract.setScreen("TheSiege");
					this.World.Contracts.showActiveContract();

					foreach( a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally != null)
						{
							ally.setAttackableByAI(true);
						}
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wait",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保持围困%objective%",
					"拦截任何试图突围的人"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil"))
				{
					return;
				}

				this.Contract.m.Origin.getOwner().addPlayerRelation(-99.0, "在战争选择了阵营");

				foreach( i, a in this.Contract.m.Allies )
				{
					local ally = this.World.getEntityByID(a);

					if (ally == null || !ally.isAlive())
					{
						this.Contract.m.Allies.remove(i);
					}
				}

				if (this.Contract.isPlayerNear(this.Contract.m.Origin, 300))
				{
					if (this.Flags.get("IsReliefAttackForced"))
					{
						if (this.World.getTime().IsDaytime)
						{
							this.Contract.setScreen("ReliefAttack");
							this.World.Contracts.showActiveContract();
						}
					}
					else if (this.Flags.get("IsSurrenderForced"))
					{
						this.Contract.setScreen("Surrender");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsDefendersSallyForthForced"))
					{
						this.Contract.setScreen("DefendersSallyForth");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsTakingAction"))
					{
						if (this.World.getTime().IsDaytime)
						{
							if (this.Flags.get("IsPlayerDecision"))
							{
								this.Contract.setScreen("TakingAction");
								this.World.Contracts.showActiveContract();
							}
							else
							{
								this.Contract.setState("Running_TakingAction");
							}
						}
					}
					else if (this.Flags.get("IsMaintainingSiege"))
					{
						this.Contract.setScreen("MaintainSiege");
						this.World.Contracts.showActiveContract();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_TakingAction",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"参与攻击%objective%"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil"))
				{
					return;
				}

				if (this.Flags.get("IsLost"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultTheGate") && !this.TempFlags.get("AssaultTheGateShown"))
				{
					this.TempFlags.set("AssaultTheGateShown", true);
					this.Contract.setScreen("AssaultTheGate");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultAftermath"))
				{
					this.Contract.setScreen("AssaultAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssaultTheCourtyard") && !this.TempFlags.get("AssaultTheCourtyardShown"))
				{
					this.TempFlags.set("AssaultTheCourtyardShown", true);
					this.Contract.setScreen("AssaultTheCourtyard");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBurnTheCastleAftermath"))
				{
					this.Contract.setScreen("BurnTheCastleAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBurnTheCastle") && !this.TempFlags.get("BurnTheCastleShown"))
				{
					this.TempFlags.set("BurnTheCastleShown", true);
					this.Contract.setScreen("BurnTheCastle");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "AssaultTheGate")
				{
					this.Flags.set("IsAssaultTheGate", false);
					this.Flags.set("IsAssaultTheCourtyard", true);
				}
				else if (_combatID == "AssaultTheCourtyard")
				{
					this.Flags.set("IsAssaultTheCourtyard", false);
					this.Flags.set("IsAssaultAftermath", true);
				}
				else if (_combatID == "BurnTheCastle")
				{
					this.Flags.set("IsBurnTheCastle", false);
					this.Flags.set("IsBurnTheCastleAftermath", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "AssaultTheGates" || _combatID == "AssaultTheCourtyard" || _combatID == "BurnTheCastle")
				{
					this.Flags.set("IsLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_NighttimeEncounter",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保持围困%objective%",
					"拦截任何试图突围的人"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Time.getVirtualTimeF() < this.Flags.get("WaitUntil") || this.World.getTime().IsDaytime)
				{
					return;
				}

				if (this.Flags.get("IsNighttimeEncounterLost"))
				{
					this.Contract.setScreen("NighttimeEncounterFail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNighttimeEncounterAfermath"))
				{
					this.Contract.setScreen("NighttimeEncounterAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNighttimeEncounter") && !this.TempFlags.get("NighttimeEncounterShown"))
				{
					if (!this.World.getTime().IsDaytime)
					{
						this.TempFlags.set("NighttimeEncounterShown", true);
						this.Contract.setScreen("NighttimeEncounter");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (!_actor.isPlayerControlled())
				{
					this.Flags.set("IsNighttimeEncounterLost", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "NighttimeEncounter")
				{
					this.Flags.set("IsNighttimeEncounter", false);

					if (!this.Flags.get("IsNighttimeEncounterLost"))
					{
						this.Flags.set("IsNighttimeEncounterAfermath", true);
					}
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "NighttimeEncounter")
				{
					this.Flags.set("IsNighttimeEncounterLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_SecretPassage",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在夜晚结束前潜入 %objective%",
					"刺杀敌人的指挥官"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setOnCombatWithPlayerCallback(this.onSneakIn.bindenv(this));
					this.Contract.m.Origin.setAttackable(true);
				}
			}

			function end()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.setOnCombatWithPlayerCallback(null);
					this.Contract.m.Origin.setAttackable(false);
				}
			}

			function update()
			{
				if (this.Flags.get("IsSecretPassageWin"))
				{
					this.Contract.setScreen("SecretPassageAftermath");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsSecretPassageLost"))
				{
					this.Contract.setScreen("SecretPassageFail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.World.getTime().IsDaytime)
				{
					this.Contract.setScreen("FailedToReturn");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, a in this.Contract.m.Allies )
					{
						local ally = this.World.getEntityByID(a);

						if (ally == null || !ally.isAlive())
						{
							this.Contract.m.Allies.remove(i);
						}
					}

					if (this.Contract.m.Allies.len() == 0)
					{
						this.Contract.setScreen("Failure");
						this.World.Contracts.showActiveContract();
						return;
					}
				}
			}

			function onSneakIn( _dest, _isPlayerAttacking = true )
			{
				if (!this.TempFlags.get("IsSecretPassageShown"))
				{
					this.TempFlags.set("IsSecretPassageShown", true);
					this.Contract.setScreen("SecretPassage");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "SecretPassage";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
					this.Contract.flattenTerrain(p);
					p.Entities = [];
					p.EnemyBanners = [
						this.Contract.m.Origin.getOwner().getBannerSmall()
					];
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
					p.Entities.push({
						ID = this.Const.EntityType.Knight,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/humans/knight",
						Faction = this.Contract.m.Origin.getOwner().getID(),
						Callback = this.onEnemyCommanderPlaced
					});
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onEnemyCommanderPlaced( _entity, _tag )
			{
				_entity.getFlags().set("IsFinalBoss", true);
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().get("IsFinalBoss") == true)
				{
					this.Flags.set("IsSecretPassageWin", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "SecretPassage")
				{
					this.Flags.set("IsSecretPassageWin", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "SecretPassage" && !this.Flags.get("IsSecretPassageWin"))
				{
					this.Flags.set("IsSecretPassageFail", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_ReliefAttack",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保持围困%objective%",
					"拦截任何试图突围的人"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("IsReliefAttackLost"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}

				local isAlive = false;

				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive() && e.getFaction() == this.Contract.m.Origin.getOwner().getID())
					{
						isAlive = true;

						if (e.getDistanceTo(this.Contract.m.Origin) <= 250)
						{
							this.onCombatWithPlayer(e, false);
							return;
						}
					}
				}

				if (this.Flags.get("IsReliefAttackWon") || !isAlive)
				{
					this.Contract.setScreen("ReliefAttackAftermath");
					this.World.Contracts.showActiveContract();
					return;
				}

				foreach( i, a in this.Contract.m.Allies )
				{
					local ally = this.World.getEntityByID(a);

					if (ally == null || !ally.isAlive())
					{
						this.Contract.m.Allies.remove(i);
					}
				}

				if (this.Contract.m.Allies.len() == 0)
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}
			}

			function onCombatWithPlayer( _dest, _isPlayerAttacking = true )
			{
				_dest.setPos(this.World.State.getPlayer().getPos());
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.CombatID = "ReliefAttack";
				p.Music = this.Const.Music.NobleTracks;
				p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
				p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
				p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall());
				p.EnemyBanners.push(_dest.getBanner());
				this.Contract.flattenTerrain(p);
				local alliesIncluded = false;

				for( local i = 0; i < p.Entities.len(); i = ++i )
				{
					if (this.World.FactionManager.isAlliedWithPlayer(p.Entities[i].Faction))
					{
						alliesIncluded = true;
					}
				}

				if (!alliesIncluded && _dest.getDistanceTo(this.Contract.m.Origin) <= 400)
				{
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local e = this.World.getEntityByID(id);

						if (e.isAlliedWithPlayer())
						{
							e.die();
							break;
						}
					}
				}

				this.World.Contracts.startScriptedCombat(p, false, true, true);
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "ReliefAttack")
				{
					this.Flags.set("IsReliefAttackWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "ReliefAttack")
				{
					this.Flags.set("IsReliefAttackLost", true);
				}
			}

		});
		this.m.States.push({
			ID = "Running_DefendersSallyForth",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保持围困%objective%",
					"拦截任何试图突围的人"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Origin.getDistanceTo(this.World.State.getPlayer()) >= 800)
				{
					this.Contract.setScreen("TooFarAway");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("IsDefendersSallyForthLost"))
				{
					this.Contract.setScreen("DefendersPrevail");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsDefendersSallyForthWon"))
				{
					this.Contract.setScreen("DefendersAftermath");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.Contract.m.Origin.getOwner().addPlayerRelation(-99.0, "在战争选择了阵营");
					this.Contract.setScreen("DefendersSallyForth");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "DefendersSallyForth")
				{
					this.Flags.set("IsDefendersSallyForthWon", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "DefendersSallyForth")
				{
					this.Flags.set("IsDefendersSallyForthLost", true);
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

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + 5.0);
			}

			function update()
			{
				if (this.Flags.get("IsPrisoners") && this.Time.getVirtualTimeF() <= this.Flags.get("WaitUntil"))
				{
					this.Contract.setScreen("Prisoners");
					this.World.Contracts.showActiveContract();
				}

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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% welcomes you into his room. 他的办公桌上铺着一张地图。 地图上摆满了木制的小军事模型，代表着在作战地图上来回移动的军队。 这名贵族特别指向其中一个。%SPEECH_ON%我需要你到这里去与 %commander% 交谈。他正在围攻这里的要塞并需要你的协助来发起总攻。 你将会被支付 %reward% 克朗，我认为足够丰厚了不是吗？%SPEECH_OFF% | 你进入 %employer%的作战指挥所，围绕在作战地图旁的一群将军和指挥官突然安静了下来。%employer% 向你挥手并把你带到了一旁。 军人们瞪你了一会儿然后慢慢地回到了他们的战略讨论当中去。%employer% 解释他的处境。%SPEECH_ON%我的指挥官 %commander% 正在围攻这座堡垒，它位于 %objective%。他需要多一些人手发起进攻，这也就是为什么叫你来。 到那儿去帮他，我会付给你丰厚的 %reward% 克朗作为回报。听起来很划算不是吗？%SPEECH_OFF% | 你正要进入 %employer%的房间，他冲出来搭上你的肩膀。 他带你穿过大厅来到一个窗前，凝视着窗外的中庭对你说。%SPEECH_ON%我的将军们不需要见你。 他们认为干你们这一行的身上没有荣誉感。 有时候聘请雇佣兵需要一些政治手腕。%SPEECH_OFF%你摇头并简洁的回复。%SPEECH_ON%论杀人我们与他们无异。%SPEECH_OFF%The nobleman nods.%SPEECH_ON%当然，佣兵，但是将来你们可能也会来杀我们。 我的将军们为此夜不能寐，有些人忧虑，有些人愤怒。 我之所以能酣眠如婴儿是因为我懂得这世间的现实，明白吗？ 所以让我们来谈生意吧。 我需要你去 %objective% 并协助我的指挥官 %commander% 进攻那里的要塞。 你将会被支付 %reward% 克朗作为酬劳。%SPEECH_OFF% | %employer% 与你会面并带你来到他的花园。 考虑到时下的处境，他竟然出奇地放松。 他擦拭着一株西红柿并对你说。%SPEECH_ON%战争如地狱。你我交谈间已有人相继死去。 正如此。我不想滥用我的权力。%SPEECH_OFF%你把大拇指塞进裤腰里说。%SPEECH_ON%为了我的人，我希望你不要。%SPEECH_OFF%%employer% 点头并握住一个西红柿。 藤条被紧紧扯住然后扭断。 他咬了一口然后点头，仿佛一个园丁的生活才是他所向往的。%SPEECH_ON%我有一名指挥官叫 %commander%，他正在围攻 %objective%。他正在计划发起总攻。 虽然有点危言耸听，但是他已经为此筹划许久了。 他只是需要最后一点人手来确保行动顺利。 到他那里去协助他，我会付给你 %reward% 克朗。%SPEECH_OFF% | %employer% 迎接你并带你来到他的一张作战地图前。 He points at %objective%.%SPEECH_ON%指挥官 %commander% 正在围攻他们的要塞。 我需要一些猛士去帮他发起进攻。 到他那里去协助他，我会付给你 %reward% 克朗。听起来不错吧？%SPEECH_OFF% | 当你进入 %employer%的房间你看见一群指挥官站在一张地图的周围。 地图上摆满了代表领主的小军事模型。 一个人用棍子推了推摆在画风拙劣的平原上的木马。%employer% 来迎接你，然而他的一个将军把你带到一旁解释他们的需求： \n\n 指挥官 %commander% 正在 %objective% 进行围城。 守军溃败在即，但是他担心援军正在赶来。 他想在援军赶来之前发起总攻。 到那儿去，按指挥官的需求帮助他，你将会被支付 %reward% 克朗。 | 你停留在 %employer%的门外并问自己，你需要惹上这个烂摊子吗？ 突然，一个端着一箱钱的仆人遇见你。 他询问 %employer% 是否在里面因为 %reward% 克朗已经准备好付给佣兵了。 你马上抢在仆人前面进入屋内。%employer% 热情地迎接你。 他解释说指挥官 %commander% 正在围攻 %objective% 并马上将取得重大突破。 他只是需要一些人手来推波助澜。%employer% 假装思索了一下然后说道。%SPEECH_ON%%reward% 克朗将会付给你。%SPEECH_OFF%你这时佯装惊讶。 | 你不确定将来战势是否会有利于 %employer%，也不确定他的将领们是否总是这般紧张。 他们看起来好像宁可倒在剑下也不愿多盯作战地图一秒。%employer% 正坐在房间里的一角，紧挨着炉火和一个端着酒壶的仆人。 这名贵族把你招呼过去并开始讲道。%SPEECH_ON%别介意那些负面情绪。 战事顺利。一切安好。 为了向你展示境况有多好，你需要与指挥官 %commander% 交谈，他在 %objective% 因为他即将结束对那座该死的要塞的围攻。 胜利就在眼前，你所需要做的就是协助我将其取入囊中！ %reward% 克朗听起来如何？%SPEECH_OFF% | 你进入 %employer%的房间发现一名贵族把自己深陷在一张舒适的椅子里。 他的脚下是两只打盹的狗和一直发出咕噜声的猫。 他酣然入梦，鼾声如雷，伸出的手臂上仍然挂着一只滴淌的高脚杯。 一名身着将军服饰的人在房间的另一头用手势招呼你过去。%SPEECH_ON%别介意我们的领主。 战事重压他的心神。 现在，听着。我领到了我的军令，你领到了你的，你的军令在我这。 我们需要你去 %objective% 并帮助指挥官 %commander% 围攻那里的要塞。就这些。%SPEECH_OFF%你询问起酬劳。这名将军脸色变得有些臭。%SPEECH_ON%是的。酬劳。当然有。 我会许诺给你 %reward% 克朗。 我希望这些对你的…光荣的服务来说足够。%SPEECH_OFF%结尾这句措辞似乎让这个人不舒服。 很明显他被指示过要尽量圆滑处置。 | %employer%的一名将军在大厅外与你会面。%SPEECH_ON%领主大人很忙。%SPEECH_OFF%他把一张卷轴塞到你胸前。 你展开它开始阅读。 上面写道，指挥官 %commander% 正在围攻 %objective% 并需要帮助。 无疑这正是 %companyname% 此次前来的差事。 你抬头看着这个男人。 他咬紧着牙喃喃道。%SPEECH_ON%你的酬劳是 %reward% 克朗，你这光荣的佣兵。%SPEECH_OFF%最后那句措辞好似被指导过。 | 你找到 %employer% 后他带你出去看他的私人犬舍。 他边走边聊的同时向狗扔着残羹剩饭。%SPEECH_ON%战事进展得太棒了。 这简直是我干过的最伟大的事，我太高兴了。%SPEECH_OFF%他抚摸其中一只杂种狗的耳根然后让它舔自己的手指。%SPEECH_ON%但并不是事事顺遂。 我需要你去 %objective% 协助指挥官 %commander%，他正在带领围攻那儿。%reward% 克朗将会作为你帮助的酬劳。%SPEECH_OFF%一个仆人带着一只活鸡跑过来。 这名贵族拎着它的腿把它抛进一个关着狂吠的狗的笼子里。 这只家禽疯狂地拍打着翅膀，在犬牙交织的撕咬中来回跳跃，最终被突然按倒。 顷刻间它被撕成了碎片。%employer% 转过来，用一根羽毛拂拭你的肩膀。%SPEECH_ON%所以，我们成交吗？%SPEECH_OFF% | %employer% 迎接你进入他的房间，这间房貌似已经被改造成了一个临时作战指挥所。 指挥官们尽职地站在一张作战地图旁，将军事模型推来推去并为军事模拟的结果而争论。%employer% 将你带到一旁。 他一遍转动手上的戒指一边说。%SPEECH_ON%指挥官 %commander% 需要帮助来围攻 %objective%。线人告诉我他即将有重大突破，但是他需要像你这样的人来真正地实现突破。 过去帮助他，待你凯旋归来时 %reward% 克朗将作为回报在这儿等着你。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "多少钱，你说？",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不划算。 | 我们还有其他要事。 | 我不会让战团去在围城战中煎熬。}",
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
			ID = "TheSiege",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{你来到 %commander%的营帐发现他的士兵貌似很放松。 他们在泥地上放了一块木板，在上面摇骰子，讲笑话唱歌。 周围的旗帜随风飘动，大多失去了曾经的色泽。 一些人正在用绳子栓投石机上的长杆。%commander% 亲自带你去他的指挥帐篷。 他递给你一杯酒，尝起来就像耗子在里面泡过澡。 他向你解释当下局势。%SPEECH_ON%我相信你已经知道，我们在这儿呆了有一阵子了，马上就要实现重大突破。 我需要你在身边随时待命。 一旦进攻时机成熟，我会下令让你开始进攻。%SPEECH_OFF% | %commander%的营帐已经毁坏了 %objective% 周围的土地。人群已经一天天把土地踩成了烂泥。 一些人转动着一台破旧投石机的辐条。 他们把一个生蛆的奶牛脑袋抛进桶里并放松绳索发条，直到攻城器械的长杆向前弹出，向要塞射出一个旋转的血淋淋的黑脑袋。 它撞上一个锯齿状的棱堡然后从墙上滚下，留下一道恶心的血印。 一些守城者叫骂回来。%SPEECH_ON%射得好呀，你们这些臭傻逼！%SPEECH_OFF%%commander% 拍拍你的肩膀。他咧嘴笑着。%SPEECH_ON%欢迎来到前线，佣兵。 你和你兄弟们的出现使我们万分感激。%objective% 已经孤立无援，他们拒绝投降且斗志不减，尽管已经食不果腹。 但是饥饿…会拖垮他们。 时机一旦成熟，我就发起进攻，我要你做的就是随时待命。%SPEECH_OFF% | %commander% 欢迎你来到前线。 他告诉你 %objective% 守军已经疲惫，补给不足，并且即将崩溃。 鉴于此，他正准备发起总攻并需要 %companyname% 的成员到时候准备就绪。 | %objective% 的围攻看起来更像是一场消遣的大戏而不是全力以赴的战斗。 双方都处于极度的物资匮乏状态，隔着城墙互怼脏话，并且在间歇咒骂自己这般不幸而身陷如此困境。然而，%commander% 眼中带着愉快的光芒走向你。%SPEECH_ON%啊哈，雇佣兵。让我来告诉你当下的情况吧。 我们已经切断了 %objective% 的食物补给并且几天前我们的细作烧毁了他们的粮仓。 他们马上就要饿死了。 因为我们在赶时间，我会组织一次全面进攻来让这次围攻速战速决。 到时候准备就绪就行。%SPEECH_OFF% | 你来到 %objective% 看见要塞屹立在地平线上的轮廓，%commander% 透过一双皮革包裹的望远镜，面目扭曲地看着望远镜中的景象。 他把望远镜递给你看。\n\n 你第一眼看到的是一个男人上下摆动屁股并用双手拍着。 周围的士兵目瞪口呆地看他当众撸管。 你放下望远镜，懒得再看别的东西。%commander% 摇了摇头。%SPEECH_ON%我们切断了他们的食物补给所以他们现在发疯了。 他们自认为很搞笑，但是很快我们就知道谁笑到最后。 我在计划一次进攻。 我需要你和 %companyname% 的人得到命令时准备就绪。%SPEECH_OFF% | %commander% 迎接你来到 %objective% 的郊外，在这里他已经建好了攻城营地。 一排排帐篷里塞满了疲惫而满腹牢骚的男人。 他们炖东西的罐子很脏，相互开的玩笑也很脏。 在远处，%objective% 的勤奋的守卫们从垛口向外盯着。 指挥官带你到他的帐篷并向你讲解当下的情况。%SPEECH_ON%%objective% 食物耗尽在闹饥荒。 很不幸，我没有时间了。 我们需要立刻进攻这个该死的地方，我的意思是他妈的立刻。 时机一到，会到的佣兵，我需要你准备就绪。%SPEECH_OFF% | %objective% 的郊外到处都是帐篷。一名 %commander% 的护卫押送着你穿过被包围的城市。 满腹牢骚的正规军怀疑地看着你。然而，%commander%，却愉快地迎接你到他的帐篷。 一踏进帐篷，你就看见一个男人被双手吊着，双脚悬空。 另一个人在木桶的血水里洗刀子。%commander% 把手伸向这个囚犯。%SPEECH_ON%啊，佣兵。你刚错过了好戏。%SPEECH_OFF%你问他刚在干什么。 指挥官走到这个囚犯前，凑起他的下巴，抬起他筋疲力竭的脑袋。%SPEECH_ON%我刚在找答案。%objective% 马上要陷落了，但是我没时间坐等那一刻。 我马上要进攻这座要塞，到时候我需要你和你的人准备就绪。%SPEECH_OFF% | 你来到 %commander%的攻城营地发现士兵们正在把一袋子人头往投石机里装并射向 %objective%的要塞。 指挥官亲自走到你身边，带着灿烂而满意的沉浸在这景象当中。%SPEECH_ON%你知道，其中一些人头是我们自己人的，但是我猜城墙那边的饭桶们看不出差别。 谁的人头不重要，重要的是有多少，你懂吗？过来，佣兵。%SPEECH_OFF%他带你来到他的指挥帐篷，里面铺着一张地图。%SPEECH_ON%守军已经累了，并且最新情报告诉我他们马上就要粮食耗尽开始抢剩饭吃了。 但是我没时间等他们自己意识到自己的徒劳，我必须逼他们。 我们马上就要发起一场进攻。 命令下达时你需要在那待命。%SPEECH_OFF% | 当你进入 %commander%的营地，他的一些士兵朝你的人身上吐口水，这引发了一场争斗。 万幸的是，指挥官本人出面将事情摆平。 他迅速带你去他的帐篷，你们在帐篷里谈话时你的人在外面站着。%SPEECH_ON%我必须为我手下的行为道歉。 当你每天都在站在和睡在烂泥里，而你的敌人却睡在床上从城墙另一边骂你，你的情绪会变得极其脆弱。\n\n万幸的是，我们的一个细作烧毁了 %objective%的粮仓和库存，让这座要塞没有了补给。 守军已经开始挨饿了，但是我怕我的人很难再坚持太久。 我还担心援军可能正在赶来试图解围。 所有这些都意味着一件事… 我要下令进攻。 计划还正在制定，命令下达时我需要你准备就绪。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%companyname% 就要准备好了。",
					function getResult()
					{
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TakingAction",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% 迎接你来到他围城的郊外。 他身边跟着一队男仆而他的脸色极为难看。 他迅速为你讲解当下的情况。%SPEECH_ON%佣兵，你来的正是时候。 我的侦察兵刚刚汇报说援军正在赶来帮 %objective% 解围。我们要不然就进攻，要不就试着烧了这个该死的地方拿烟把他们熏出来。 只是后者可能留不下太多东西给我们。%SPEECH_OFF%奇怪的是，指挥官其实正看着你寻求建议。 | %objective% 正在被 %commander%的人包围，但更紧张的貌似是攻城方而不是守军。%commander% 亲自拉着你去他的帐篷。 他一边讲解一边用手指关节敲着桌子。%SPEECH_ON%我的侦察兵已经发现一队正在赶来解围的部队。 击退他们的话我们的人手不够，体力更不够。 我们要不然现在就发起进攻，要不就用投石机点火发射把那个该死的地方烧为灰烬。 守军无疑会跑出来，但是废墟里不会留太多战利品。%SPEECH_OFF%然而这时，出乎意料的是，指挥官抬起头问你。%SPEECH_ON%你认为我们该怎么做，佣兵？%SPEECH_OFF% | 当你来到 %commander%的帐篷，他正在和他的副官们站在一张地图周围，你的到来让他们迅速停止争论。指挥官指着你。%SPEECH_ON%雇佣兵！我们得到消息援军正在赶来解围，但击退他们的话我们的人手不够。 我们要不然进攻 %objective% 要不就把这破地方化为焦土，用烟把守军熏出来，再拿走废墟中留下的东西。 我的副官在这个问题上有分歧。 决定性的一票给你，你看怎么办？%SPEECH_OFF%副官们满腹牢骚，但是很奇怪，对于把决定权留给一队佣兵没什么意见。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "要我说，我们全力进攻这座城堡。",
					function getResult()
					{
						this.Flags.set("IsAssaultTheGate", true);
						this.Contract.setState("Running_TakingAction");
						return "AssaultTheGate";
					}

				},
				{
					Text = "要我说，我们朝城堡发射火雨然后用烟把他们熏出来。",
					function getResult()
					{
						this.Flags.set("IsBurnTheCastle", true);
						this.Contract.setState("Running_TakingAction");
						return "BurnTheCastle";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AssaultTheGate",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% 已经下令进攻。\n\n {%companyname% 和一队贵族士兵将要进攻前门。 你们都挤在攻城槌的罩子里面，比起攻城器械，这更像是一个带轮子的窝棚。 所有人手臂都放在撞杆上，把攻城槌向前推。 箭雨不断地从顶棚上掠过，发出砰砰砰的响声。 你抬头看到几只箭头已经刺穿进来。 当你们到城门口时，你命令所有人把撞杆向后拉，然后再命令他们松开。\n\n沉重的橡木发出嘎嘎的响声，撞杆向前弹出猛撞向城门。 城门从中间裂开缝隙，从缝隙中你可以到 %objective%的守军正在门另一边等着你们。 再一次下令，再一次撞击。 这一次直接撞穿了城门，扯断了铰链，使每扇门都碎落成一堆碎片和金属。 部队准备就绪，你和所有人冲进城门。 | 与指挥官的一队手下一起，%companyname% 把一个盖着罩子的攻城槌推向 %objective% 的城门。一些守军嘲笑着向你嚎叫。%SPEECH_ON%{你不请我们出去先吃个晚饭吗？ | 哼，你们的撞杆弄得挺长的嘛。 想要掩饰啥啊？ | 有种就过来你们这群丑逼。 | 你们就在自己的小窝棚下面向神祈祷吧。}%SPEECH_OFF%当你们摆动撞杆猛撞向城门，城门被撞碎时，他们的谩骂突然静止了。 你的人迅速冲过城门的缺口。 | 带着指挥官的一些人，你和 %companyname% 把一个攻城槌推向 %objective% 的城门。顶棚摇摇晃晃吱吱作响，比起护盾，这更像是一个窝棚。 你祈祷它能扛得住。 箭矢在顶棚上嗒嗒作响，有的弹起来发出金属和木头尖锐的摩擦声。 当你离 %objective%的城门更近一些时，箭矢变成了石头，重重地砸在工程器械的罩子上。%randombrother% 向攻城槌外看，笑道。%SPEECH_ON%去死吧，伙计。%SPEECH_OFF%突然一阵可怕的嘶嘶声包围了所有人，仿佛你们掉进了蛇窝。 直到你发现滚烫的油从顶棚边流下。 其中一股热油浇到了一名贵族背上，他嚎叫着倒地，化为一个焦黑的泥偶。 你匆忙下令开始撞城门。 所幸攻城槌一击就将 %objective% 的城门彻底撞开。 你的人迅速冲过城门与迎面为数不多的守军厮杀。} | 进攻 %objective% 的命令已经下达。 你让 %companyname% 准备就绪。你的人和 %commander% 开始把攻城槌推向要塞的城门。 箭矢划过天空，在阳光下熠熠发光，呼啸着冲向进攻的人潮。 士兵们无声地倒下，一些人倒地捂住伤口。\n\n 正门迅速被撞开，你的人冲过缺口来到中庭，这里有一些 %objective%的守军在等着。 | %commander% 下令开始进攻。 你的队伍和他的军队一同冲向要塞，攻城车倾泻的炮弹如黑色的冰雹从头顶划过。 城墙被射得残破不堪，而守军在 %commander%的弓箭手持续的压力下龟缩不动。 你将一辆攻城槌推向正门并迅速撞开它。 当 %companyname% 冲过城门，%objective% 的守军在中庭严阵以待。 | 进攻 %objective%的要塞的命令已经下达。 随着预先一轮的射击，炮弹和箭矢将天空染成了末日般的景色。 随着火焰在 %objective% 的城墙上四处燃起，你看到 %commander%的士兵正在垛口上搭梯子并试图一路杀上城墙。 与此同时，你和你的人躲在一辆攻城槌的罩子下缓慢前行，推到正门前并迅速撞开城门。 当你们冲进去时，中庭里站满了守军准备战斗。 | %commander% 下令进攻 %objective%的要塞。 进攻像这样展开:来往的箭矢将天空染黑，箭雨咆哮，箭头不断弹起。 攻城车的炮弹像寒冷的彗星冲向天际，砸向城墙和塔楼。 守军奋力将梯子从垛口往下推。 进攻者不断地往梯子上爬，爬得最高的人举起盾牌，他身后的人用长矛往上刺。 你同 %companyname% 推着一辆摇摇晃晃的攻城槌来到正门前，在这片混乱的掩护下没有引起太多注意。\n\n 当前门被撞开，你和你的人冲过去时恰巧遇到一队守军在那集结。 在四周的城墙上你能看到 %commander%的人正在拼命地厮杀试图掌控战局。 | 不幸的是，%commander% 觉得要从正面拿下 %objective% 的要塞。 你和 %companyname% 负责把一辆攻城槌开到正门前。 当你在淤泥中推着攻城槌前行时，你注意到一个人在城门上守着一口热气腾腾的油锅等着你们。 你瞥了一眼周围看到士兵们抬着梯子准备冲向城墙。 他们迅速爬上去开始厮杀。 当你回看前方时，滚油旁的守军已经消失了，只有一双腿从油锅里向外搭着。\n\n 你们顺利撞开正门冲进去。 迎面而来的是一队守军，与此同时 %commander%的士兵们还在城墙上奋战。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "AssaultTheGate";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
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
			ID = "BurnTheCastle",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_68.png[/img]{一列弓箭手把箭头塞进捆好的布里然后浸入沥青里面。 他们撑起弓时，一个小男孩沿路跑过用火把将箭点燃。 指挥官举起手，弓箭手们便举起火弓。 他手一放下，弓箭手们便放弓发射。 火箭划过天际，伴着噼啪声和嘶嘶声然后销声匿迹。 只看见要塞上被插满了。 突然一个士兵指着逐渐升起的浓烟大喊。 不一会儿，火舌便冲向天际。 几分钟后正门被撞开，裹着灰烬和浓烟的士兵们如地狱里的泥偶一般冲出来。\n\n %commander% 再次举起手臂，然而这次手中握着一把剑。%SPEECH_ON%CHARGE!%SPEECH_OFF% | 投石机，攻城弩以及弓箭手朝 %objective% 射击。遮天蔽日的弹雨嘶嘶呼啸着穿过天际。\n\n 要塞一会儿便火光弥漫。 窒息的黑烟一团团涌动。 火苗随之缓缓弥漫。 正门响了一下，两下，然后被撞开。 被熏黑的士兵们咳嗽着蜂蛹而出，相互拉扯着争抢新鲜的空气。%commander% 拔剑指向敌军。%SPEECH_ON%不收俘虏！%SPEECH_OFF%%objective% 的守军们似乎听到了这句话并匆忙列阵。 在某一瞬间，你猜想被熏黑的他们是否也曾有一面投降的白旗。 | 放火点燃 %objective% 的命令已经下达。 你看着 %commander%的军营用燃烧的攻城炮弹和箭雨将天空照亮。 火焰不久便从城墙后升起，你看到被火焰包裹的人四下狂奔。 正当地狱之火从内部吞噬着 %objective%，正门打开了，一群被熏黑的绝望的士兵冲了出来。 看到他们后，%commander% 下令所有人冲锋。 | %commander% 命令他的士兵在 %objective% 放火。 这由投石机和抛石机来实现，它们满载着用柴火包裹并浸满沥青的石头。 炮弹被点燃并投向空中。 一轮激烈的火箭齐射随之而来，射向 %objective%的城内，你随之看到浓烟冒起。 要塞里沦为了炼狱，不久正门打开士兵们跑了出来。%commander% 拔出他的剑。%SPEECH_ON%他们就在那，伙计们。 让我们一次做个了结！%SPEECH_OFF% | 弓箭手开始把他们的箭裹在布里往沥青里浸泡。 孩子们提着装满油的桶四下奔跑，开始往投石机的弹药上涂。 当这些准备就绪，%commander% 下令发射。 人们或许曾经崇拜过火焰，但是此时，随着弹雨呼啸着划过天际，用火焰连续轰击着 %objective%，一切都化为了剧烈的恐惧。 攻城的炮弹粉碎着塔楼，炮弹从塔顶坠入，将整座塔点燃。 守军身上插着燃烧的箭矢四处奔逃。 随着地狱之火愈燃愈烈，正门打开，裹着浓烟和碳灰的泥人们冲了出来，自相踩踏着逃离这眼前的地狱。\n\n 看到这幅景象，%commander% 拔出他的剑。%SPEECH_ON%杀向他们，伙计们，不要留情！%SPEECH_OFF% | %commander% 下令让他们的人把地狱降临到 %objective%。你看到投石机、抛石机和弓箭手们发射出燃烧的弹雨遮盖天空。 要塞很快火光弥漫化为了炼狱。 绝望的士兵们打开正门冲了出来，咳嗽着拼命相互拉扯只为争抢一多口空气。%commander% 见此情景拔剑大笑。%SPEECH_ON%他们就在那，他们都得死！冲锋！%SPEECH_OFF% | 你看到围城工程师用奶牛尸体和其他多脂的死畜填充投石机和抛石机。 孩子们提着装满沥青的油桶从战线穿过，将每一颗弹药浸满沥青然后点燃。 下一秒，工程师便把尸体射向空中。 它们在天空中淌着泪水。 你看到一颗弹药击中一座塔楼并从外面炸开，将火雨倾泻到要塞的中庭中。 不久这充满兽性的空中打击便将 %objective% 化为一座炼狱。\n\n 前门破开，一群士兵冲了出来。 他们争相拉扯着对方，看起来就像是移动着的浓烟和灰烬，或是一片在城门前展开的黑色蕨菜。%commander% 拔出他的剑。%SPEECH_ON%我们等待已久的时刻到了，伙计们。 好吧，不用再等了！冲锋！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "BurnTheCastle";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
						];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.getFaction(),
							Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract),
							Tag = this.Contract
						});
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = null
						});
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "AssaultTheCourtyard",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%的城门已经被攻陷，但是还有更多的事要做。 这股劲头需要保持着: 你迅速命令你的人向中庭里推进。 | 城门已经被攻下，但是 %objective%的中庭还没有被攻陷。 你命令 %companyname% 持续向前推进。 | %companyname% 已经攻陷了城门同时 %commander%的士兵正在城墙四周冲杀，企图肃清所有塔楼。 你不想在此泄劲，于是你迅速下令继续进攻中庭。 | 当你冲进中庭，%commander%的士兵在城墙上厮杀企图夺取控制权。 | 你同 %companyname% 冲进 %objective%的中庭。 你的上方是刀剑交错的叮当声，%commander%的士兵正在厮杀企图夺取城墙的控制权。 | 中庭必须被攻下来！ 你同 %companyname% 冲进要塞里战斗。 你的四周都是 %commander%的士兵，为了夺取城墙正在奋力厮杀。 | 当你冲进 %objective%的中庭，死尸从上方落下，他们都被 %commander%的士兵杀死，这些士兵拼命要夺取城墙的控制权。 | %commander%的士兵正在进攻城墙。 现在你必须履行你这块的职责，夺下中庭！ | 正当 %commander%的人夺取城墙时，你开始夺取中庭。不能失败！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "AssaultTheCourtyard";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "AssaultAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%的要塞已经陷落。 你看到 %commander%的士兵们在四处搜刮财物，把死尸们从生前最后一刻爬到的角落里拖出来。 尸体有被烧焦的，有被斩首的，有断肢的，有拖着内脏的，还有一些看起来像是在安睡中死去。 其中一名正规军从垛口探出身子，扯下要塞的旗帜，在原处升起 %noblefamily% 的纹章并欢呼起来。 | 死尸四处散落在中庭里，有些像湿衣服一样在墙边折叠着，有些依然在角落里挂着一张惊恐的面庞，你看到一些焦黑的尸体在烧毁的马厩里干瘪扭曲，这些尸体中有的是马，猪，狗甚至是羽翼残破的鸟，它们一同被卷入到这场难以停歇的杀伐当中。\n\n %commander% 四处走向他生还的士兵们并向他们出色的战绩庆贺。 其中一名士兵将 %noblefamily% 的旗帜升到了塔楼上。 这个不幸的地方有了新的主人。 | 进攻结束了，%objective% 的守军已被全部肃清。 即使当中有人存活于此，也已结队逃跑。%commander% 命令他的一个士兵将 %noblefamily% 的纹章升上塔顶，就像这样，%objective% 换了主人，最终换来的结局不过是一面旗软绵绵地在风中摆动。 | 代价惨重，但是进攻总算结束了。%commander% 踩在尸体上命令他的士兵立刻清理战场。 其中一名士兵举起 %noblefamily% 的旗帜让所有人看清这场战斗是谁获胜了。 | 你周围都是 %objective% 守军的尸体。 它们被发现时已经发硬，但是历史不会记住的。 他们的名字会被遗忘，他们的存在也毫无意义。 你看到一名 %commander%的士兵在一座塔楼上展开他们的旗帜，至少那面旗子还挺好看。 | 一些零星的战斗依然在持续。 你看到 %commander%的士兵把守军从附近一座塔楼扔了下去，那名可怜的守军尖叫着摔死。 当守军被全部肃清，一名士兵挥起 %noblefamily% 的旗帜。 旗子在刚刚迎来的宁静中响亮地拍打着。 | 医师们冲进要塞为 %commander%的士兵疗伤。 一些 %objective%的守军也受伤了，但是他们被丢下来看自己造化。 任何求救的呼声换来的是冰冷的剑刃。 幸存者马上学会了装作没有受伤，不发出求救。\n\n %noblefamily%的旗帜在正门上空展开。 | %commander%的士兵跑到 %objective% 中庭里的尸体上搜寻财物。 一个女人被发现并被拉进了一座塔楼。 年幼的孩子们跟在她身后肆意哭嚎却没有人理会。%commander% 亲自向你出色的战绩庆贺。 他指向一名在正门上空展开 %noblefamily% 旗帜的士兵。%SPEECH_ON%看到那个纹章了吗？它象征着胜利。%SPEECH_OFF%你意识到堆积成山的敌人尸体可以书写胜利，一片迎风拍打的布竟然也可以。 | 中庭里的尸体堆积成山，血水从周围的城墙上淌下。%commander%的人四下收集他们能搜刮到的武器，并在受伤的敌人身上补刀。 他们自己的伤兵由瘦弱的老医师们用包装的研磨草药治疗。%noblefamily%的旗帜在城墙上展开以镇军心，以免现有的证据不能够充分地显示出，%objective% 已经易主。 | %objective% 的市民被要求在城中穿行，亲眼目睹死去的守军和守城的彻底失败。%commander% 站在他们头顶的城墙上，大拇指塞进裤腰里，露出得意的微笑。 当一名士兵展开 %noblefamily%的旗帜，他指向那里。%SPEECH_ON%看到没？这是你们现在的主子。明白吗？%SPEECH_OFF% | 你看着市民们从 %objective%的守军身旁走过。%commander% 似乎乐于彰显场这场胜利有多么彻底，告诉众人无需再反抗了。 你不能责怪他: 失败会让被征服者的心中滋生反叛的念头，这个念头比拿着剑表明敌意的士兵更可怕，因为后者起码可以让对手心无杂念地立刻斩杀。 | %commander% 让 %objective% 的市民排队从要塞里穿行而过。 他们被要求观看战败的淌着血的守军尸体。 队伍中有一名漂亮的工坊女工，她被指挥官拉了出来。 他问女人是否认识这些尸体里的人。 她指着一个脸已经塌陷进去的尸体。 她认出了他制服上别着的枯萎的玫瑰－是出征那天早上她送给丈夫的。%commander% 对她的损失表示歉意，随后小心地带她回到队伍里。 他带着父亲般的严厉向人群致辞。%SPEECH_ON%你们这些人都会被善待。 我们会进行重建，也会让你们吃饱肚子。 但是，不要犯错误，%objective% 属于 %noblefamily%。只要我们在这一点上达成共识，那你们一切都会好的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.changeObjectiveOwner();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BurnTheCastleAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_68.png[/img]{火焰像魔法一样将 %objective%的守军驱赶了出来。 你和 %commander% 走过无人把守的城门看看这里还剩下什么。 很不幸，火焰已经将这座城的大部分夷为了平地。 即便如此，一名正规军依然将 %noblefamily% 的旗帜在塔楼上升起。 你很难从盘旋的灰烬和浓烟中辨认出旗帜上的纹章。 | 战场上遍布着死去的和即将死去的人。%commander%的士兵们从堆积成山的尸体中穿过，时不时地用他们的长矛朝地上刺，使呜咽声沉默下来。\n\n 你同指挥官一道穿过 %objective%的城门。 火焰将每一座木制建筑化为了嶙峋焦黑的框架。 中庭内四处都是烧焦的农场牲畜。%commander% 耸肩并命令他的一名士兵将 %noblefamily% 的旗帜在其中一座塔楼上升起，以便所有人都知道谁是今天的胜利者。 | 战斗结束了。用火焰将 %objective%的守军驱赶出来拯救了更多的生命，然而城门以上一切都已被火焰洗劫。 不论曾经是何面貌，将这里重建并恢复往日的辉煌都需要花费时间。 当 %commander% 命令他的一名士兵将 %noblefamily% 的旗帜在一座塔楼上升起时，他似乎感到很开心。 彩色的亚麻布在浮尘和浓烟的阴霾中清脆地啪啪拍打着。 | %commander% 踏过 %objective% 要塞里的灰烬。%SPEECH_ON%好吧，我们拿下它了。 不论还剩下什么。 我都不会抱怨。做得好，佣兵。%SPEECH_OFF% | %objective% 的市民们赶出来看他们守军的遗体。 女人们在烧焦的尸体中寻找着他们爱人的记号。 然而，她们只发现她们的男人们已经被烧成焦黑而干瘦的骨架，面庞已经消融在了生前最后一刻那骇人的惊恐中。 %commander%的一名人将 %noblefamily%的旗帜在前门的上空展开，指挥官迅速指向那面旗。%SPEECH_ON%听着！看到了吗？ 那就是我们。 现在你们所要做的就是尊重它，这样一切都能恢复常态！ 如果不尊重它，那我将带你们进入新的常态，明白吗？%SPEECH_OFF%一群市民静静地点头。%commander% 微笑着，带着一种令人毛骨悚然的真诚。%SPEECH_ON%很好！现在，这儿谁会做炒鸡蛋？%SPEECH_OFF% | 你和 %commander% 进入 %objective%的要塞，发现这场战斗最终以守军们争抢空气而告终。 被熏黑的躯体，像人又像野兽，在互相拉扯着。 一个人的手正在拉扯另一个人被烧焦的尸体，他的手指抠掉了对方身上一缕烧焦的肉。 你捂住嘴尽量不呕吐出来。%commander% 命令他的人将 %noblefamily%的旗帜在正门上空升起。 他拍了拍你的肩膀。%SPEECH_ON%嘿，做得很好，佣兵。 你应该吸进那股恶臭。 这样可以帮助你更快的习惯它。%SPEECH_OFF% | 你用一片布捂着嘴穿过 %objective%的城墙。%commander% 走在你身旁，沾沾自喜地抬起头，他这副模样自带着一股恶臭。 在 %objective% 里，你看到尸体们被融化的骨肉缠在一起，竖起的牙齿在粗糙而扭曲的脸上闪现,与这被烧死的可怕结局相呼应。%commander% 拍了拍你的肩膀。%SPEECH_ON%这真是一场大胜，你知道吗？ 你应该回到 %employer%，除非你想帮助清理战场。%SPEECH_OFF% | 你和 %commander% 举着剑进入 %objective%，但是没什么可战斗的了：地狱之火吞噬了所有的活物。 即使没有被烧死，他们也已沾满了灰烬和浓烟被活活呛死。%commander% 踢开周围的瓦砾时，踢翻了一具烧焦的尸体。%SPEECH_ON%见鬼，除了城墙这里什么都不剩。%SPEECH_OFF%他坚定地看着你。%SPEECH_ON%但是城墙就是一切。%SPEECH_OFF%你蹲下看着这个死人。%SPEECH_ON%你觉得他也是这么想的吗？%SPEECH_OFF%指挥官耸耸肩。他迅速转过身去命令他的一名士兵将 %noblefamily%的旗帜在前门上空展开。 | 你踏进了 %objective% 但是马上就后悔了。 这里遍地都是尸体然而没有一具还能被辨认出。 火焰把一切都烧黑了，即使是地上的烂泥本身。%commander% 用他的脚试探着翻动尸体。 血肉上的的碎屑嘎吱作响，像踩在一层薄冰上碎了一样。 他用脚碾碎尸体的鼻子。%SPEECH_ON%这样特别难看，你不觉得吗？%SPEECH_OFF%他转过身去吹响刺耳的口哨，然后指向他的一名士兵。%SPEECH_ON%你！去把 %noblefamily% 的旗帜在前门和塔楼上升起来！%SPEECH_OFF%这名士兵敬礼后便冲过去执行命令。%commander% 拍了拍你的肩膀说道，%employer% 应该对这样的结果非常高兴。 | %objective%的要塞里没剩太多东西能恢复了：这场大火烧光了他妈的几乎所有东西。 留下来的都被烧焦了。 冲到塔楼上逃命的，都窒息而死了。 从死者的面孔可以明显地看出－这两条路都没有好结果。 但是 %commander% 似乎很高兴，命令他的士兵们开始清理战场并把 %noblefamily% 的旗帜展开。 | 你在 %objective% 的尸体们身上搜刮财物。这些死尸吸引了你的眼球，因为你从未在同一个地方看到过这么多烧焦的尸体。 其中一个正紧紧抓着一只小小的身躯，凑近一看，发现是一个婴儿。%commander% 走来拍了拍你的肩膀。%SPEECH_ON%啊，太可惜了。 嘿，你做得很好，佣兵。 不要再纠结没有意义的事情了，知道吗？%SPEECH_OFF%你点头。指挥官微笑了一下然后命令他的士兵们开始将 %noblefamily%的旗帜挂在他们能挂到的所有地方。 最好让陌生人知道，这座被烧毁的堡垒有了新主人。 | 在 %objective% 里，你发现了各种烧焦的模样。 从狗被烧死的尸体可以看出，它们在被火烧死前，早已被铁链活活烫死。 马被困在马厩里，被熏黑的马腿僵硬地在半空中伸着。 猪冲破篱笆跑了出去，毫无疑问，篱笆一直在燃烧。 淡淡的培根香气也难以削弱原本令人恐惧的恶臭。 所有这些生物都在劫难逃。\n\n 你打开一个储藏室的门，发现一堆窒息而死的守军。%commander% 走来站在你身后，朝里面看去。%SPEECH_ON%可怜的家伙。他们看起来很年轻。 可能是马厩的帮手，扈从。真可惜。%SPEECH_OFF%指挥官俯身进入房间，将一条面包上的稻草敲落。 他把面包的外壳剥去露出里面新鲜的部分。%SPEECH_ON%嘿，你饿了吗？%SPEECH_OFF%你礼貌地婉拒了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.changeObjectiveOwner();
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Origin.spawnFireAndSmoke();

				foreach( a in this.Contract.m.Origin.getActiveAttachedLocations() )
				{
					a.spawnFireAndSmoke();
					a.setActive(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "MaintainSiege",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%commander% 带来消息说守军可能正在被削弱。 他希望避免伤亡惨重的进攻而是等待他们出来。 你被指示一直留在攻城营地中，直到被另行通知。 | %commander%的一名副官通知你说，指挥官已经决定多等一段时间，希望守军会投降而不是继续战斗。 %companyname% 收到命令随时待命，直到被另行通知。 | 有消息传来，围城将持续更长一段时间。 你被指示再等一段时间，直到被另行通知。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%companyname% 就要准备好了。",
					function getResult()
					{
						if (this.Flags.get("IsNighttimeEncounter"))
						{
							this.Contract.setState("Running_NighttimeEncounter");
						}
						else if (this.Flags.get("IsReliefAttack"))
						{
							this.Flags.set("IsReliefAttackForced", true);
							this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
							this.Contract.setState("Running_Wait");
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NighttimeEncounter",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{%commander% 命令你和你的人前去巡逻。 在巡逻的途中，你发现一些 %objective%的守军从要塞城墙旁的一条小溪中溜了出去。 他们正在从某条密道中溜走。 你急中生智，命令你的人冲向他们，希望在他们第一眼看到你之前占领密道。 别让这些杂种从密道溜回去！ | 正当你等着看围城的进展时，%commander% 走过来命令你和 %companyname% 开始巡视 %objective% 外围的守军。\n\n 边走边瞧着，正当你要站稳脚跟时，你看到一些 %objective%的守军正从一条地道里溜出来。 你蹲下来仔细观察。 当地道的盖子合上时，你看到上面已经被苔藓和青草覆盖，以掩盖其位置。 如果你现在离开并告诉 %commander%，你很可能会被他们发现并摧毁密道。 你决定抓住时机并下令发起进攻。 %companyname% 需要确保没有守军逃出去！ | 当围攻平息后，你决定采取一些主动措施，并请示能否派你和 %companyname% 外出巡逻。 一定程度的行军可以让这些人振奋精神和保持警觉。 否则，他们就会在营区附近徘徊，然后和正规军斗殴。%commander% 同意了。\n\n 巡逻仅进行了几分钟，你就发现一些 %objective%的守军拖着疲惫的身躯，从草草挖出的护城里往河堤上爬。 他们正从要塞城墙旁的污水口游进护城河。%randombrother% 摇了摇头。%SPEECH_ON%真他妈见鬼。%SPEECH_OFF%你让他保持冷静。 如果这些守军知道他们的密道被发现了，他们肯定会堵上的。 你等所有的守军都从密道里出来，然后再下令进攻。 这些守军一个都不许跑掉！ | 巡逻的命令已经下达，你和 %companyname% 自告奋勇接下任务。 你的人嘟囔和抱怨着，但是这样的任务有助于让这些杂兵们振奋精神和保持警觉。\n\n 找到一群 %objective%的守军正从一条密道里溜出来也是振奋精神的一剂良药！ 刚开始巡逻不到几分钟，你就发现守军在往外溜。 你看着守军们整理好行装，正当他们准备潜入腹地时，你下令发起进攻。 这些守军一个都不许跑掉！ | 随着围攻的展开，%commander% 命令你和你的人开始在 %objective% 附近的要塞巡逻。在半途中你的伙计们偶然发现一些守军正在从一条密道往外溜，密道坐落于半胸高的护城河里，污泥被踩出嘎吱嘎吱的响声。 占领这条密道在未来将是一个巨大的战术优势。 你迅速命令你的人发起进攻－这些守军一个都不许跑掉！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "抓住他们！",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "NighttimeEncounter";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NighttimeEncounterFail",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{该死。一些守军设法从密道偷偷溜回去，你已经听到密道被人封住了。 | 你只是速度不够快，没有拦住所有的守军，让其中一些逃走了。 他们溜回了 %objective% 并把身后的密道封住了。 | 好吧，原本的目标是杀了那些溜走的人并夺取密道。 但事与愿违，其中一些守军溜回了 %objective% 并堵住了身后的密道。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.Flags.set("IsNighttimeEncounterLost", false);
						this.Flags.set("IsNighttimeEncounter", false);
						this.Flags.set("IsReliefAttack", true);
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NighttimeEncounterAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你设法杀了所有的守军并夺取密道。 当你把消息报告给 %commander%，他让你偷偷从密道穿过去并暗杀 %objective%的总指挥官。 你还有几个小时的准备时间，但时间就是一切，你必须在夜幕降临之前动身。 | 杀掉了所有的守军后，你设法夺取这条密道。 你回到 %commander% 身边向他说明情况。 他认真地点头，然后朝你转过身来。%SPEECH_ON%我想让你偷偷从密道穿过去，进入要塞里面，然后刺杀他们的首领。%SPEECH_OFF%比起正面进攻，这次夜间行动是你一段时间以来，听到过的最欣然接受的任务了。 | 密道已经被夺取了，消息也已经汇报给了 %commander%。他笑着摇了摇头。%SPEECH_ON%我们已经盼望这样的结果很久了，结果你来了，第一个出去巡逻然后就发现了要道可以进入 %objective%。%SPEECH_OFF%他说他想让你同 %companyname% 偷偷穿过密道然后刺杀敌放的首领。 一旦事成，守军将会溃散，%objective% 将被轻而易举地拿下。 现在如果不这么做，就得正面进攻，你对后者不抱兴趣。 你还有几个小时的准备时间，但你应该在天亮之前结束任务。 | 一名守军大喊着救命。%SPEECH_ON%他们发现了呃－%SPEECH_OFF%%randombrother% 迅速在这名士兵的嘴里塞了块布，然后割开了他的喉咙。 你环顾 %objective% 城墙周围的动静，但似乎没有人听到哭喊声。\n\n 在返回攻城营地的途中，你被 %commander% 拦下。他在盼望好消息，而你正好带来一个。 这名首领跺着他的脚。%SPEECH_ON%神啊，这是我数周以来听到过的最好的消息！ 好的，非常棒，但是我们需要迅速采取行动。 我想让你和你的人从那条密道溜过去，暗杀 %objective%的首领。 事不宜迟，最多还有几个小时，明白了吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会做好准备然后偷偷潜入。",
					function getResult()
					{
						this.Flags.set("IsSecretPassage", true);
						this.Contract.setState("Running_SecretPassage");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FailedToReturn",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你没能杀死守军的首领，他们的指挥官仍然在坐镇指挥，%commander% 不得不取消围攻。 尽管这次围攻失败并非完全是你的错，%employer% 却很可能这么看。 | 密道已经被堵住了！ 由于守军的指挥官依然活着，进攻这座要塞要付出太大的代价。%commander% 取消了围攻，你也为此受到了一些责备。 | 好吧，你在使用密道前等待了太长时间。 守军一定已经变得警觉，因此用一堆石头堵上了密道。 由于守军依然在指挥官稳固的统领之下，这座要塞对 %commander%的军队来说要付出太大的代价。 他已经取消了围攻。%employer% 会不高兴的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "在闲逛，那时候在围攻 " + this.Flags.get("ObjectiveName"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SecretPassage",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你同 %companyname% 悄悄从密道溜了过去。 隧道的墙壁上往下滴着屎尿，你淌过的水里也好不到哪去。%randombrother% 抱怨了一下，但你让他闭嘴。\n\n 从另一头出来，你们掉进了一座庭院，队伍沿着一排灌木丛偷偷潜入，随后趴在地上等待你侦查四周。\n\n 一些守军在四处走动。 他们在叹气和呻吟。 饥饿让他们的肚子咕咕作响，随之而来的是一连串咒骂声。 很快，你看到指挥官身边站着他最精锐的警卫。 他正在穿过中庭进行巡视。 你再也不会遇到比这更好的机会了，于是你下令进攻！ | %companyname% 同你打开密道。 你看到一个喂马伙计从里面钻了出来，手上拿着一个纸卷，上面是指定的货物清单。 他乞求你饶命，但你当下不能冒任何风险。%randombrother% 割断他的喉咙，把他溺在了从密道流出的污水里。 你们继续前进，掉进到一座庭院。 人们和你沿着一排灌木丛偷偷潜入，并观察了一段时间。\n\n 正在你等待的时候，一个身着指挥官服饰的人向前走了几步，他身后跟着一队警卫。 你觉得再也不会遇到比这更好的机会了，于是你下令进攻！ | 密道里又黑又脏，隧道里流过的水中全是屎尿。 你提了提裤子继续往里走。 火把会让你们暴露自己，所以你们扶着墙摸黑前行。 你们不知道，也永远不愿知道自己的手指会碰到什么。 最终，一道昏暗的光芒在远端闪烁起来，你们从密道滑了出来，进入了一座庭院。\n\n %objective%的指挥官正在检阅他的部队，但突然停下，转身看着你同 %companyname% 带着恶臭的闪亮登场。 他瞪大了眼睛，一只手指着你，另一只手摸向他的武器。%SPEECH_ON%刺客！%SPEECH_OFF%你命令 %companyname% 发起进攻！ | 这条密道是通往 %objective% 城墙另一边的意想不到的捷径。 隧道另一边站着一名守卫。 他看到了你和你的人从黑暗中穿过的身影。他问道。%SPEECH_ON%我希望他妈的上古神明显灵，能让你把我们要的东西带着。 记着，我们要了鸡蛋和…%SPEECH_OFF%过了一会儿，他看到 %randombrother%的脸从阴影中浮现出来，又过了一会才意识到眼前的陌生人并不是他的跑腿伙计。 这名守卫退了回去，但他还没来得及喊出声，你的佣兵们就一刃穿过了他的胸膛，随后扛起尸体迅速钻进了灌木丛中。 把尸体藏起来后。你们悄悄地潜入 %objective% 并看到他们的指挥官正在庭院里练兵。\n\n 没有比这更好的机会了，你命令 %companyname% 发起进攻！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Contract.getActiveState().onSneakIn(null, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SecretPassageAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective%的指挥官已经倒下，他的士兵们迅速放下了武器。 一名副官举起手急忙说道。%SPEECH_ON%我们没有兴趣继续这场败仗。 唯一有兴趣的人已经倒在这儿了。我们投降。%SPEECH_OFF%%employer% 将会对这场战斗的转折非常高兴。 | 战斗结束后，你找到了垂死的 %objective% 守军指挥官。 他吐着血，而你踩在他身上。%SPEECH_ON%我们永不投降。杀了我吧，你们这些可怜的佣兵。%SPEECH_OFF%你一剑刺穿他的眼窝。 他的一名副官丢下武器并举起手。%SPEECH_ON%嘿，他是这儿唯一想守住这个地方的人。 这里全都属于你了。让我们活命吧！%SPEECH_OFF%你命令 %randombrother% 发出信号，告诉 %commander% 这座要塞已经被拿下。 | %objective%的指挥官已经战死，而他的士兵们不约而同地立刻投降了。 他们解释说，只有指挥官本人想守住这个地方。 显然，他在争取贵族家族的关注，并认为英勇的坚守会为他换来家族掌权者的席位。 好吧，他现在死在了烂泥里。 你告诉 %randombrother% 发出信号，以便 %commander% 知道 %objective% 已经投降了。 一名守军向你求饶。%SPEECH_ON%你肯定会让我们活命的，是吧？%SPEECH_OFF%你擦了擦你的刀刃并耸耸肩。%SPEECH_ON%我做不了主。 我的金主和他的军队即将穿过那扇门了。 他的决定我无法左右。 你既然乞求仁慈，那就拿起武器，我的人会给你。%SPEECH_OFF%这名守军皱着眉点头。%SPEECH_ON%我想我只能和他碰碰运气了。%SPEECH_OFF% | %objective%的指挥官死在烂泥中。 他幸存的部队全都举起了双手。 你命令你的人把这些守军铐起来，同时你发出信号，在塔楼上展开了你的纹章。%commander%的攻城营地响起了号角作为回应。 战斗结束了。%employer% 无疑是最开心的。 | 战斗结束了，%objective%的首领死在了烂泥中。 守军们被夺去了心脏和灵魂，立刻投降了。 你命令 %companyname% 把他们围住并拷起来。%randombrother% 前去向 %commander% 发出信号，告知这座要塞已经被占领。%employer% 无疑会很高兴见你回去。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们做到了！",
					function getResult()
					{
						this.Contract.changeObjectiveOwner();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SecretPassageFail",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_33.png[/img]{不幸的是，你没能找到合适的位置暗杀指挥官，于是不得不撤回来。 %objective% 的守军嘲笑着你们，看着你和那些人从隧道溜了回去。 当你们回到外面时，你发现密道已经被封住了。 看起来必须采取更艰难的方式来占领 %objective%。 | 这场战斗进行得并不如你所愿。 你同 %companyname% 被逼回了密道并展开撤退。 当你们回到外面时，伴随着石头的轰鸣声，守军封住了一切。 你已经尽力了，但看来拿下 %objective% 并不像你期望的那样简单。 | 值得称赞的是，守军的确做得很好。 尽管他们疲惫不堪，食不果腹，但仍如狗急跳墙一般坚持奋战。 当你们撤回到 %objective%的城墙外时，你听到远处密道被封住的声音。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的！",
					function getResult()
					{
						this.Flags.set("IsSecretPassage", false);
						this.Flags.set("IsReliefAttackForced", true);
						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(15, 30));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ReliefAttack",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_90.png[/img]{%commander%的侦察兵带回了消息，一支援军正在赶来并试图帮 %objective% 解围。指挥官点头并命令他的士兵们准备战斗。 你也做了同样的事。 | 正在周围待命时，一些侦察兵回到了 %commander%的帐篷。 你跟随他们一起进来，看到指挥官正在点着头收拾他的东西。 他看着你解释道。%SPEECH_ON%一支援军正在赶来。 他们正试图解围。 让你的人准备就绪。%SPEECH_OFF% | {你看到 %randombrother% 正在和一名正规军扳手腕。 他们用一只无头鸡当赌注。 获胜者可以饱餐一顿，失败者只能胳膊发酸。 | 一名围城的士兵和 %randombrother% 正准备展开一场竞赛。 谁先眨眼，谁就输了。 获胜者将赢得一只鸡。 | 你看到 %randombrother% 将一块大石头扔到烂泥里的一根木桩旁。 围城部队的一名士兵也做了同样的事。 显然他们正在为了赢得一只鸡而比赛，他们马上要进行决胜局的最后一掷了。} 他们正准备开始，一名侦察兵冲进了营地汇报说，一支军队正在赶来，试图帮 %objective% 解围。%commander% 命令他的人做好准备 你复述给 %companyname%。 | %commander%的侦察兵带回了消息称，一支军队正在赶来，试图帮 %objective% 解围。你命令 %companyname% 为一场大战做好准备。 | 一场大战即将来临：%commander%的侦察兵带回了消息称，一支援军正在赶来并试图解围。做好准备！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备战斗！",
					function getResult()
					{
						this.Contract.spawnReliefForces();
						this.Contract.setState("Running_ReliefAttack");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ReliefAttackAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_86.png[/img]{援军已经被击溃并退出了战场。%objective%的守军无疑看到了整场战斗，士气遭到了打击。 他们投降可能只是时间问题！ | 万岁！援军已经被基本解决了。%commander% 感谢你的帮助。 他拿起用皮革包裹的望远镜，微笑着望向 %objective%的城墙。%SPEECH_ON%喔，他们乱作一团。 他们看到了全部场面。 我这辈子从未看到过这么绝望的一群人。%SPEECH_OFF%他拍着你的肩膀咧开嘴笑着。%SPEECH_ON%佣兵，我觉得这场围攻已经快结束了！%SPEECH_OFF% | 你设法击溃了这支援军！ 这可能是 %objective% 最后的希望，现在他们随时可能投降。 | %commander% 感谢你帮忙摧毁了援军。 他认为现在 %objective% 随时可能投降。 | 看着世上唯一的希望被粉碎，对部队士气来说不是什么好事。%objective%的守军正巧目睹他们的援军被赶尽杀绝，无疑他们现在已经处于投降的边缘。 | 好吧，%objective% 最后的伟大的希望，已经被彻底击溃了。 你同 %commander% 汇合并一致认为：守军无疑已经准备投降了。 这只是时间问题。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "他们不可能一直撑下去。",
					function getResult()
					{
						this.Flags.set("IsReliefAttackForced", false);

						if (this.Flags.get("IsSurrender"))
						{
							this.Flags.set("IsSurrenderForced", true);
						}
						else if (this.Flags.get("IsDefendersSallyForth"))
						{
							this.Flags.set("IsDefendersSallyForthForced", true);
						}

						this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(10, 20));
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Surrender",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]%objective% 投降了！\n\n{你穿过大门，发现保卫者横七竖八地散落在周围。饥饿的人们身体痛苦地弯曲着，有些人依靠在墙上，嘴唇干裂，乞求着水。没有任何动物还活着，它们都已被屠杀。黑鸟从墙上凝视着你，加入了你们的征服，并等待着掠夺的机会。%commander%拍了拍你的肩膀，并感谢你的帮助。 | 前门发出咔嚓声打开了，你像胜利者一样走了进去。然而，内部的情景应该消除任何打败这些可怜人的荣誉观念。死亡的保卫者被堆在一个角落里。有几个男人被钉在十字架上，因为他们吃人肉，但甚至那些被处决的人也显示出被食用的迹象。庭院的一侧有一个被烧毁的谷仓。一些人嘴里是黑的，显然已经试图狼吞虎咽地吃下烧焦的谷粒残骸。每一只动物都被屠杀并剥尽了骨头。}\n\n%commander%嘲笑着这一幕，并命令他的士兵开始给囚犯戴上镣铐。他转向你。%SPEECH_ON%谢谢你，佣兵。现在你可以回到%employer%那里了。%SPEECH_OFF% | 在营地里，你看到防御者们站成一列。%commander%的两个士兵正在沿着队列走下去，一个拖着链子，另一个把链子接过来用来给囚犯戴上镣铐。你看到一个尸体被穿刺在一个马厩的上方，风标刺穿了他的胸膛，将他的心脏带在上面，就像某种仪式性的结局一样。%commander%笑着走过来。%SPEECH_ON%那是他们的中尉。{%SPEECH_ON%他们说他拒绝投降，而是从塔上跳下来死了。 | 显然，他拒绝投降，所以他的部下把他从塔上扔了下去。}%SPEECH_OFF%有趣。那么，%employer%会很高兴再次见到你的。 | 在墙外，%commander%的士兵们正在拿走防御者们的武器，将它们扔进一个大堆积木中。防御者们自己则聚集在一个角落里，每个人都被镣铐缚在背后，低着头，眼睛盯着泥土。几个警卫看守着他们，偶尔会踢他们、吐口水，甚至威胁要杀了他们。真是有趣的玩笑。\n\n%commander% 走过来拍了拍你的背。%SPEECH_ON%做得好，佣兵。你的帮助非常受用。回到%employer%那里去吧。你在这里完成了你的工作。%SPEECH_OFF% | 走过大门时，你发现那些防御者在乞求怜悯。他们的中尉已经死在泥里，还在不断流血。一个人解释道。%SPEECH_ON%我们早就想投降了，但他不让我们！你们必须要理解！我们不想再继续这个战争了。%SPEECH_OFF%%commander%在你旁边走过，点了点头。%SPEECH_ON%你的工作完成了，佣兵。去看看%employer%吧。%SPEECH_OFF%你问他会怎么处理俘虏。他耸了耸肩。%SPEECH_ON%不知道。我想我会先吃点东西。或许写封信给我所爱的人。我试着不冲动。%SPEECH_OFF%说得也对。 | 你与队长走过打开的大门。里面，一些幸存的防御者正在瘫坐着，跪在地上乞讨食物。他们几乎无法抬起身体去乞讨，他们的胃疼得难受。%SPEECH_ON%求求你们……救救我们……%SPEECH_OFF%%commander%把脚放在其中一人身上，把他推倒在地。%SPEECH_ON%我们看起来像是来帮助你们的吗？%SPEECH_OFF%队长转向你。%SPEECH_ON%干得好，佣兵。回去找%employer%吧，你在这里的工作已经完成了。%SPEECH_OFF% | 穿过门，你发现防御者正在被赶到一个角落里。%commander%问他们的领袖是哪个。这群人一致指向庭院对面。一名尸体被吊在其中一座塔上，脸色苍白，手和鼻子都发紫。其中一名囚犯解释道。%SPEECH_ON%如果不是我们，你们仍然会在外面，而我们仍然会在这里挨饿。%SPEECH_OFF%%commander%点点头。%SPEECH_ON%好吧。我不会惩罚你们所有人。佣兵！你回去找%employer%吧，你在这里的工作已经完成了。%SPEECH_OFF% | 穿过门，你看到堡垒的指挥官挥舞着长剑，%commander%的几个手下用长矛把他逼到了角落。他们一拥而上，像对待野兽一样把他给刺穿了。被箭杆卡住，他自认失败，向前跪倒在地，好像慵懒地靠在某些栅栏上一样。%SPEECH_ON%好吧，我想你们这些混蛋得手了。%SPEECH_OFF%他转向他的人，似乎是他们实际上打开了城门。%SPEECH_ON%我会在下一辈子见到你们这些人的。%SPEECH_OFF%他口中喷出鲜血，身体颤动了一下，就此不再动弹。士兵们取回长矛，领袖直接跌落泥潭。%commander%站在他身上，对你说道。%SPEECH_ON%好了，佣兵。回去见%employer%吧。%SPEECH_OFF% | 要塞的内部是个恐怖之地。人们蜷缩在一起捂着自己的腹部，有些人已经死亡，有些人则希望他们也已经死了。地方指挥官被吊在一座塔上，家族的旗帜缠在他的脖子上，好像这能为他的死带来一些尊严。动物骨头散布在院子里，到处都是粪便、尿液和呕吐物。%commander% 来到你的身旁点点头。%SPEECH_ON%看起来没错。可惜他们没有早点投降。%SPEECH_OFF%你暗示着那个死去的中尉挂在自己的军旗下才是阻止投降的原因。指挥官再次点头。%SPEECH_ON% 是啊，他认为这是光荣的事情。也许我以前也会这样做，但是看到了这一幕之后，我不再那么确定他是对的了。%SPEECH_OFF% | 穿过大门，你发现守卫们聚集在一座礼拜场所外。他们剩下的不多，也没有一个人在祈祷。尸体已经被堆在一个角落，而且有食人的证据。附近没有任何动物。马厩里苍蝇又多又吵。猪圈也被踩得乱七八糟。其中一名囚犯抬头看着你。%SPEECH_ON%我们吃了我们能吃的一切。你懂吗？我们。吃。光。了。所有。我们。能够吃到的所有东西。%SPEECH_OFF%%commander% 走到你身边。%SPEECH_ON%别被他们打扰了，佣兵。赶快回去找你的雇主。毫无疑问，他在等着你。%SPEECH_OFF% | 你和[队长]%commander%穿过前门。门内的守卫早已是黄花菜一般，蹒跚地四处摇摆。一个抓住了你的肩膀。%SPEECH_ON%食物！食物！%SPEECH_OFF%他的呼吸散发着可怕的饥饿气息。你把他扔到地上，他大声哭泣，并开始往嘴里塞泥巴。[队长]%commander%一边咀嚼着一片涂了黄油的面包一边来到你身边。%SPEECH_ON%这些家伙看起来真是可怜啊，是吧？%SPEECH_OFF% 面包屑从他嘴里喷出来，囚犯们盯着它们就像盯着金子一样。[队长]%commander%拍了拍你的肩膀。%SPEECH_ON%赶紧回到%employer%那，他会很高兴听到这个好消息的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%objective% 已经陷落！",
					function getResult()
					{
						this.Contract.changeObjectiveOwner();
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "DefendersSallyForth",
			Title = "在围城中…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{一阵响亮的喊杀声压过了攻城营地的喧嚣。 你向外望去，看到 %objective% 的城门打开了，一群人跑了出来。%commander% 冲出他的帐篷，瞧了一眼，随后开始朝他的士兵吼叫。%SPEECH_ON%突围了！突围了！他们来了，伙计们，他们来了！ 做好准备！杀光这些狗杂种，你们听清楚了吗？%SPEECH_OFF%攻城营地里忙碌起来准备应战。 你迅速集合 %companyname% 并准备加入战斗。 | %objective% 的守军们突围了出来！ 你命令你的人做好准备加入 %commander% 的战斗。 | 那里没有任何人投降！ %objective% 的守卫突围了出来。 他们看起来是一群虚弱和饥肠辘辘的人，但是看来他们宁愿死在这里也不愿投降。%commander% 让他的士兵们准备就绪，你们也这样做 %companyname%。 | %objective% 的城门打开了！ 一开始没什么动静，随后传来了一阵低沉的吼声，一小群守军开始冲了出来。 他们振臂高呼，高唱着家族的战歌。 他们用歌声向你们逼近，你们将以武力奉还。战斗！ | 攻城营地里传来了一阵尖锐的生锈的铰链声。 你朝 %objective% 望去，看到的城门缓缓打开。 一群人拿着旗帜和武器冲了出来。 他们看起来像一群残兵败将，饥肠辘辘地蹒跚向前。%commander% 摇摇头。%SPEECH_ON%这些蠢货。他们为什么就不投降呢？%SPEECH_OFF%你耸耸肩转向 %companyname%。%SPEECH_ON%如果他们想死，那就成全他们吧。拿起武器，伙计们！%SPEECH_OFF% | %randombrother% 来到你身旁指着城门后的 %objective%。%SPEECH_ON%看，先生。%SPEECH_OFF%你看着城门缓缓打开。 一队士兵摇摇晃晃地走出来。 他们并没有扛着白旗，而是扛着他们家族的家徽。 你跑去告诉 %commander% 守军正在向外突围。他点头。%SPEECH_ON%我知道他们是一群顽强的家伙，但这真得很可悲。 没有人该这样无谓的死去。%SPEECH_OFF%你差点想说，如果照这么讲，那么所有人第一时间就不应该出现在这儿，参与这种破事。 然而，你忍住没有开口，出去和 %companyname% 的人一起准备战斗。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们做个了结吧！",
					function getResult()
					{
						local tile = this.Contract.m.Origin.getTile();
						this.World.State.getPlayer().setPos(tile.Pos);
						this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "DefendersSallyForth";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Contract.flattenTerrain(p);
						p.Entities = [];
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall()
						];
						p.EnemyBanners = [
							this.Contract.m.Origin.getOwner().getBannerSmall()
						];
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.getFaction(),
							Callback = this.Contract.onCommanderPlaced.bindenv(this.Contract)
						});
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.m.Origin.getOwner().getID());
						p.Entities.push({
							ID = this.Const.EntityType.Knight,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/knight",
							Faction = this.Contract.m.Origin.getOwner().getID(),
							Callback = null
						});
						this.Contract.setState("Running_DefendersSallyForth");
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			],
			function start()
			{
				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null && e.isAlive())
					{
						e.die();
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "DefendersPrevail",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]难以置信的是，疲惫不堪的 %objective% 守军胜利了！ 随着围攻失败你撤出了战场。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这场围攻已经失败了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "失败于围攻 " + this.Flags.get("ObjectiveName"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DefendersAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_31.png[/img]{%objective% 的守军已经被歼灭，要塞城门大开。 你同 %commander% 走进敞开的城门，看到到处都是尸体，垃圾，和被宰杀的动物，一幅血淋淋的绝望的迹象。 指挥官点头拍着你的肩膀。%SPEECH_ON%做得好，佣兵。你现在应该回去找 %employer%，告诉他这个好消息。%SPEECH_OFF% | 战斗结束了，%objective% 的守军被彻底击溃，他们的要塞城门大开，等待被占领。%commander% 感谢你的效劳，随后宣告 %companyname% 可以离开战场。 你现在应当去见 %employer%，他一定非常高兴。 | %objective%的守军竭尽了全力，然而他们如果想要这样打下去，他们早应该在实力尚与勇气相当的数周前就如此。 现在已经无济于补了。被饿死的尸体看起来和被撑死的很相似，时间一久，他们看起来都一个样子。\n\n %commander% 过来告诉你说，他已经不需要 %companyname% 继续效力了。 你表示赞同，你现在应该回去找 %employer% 索取报酬。 | 在饱受饥饿，被无能将领拖累的情况下突围，绝不是一个好主意。 你不确定 %commander% 是否会宽恕投降的 %objective% 守军。 至于现在，他们全部死在了烂泥里，他们早已错过了投降的时机。 你集合 %companyname% 的伙计们，命令他们准备开拔回去见 %employer%。 明天将会是一个愉快的发薪日。 | 随着 %objective% 放弃抵抗，你同 %commander% 进入了要塞。 这些人这般绝望的原因是：他们的作战条件极为令人痛心。 死人被剥光后堆在了角落里。 一根烤肉扦子上残留着炙烤过的痕迹，可能烤过一头猪，但已经很难辨认出了，因为他们早已迅速地将那只动物瓜分得丝毫不剩。 一个吊死的人在塔楼上摇晃。 他们在他的胸前钉着一块木板，上面写着“食人者”，很可能是用他自己的血写的。\n\n %commander% laughs.%SPEECH_ON%这里看起来很热闹，不是吗？ 下次那些好战的副官一本正经地让你们坚持下去时，想想这个场景。%SPEECH_OFF% | %companyname% 和 %commander%的军队已经基本上击溃了突围的 %objective% 守军。随着要塞无人把守，%commander%的士兵迅速占领了它。 指挥官亲自来告诉你，去找 %employer% 领取酬劳。 | %objective%的守军死了战场上，但这在某种意上算是幸运的。 在他们要塞的城墙后面，几乎不剩什么有价值的东西了，尤其是完全没有了食物。 城墙后面的世界仿佛已不知食物为何物，守军们已经将这里吃得颗粒不剩。 你确信仅仅是提到食物对这些人来说已过于残酷，甚至是一个关于味道的词汇都像鞭打着肚子一般折磨人。%commander% 来到你身旁笑道。%SPEECH_ON%我想我知道饥饿是什么感觉，但我一直有解决的方法，你知道吗？ 我从不在走投无路的时候让自己挨饿。 太可怕了。 但是话又说回来，他们最终找到出路了，不是吗？%SPEECH_OFF%你点头，看着这个男人被自己的黑色幽默逗笑。%SPEECH_ON%你做得很好，佣兵。 去见 %employer% 吧，他会给你丰厚的酬劳的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "%objective% 已经陷落！",
					function getResult()
					{
						this.Contract.changeObjectiveOwner();
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Prisoners",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_53.png[/img]{你的几个人设法俘虏一些 %objective%的守军。 他们挤着站在一起，被你的佣兵们用武器拦着。 一些人的脚在靴子里发抖。 其中一个人甚至没穿靴子。 另一个人吓尿了裤子。%randombrother% 询问如何处置他们。 | %randombrother% 汇报说一些 %objective% 的守军已经被俘虏了。 你恰巧看到一群人挤着站在一起，抱紧了双臂，低着头。一个人大喊。%SPEECH_ON%求求你，不要杀我们！ 我们只是在奉命行事，就和你们一样！%SPEECH_OFF% | 你的人设法俘虏了一些 %objective%的守军。 他们被围了起来，脱得只剩底裤，被命令脸朝着地。%randombrother% 询问如何处置他们。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "放他们走。%rivalhouse% 或许会领了这份好意。",
					function getResult()
					{
						return "PrisonersLetGo";
					}

				},
				{
					Text = "他们可能还有些价值。 把他们带给 %commander% 当战俘。",
					function getResult()
					{
						return "PrisonersSold";
					}

				},
				{
					Text = "与其在以后的战斗中再面对他们，不如现在就杀了他们。",
					function getResult()
					{
						return "PrisonersKilled";
					}

				}
			],
			function start()
			{
				this.Flags.set("IsPrisoners", false);
			}

		});
		this.m.Screens.push({
			ID = "PrisonersLetGo",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_53.png[/img]{战俘对你们或其他任何人来说都毫无用处。 你放了他们，希望自己不会为这个决定后悔。 | 你放了战俘。 他们哭着感谢你，但你只希望这么做不会铸成大错。 | 你把战俘放走了。 他们离开前挨个感谢你，希望和你们永不重逢。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "今天死的人够多了。",
					function getResult()
					{
						this.World.Assets.addMoralReputation(2);
						this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID")).addPlayerRelation(5.0, "让他们的人在战斗结束后自由");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "PrisonersKilled",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_53.png[/img]{你对着 %randombrother%点头。%SPEECH_ON%杀死他们。%SPEECH_OFF%战俘们站了起来，但是他们已经毫无生路。 他们被逐一屠杀了。 | 这些带着镣铐的人没有什么用处，但是如果他们获得自由，很可能改日会回来与你再战。 你下令处决他们，随之而来的是一阵疯狂的乞求声和割喉的声音。 | 在这样的战争中，没有食物和住所来提供给这些战俘，并且当你还在敌方的领土上时，要他们无用。 但如果你放走了他们，很可能他们改日又会对你刀剑相向。\n\n 想到这里，你下令处决他们。 抗议的声音稍纵即逝，淹没在了喉咙被割破和砍断的咕噜声中。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们还有更重要的事情…",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-2);

						if (this.World.FactionManager.isCivilWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "PrisonersSold",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_53.png[/img]{你把俘虏们带给 %commander%。这些人排成一列，指挥官在四周来回走动。%SPEECH_ON%这一个。这一个。 他。还有他。剩下的都杀了。%SPEECH_OFF%人群中那些乍一看最能派上用场的，成为了幸运儿，被拉到了前面。 其余的都被长矛穿膛而死。%commander% 递给你一些克朗。%SPEECH_ON%感谢你抓到他们。 他们会被用来做苦力。%SPEECH_OFF% | 俘虏们被带给 %commander%。 他下令把这些人铐起来并安排去做苦力。 指挥官付给你一笔可观的费用，作为这些俘虏的酬劳。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们还有更重要的事情…",
					function getResult()
					{
						this.World.Assets.addMoney(250);
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]250[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你向 %employer% 汇报说 %objective% 已经被夺取并在控制之下。 这个人用手遮住他得意的笑容，故作镇静，仿佛贵族不应屈尊于凡夫的喜悦。 他只是点了点头，仿佛这个消息早在预料之中。%SPEECH_ON%很好。很好。当然了。%SPEECH_OFF%这个男人打了一个响指，一名仆人递给你了一个装着 %reward_completion% 克朗的袋子。 | Entering %employer%'s room brings silence to a throng of commanders, lieutenants, and the nobleman himself. 他挺起身。%SPEECH_ON%我的线人已经汇报了占领 %objective% 的消息。你的报酬在外面。%SPEECH_OFF%这名领袖甚至都没有感谢你，尽管 %reward_completion% 克朗对你来说已经绰绰有余。 | %employer% 欢迎你来到他的作战室。 一群指挥官在桌子上的地图周围徘徊。 你看到他们把一个军事模型推到 %objective% 上。%employer% 咧嘴笑道。%SPEECH_ON%不能让这些人走漏风声，但我们为你所做的工作感到满意。 我的密探带给我的消息让我确信，我重金投资到你们这样的人身上是值得的。%SPEECH_OFF%这名贵族亲自给你一个装着 %reward_completion% 克朗的袋子。 | %employer%的房间里忙作一团。 指挥官们来回奔跑着相互争论，不论他们在房间的哪一头，或是彼此相隔了多远，仆人们来回穿梭躲避，确保给他们周到地供奉酒食。 在战争中，没有时间把浪费精力在琐碎的事情上，比如说自己穿斗篷或是做饭。 你惊讶的发现，在他们争论时，并没有仆人用叉子喂东西到他们嘴里。\n\n 然而，%employer% 只是闲在一旁。 他翻着一本书，仿佛自己置身于一个鸟儿吱吱喳喳的花园。 他抬起头。先瞥了一眼他的将军们，然后看着你。%SPEECH_ON%做得好。这是你的酬劳。%SPEECH_OFF%一个箱子被慢慢推到你的胸前。里面装着 %reward_completion% 克朗。 | 一名仆人阻拦你进入 %employer%的房间。他解释道。%SPEECH_ON%我奉命在这里见你，带给你这个装着 %reward_completion% 克朗的袋子。%SPEECH_OFF%你拿了袋子并点头。 | 你试图进入 %employer%的房间，但是一名警卫拦住了你。%SPEECH_ON%只许贵族进入。%SPEECH_OFF%你把警卫的长戟从脸上推开，表示你和 %employer% 有生意要谈。 警卫放下了长戟。%SPEECH_ON%只许贵族进入。%SPEECH_OFF%正当你准备开始争吵，一名仆人从屋里踏了出来，带着一个大袋子。 他看到 %companyname% 的徽章，把袋子递给你。%SPEECH_ON%你的 %reward_completion% 克朗。恐怕我的领主和指挥官们现在很忙。%SPEECH_OFF%说完仆人就走了。 警卫盯着你。%SPEECH_ON%只许贵族进入。%SPEECH_OFF% | 帮助攻下 %objective% 的奖赏是 %reward_completion% 克朗，和砰的一声在你面前关上的门。%employer% 正忙于和他的指挥官们争论，以至于没有给你任何额外的道贺。 | 一名 %employer%的指挥官与你在大厅见面。 他带着一名仆人，仆人身上挎着一个大袋子。这名指挥官说道。%SPEECH_ON%啊，%companyname%。干你们这一行的没有什么荣誉可言，佣兵。 你应该成为一个真正的男人，和贵族们并肩作战。 我们的工作无上光荣。 你为什么不加入我们？%SPEECH_OFF%一大袋的 %reward_completion% 克朗递到了你的手上。 你向这名指挥官报以微笑，牙齿上环绕着金色的反光。%SPEECH_ON%是的，为什么呢？%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "%objective%陷落了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "参加围攻 " + this.Flags.get("ObjectiveName"));
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
		this.m.Screens.push({
			ID = "Failure",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]真是一场灾难。战斗失败了，你为了保全剩下的人而撤退。%objective% 近期之内不会再被攻陷了。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死的地方！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "失败于围攻 " + this.Flags.get("ObjectiveName"));
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TooFarAway",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_36.png[/img]{时间的流失似乎已让你望而却步。 尽管你不在，围攻仍然再继续，但最终因没有获得预期的 %companyname% 的帮助，围攻宣告失败。不用再费事回去见 %employer%。 | 你被雇佣来协助围攻，而不是放弃围攻。 没有 %companyname% 的协助，士兵们可能不得不撤出战场。 | 你离攻城范围太远了！ 没有你的帮助，进攻方不得不撤退，%objective% 幸免了 %employer%的攻占。 考虑到这正是你被雇佣来要帮助完成的任务，你最好还是别回去见那名贵族了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "没错，围攻是在这里进行的…",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnReliefForces()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 8, originTile.SquareCoords.X + 8);
			local y = this.Math.rand(originTile.SquareCoords.Y - 8, originTile.SquareCoords.Y + 8);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(tile, this.m.Origin.getOwner().getName() + " Army", true, this.Const.World.Spawn.Noble, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyFaction.getBannerString());
		party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
		party.setDescription("为地方领主服务的专业士兵。");
		party.setFootprintType(this.Const.World.FootprintsType.Nobles);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 5);
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

		party.setAttackableByAI(false);
		this.m.UnitsSpawned.push(party.getID());
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(10.0);
		c.addOrder(wait);
	}

	function spawnSupplyCaravan()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 7, originTile.SquareCoords.X + 7);
			local y = this.Math.rand(originTile.SquareCoords.Y - 7, originTile.SquareCoords.Y + 7);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (!tile.HasRoad)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(tile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, this.Math.rand(100, 150));
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("一个带有武装护卫的商队，在定居点之间运输着值得保护的东西。");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.addToInventory("supplies/ground_grains_item");
		party.getLoot().Money = this.Math.rand(0, 100);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		move.setRoadsOnly(true);
		c.addOrder(move);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(despawn);
	}

	function spawnSiege()
	{
		this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));

		foreach( a in this.m.Origin.getActiveAttachedLocations() )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				a.spawnFireAndSmoke();
				a.setActive(false);
			}
		}

		local f = this.World.FactionManager.getFaction(this.getFaction());
		local castles = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				castles.push(s);
			}
		}

		if (castles.len() == 0)
		{
			castles = clone f.getSettlements();
		}

		local originTile = this.m.Origin.getTile();
		local lastTile;

		for( local i = 0; i < 2; i = ++i )
		{
			local tile;

			while (true)
			{
				local x = this.Math.rand(originTile.SquareCoords.X - 1, originTile.SquareCoords.X + 1);
				local y = this.Math.rand(originTile.SquareCoords.Y - 1, originTile.SquareCoords.Y + 1);

				if (!this.World.isValidTileSquare(x, y))
				{
					continue;
				}

				tile = this.World.getTileSquare(x, y);

				if (tile.getDistanceTo(originTile) == 0)
				{
					continue;
				}

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					continue;
				}

				if (i == 0 && !tile.HasRoad && !this.m.Origin.isIsolatedFromRoads())
				{
					continue;
				}

				if (lastTile != null && tile.ID == lastTile.ID)
				{
					continue;
				}

				break;
			}

			lastTile = tile;
			local party = f.spawnEntity(tile, castles[this.Math.rand(0, castles.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Noble, castles[this.Math.rand(0, castles.len() - 1)].getResources());
			party.setDescription("为地方领主服务的专业士兵。");
			party.setVisibilityMult(2.5);

			if (i == 0)
			{
				party.getSprite("body").setBrush("figure_siege_01");
				party.getSprite("base").Visible = false;
			}
			else
			{
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
			}

			party.setAttackableByAI(false);
			this.m.UnitsSpawned.push(party.getID());
			this.m.Allies.push(party.getID());
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 5);
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
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			local wait = this.new("scripts/ai/world/orders/wait_order");
			wait.setTime(9000.0);
			c.addOrder(wait);
		}
	}

	function changeObjectiveOwner()
	{
		if (this.m.Origin.getFactionOfType(this.Const.FactionType.Settlement) != null)
		{
			this.m.Origin.getOwner().removeAlly(this.m.Origin.getFactionOfType(this.Const.FactionType.Settlement).getID());
		}

		this.m.Origin.removeFaction(this.m.Origin.getOwner().getID());
		this.World.FactionManager.getFaction(this.getFaction()).addSettlement(this.m.Origin.get());

		if (this.m.Origin.getFactionOfType(this.Const.FactionType.Settlement) != null)
		{
			this.World.FactionManager.getFaction(this.getFaction()).addAlly(this.m.Origin.getFactionOfType(this.Const.FactionType.Settlement).getID());
		}

		if (this.m.SituationID != 0)
		{
			this.m.Origin.removeSituationByInstance(this.m.SituationID);
			this.m.SituationID = 0;
		}

		this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/conquered_situation"), 3);
	}

	function flattenTerrain( _p )
	{
		if (_p.TerrainTemplate == "tactical.hills_steppe")
		{
			_p.TerrainTemplate = "tactical.steppe";
		}
		else if (_p.TerrainTemplate == "tactical.hills_tundra")
		{
			_p.TerrainTemplate = "tactical.tundra";
		}
		else if (_p.TerrainTemplate == "tactical.hills_snow" || _p.TerrainTemplate == "forest_snow")
		{
			_p.TerrainTemplate = "tactical.snow";
		}
		else if (_p.TerrainTemplate == "tactical.hills" || _p.TerrainTemplate == "tactical.mountain")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.hills" || _p.TerrainTemplate == "tactical.mountain")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.forest_leaves" || _p.TerrainTemplate == "tactical.forest" || _p.TerrainTemplate == "tactical.autumn")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
		else if (_p.TerrainTemplate == "tactical.swamp")
		{
			_p.TerrainTemplate = "tactical.plains";
		}
	}

	function onCommanderPlaced( _entity, _tag )
	{
		_entity.setName(this.m.Flags.get("CommanderName"));
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Flags.get("ObjectiveName")
		]);
		_vars.push([
			"noblefamily",
			this.World.FactionManager.getFaction(this.getFaction()).getName()
		]);
		_vars.push([
			"rivalhouse",
			this.m.Flags.get("RivalHouse")
		]);
		_vars.push([
			"commander",
			this.m.Flags.get("CommanderName")
		]);
		_vars.push([
			"direction",
			this.m.Origin == null || this.m.Origin.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Origin.getTile())]
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( id in this.m.UnitsSpawned )
			{
				local e = this.World.getEntityByID(id);

				if (e != null && e.isAlive())
				{
					local c = e.getController();
					c.clearOrders();

					if (e.isAlliedWithPlayer())
					{
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(60.0);
						c.addOrder(wait);
					}
				}
			}

			if (this.m.Origin != null && !this.m.Origin.isNull())
			{
				this.m.Origin.getSprite("selection").Visible = false;
				this.m.Origin.setOnCombatWithPlayerCallback(null);
				this.m.Origin.setAttackable(false);
			}

			if (this.m.Home != null && !this.m.Home.isNull())
			{
				this.m.Home.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(2);
			}
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return false;
		}

		if (this.m.Origin == null || this.m.Origin.isNull() || this.m.Origin.getFaction() == this.getFaction())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
		_out.writeU8(this.m.Allies.len());

		foreach( ally in this.m.Allies )
		{
			_out.writeU32(ally);
		}
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
		local numAllies = _in.readU8();

		for( local i = 0; i < numAllies; i = ++i )
		{
			this.m.Allies.push(_in.readU32());
		}
	}

});

