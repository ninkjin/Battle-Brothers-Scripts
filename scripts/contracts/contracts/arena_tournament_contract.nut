this.arena_tournament_contract <- this.inherit("scripts/contracts/contract", {
	m = {},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = 1.3;
		this.m.Type = "contract.arena_tournament";
		this.m.Name = "竞技场锦标赛(The Arena Tournament)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		local items = [];
		items.extend(this.Const.Items.NamedWeapons);
		items.extend(this.Const.Items.NamedHelmets);
		items.extend(this.Const.Items.NamedArmors);
		local item = this.new("scripts/items/" + items[this.Math.rand(0, items.len() - 1)]);
		this.m.Flags.set("PrizeName", item.createRandomName());
		this.m.Flags.set("PrizeScript", item.ClassNameHash);

		if (item.isItemType(this.Const.Items.ItemType.Weapon))
		{
			this.m.Flags.set("PrizeType", "weapon");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Shield))
		{
			this.m.Flags.set("PrizeType", "shield");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Armor))
		{
			this.m.Flags.set("PrizeType", "armor");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Helmet))
		{
			this.m.Flags.set("PrizeType", "helmet");
		}

		this.m.Flags.set("Round", 1);
		this.m.Flags.set("RewardApplied", 0);
		this.m.Flags.set("Opponents1", this.getOpponents(1).I);
		this.m.Flags.set("Opponents2", this.getOpponents(2).I);
		this.m.Flags.set("Opponents3", this.getOpponents(3).I);
		this.contract.start();
	}

	function getOpponents( _round, _index = -1 )
	{
		local twists = [];

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}
				}

			});
		}

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.BanditRaider, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.BanditRaider);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.MasterArcher, true);
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				}

			});
		}

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Executioner.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Executioner.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Executioner.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost - this.Const.World.Spawn.Troops.DesertStalker.Cost); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 2); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 4); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}
				}

			});
		}

		if (_round == 3 && this.Const.DLC.Unhold)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Unhold, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Unhold);
					}
				}

			});
		}

		if (_round == 3 && this.Const.DLC.Lindwurm)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < this.Math.min(3, _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Lindwurm, _d)); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Lindwurm);
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.SandGolemMEDIUM, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.SandGolemMEDIUM);
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				}

			});
		}

		if (_round == 1 && this.Const.DLC.Unhold)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Spider, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Spider);
					}
				}

			});
		}

		if (_round <= 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				}

			});
		}

		if (_round == 1)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Serpent, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Serpent);
					}
				}

			});
		}

		if (_round == 1)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.HyenaHIGH, _d); i = ++i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.HyenaHIGH);
					}
				}

			});
		}

		if (_index >= 0)
		{
			return {
				I = _index,
				F = twists[_index].F
			};
		}
		else
		{
			local maxR = 0;

			foreach( t in twists )
			{
				maxR = maxR + t.R;
			}

			local r = this.Math.rand(1, maxR);

			foreach( i, t in twists )
			{
				if (r <= t.R)
				{
					return {
						I = i,
						F = t.F
					};
				}
				else
				{
					r = r - t.R;
				}
			}
		}
	}

	function startTournamentRound()
	{
		local p = this.Const.Tactical.CombatInfo.getClone();
		p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
		p.CombatID = "Arena";
		p.TerrainTemplate = "tactical.arena";
		p.LocationTemplate.Template[0] = "tactical.arena_floor";
		p.Music = this.Const.Music.ArenaTracks;
		p.Ambience[0] = this.Const.SoundAmbience.ArenaBack;
		p.Ambience[1] = this.Const.SoundAmbience.ArenaFront;
		p.AmbienceMinDelay[0] = 0;
		p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.IsUsingSetPlayers = true;
		p.IsFleeingProhibited = true;
		p.IsLootingProhibited = true;
		p.IsWithoutAmbience = true;
		p.IsFogOfWarVisible = false;
		p.IsArenaMode = true;
		p.IsAutoAssigningBases = false;
		local bros = this.getBros();

		for( local i = 0; i < bros.len() && i < 5; i = ++i )
		{
			p.Players.push(bros[i]);
		}

		p.Entities = [];
		local baseDifficulty = 45 + 10 * this.m.Flags.get("Round");
		baseDifficulty = baseDifficulty * this.getScaledDifficultyMult();
		local opponents = this.getOpponents(this.m.Flags.get("Round"), this.m.Flags.get("Opponents" + this.m.Flags.get("Round")));
		opponents.F(this, baseDifficulty, p.Entities);

		for( local i = 0; i < p.Entities.len(); i = ++i )
		{
			p.Entities[i].Faction <- this.getFaction();
		}

		this.World.Contracts.startScriptedCombat(p, false, false, false);
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"让你的最多五名部队成员装备竞技场项圈。",
					"再次进入竞技场，开始第一轮。",
					"每一轮战斗将是决斗，你将不能撤退或在之后搜刮。",
					"每回合结束后，你可以选择退出比赛并获得一些安慰奖励，或者立即开始下一轮。"
				];
				this.Contract.m.BulletpointsPayment = [
					"获得一个命名为%prizename%的传奇%prizetype%作为在三轮中获胜的奖励。"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.Flags.set("Day", this.World.getTime().Days);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Flags.get("Round") > 1 && this.Contract.getBros() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsFailure"))
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.World.getTime().Days > this.Flags.get("Day") + 1)
				{
					this.Contract.setScreen("Failure2");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("Round") > 1)
				{
					this.Contract.setScreen("Won" + this.Flags.get("Round"));
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.increment("Round");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.set("IsFailure", true);
				}
			}

		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Task",
			Title = "在竞技场",
			Text = "",
			Image = "",
			List = [],
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们将赢得大奖!}",
					function getResult()
					{
						return "Overview";
					}

				},
				{
					Text = "{我们还没有准备好。}",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						return 0;
					}

				}
			],
			function start()
			{
				this.Text = "[img]gfx/ui/events/event_155.png[/img]数十名男子在竞技场入口处闲逛。有些人沉默不语，不想暴露出他们的能力。然而，其他人则毫不掩饰地吹嘘自己的功夫，或是希望自己的虚张声势掩盖他们的短板。";
				this.Text += "队长, 通常是你见过的最不感兴趣的有趣工作的人, 今天实际上相当活跃。他一只手拿着一卷卷轴，另一只手竖起三根手指。%SPEECH_ON%三轮！三轮比赛，接连不断，每一轮比上一轮更难。用相同的五个人赢得所有三轮比赛，赢得一项名为 %prizename% 的著名%prizetype%大奖！那是一项锦标赛！你想要参加吗？%SPEECH_OFF%";
				this.Text += "竞技场主继续说道。%SPEECH_ON%准备好后，让那些将参加战斗的人戴上我们提供的竞技场项圈。%SPEECH_OFF%";
			}

		});
		this.m.Screens.push({
			ID = "Overview",
			Title = "Overview",
			Text = "这个竞技场锦标赛如下所示。你同意这些条件吗？",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们进入比赛！",
					function getResult()
					{
						for( local i = 0; i < 5; i = ++i )
						{
							this.World.Assets.getStash().add(this.new("scripts/items/accessory/special/arena_collar_item"));
						}

						this.Contract.setState("Running");
						return 0;
					}

				},
				{
					Text = "我得考虑一下。",
					function getResult()
					{
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}

		});
		this.m.Screens.push({
			ID = "Start",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_155.png[/img]{等待轮到你的时候，人群的嗜血之情在黑暗中传播，灰尘从头顶落下，脚步声如雷鸣。他们期待着，杀戮声中狂欢。战斗之间的静谧只有短暂的片刻，这份寂静随着生锈的大门上升而消失，铁链摩擦发出响声，人群再次嗡嗡作响。你走出光线，如此雷鸣般的声音撞击着你的心脏，即使是一具僵尸也会动荡不安。 | 竞技场的观众肩并肩，大部分都喝醉了。他们尖叫着吼叫着，语言上既有本地的，也有外来的，但他们的血腥欲望不需要过多的口胡，只要看着他们狂热的脸庞和挥舞的拳头。现在，%companyname%的士兵们将满足这些疯狂的笨蛋。 | 清洁工人在竞技场中匆忙前行。他们拖走尸体，收集值得收集的东西，偶尔会把奖杯扔到人群中，引发一个模仿竞技场战斗的暴民骚动。%companyname%现在也是这场盛宴的一部分。 | 竞技场在等待，人群熊熊燃烧，%companyname%的胜利之际已经到来！ | 当%companyname%的士兵走进这个充满鲜血的坑时，人群轰鸣。尽管人民的快感来自于无意识的嗜血之情，但你无法控制自己内心的一丝自豪感，因为你知道这是你的战团准备上演一场盛大的表演。 | 大门升起，除了锁链的响声、滑轮的吱嘎声和奴隶劳作的呻吟外，什么声音也听不见。当%companyname%的人们走出竞技场的深处时，他们能听到脚底下沙子的声响，直到他们站在沙坑中央。一个陌生的声音从体育场的顶部尖叫着，是一种你无法理解的语言，但这些话语在人群中回响了一次，然后观众们就爆发出欢呼和咆哮声。现在，你的人将在平民的警觉眼神下证明自己。 | %companyname%的事务很少在那些希望与这样的暴力事件保持距离的人眼前完成。但在角斗场，平民们渴望死亡和痛苦，当你的人进入沙坑时，他们发出咆哮声，并准备好战斗时，则发出动物般的怒吼。 | 角斗场的形状像一个伤口的坑，其天花板被神撕裂开来，揭示了人类的虚荣、嗜血和野蛮。在那里，人们尖叫着，如果鲜血四溅到他们身上，他们会用那污物洗脸并互相冲着笑，好像那是一场玩笑。他们为了奖杯而互相搏斗，并为他人的疼痛而狂欢。%companyname%将在这些人的面前战斗，他们将为他们提供娱乐，并提供精彩的表演。 | 竞技场的观众群是阶级的混合物，有富人和穷人，只有高级官员才会把自己分离成站台。在%townname%的人民暂时团结起来，慷慨地聚在一起观看男人和怪物相互屠杀。%companyname%很高兴能够尽自己的一份力。 | 小男孩坐在父亲的肩膀上，年轻的女孩向角斗士扔花，妇女扇着自己，男人们在想着是否也能够这样做。这就是竞技场的人民——其他人都喝醉了大醉，乱喊乱叫的。希望%companyname%能够为这个疯狂的群体贡献至少一两个小时的娱乐。 | 当%companyname%的人走上沙坑时，观众群发出震耳欲聋的欢呼声。一个傻瓜会把兴奋和渴望混淆在一起，因为一旦掌声结束，就会有一些空啤酒杯和臭烂的番茄，还有那些观看这件事情的人的大笑。你在想%companyname%的人是否真的最好在这里度过，但随后认真考虑了一下可以获得的金钱和荣耀，而且在这一天结束时，看台上的那些杂碎们会回家过他们一样的狗日子，而你也会回家过你的狗日子，但至少你的口袋会更加充实。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们赢得那个奖品吧！",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "我们不会接受的，我不想死！",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnArenaCancel);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Won2",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]{三场战斗中的第一场已经结束。你需要认真评估自己的士兵是否能够继续下一轮，而下一轮将比上一轮更加困难。就像你在坟墓中找不到自豪一样，离开并没有什么羞耻感。你仍然会得到一些硬币，但也会放弃赢取大奖的机会。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们也会赢得下一轮！",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "是时候退出这个锦标赛了。",
					function getResult()
					{
						return "DropOut";
					}

				}
			],
			function start()
			{
				if (this.Flags.getAsInt("RewardsApplied") < 2)
				{
					this.Flags.set("RewardsApplied", 2);
					this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

					if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
					{
						this.updateAchievement("Gladiator", 1, 1);
					}

					this.Contract.updateTraits(this.List);
				}

				this.Contract.m.BulletpointsObjectives = [
					"下一轮将自动开始。",
					"每一轮战斗将是决斗，你将不能撤退或在之后搜刮。",
					"每轮结束后，您可以选择退出或立即开始下一轮。"
				];
			}

		});
		this.m.Screens.push({
			ID = "Won3",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img] 战局进入了倒数第二位阶段，你可以选择放弃现在，或者继续战斗争取最终胜利。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "进入最后一轮！",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "是时候退出这个锦标赛了。",
					function getResult()
					{
						return "DropOut";
					}

				}
			],
			function start()
			{
				if (this.Flags.getAsInt("RewardsApplied") < 3)
				{
					this.Flags.set("RewardsApplied", 3);
					this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

					if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
					{
						this.updateAchievement("Gladiator", 1, 1);
					}

					this.Contract.updateTraits(this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Won4",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]战斗结束了，在你的耳边回荡的沉闷叫喊声是观众的欢呼，它压倒了所有的感官，让你沉浸在一片兴奋的爆炸中。你只是人民的化身，一个图腾，通过你，他们能够间接地激励自己的虚荣和英雄主义。除了人们的崇拜，你还得到了大奖：%prizename%！",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess * 2);
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("RewardsApplied", 4);
				this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

				if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
				{
					this.updateAchievement("Gladiator", 1, 1);
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new(this.IO.scriptFilenameByHash(this.Flags.get("PrizeScript")));
				item.setName(this.Flags.get("PrizeName"));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.Contract.updateTraits(this.List);
			}

		});
		this.m.Screens.push({
			ID = "DropOut",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]{你决定退出比赛，保留你的人以备再战。因为这是在竞技场里进行的，所以没有听到嘘声或嘶嘶声。这最多只是一个官方手续，支付一笔小额经济赔偿金就可以离开。没有人会为此悲伤，尤其不是来自其他角斗士，他们比任何人都更了解这个决定的意义。那么观众们呢？他们只想看到鲜血，他们甚至不会注意到哪些带着鲜血的身体已经离去。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "也许下次吧。",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				local money = (this.Flags.get("Round") - 1) * 1000;
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]{ %companyname% 的士兵被打败了，他们要么是痛快的死去, 或者更惨的是受到重伤而伤痕累累。但至少观众们很高兴。在竞技场下面，任何的表现，即使以死亡告终，都是好的表现。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "灾难！",
					function getResult()
					{
						local roster = this.World.getPlayerRoster().getAll();

						foreach( bro in roster )
						{
							local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

							if (item != null && item.getID() == "accessory.arena_collar")
							{
								bro.getFlags().increment("ArenaFights", 1);
							}
						}

						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "在竞技场",
			Text = "{[img]gfx/ui/events/event_155.png[/img]你的角斗比赛的时间已经到了，但你没有出现在那里。也许出现了更重要的事情，或者你只是像懦夫一样躲起来了。无论哪种情况，你的声誉都会因此受损。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "But...",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Collars",
			Title = "在竞技场",
			Text = "{[img]gfx/ui/events/event_155.png[/img] 竞技场比赛的时间到了，但是你的士兵们没有佩戴竞技场项圈，所以他们被禁止进入。\n\n你应该决定谁去参加比赛，通过给他们佩戴竞技场项圈，一旦你再次进入竞技场比赛就会开始。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "好, 就这样！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
	}

	function getBros()
	{
		local ret = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				ret.push(bro);
			}
		}

		return ret;
	}

	function updateTraits( _list )
	{
		local roster = this.World.getPlayerRoster().getAll();
		local n = 0;

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				local skill;
				bro.getFlags().increment("ArenaFightsWon", 1);
				bro.getFlags().increment("ArenaFights", 1);

				if (bro.getFlags().getAsInt("ArenaFightsWon") == 1)
				{
					skill = this.new("scripts/skills/traits/arena_pit_fighter_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 5)
				{
					bro.getSkills().removeByID("trait.pit_fighter");
					skill = this.new("scripts/skills/traits/arena_fighter_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 12)
				{
					bro.getSkills().removeByID("trait.arena_fighter");
					skill = this.new("scripts/skills/traits/arena_veteran_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}

				n = ++n;
			}

			if (n >= 5)
			{
				break;
			}
		}
	}

	function getAmountToSpawn( _type, _resources, _min = 1, _max = 24 )
	{
		return this.Math.min(_max, this.Math.max(_min, _resources / _type.Cost));
	}

	function addToCombat( _list, _entityType, _champion = false )
	{
		local c = clone _entityType;

		if (c.Variant != 0 && _champion)
		{
			c.Variant = 1;
		}
		else
		{
			c.Variant = 0;
		}

		if (c.Variant != 0 && "NameList" in _entityType)
		{
			c.Name <- this.Const.World.Common.generateName(_entityType.NameList) + (_entityType.TitleList != null ? " " + _entityType.TitleList[this.Math.rand(0, _entityType.TitleList.len() - 1)] : "");
		}

		_list.push(c);
	}

	function getScaledDifficultyMult()
	{
		local p = this.World.State.getPlayer().getStrength();
		p = p / this.World.getPlayerRoster().getSize();
		p = p * 12;
		local s = this.Math.maxf(0.75, 1.0 * this.Math.pow(0.01 * p, 0.95) + this.Math.minf(0.5, this.World.getTime().Days * 0.005));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function setScreenForArena()
	{
		if (!this.m.IsActive)
		{
			return;
		}

		if (this.getBros().len() == 0)
		{
			this.setScreen("Collars");
		}
		else if (this.World.getTime().Days > this.m.Flags.get("Day") + 1)
		{
			this.setScreen("Failure2");
		}
		else
		{
			this.setScreen("Start");
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"prizename",
			this.m.Flags.get("PrizeName")
		]);
		_vars.push([
			"prizetype",
			this.m.Flags.get("PrizeType")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
			this.m.Home.getBuilding("building.arena").refreshCooldown();
			local roster = this.World.getPlayerRoster().getAll();

			foreach( bro in roster )
			{
				local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

				if (item != null && item.getID() == "accessory.arena_collar")
				{
					bro.getItems().unequip(item);
				}
			}

			local items = this.World.Assets.getStash().getItems();

			foreach( i, item in items )
			{
				if (item != null && item.getID() == "accessory.arena_collar")
				{
					items[i] = null;
				}
			}
		}

		this.m.Home.removeSituationByID("situation.arena_tournament");
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

