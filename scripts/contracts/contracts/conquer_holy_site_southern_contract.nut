this.conquer_holy_site_southern_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Target = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.conquer_holy_site_southern";
		this.m.Name = "征服圣地";
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

		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();
		local target;
		local targetIndex = 0;
		local closestDist = 9000;
		local myTile = this.m.Home.getTile();

		foreach( v in locations )
		{
			foreach( i, s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0 && !this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
				{
					local d = myTile.getDistanceTo(v.getTile());

					if (d < closestDist)
					{
						target = v;
						targetIndex = i;
						closestDist = d;
					}
				}
			}
		}

		this.m.Destination = this.WeakTableRef(target);
		this.m.Destination.setVisited(true);
		local b = -1;

		do
		{
			local r = this.Math.rand(0, this.Const.PlayerBanners.len() - 1);

			if (this.World.Assets.getBanner() != this.Const.PlayerBanners[r])
			{
				b = this.Const.PlayerBanners[r];
				break;
			}
		}
		while (b < 0);

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

		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Flags.set("DestinationIndex", targetIndex);
		this.m.Flags.set("MercenaryPay", this.beautifyNumber(this.m.Payment.Pool * 0.5));
		this.m.Flags.set("Mercenary", this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		this.m.Flags.set("MercenaryCompany", this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)]);
		this.m.Flags.set("MercenaryBanner", b);
		this.m.Flags.set("Commander", this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)]);
		this.m.Flags.set("EnemyID", target.getFaction());
		this.m.Flags.set("MapSeed", this.Time.getRealTime());
		this.m.Flags.set("OppositionSeed", this.Time.getRealTime());
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"从北方异教徒手中征服%holysite%",
					"摧毁或击溃附近的敌方部队"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsAlliedArmy", true);
				}
				else if (r <= 40)
				{
					this.Flags.set("IsSallyForth", true);
				}
				else if (r <= 60)
				{
					this.Flags.set("IsMercenaries", true);
				}
				else if (r <= 80)
				{
					this.Flags.set("IsCounterAttack", true);
				}

				if (this.Contract.getDifficultyMult() >= 1.15)
				{
					this.Contract.spawnEnemy();
				}
				else if (this.Contract.getDifficultyMult() <= 0.85)
				{
					local entities = this.World.getAllEntitiesAtPos(this.Contract.m.Destination.getPos(), 1.0);

					foreach( e in entities )
					{
						if (e.isParty())
						{
							e.getController().clearOrders();
						}
					}
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
					this.Contract.m.Destination.setOnEnterCallback(this.onDestinationAttacked.bindenv(this));
				}

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onCounterAttack.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsFailure"))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsVictory"))
				{
					if (this.Flags.get("IsCounterAttack"))
					{
						this.Contract.setScreen("CounterAttack1");
						this.World.Contracts.showActiveContract();
					}
					else if (!this.Contract.isEnemyPartyNear(this.Contract.m.Destination, 400.0))
					{
						this.Contract.setScreen("Victory");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCounterAttack( _dest, _isPlayerInitiated )
			{
				if (this.Flags.get("IsCounterAttackDefend") && this.Contract.isPlayerAt(this.Contract.m.Destination))
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
					p.LocationTemplate.Template[0] = "tactical.southern_ruins";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
					p.LocationTemplate.ShiftX = -4;
					p.CombatID = "ConquerHolySiteCounterAttack";
					p.MapSeed = this.Flags.getAsInt("MapSeed");
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "ConquerHolySiteCounterAttack";
					p.Music = this.Const.Music.NobleTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onDestinationAttacked( _dest )
			{
				if (this.Flags.getAsInt("OppositionSeed") != 0)
				{
					this.Math.seedRandom(this.Flags.getAsInt("OppositionSeed"));
				}

				if (this.Flags.get("IsVictory") || this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					return;
				}
				else if (this.Flags.get("IsAlliedArmy"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("AlliedArmy");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
						p.CombatID = "ConquerHolySite";
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.NobleTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner(),
							this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, true, true, true);
					}
				}
				else if (this.Flags.get("IsSallyForth"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("SallyForth");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "ConquerHolySite";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				else if (this.Flags.get("IsMercenaries"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Mercenaries1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
						p.CombatID = "ConquerHolySite";
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.NobleTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, (130 + (this.Flags.get("MercenariesAsAllies") ? 30 : 0)) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("MercenariesAsAllies"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
							p.AllyBanners.push(this.Flags.get("MercenaryBanner"));
						}
						else
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
							p.EnemyBanners.push(this.Flags.get("MercenaryBanner"));
						}

						this.World.Contracts.startScriptedCombat(p, true, true, true);
					}
				}
				else if (this.Flags.get("IsCounterAttack") && this.Flags.get("IsVictory"))
				{
					if (this.Flags.get("IsCounterAttackDefend"))
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
						p.LocationTemplate.ShiftX = -2;
						p.CombatID = "ConquerHolySiteCounterAttack";
						p.LocationTemplate.Template[0] = "tactical.southern_ruins";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "ConquerHolySiteCounterAttack";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						p.AllyBanners = [
							this.World.Assets.getBanner()
						];
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				else if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Attacking");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.OwnedByFaction = this.Flags.get("EnemyID");
					p.CombatID = "ConquerHolySite";
					p.LocationTemplate.Template[0] = "tactical.southern_ruins";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.Walls;
					p.Music = this.Const.Music.NobleTracks;
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, (this.Flags.get("IsCounterAttack") ? 110 : 130) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
					p.AllyBanners = [
						this.World.Assets.getBanner()
					];
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
					];
					this.World.Contracts.startScriptedCombat(p, true, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "ConquerHolySiteCounterAttack")
				{
					this.Flags.set("IsCounterAttack", false);
					this.Flags.set("IsVictory", true);
				}
				else if (_combatID == "ConquerHolySite")
				{
					this.Flags.set("IsVictory", true);
					this.Flags.set("OppositionSeed", this.Time.getRealTime());
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "ConquerHolySite" || _combatID == "ConquerHolySiteCounterAttack")
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

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
					this.Contract.m.Destination.setOnEnterCallback(null);
				}
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{你发现%employer%正坐在一堆卷轴后面忙着写字，他旁边的神职人员也在专心听取，每当Vizier说完一句话，他们就会抢走卷轴。最终结束时，这个从事写作的人终于抬起头来。%SPEECH_ON%我们有一个%holysite%被北方鼠辈闯入的问题。我会试着克制对此事的感情，因为Gilder不会用愤怒的情绪来玷污人性的理智，总之，这些野蛮人的存在冒犯了我们理智的食欲。%SPEECH_OFF%Vizier沾上一根羽毛笔，然后回到他的写作和发言之中。%SPEECH_ON%但是，狗吠鸟飞。我需要一只狗，Crownling，还需要一只有咬力的狗。带领你的战团前往圣地，铲除那些败类。如果你同意，那么%reward%克朗将会等待你回来。%SPEECH_OFF% | %employer%用惊人的热情欢迎你。%SPEECH_ON%我真的相信Gilder会派来一个重要的人物，一个具有强大力量和绝对实力的人物。一个Crownling，当然，但是一个战士？当然是！%SPEECH_OFF%在你还没来得及问这是什么事情时，Vizier拿起一只镶金边的酒杯，杯口的一半被切成了月牙形。%SPEECH_ON%我们的圣地%holysite%被野蛮的北方人夺走了。我们的世界正受到黑暗的威胁，为了抵御阴影，我们必须在我们的努力中获得祝福。我的领地上的人很多，但是Gilder的地盘延伸千里，我需要像你这样的士兵来帮忙夺回%holysite%。其实它是Gilder的领土之一，而Gilder支付我们所有人：%reward%克朗将会支付给你。我们达成一致了吗？%SPEECH_OFF% | 在一个罕见的场景中，你看到%employer%俯伏在一块闪闪发光的太阳形徽章下。他自言自语几句，然后站起来，又说了几句小声的话，逐个擦拭他的指尖，然后转向你。%SPEECH_ON%在这些士兵正在为我们做出有利的进展的时候，%holysite%已经无人守卫。为了赢得这场战争，我留下了一个机会，让野蛮的北方人占据了这个地方。我希望，当面对你时，外面有人来帮我一下。Gilder会给我们提供金子般的道路，Crownling，你也不例外。通过我的手，如果你夺回%holysite%，你将获得%reward%克朗！%SPEECH_OFF% | 一只金色的酒杯散落在大理石地板上，红酒四溅。Vizier对你大声喊叫，愤怒和需要交织在一起。%SPEECH_ON%终于，有人可以提供帮助了！%SPEECH_OFF%他打发了一些帮手，甚至打发了一些看起来像是他自己的中尉。%SPEECH_ON%Crownling，%holysite%已经被北方的蠢物征服了。我曾为他们洗耳恭听，曾经流泪想到他们抢走这个地方，我将每天为他们玷污Gilder的足迹而流泪。%reward%克朗，这就是你将得到的奖励。这对你来说是一笔可观的财富，但毕竟有这样一句话，对于某些人，这样被铺设的金色路径可能更像是字面意义超过了其他人的。%SPEECH_OFF% | %employer%被披着丝绸的男人包围。其中一个带着一只笼子，里面装着萤火虫，昏暗的虫光在这里和那里闪烁。另一个笼子里只剩下一只死鸟的骨头，除了两根仿佛是曾经的翅膀的羽毛，鸟的其他部分已经全部剥离。看到你后，Vizier从这些人之间走了出来，就像一座庙宇中不可移动的柱子之间走路一样。%SPEECH_ON%Crownling，你来了！我的侦察兵报告说我们在与北方狗的战争中已经退了一步。%holysite%已经被占领了，根据Gilder的耳语，我必须让它回到我们手中。不仅为了我的领地，而且为了使Gilder的崇高有所收获。如果你完成任务，你将获得%reward%克朗，这对于这个艰巨的任务来说是一个巨额的奖励，是的！%SPEECH_OFF% | 记住往常的华丽和奢侈，你看到%employer%跪在地上，穿着相对较为简朴的服装。他戴着一顶裹着黑色缎绸的首饰。这位社交场上的低调人士平静地对你说话。%SPEECH_ON%北方异教徒从我们的领土占领了%holysite%。我不责怪他们的行为，他们不知道自己在做什么。我会在Gilder知道我的过失之后，用我的诚实之手去挽回这个错误。但失败并不意味着放弃。我需要你去圣地并将其带回我们的领域。对此，你将得到放置在你的资金包中的%reward%克朗。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我相信你会为这样的袭击付出充分的报酬。 | 我们已经准备好尽自己的一份力了。 | 我们再多谈谈报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 这太远了。 | 我们有更紧迫的事情要处理。 | 我们还有别的地方要去。}",
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
			ID = "Attacking",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{正如维齐尔所料，北方人已经占据了 %holysite% 及其周围的位置。大多数宗教信徒早已离开，只剩下 %companyname% 和对立势力。你拔出剑命令士兵发起攻击。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AlliedArmy",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_164.png[/img]{当你接近%holysite%时，一个人突然从地面下站了起来。你吓了一跳，拔出武器，但这个人说自己是 %employer% 的伪装指挥官。 %SPEECH_ON%放轻松，雇佣兵，你还会得到你的硬币的。维齐尔的信鸽已经告诉我的队伍你的到来，我必须说你迟到了。我知道这不是你们的战争, 但好吧, 我想现在也不是责备彼此之时. 让我们共同努力夺回圣地，为了吉尔德荣耀！%SPEECH_OFF% | 当你接近%holysite%时，一个人突然从地面下站了起来，并问你是不是 %companyname% 的指挥官。经过短暂的确认后，他立刻说话道 %SPEECH_ON%是的，当然是你。我是%employer%的中尉指挥官%commander%。维齐尔的信鸽已经告诉我你可能会来。 雇佣兵，虽然你可能只是为钱而战，但只要我们能赢得今天这场战斗，吉尔德将会给我们带来无尽的荣耀！%SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
				this.Banner = this.World.FactionManager.getFaction(this.Contract.getFaction()).getUIBanner();
			}

		});
		this.m.Screens.push({
			ID = "SallyForth",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{ %holysite% 的守卫者得到了增援! 但值得庆幸的是，还有一线希望: 额外的援军使得使他们有信心离开圣地的自然防御并在开阔的战场上接近你。 | 你惊讶地看到防守者离开 %holysite% 并徒步穿过开阔的战场。一份迅速的侦查报告传达道: 他们在过去几天中得到了增援, 因此变得很有底气。 一方面，他们深深的阵列有点令人不安，但另一方面，在平坦的战场上面对他们会更容易。经过理智评估, 他们选择在开阔战场直面 %companyname% 将是一个致命的错误。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那就是一场野战了。",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries1",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{当 %holysite% 出现在视野中时，一个看起来几乎与你相似得有些诡异的男人走了过来。他身边有一名财务主管和几个雇佣兵。%SPEECH_ON%晚上好，队长。我是来自 %mercenarycompany% 的雇佣兵 %mercenary%，像你一样为钱而来。现在，我打赌维齐尔已经为你和你的手下签订了合同，但如果你支付给我 %pay% 克朗，我将会协助您完成这个小任务？%SPEECH_OFF%. | 你被一群男人包围，其中一个人的步态和体质都让你感到奇怪地相似。他自称为%mercenary%，是%mercenarycompany%的队长。%SPEECH_ON%我以为维齐尔会派专业军队来处理圣地易手的事情。我必须向您承认，队长，我曾经帮助北方人占领这个著名的纪念碑。然而，如果以 %pay% 克朗作为报酬，我愿意帮助你们夺回它。作为一名同行雇佣兵，相信你能看出这对所有人来说都是一个好交易.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [],
			function start()
			{
				if (this.World.Assets.getMoney() > this.Flags.get("MercenaryPay"))
				{
					this.Options.push({
						Text = "你被雇佣了!",
						function getResult()
						{
							return "Mercenaries2";
						}

					});
				}
				else
				{
					this.Options.push({
						Text = "恐怕我们没有那么多的钱币。",
						function getResult()
						{
							return "Mercenaries3";
						}

					});
				}

				this.Options.push({
					Text = "自己找工作去，%mercenary%。我们不需要帮助。",
					function getResult()
					{
						return "Mercenaries3";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries2",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{那队长露出笑容，拍了拍你的肩膀。%SPEECH_ON%啊哈，就是这样！就是这种高尚的雇佣兵精神！嗯，作为 %companyname% 的指挥官，让我们一起前往战斗吧，虽然只是短暂的时间！%SPEECH_OFF% | 交易完成后，雇佣军队长靠近你。他几乎贴在你身边，让人感到不舒服，并且肯定能闻到他的呼吸，这是令人不喜欢的。%SPEECH_ON%你知道，像我们这样的人，伙计们，我们是朋友对吧？像我们这样的朋友必须要互相支持。在接下来的战斗中，我们会一起并肩作战。%SPEECH_OFF%他点了点头，并猛地拍了一下你的肩膀。%SPEECH_ON%战斗结束后，我希望我们还能再做好朋友啊！你懂得。 %SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "开始进攻！",
					function getResult()
					{
						this.Flags.set("MercenariesAsAllies", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.addMoney(-this.Flags.get("MercenaryPay"));
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("MercenaryPay") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Mercenaries3",
			Title = "在 %holysite%",
			Text = "[img]gfx/ui/events/event_134.png[/img]{%SPEECH_START% 真是太遗憾了。%SPEECH_OFF% %mercenary%说着，迅速回到了 %mercenarycompany% 的队伍中。他不断地向后退，直接撞上了保卫 %holysite% 的士兵。他的手臂张开，像在逆流中游泳一样摆动着。%SPEECH_ON%我可真是感到非常遗憾啊！好吧， %companyname% 队长，让我们看看哪一方购买的雇佣兵更出色呢？%SPEECH_OFF%这位雇佣兵拔出武器，周围的北方士兵也做同样的事情，你也跟着拔出武器。现在是时候战斗了。 | %SPEECH_ON%哦，我明白了。嗯，我也没抱太大期望。毕竟，我也是一名雇佣兵。而现在……%SPEECH_OFF%他向后走到他的同伴那里，他的同伴站在保护 %holysite% 的北方士兵队列中。%SPEECH_ON%现在，南方人证明自己是出价最高的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们将在战场上再见。开始进攻！",
					function getResult()
					{
						this.Flags.set("MercenariesAsAllies", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{战斗结束了，但远处的金色闪光引起了你的注意。当你凝视着地平线时，一队北方人出现了，他们鲜艳的外表无疑是为了被看到。这是一次反击！ | 当你收起剑的时候，一支箭从头顶飞过，落在沙地上发出轻微的声响。你朝着箭矢来源看去，看到一个年轻而紧张的弓手被人拍打了一下脑袋。这个男人旁边是整个北方军团！这是一次反击！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们将坚守这个地点进行防御！",
					function getResult()
					{
						return "CounterAttack2";
					}

				},
				{
					Text = "我们会在开阔地见他们！",
					function getResult()
					{
						return "CounterAttack3";
					}

				},
				{
					Text = "我们无法再战斗。撤退！",
					function getResult()
					{
						return "Failure";
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{%SPEECH_START%又来了一些北方人。%SPEECH_OFF%%randombrother% 说。你点点头回答道。%SPEECH_ON%给金匠的火炉添更多的木材。%SPEECH_OFF%雇佣兵提到金匠对金子比火焰更珍视，但你叫他闭嘴，准备迎接即将到来的战斗。%holysite%本身的防御应该能很好地为战团服务。 | 你命令士兵在%holysite%内自卫。%randombrother%环顾四周。%SPEECH_ON%你是否曾经想过正在观看这一切的神会不会有点失望呢？你知道的吗？就像我们把他们的锅碗弄得一团糟？%SPEECH_OFF%你扇了他的脑袋一巴掌，让他集中注意力。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "集合！",
					function getResult()
					{
						this.Flags.set("IsCounterAttackDefend", true);
						this.Flags.set("IsVictory", false);
						local party = this.Contract.spawnEnemy();
						party.setOnCombatWithPlayerCallback(this.Contract.getActiveState().onCounterAttack.bindenv(this.Contract.getActiveState()));
						this.Contract.m.Target = this.WeakTableRef(party);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "CounterAttack3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你命令%companyname%进入战场。北方的中尉挥手微笑着迎接你。%SPEECH_ON%终于出来了，受够祈祷了吧？%SPEECH_OFF%你转过身吐了口痰。%SPEECH_ON%我们已经没有地方埋葬你们的尸体了。%SPEECH_OFF%中尉的微笑变得沉默，随即下令冲锋。出兵！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Flags.set("IsCounterAttackDefend", false);
						this.Flags.set("IsVictory", false);
						local party = this.Contract.spawnEnemy();
						party.setOnCombatWithPlayerCallback(this.Contract.getActiveState().onCounterAttack.bindenv(this.Contract.getActiveState()));
						this.Contract.m.Target = this.WeakTableRef(party);
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
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{当你收起武器，让同伴开始搜刮尸体时，你有一种奇怪的感觉，好像这不是第一次发生在 %holysite% 的血腥事件。无论如何，如果有人注定要在这场争斗中死去，你很高兴那个人不是你。几个南方人进来保护圣地时，你动身前往 %employer%。，你相信他会很高兴收到你的好消息。 | 你打败了敌人，成功收复了 %holysite%。南方士兵慢慢地修复防线，在他们身后缓缓涌来一群信徒，迈过死者后跪拜在圣地前。没有一个人对你说谢谢。虽然这并不重要，因为那是 %employer% 的工作 | 战斗结束后，一些忠诚的人开始聚集在%holysite%的角落里。你不知道这些人从哪里来，他们不在意你，而你也不在意他们。现在重要的是有大量克朗在 %employer% 那等待着你回去领取。当你离开时，几个南方士兵接管了岗位，并没有向你道谢。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Contract.m.Destination.setFaction(this.Contract.getFaction());
						this.Contract.m.Destination.setBanner(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
						this.updateAchievement("NewManagement", 1, 1);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.spawnAlly();
			}

		});
		this.m.Screens.push({
			ID = "Failure",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/%illustration%.png[/img]{你没有保护好%holysite%，让北方人攻破了。现在留在这里没有任何意义，回去找%employer%的唯一理由就是希望你的头能够被放在大臣金镶嵌的盘子里。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "灾难！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能征服一个圣地");
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
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 正坐在一个巨大的金色吊灯下，它像太阳一样悬挂在天花板上。看起来这是你离开时安装的。当你走近时，一个神圣的人拦住了你，并摇了摇头。他用手在空中画了个圆圈，然后轻轻地触碰了你的额头，热情地引导你到房间另一边放着整齐堆放着 %reward% 克朗的木盘处。\n\n 这个人向你鞠躬致意，随后将金色吊灯的光芒引导到装满克朗的木盆处，克朗被照得闪闪发光。虽然这似乎是某种诡计，但报酬是真实的，所以您接受并离开了。 | 当你进入%employer%的房间时，一些卫兵对你鞠躬跪拜。在远处，维齐尔静静地坐在宝座上，周围都是穿着丝绸衣服的神圣人物，看来今天你无法接近他。然而，一群年轻男孩一个接一个地给你带来了装满克朗的盘子，直到你收到了%reward%克朗。维齐尔点头示意，并用手势让你收下了报酬后离开。 | 当你走进大厅时，你看到 %employer% 似乎被一团金色的雾气所迷住。他站在一个旋转平台上——在地板下几乎看不见的奴隶的帮助下粗糙地旋转——手腕上系着布条。他的妃嫔站在一边，嘴里含着了一些金色液体，然后喷出唇溅溅的雾气。仔细观察后，你会发现这并不是你刚走进来时想象中那么壮观。在你想靠近进一步观察之前，一个身穿宗教服装的大汉拦截了你，并带领你到房间后面的桌子前。桌子上摆满了盛有克朗的托盘，总共价值%reward%克朗作为您的报酬。你收取了报酬后匆忙地被离开了房间。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "征服了一个圣地");
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

	function spawnAlly()
	{
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y + 4; y <= o.Y + 6; y = ++y )
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
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			candidates.push(s);
		}

		local party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, 170 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("忠于城邦的应征士兵。");
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 5);
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
		local occupy = this.new("scripts/ai/world/orders/occupy_order");
		occupy.setTarget(this.m.Destination);
		occupy.setTime(10.0);
		c.addOrder(occupy);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
		return party;
	}

	function spawnEnemy()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y - 4; y <= o.Y - 3; y = ++y )
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
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 140) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("为地方领主服务的专业士兵。");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
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
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(this.m.Destination.getTile());
		c.addOrder(attack);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Destination.getTile());
		c.addOrder(move);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(999.0);
		c.addOrder(guard);
		return party;
	}

	function onPrepareVariables( _vars )
	{
		local illustrations = [
			"event_152",
			"event_154",
			"event_151"
		];
		_vars.push([
			"illustration",
			illustrations[this.m.Flags.get("DestinationIndex")]
		]);
		_vars.push([
			"holysite",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"pay",
			this.m.Flags.get("MercenaryPay")
		]);
		_vars.push([
			"employerfaction",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"mercenary",
			this.m.Flags.get("Mercenary")
		]);
		_vars.push([
			"mercenarycompany",
			this.m.Flags.get("MercenaryCompany")
		]);
		_vars.push([
			"commander",
			this.m.Flags.get("Commander")
		]);
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
				this.m.Target.setOnCombatWithPlayerCallback(null);
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

		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			foreach( s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0 && !this.World.FactionManager.isAllied(this.getFaction(), v.getFaction()))
				{
					return true;
				}
			}
		}

		return false;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull() && _tile.ID == this.m.Destination.getTile().ID)
		{
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

