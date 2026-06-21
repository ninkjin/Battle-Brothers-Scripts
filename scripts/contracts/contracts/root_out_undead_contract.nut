this.root_out_undead_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Objective1 = null,
		Objective2 = null,
		Target = null,
		Current = null,
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

		this.m.Type = "contract.root_out_undead";
		this.m.Name = "铲除亡灵";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		if (this.m.Origin == null)
		{
			this.setOrigin(this.World.State.getCurrentTown());
		}

		local nearest_undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getNearestSettlement(this.m.Origin.getTile());
		local nearest_zombies = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getNearestSettlement(this.m.Origin.getTile());

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Objective1 = this.WeakTableRef(nearest_undead);
			this.m.Objective2 = this.WeakTableRef(nearest_zombies);
		}
		else
		{
			this.m.Objective2 = this.WeakTableRef(nearest_undead);
			this.m.Objective1 = this.WeakTableRef(nearest_zombies);
		}

		this.m.Flags.set("Objective1Name", this.m.Objective1.getName());
		this.m.Flags.set("Objective2Name", this.m.Objective2.getName());
		this.m.Payment.Pool = 1500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
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

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"摧毁%objective1%",
					"摧毁%objective2%",
					"返回 %townname%"
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
				this.Contract.m.Objective1.setLootScaleBasedOnResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective1.setResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective1.clearTroops();
				this.Contract.addUnitsToEntity(this.Contract.m.Objective1, this.Contract.m.Objective1.getDefenderSpawnList(), 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective1.setDiscovered(true);

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Objective1.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Objective1.getLoot().clear();
				}

				this.World.uncoverFogOfWar(this.Contract.m.Objective1.getTile().Pos, 500.0);
				this.Contract.m.Objective2.setLootScaleBasedOnResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective2.setResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective2.clearTroops();
				this.Contract.addUnitsToEntity(this.Contract.m.Objective2, this.Contract.m.Objective2.getDefenderSpawnList(), 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Objective2.setDiscovered(true);

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Objective2.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Objective2.getLoot().clear();
				}

				this.World.uncoverFogOfWar(this.Contract.m.Objective2.getTile().Pos, 500.0);
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					this.Flags.set("IsNecromancers", true);
				}
				else if (r <= 25)
				{
					this.Flags.set("IsBandits", true);
				}

				this.Flags.set("ObjectivesDestroyed", 0);
				this.Flags.set("Objective1ID", this.Contract.m.Objective1.getID());
				this.Flags.set("Objective2ID", this.Contract.m.Objective2.getID());
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [];

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull() && this.Contract.m.Target.isAlive())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.BulletpointsObjectives.push("杀死逃跑的亡灵巫师");
				}

				if (this.Contract.m.Objective1 != null && !this.Contract.m.Objective1.isNull() && this.Contract.m.Objective1.isAlive())
				{
					this.Contract.m.Objective1.getSprite("selection").Visible = true;
					this.Contract.m.BulletpointsObjectives.push("摧毁%objective1%");
					this.Contract.m.Objective1.setOnCombatWithPlayerCallback(this.onCombatWithPlayer.bindenv(this));
				}

				if (this.Contract.m.Objective2 != null && !this.Contract.m.Objective2.isNull() && this.Contract.m.Objective2.isAlive())
				{
					this.Contract.m.Objective2.getSprite("selection").Visible = true;
					this.Contract.m.BulletpointsObjectives.push("摧毁%objective2%");
					this.Contract.m.Objective2.setOnCombatWithPlayerCallback(this.onCombatWithPlayer.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("ObjectiveDestroyed"))
				{
					this.Flags.set("ObjectiveDestroyed", false);

					if (this.Flags.get("IsBanditsCoop"))
					{
						this.Contract.setScreen("BanditsAftermathCoop");
					}
					else if (this.Flags.get("IsBandits3Way"))
					{
						this.Contract.setScreen("BanditsAftermath3Way");
					}
					else if (this.Flags.get("ObjectivesDestroyed") == 1)
					{
						this.Contract.setScreen("Aftermath1");
					}
					else
					{
						this.Contract.setScreen("Aftermath2");
					}

					this.World.Contracts.showActiveContract();
				}

				if (this.Flags.get("IsNecromancersSpawned"))
				{
					if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
					{
						this.Contract.setScreen("NecromancersAftermath");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Contract.m.Target.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) >= 9)
					{
						this.Contract.setScreen("NecromancersFail");
						this.World.Contracts.showActiveContract();
					}
				}

				if (!this.Flags.get("IsBandits") || this.Flags.get("ObjectivesDestroyed") != 0)
				{
					if (this.Contract.m.Objective1 != null && !this.Contract.m.Objective1.isNull() && !this.Contract.m.Objective1.getFlags().has("TriggeredContractDialog") && this.Contract.isPlayerNear(this.Contract.m.Objective1, 450))
					{
						this.Contract.m.Objective1.getFlags().add("TriggeredContractDialog");
						this.Contract.setScreen("UndeadRepository");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Contract.m.Objective2 != null && !this.Contract.m.Objective2.isNull() && !this.Contract.m.Objective2.getFlags().has("TriggeredContractDialog") && this.Contract.isPlayerNear(this.Contract.m.Objective2, 450))
					{
						this.Contract.m.Objective2.getFlags().add("TriggeredContractDialog");

						if (this.Flags.get("IsNecromancers"))
						{
							this.Flags.set("IsNecromancersSpawned", true);
							this.Contract.setScreen("Necromancers");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Contract.setScreen("UndeadRepository");
							this.World.Contracts.showActiveContract();
						}
					}
				}
			}

			function onCombatWithPlayer( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
				this.Contract.m.Current = _dest;

				if (_dest != null && !_dest.getFlags().has("TriggeredContractDialog") && this.Flags.get("IsBandits") && this.Flags.get("ObjectivesDestroyed") == 0)
				{
					_dest.getFlags().add("TriggeredContractDialog");
					this.Contract.setScreen("Bandits");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					_dest.m.IsShowingDefenders = true;
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.EnemyBanners.push(_dest.getBanner());

					if (this.Flags.get("IsBandits") && this.Flags.get("ObjectivesDestroyed") == 0)
					{
						if (this.Flags.get("IsBanditsCoop"))
						{
							p.AllyBanners.push("banner_bandits_06");
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditRaiders, 90 * this.Contract.getScaledDifficultyMult(), this.Const.Faction.PlayerAnimals);
						}
						else
						{
							p.EnemyBanners.push("banner_bandits_06");
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditRaiders, 90 * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
					}

					this.World.Contracts.startScriptedCombat(p, this.Contract.m.IsPlayerAttacking, true, true);
				}
			}

			function onLocationDestroyed( _location )
			{
				if (_location.getID() == this.Flags.get("Objective1ID"))
				{
					this.Contract.m.Objective1 = null;
					this.Flags.set("ObjectiveDestroyed", true);
					this.Flags.set("ObjectivesDestroyed", this.Flags.get("ObjectivesDestroyed") + 1);
				}
				else if (_location.getID() == this.Flags.get("Objective2ID"))
				{
					this.Contract.m.Objective2 = null;
					this.Flags.set("ObjectiveDestroyed", true);
					this.Flags.set("ObjectivesDestroyed", this.Flags.get("ObjectivesDestroyed") + 1);
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{你找到 %employer% 时他整卷起一张地图把一段点进蜡烛里。 火迅速燃起来，纸焦黑的消散在火中。他招手唤你进去。%SPEECH_ON%一张坏地图对于军队就像毒药一样。 另一方面，一个好地图则是金子。%SPEECH_OFF%随着火开始潦到他的手指，他放下了纸踩灭了火。 他坐下来拿出又一张卷轴，展开来铺过了整张办公桌。 它完全就是你见过最漂亮的地图。%employer% 用两根棒子标出了两个特殊的点。%SPEECH_ON%“%objective1%”和“%objective2%”，两个鲜艳的名字。 在这两个地方据我的密探报告说是亡灵们出发的地方。 至少，那些怪物中的大部分。 去这两个地方，佣兵，并帮我们解决这些恐怖的东西。%SPEECH_OFF% | 你走进 %employer%的房间。 他的将军面红耳赤，一场没能达成共识的争论。 贵族招手叫你进去。%SPEECH_ON%啊，一个我实际上愿意他妈的谈话的人。 伙计，让开点。%SPEECH_OFF%轻蔑的目光下，你走过了一片傲慢的指挥官。%employer% 在你胸口拍了一张地图。 上面有两个地点被画上了圈还有潦草画出来的头骨和交叉的骨头作为标记。%SPEECH_ON%去这两个地方，佣兵。“%objective1%”和“%objective2%”。我的书记员相信这些地点对于亡灵们而言非常关键。 我的指挥官们不这么认为，但是为什么不看一看呢？ 现在如果你看到这些吓人玩意，杀了它们，摧毁所有它们爬出来的该死的洞，然后带着你的英雄事迹回来找我。 听起来如何？%SPEECH_OFF% | %employer% 正在照料他的花园。 蔬菜都变成了灰色。 他的手指从藤上擦下来的只有灰尘。%SPEECH_ON%我很悲伤，佣兵，因为很多东西的状况，但至少我的食物没有他妈的回来咬我的屁股。%SPEECH_OFF%你笑着并回应道。%SPEECH_ON%给它点时间。我们可估计不了蔬菜能有多强的怨念。%SPEECH_OFF%贵族认真的点了点头，好像你是个在讨论哲学而不是开玩笑。 他丢给你一张地图。%SPEECH_ON%你得找到两个标出来的地方，“%objective1%”和“%objective2%”。我们估计，两个都是亡灵的巢穴。 去那里，杀光它们，然后摧毁它们的家。 或者坟墓。坑。不重要。%SPEECH_OFF% | 一个愁眉苦脸的农民，这很平常，在你进入 %employer%的房间时正走出去。 他招手叫你到他的办公桌边。%SPEECH_ON%很高兴你来了，佣兵，因为我有个了不得的任务给你。 我的侦查兵报告了两个对我和这片土地的人们而言有强烈兴趣的地方。 它们被称作“%objective1%”和“%objective2%”并且，按猜测，亡灵正从这两个地方涌出。 所以，要不要去那个地方看看？ 然后我说的看看是指杀光它们，如果这是真的，并把好消息带回来告诉我。%SPEECH_OFF% | 你看到 %employer% 盯着他办公桌上的一只死猫。 这猫科小动物胸口插着一把匕首而且你注意到贵族手里还拿着另一把刀。 一个卫兵站在一边，剑已经拔了出来，还有一个书记员在他边上拿着笔和卷轴。 随着所有人都放松下来你走过了房间。 刀进鞘，笔开写。 书记员赶快把猫带走去做天知道什么事情了。%employer% 坐下来。%SPEECH_ON%欢迎，佣兵。我们刚才是在做点实验。 我们不相信猫有九条命，但在这个恐怖新世界它们可能有两条命。 但是过后看来，并没有。 它们没有。它们只有一条命。%SPEECH_OFF%贵族拉出一张地图拍着摊开在办公桌上。 他指向两个记号。%SPEECH_ON%“%objective1%”这里。“%objective2%”这里。 去这两个地方。如果我的侦察兵说的没错，你会在那里见到亡灵。许多亡灵。 你要摧毁那里的一切并确保这些亡灵污秽被彻底清除。%SPEECH_OFF% | %employer% 身边站着一个显然跑了很长路的侦察兵。 那个探路者正在饱餐一顿，补充一切他这一路上消耗的东西。%employer% 展示给你一张粗糙画下的地图。%SPEECH_ON%“%objective1%”和“%objective2%”。我们，好吧，我这边的小鸟朋友先生，相信这两个是亡灵们的仓库，现在来说这个说法恐怕有点不适合。 从这两个地方正冒出来各种各样不洁的东西。 去这两个地方，摧毁一切你看到的东西，然后英雄一样凯旋。%SPEECH_OFF%You shrug.%SPEECH_ON%%companyname% 比起荣誉更想要点克朗。%SPEECH_OFF% | %employer% 用一张地图迎接了你。%SPEECH_ON%“%objective1%”和“%objective2%”，认得这两个地方吗？ 不，当然不。 但我想要你去这两个地方，铲除那里的一切邪恶，然后回来。 简短直接的一次前往死者堆积地的旅游，对吗？%SPEECH_OFF%是啊。怎么可能会出什么问题？ | %employer% 问你怕不怕亡灵。你耸耸肩并回应道。%SPEECH_ON%我害怕带着未尽之愿的遗憾死去。 只怕那个。那个还有马。%SPEECH_OFF%贵族笑了笑。%SPEECH_ON%好，行吧。这里是一张地图。 你能看到上面标了“%objective1%”和“%objective2%”。我的侦察兵相信亡灵躲在那里。 很合理，毕竟那里一开始就是我们放死者的地方。 去这两个地方，摧毁它们，然后回来拿你的报酬。足够简单，对吧？%SPEECH_OFF% | %employer% 在他的门口拿着张地图欢迎你。%SPEECH_ON%“%objective1%”和“%objective2%”，清晰的标了出来，看到了吗？ 你当然看得到。 我的小鸟们说大量邪恶事物正从这两个地方涌出来。 如果是真的，那我需要一个无畏，善于杀戮的人去这两个地方摧毁那里的一切。 我相信你就是这样一个人。是吗？%SPEECH_OFF% |  一个全副武装，但是满面愁容的人离开了 %employer%的房间。 你进去的时候，贵族招手叫你到他的桌边看看地图。%SPEECH_ON%你不害怕死者，对吗？ 亡灵呢？不？ 完美。“%objective1%”在那儿，还有“%objective2%”那儿。 去这两个地方，摧毁它们，并给刚才走出去的懦夫看看真男人是怎么办事的。%SPEECH_OFF%你竖起一根手指试图修正。%SPEECH_ON%一个好价钱买来的真正的男人。%SPEECH_OFF% | %employer% 欢迎你进入他房间时问了个奇怪的问题。%SPEECH_ON%过墓地吗，佣兵？%SPEECH_OFF%在你回答前，他给自己倒了杯酒喝了口，伸出另一只手让你保持沉默。%SPEECH_ON%它们是群神奇的东西。非自然，真的。 什么样的生物会把他们的死者带去些地方，好地方，并埋起来？ 多么华而不实。多么不合逻辑。 这样一来，亡者归来，有什么值得惊讶的？ 或许他们是因为我们破坏了自然法则在缠扰我们。%SPEECH_OFF%他丢给你一个卷轴，上面画着一张细致的地图。 两个点被标记了出来。%SPEECH_ON%“%objective1%”和“%objective2%”。我需要你去这两个地方，摧毁它们，然后回来。 对于你的职业而言足够简单，对吗？%SPEECH_OFF% | 你看到 %employer% 摇着头用笔划过一张地图。%SPEECH_ON%“%objective1%”和“%objective2%”，两个离这并不远的粪坑需要被摧毁。 当然，它们是亡者，然后，亡灵的家。 它们可没让我们消停过而且现在，好吧，这些尸体还能安息吗？ 谁知道呢。但是杀光它们，明白了吗？%SPEECH_OFF% | %employer% 在照看一堆笼子里的鸟。 有些绕着它们的牢房煽动翅膀，撞着笼子。 贵族捡起一只鸟的尸体，腿僵直。 他把尸体丢给你。%SPEECH_ON%我有个活给你，佣兵。离这里不远的“%objective1%”和“%objective2%”需要被摧毁。 我的侦察兵报告，通过这些小鸟，这些地方有亡灵聚集，或许是个源头，或是个行动基地，如果一群尸体有能力形成这样的组织。%SPEECH_OFF%他开始往鸟窝里丢鸟食籽。 几只鸟盯着饲料并决定不去吃它，拒绝去偷自然界最伟大的馈赠。 另一边，剪了翅膀的鸟则在啄着。%employer% 转身向你，拍打着擦干净手。%SPEECH_ON%所以，我们成交吗？%SPEECH_OFF% | 你发现 %employer% 被他的卫兵围起来，全都看着房间中间的一具尸体。 一股恶臭在贵族之前迎接了你。 一个瘴气从尸体上飘浮下来，色调呈钝灰色就好像风道间的一堆尘埃。%SPEECH_ON%佣兵！很高兴见到你！ 如果你可以，无视这场闹剧。 我们遇到了个麻烦，一个卫兵自杀了，而且，好吧，在活过来。 也许，一场复杂的刺杀计划？ 现在这个世道很难说。 过来，我有些东西给你。%SPEECH_OFF%他招手让你上前，伸出来的手里拿着一张卷轴。 你拿上它摊开了地图。 他解释了下。%SPEECH_ON%“%objective1%”和“%objective2%”，如果你认得出来它们，是我们认为的亡灵们的源头。 我需要一个像你一样的，嗯，钢铁般身材的人去那两个地方解决他们。 希望你对这个活感兴趣。%SPEECH_OFF% | %employer% 欢迎你进入他的房间，但一个卫兵用长柄的刃检查了下你的脖子。 你保持镇定，贵族快速命令他的手下退下。贵族道歉。%SPEECH_ON%抱歉发生了这种不幸的事情，但是人们都很紧张。 有个晚上他们中的一个在睡梦中死了并且，好吧，他回来了。 一个食尸鬼一样咆哮的野兽在任何人明白发生了什么之前杀死了三个人。%SPEECH_OFF%你挠了挠下巴，说你本来就需要好好刮下胡子的。%employer% 带着微笑点头。%SPEECH_ON%嗯，这就是我喜欢你的地方，佣兵。 总是很有精神。 看看我这里的这张地图。 看到这些地点了吗？“%objective1%”和“%objective2%”，农民们是这么称呼它们的。 我们有理由相信这两个地方都有强大的力量正供给着亡灵大军。 我需要一个你这样身材和决心的人去这两个地方并摧毁它们。 有兴趣吗，雇佣兵？%SPEECH_OFF% | 你发现 %employer% 倚在椅子上。 他丢给你一张地图。%SPEECH_ON%读它，了解它。 看到“%objective1%”和“%objective2%”了吗？我的密探相信这两个地方有强大的力量在支撑着亡灵。 我想它们只是充满了一大堆好给亡灵们复活的尸体的地方。 不论如何，我需要你去这两个地方，摧毁它们，然后回来找我。 你对此有没有兴趣？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{多少报酬？ | 让我感兴趣的是报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。}",
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
			ID = "UndeadRepository",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_57.png[/img]{一股熟悉的恶臭吹过战队。%randombrother% 说他们肯定在接近着存放处。 你说他真是个天才并且应该为人类做点发明发现。 在战队的笑声中你几乎听得到他的沉默。 | 随着你接近目标，%employer% 对这片区域的判断正显得越来越正确。 你无法否认这股恶臭：这片区域里的死者都回来游荡了。 | 你找到一具尸体缠在灌木中，它被树枝挂住的手带着一股亡者的冷淡划向外面。%randombrother% 走过去，小心的保持着距离，并一刃刺穿了它的头颅。 他后退，抹干净了他的武器并说队伍肯定离你要来摧毁的东西不远了。 | 从尸体和它们散发出的压倒性恶臭判断，%objective% 无疑很近了。 | 你看到半个人在地上爬着。 它抬头看到你，无意识的低吼着，对它的新存在形态毫无关心同时急切的想要结束的你。 一脚，你把它的头推到了泥巴里。 它的低吼变成了咯咯声而你小心的用匕首穿过了它的耳洞。%randombrother% 看向周围。%SPEECH_ON%这个 %objective% 现在应该不远了。%SPEECH_OFF% | 你的目的地还没进入视野，但它的气味已经以一种你希望没有反映其源头凶狠的恶臭袭击了你的鼻子。 你应该让手下准备战斗。 | %randombrother% 指向路的前方散落着一大堆看起来杂技般姿势的尸体。 你无法想象发生了什么，但是尸体看起来都死了很久却没有苍蝇或任何其他动物碰过他们。 你告诉手下你的目的地很近了而且他们得准备好战斗。 | 战队碰到了一具蹒跚的尸体上拷着手和脚。 生时的囚禁没有因复苏结束所以你做了行刑者很久前就该做的并移除了僵尸的头。%randombrother% 问你目的地是不是很近了而你点了点头。 它显然已经很近了，而且还会有场 %companyname% 最好做点准备的战斗。 | 从战队闻到的恶臭判断你肯定离目的地不远了。 不论是行尸还是一个人在拉着什么最臭的屎，%companyname% 应该准备好作战。 | 行尸一个接一个的出现了，一系列可以轻松解决的面包屑引导着 %companyname% 径直接近它的目标。 你应该准备战斗因为很快你就要面对一整片面包了。 | 一个老人欢迎了战队并声称 %objective% 不远了。 你问他在这种地方做什么。他耸耸肩。%SPEECH_ON%当个老人，还有什么呢？%SPEECH_OFF% | %randombrother% 闻了闻空气。%SPEECH_ON%我知道 %randombrother2%的臭屁而这味道不是他放出来的。%SPEECH_OFF%被冒犯到的雇佣兵耸肩。%SPEECH_ON%没少试过，不过确实，我想你是对的。 我们已经很接近 %objective%。%SPEECH_OFF%你点头并告诉手下为即将到来的战斗做好准备。 | 你找到一具已经爬满蚯蚓的尸体带着深渊般的眼窝缠在一块巨石边上。 它来回挠着石头试着杀死它。%randombrother% 用一次横扫斩首了僵尸，就像一个人切一块黄油一样。 他向着远处点头。%SPEECH_ON%%objective% 很近了。%SPEECH_OFF%如果没错的话，%companyname% 应该准备好战斗了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "做好面对最糟糕情况的准备！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Aftermath1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{这地方的邪恶消散了。 你大吸一口气，几年都没有过的那样，就好像空气本身因为你的胜利温暖了起来。 现在只剩下 %objective2% 了。 | 随着最后的一个亡灵安息，你感到空气在变得清澈，就好像微风吹开薄雾，春天的气息。 气味的变化无疑意味着你解决这里的东西。 现在是时候去净化 %objective2% 然后了结这桩合同了。 | 这个地方的邪能被安息了。 你的下个目标还等着你。 | 随着这可怕的地方被净化，只剩下 %objective2% 留在合同上了。 | 随着最后一个僵尸安息，你感到空气中突然产生了变化。 站在一片泥泞的土地里却有一股意外纯洁的感觉侵入肺腑。%randombrother% 抹了抹额头。%SPEECH_ON%肯定是结束了。 接下来去 %objective2%？%SPEECH_OFF% | 你进入了一个邪恶的领域，但随着最后一个僵尸被击倒你感到光在变亮而且脚下土地的气味回归正常。 随着这个地方安息，是时候去 %objective2%。 | 胜利来之不易。 僵尸和些奇怪的更古老的亡灵散落在战场上。 你希望 %objective2% 会更轻松点，但是你不抱太大希望。 | 你跨过一具古人的尸体。 它看起来跟你如此不同以致可能跟你所认识的所有生物都相异。 颅骨扭曲着，像你的祖先缩水了一样，而且盔甲和武器看起来都不像这个世界的东西。\n\n 你让手下准备前往 %objective2%。 | 泥土里散落着亡灵们残破的尸体。 你跨过它们的尸体时发现你脚下的土地正在回归生气，就好像沃土从躲藏中翻身过来，而且空气本身也更舒畅了。 或许邪恶真的离开了这个地方？ 不论如何，是时候去给 %objective2% 点 %companyname% 的颜色瞧瞧了。 | 随着最后一个亡灵倒下，你环顾了下战场。 这些亡者都不是一个源头来的，可以从他们服装和盔甲的多样性看出来，但是他们同时也不是来自于同一个时代的。 有些穿着古人的盔甲并在杀戮时带着一股令人不安的整齐划一。\n\n %randombrother% 过来，说战队已经准备好前往 %objective2% 了，只等你的命令。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{胜利！ | 乖乖死吧！}",
					function getResult()
					{
						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Aftermath2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{%objective2% 成了一片废墟，尽管从你的视角来看它看起来比以往更好了。 现在该回头去找 %employer% 领报酬了。 | 你给 %objective2% 施加了点正义的修正，把它从亡灵手中夺回到生者的世界中。 你看到草木已经开始变得更加有生气了，还有一阵清爽的微风。%employer% 最后被告知一下好让你拿到报酬。 | %objective2% 里的邪恶被摧毁了。 好吧，除了废墟下零散的几个。 这里还有点黑暗，但是这更多是因为缺少光而不是邪能太多。 不管怎么说，你应该去告诉 %employer% 你做了什么。 | %objective2% 在 %companyname% 作为胜利者屹立于其废墟之上时看起来好多了。 你觉得，一个画家应该搞点什么记录你的成就。%randombrother% 在用他的靴子踩碎僵尸头时格外帅气。 不过拿到 %employer% 的报酬时会看起来更帅。 或许是时候回去找他了。 | %objective2% 被摧毁了，随之而去的还有其中的邪能。 希望它彻底离开了，但是很有可能它只是去了另一个弱点。 说起来，你最好快回去找 %employer% 拿报酬。 | %objective2% 还有其中的邪恶都被扫平了。 空气更轻，更新鲜了。%employer% 应该很高兴听到你报告的结果。 | %companyname% 胜利了，%objective2% 的邪恶安息了，又或许是被赶去了别的地方。 一部分愤世嫉俗的你希望是后者，因为那样别的贵族会想让你去干掉它那么你就又能大赚一笔了。 随着你满脑子寻思着驱邪循环经济，%randombrother% 走过来问是不是时候回去找 %employer% 了。你点头。 一步一下。 | %objective2% 还有它的全部黑暗，残忍的住民都被解决了。 看着战场让人感到很奇怪，散落着的尸体从僵尸程度的新尸体到古人布满尘土的盔甲。 这些尸体比古董店里还多样。\n\n 只要战队扫完战利品，就该回去找 %employer% 领报酬了。 | 死透了的僵尸和古人骷髅散落在地上。 死不死族，用于描述你杀死的无法估量的邪恶的奇怪陈词赘语。 但是它们确实被杀了，证明了这些怪物可以被阻止。 你准备好战队好回去找 %employer% 领取报酬。 | %objective2% 被摧毁了，证明了就算是复苏的亡者也承受不住 %companyname% 战场上的强大破坏力。 随着邪恶被清除，你感到文明和自然在回归这个地方。 鼻子里的空气带着舒心的清爽。 头顶上，鸟们闪过天空。 不仅有在觅食的秃鹫，还有小鸟。\n\n 你告诉战队拿走任何带得走的战利品并准备好回去找 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{胜利！ | 是时候回 %townname%。}",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Necromancers",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_76.png[/img]{你在远处发现了些亡灵巫师。 毫无疑问这些人要为玷污这片土地的大部分邪恶负责。 你不能让他们逃跑！ | %randombrother% 跑到你身边，脸上留着汗。%SPEECH_ON%先生，我们发现了一些不怀好意的人在游荡。%SPEECH_OFF%拿起镜子你看到，在地平线上像蚂蚁在它们的土丘上忙碌一样，几个灰衣人后带着一层恶疾般的薄雾。 你拍了拍雇佣兵的肩膀。%SPEECH_ON%好眼神。现在去告诉伙计们说我们有些亡灵巫师要解决了。%SPEECH_OFF% | 你拿起一个望远镜观察附近的区域。 意外的，有几个人在跑着，而且他们不停的回头好像你在追他们一样。 你放大了点好看的更清楚。 昏暗的袍子，苍白的脸，白色的胡子，带着邪教刻印的匕首…亡灵巫师！ 如果要解决这片土地上的邪恶，他们就需要被抓到并杀死。 | %randombrother% 报告有几个奇怪的人被看到正逃离 %companyname%。你耸耸肩并告诉他逃离一个雇佣兵团是很正常的。 他点了点头，然后补充道。%SPEECH_ON%是，当然，但是这些灰白的人穿着黑袍子而且我非常确信他们身边跟着几个看起来死挺的尸体。%SPEECH_OFF%这些描述符合一个亡灵巫师的形象。 战队应该在他们逃跑前追上他们 | 在检查地图的时候，%randombrother% 走过来汇报侦查结果。%SPEECH_ON%我们找到了几个亡灵巫师，先生。 老人，奇怪的武器，发光的眼睛，几个尸体朋友，还有些动作。%SPEECH_OFF%如果他们真的是亡灵巫师，他们非常有可能要为这片土地上的邪恶负责并应当被尽快铲除。 | 亡灵巫师！低鸣着，偷偷摸摸走着的人在尸体和其它“友军”的保护下缓慢的走着。 他们应该被马上解决！ | 亡灵巫师！黑暗技艺的研习者，这些人无疑要为这片土地上传播的邪恶负责。 他们应该被逮捕并杀死！ | %randombrother% 交给你一个望远镜。 从中看过，你快速确认了他的报告：一些亡灵巫师在那里，赶着通过附近的一个峡谷并且无疑在试图躲避 %companyname%。你收起望远镜并告诉那个雇佣兵去通知手下都做好准备。 这些亡灵巫师必须被尽快猎杀！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "追上他们！",
					function getResult()
					{
						local tile = this.Contract.m.Objective2.getTile();
						local banner = this.Contract.m.Objective2.getBanner();
						this.Contract.m.Objective2.die();
						this.Contract.m.Objective2 = null;
						local playerTile = this.World.State.getPlayer().getTile();
						local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getNearestSettlement(playerTile);
						local party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Necromancers", false, this.Const.World.Spawn.UndeadScourge, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getSprite("banner").setBrush(banner);
						party.setFootprintType(this.Const.World.FootprintsType.Undead);
						party.getSprite("body").setBrush("figure_necromancer_01");
						party.setSlowerAtNight(false);
						party.setUsingGlobalVision(false);
						party.setLooting(false);
						this.Const.World.Common.addTroop(party, {
							Type = this.Const.World.Spawn.Troops.Necromancer
						}, false);
						this.Const.World.Common.addTroop(party, {
							Type = this.Const.World.Spawn.Troops.Necromancer
						}, true);
						this.Contract.m.UnitsSpawned.push(party);
						this.Contract.m.Target = this.WeakTableRef(party);
						party.setAttackableByAI(true);
						party.setFootprintSizeOverride(0.75);
						local c = party.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
						local roam = this.new("scripts/ai/world/orders/roam_order");
						roam.setPivot(camp);
						roam.setMinRange(1);
						roam.setMaxRange(10);
						roam.setAllTerrainAvailable();
						roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
						roam.setTerrain(this.Const.World.TerrainType.Shore, false);
						roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
						c.addOrder(roam);
						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NecromancersFail",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_36.png[/img]{亡灵巫师的踪迹消失了。 如果这个世界有什么力量能复苏它就好了。 | 你没能跟上那些亡灵巫师。 你不知道他们去了哪里，但是无疑他们带着他们的邪恶一起跑了。 | 怎么回事？你怎么让亡灵巫师跑掉的？ 现在他们可以自由的到处杀人，到任何地方散播他们的邪恶。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不，不，不！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "未能摧毁亡灵天灾的据点");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "NecromancersAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{亡灵巫师被消灭了。 他们心中的邪恶也通过利刃显露了出来。 他们不会再袭扰这片土地了。 | 亡灵巫师死在地上，最终加入了他们不负责任地招募起来的军队。 | 你俯视着一个亡灵巫师，仔细观察一个会这么残忍的唤起死者去为他们战斗的人。 他的嘴依然扭曲着，好似准备好要喊出又一段邪恶咒语。 幸运的是，都结束了。 不论残酷与否，他只是个人。 | 你低头看着亡灵巫师消瘦、病态的脸。%randombrother% 走过来吐了口唾沫，花生一样径直的落在尸体的脸颊上。%SPEECH_ON%去死吧，它们吓不到我。%SPEECH_OFF%你点头。随着唾沫流下亡灵巫师的脸，你看到它的眼睛短暂的泛出红光。 你想或许最好不要告诉雇佣兵这件事情。 | 亡灵巫师们被杀掉了，尽管它们眼里的光令人的不安的久久没有消散。%randombrother% 仍然看起来对于这场战斗很骄傲。%SPEECH_ON%看看他们。都死了。%SPEECH_OFF%他向前弯腰，手抵着膝盖，像对着个聋子一样对着一具尸体的脸大声喊道。%SPEECH_ON%你的死朋友呢？哼？ 噢对，你现在也死了！真可惜！%SPEECH_OFF%你告诉他放松点不然这些黑魔法师死后还有影响。 | 这群肮脏的人被杀死了。 毫不意外的，一个死掉的亡灵巫师看起来很像个普通死人。 | 亡灵巫师被安排了而他们对这片土地的黑暗控制也被剥夺了。 无疑你很好的做掉了荼毒这片土地的不少邪能。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "少了件要担心的事。",
					function getResult()
					{
						this.Flags.set("IsNecromancers", false);
						this.Flags.set("IsNecromancersSpawned", false);
						this.Flags.set("ObjectivesDestroyed", this.Flags.get("ObjectivesDestroyed") + 1);
						this.Contract.m.Target = null;

						if (this.Flags.get("ObjectivesDestroyed") == 2)
						{
							this.Contract.setState("Return");
						}
						else
						{
							this.Contract.getActiveState().start();
							this.World.Contracts.updateActiveContract();
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Bandits",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{在你前往 %objective% 时，你遇到了一群强盗。 他们转头并拔出了他们的武器，而 %companyname% 也拔出武器作为回应。 你举起手，流浪汉的领袖也做了同样的事情，降低了两方之间的紧张感。那个领头的说话了。%SPEECH_ON%战利品是我们的，我们先来的而且，如果你敢跟我们抢，最后活下来也会是我们！%SPEECH_OFF%看起来他们只是想要抢劫这个地方。 干这件事会需要杀很多僵尸，这肯定是有益的。 或许你们可以联合起来？ 不论你怎么选，快点，因为亡灵们来了！ | 一群强盗准备要进攻 %objective%！他们拔出武器威胁要攻击，但你谈判了一段时间，看出来他们只是想抢劫这个地方。 或许 %companyname% 可以和他们一起战斗？ 又或者见鬼去吧，杀光他们，亡灵和强盗，并拿走一切。 | 随着你接近 %objective%，你遇到一群强盗。 他们在准备进攻－不是 %companyname%，而是这个地方。 看起来他们只是想要里面可能有的战利品并且会跟你抢。 或许你可以加入他们，代价是一些可能的战利品，又或者杀掉一切会动的东西并把财富和荣耀留给自己。 不过，快点选，因为亡灵们来了！ | 强盗！一群强盗，全副武装并准备好进攻。 幸运的，他们是想进攻 %objective%。 或许 %companyname% 可以加入他们，但是毫无疑问这些流浪汉会想要分很大一部分战利品。 另一个选项是杀掉一切并自己拿走战利品。 不过，最好快点选，因为亡灵们来了！ | 你遇到了几个全副武装的人。 他们快速转身来面对你，武器在手。%randombrother% 拔出利刃并威胁要杀死第一个动的人。 尽管局势紧张，你和流浪汉们的领头成功冷静下来讨论了一番。 他解释道他们是到这来抢劫 %objective% 拿走所有战利品的。 你可以和这些盗贼合作或者，如果你想拿走所有的战利品，把他们和僵尸都杀掉。 | %randombrother% 走开去撒尿，但是从草丛边跳开，一半在拉起裤子，一半试图拔出真正的武器。 一个强盗从草丛里出现，手里已经拔出利刃，然后很快一大群人喊着涌了出来，%companyname% 也同样吼了回去。 他们的领头走出来，举起手，并要求跟首领说话。\n\n 在你们弹的时候，你了解到他们是一群正在寻宝的流浪汉正想抢劫 %objective%。你可以加入他们并一起和亡灵作战，否则他们会同时和你还有亡灵敌对因为他们不是到这里来和佣兵瓜分战利品的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们有一个共同的目标。 让我们一起进攻！",
					function getResult()
					{
						this.Flags.set("IsBanditsCoop", true);
						this.Contract.m.Current.getLoot().clear();
						this.Contract.m.Current.setDropLoot(false);
						this.Contract.getActiveState().onCombatWithPlayer(this.Contract.m.Current, false);
						return 0;
					}

				},
				{
					Text = "我们不是来分享战利品的。 这里就是你们的终点！",
					function getResult()
					{
						this.Flags.set("IsBandits3Way", true);
						this.Contract.getActiveState().onCombatWithPlayer(this.Contract.m.Current, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BanditsAftermathCoop",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{这地方的邪恶消散了。 在跟强盗们分赃后，你准备朝 %objective2% 去，确保没有告诉这些盗贼这件事。 | 随着最后的一个亡灵安息，你感到空气在变得清澈，就好像微风吹开薄雾，春天的气息。 气味的变化无疑意味着你解决这里的东西。 你跟强盗分了脏。 他们有点谄媚，声称如果不是有他们在你们活不下来。 你几乎要告诉他们 %objective2% 但是这不恰当的骄傲让你不再想和他们一起共事。 | 这个地方的邪能被安息了。 %objective2% awaits.\n\n 你和强盗们分了赃，他们显然非常高兴跟你共事。 他们没有说出来，但是很显然如果你不在这他们很可能早被杀光了。 | 随着这可怕的地方被净化，只剩下 %objective2% 留在合同上了。 至于强盗们，他们拿走了说好的战利品。 他们问你要去哪里而你告诉他们这和他们无关。 | 随着最后一个僵尸安息，你感到空气中突然产生了变化。 站在一片泥泞的土地里却有一股意外纯洁的感觉侵入肺腑。%randombrother% 抹了抹额头。%SPEECH_ON%肯定是结束了。 接下来去 %objective2%？%SPEECH_OFF%随着一个强盗走过来，你告诉雇佣兵闭嘴。 最好不要告诉这些杂种下个地点。 尽管拿了很大一部分战利品，他们在战斗中根本没帮上多少忙。 | 你进入了一个邪恶的领域，但随着最后一个僵尸被击倒你感到光在变亮而且脚下土地的气味回归正常。 随着这个地方安息，是时候去 %objective2%。\n\n 强盗们的领头走上来。 他手里拿着个卷轴并记录着要分的战利品。%SPEECH_ON%很高兴和你共识，佣兵。%SPEECH_OFF%你告诉他，他的这队蠢货如果不是你没出现就是在自投死路。他耸耸肩。%SPEECH_ON%没人是完美的。下次见？%SPEECH_OFF%你无视他前去召集手下。 | 胜利来之不易。 僵尸和些奇怪的更古老的亡灵散落在战场上。 你合作的强盗正搜索着残骸，按说好的一样拿走他们那一份战利品。 你希望 %objective2% 会更轻松点，但是你不抱太大希望。 | 强盗搜索着战场拿走你和他们的领头说好的他们那份。 你告诉 %randombrother% 安静的让手下准备出发去 %objective2%。他悄悄问你原因而你回答道。%SPEECH_ON%因为我们不需要这些没用的老鼠屁出现在下场战斗里拿走我们都知道他们不配拿的战利品。%SPEECH_OFF%那佣兵点了点头。%SPEECH_ON%啊。我得说你把我想说的都说出来了，但你在敌意上更有创意，先生。%SPEECH_OFF% | 你开始准备让手下前往 %objective2%。\n\n 强盗的头领找到你。%SPEECH_ON%很高兴和你一起战斗。 说说，你们接下来要你去哪？ 更多宝藏要找，嗯？%SPEECH_OFF%你转身抓着他的衣服。%SPEECH_ON%我想我们都知道谁在那场战斗中干了大头。 现在拿上你的战利品滚。 我们的合作到此为止。 如果你尾随我们，我会把你偷的所有东西融成液态倒在你该死的头上，明白吗？%SPEECH_OFF%他缩了回去，焦急的点着头好像你马上就会兑现这个承诺。 | 随着最后一个亡灵倒下，你环顾了下战场。 这些亡者都不是一个源头来的，可以从他们服装和盔甲的多样性看出来，但是他们同时也不是来自于同一个时代的。 有些穿着古人的盔甲而且在杀戮时带着种令人不安的整齐划一。\n\n %randombrother% 走过来，说队伍已经做好准备向 %objective2% 进发了，只等你的命令。 强盗的头领插了进来。%SPEECH_ON%好，等我们分好脏，对吗？%SPEECH_OFF%你点头。毕竟这是你们之前就谈好了的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Flags.set("IsBanditsCoop", false);

						if (this.Flags.get("ObjectivesDestroyed") == 2)
						{
							this.Contract.setState("Return");
						}
						else
						{
							this.Contract.getActiveState().start();
							this.World.Contracts.updateActiveContract();
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BanditsAftermath3Way",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你在尸体堆间找到了强盗的首领。 他脸上表露出些许后悔，比那些通常来说自寻死路的人要更多一点的那种。 啊好吧，多么令人悲伤。 你集结手下准备前往 %objective2%。 | 强盗领袖躺在地上，死了。 半张脸不见了，之后很快在附近的一只僵尸嘴里找到。真可惜。 啊，是时候去 %objective2%。 | 解决了亡灵，还有那些以为能够对抗 %companyname% 的强盗蠢货，现在只剩下去 %objective2% 了。 | 强盗的决策毫不明智，同时与亡灵和 %companyname% 交战。令人震惊的，事情发展并没有顺着他们意走。 你命令手下收集好战利品就准备出发去 %objective2%。 | 随着最后的一个亡灵安息，你感到空气在变得清澈，就好像微风吹开薄雾，春天的气息。 气味的变化无疑意味着你解决这里的东西。 不幸的，那群决定要面对你的死强盗要污染一下它了。噢好吧。 现在是时候去净化 %objective2% 然后了结这桩合同了。 | 这个地方的邪能被安息了。 还有那些可怜的蠢货强盗一起。还剩下 %objective2%。 | 随着最后的僵尸被安息，还有边上一起倒下的最后一个蠢贼，你感到焕然一新。 一部分是给这些强盗展示了下把他们都害死的头领有多么糟糕。 另一部分无疑是因为邪能离开的顺畅感受。 是时候去 %objective2%。 | 胜利来之不易。 不得不说，亡灵们打的不错。 强盗们则像他们确实就是的一群蠢货一样死了。 你希望解决 %objective2% 会更轻松点，但除非它里面都是群弱智盗贼而不是亡灵，你对此不抱太大希望。 | 你发现强盗头领的尸体倒在一具僵尸的尸体上。%randombrother% 走过来嘲笑。%SPEECH_ON%看起来他们命定如此。%SPEECH_OFF%笑着，你告诉他去让手下们准备好前往 %objective2%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "他们罪有应得。",
					function getResult()
					{
						this.Flags.set("IsBandits3Way", false);

						if (this.Flags.get("ObjectivesDestroyed") == 2)
						{
							this.Contract.setState("Return");
						}
						else
						{
							this.Contract.getActiveState().start();
							this.World.Contracts.updateActiveContract();
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 以沉稳举起的酒杯和欢呼着的少妇欢迎你进入他的房间。 他的这一幕对于这充满了行尸的世界而言真是充满了活力。 你被醉酒的贵族交付了 %reward_completion% 克朗并被他的一个卫兵推了出去。 | 你走进 %employer%的房间看到他和一个女人站在一个桌子边。 上面又一个非常苍白的孩子，他没在动。 母亲沉默的哀悼着，她的脸执行着所有她该做的号啕大哭。 你打断了这悲哀的气氛来报告给贵族你的任务完成了。他点头。%SPEECH_ON%我知道。有传言说，一旦你回来了，或许被熄灭的邪能会给这片土地带来新的生命。 土壤比以往更肥沃了，但是亡者依然安息。 你的报酬就在角落里，佣兵。%SPEECH_OFF%你走过去拿上了属于你的 %reward_completion% 克朗。%employer% 在你离开时依然在安慰那个女人。 | 一个卫兵把你带到 %employer%的一个藏身处，一个就几平方的算不上房间的地方。 贵族的卷轴堆到鼻子高，但是看到你时立刻弹直了起来。%SPEECH_ON%佣兵！我正等着你呢！ 进来，进来。%SPEECH_OFF%他把文件放到一边从地上捡起一个袋子。%SPEECH_ON%%reward_completion% 克朗和我们谈好的一样。 有传言说邪能完全离开了这片土地。 我不太确认，但是毫无疑问你的胜利确保这场战争中的优势。做得好，雇佣兵。%SPEECH_OFF% | %employer% 一只手招你进房间而用另一只手提着一包克朗。%SPEECH_ON%你不必跟我汇报给我听，佣兵，因为的小鸟们已经告诉了我一切。 你的报酬，和我们谈好的一样。%SPEECH_OFF% | %employer% 热情的欢迎你，尽管一个鹰钩鼻的书记驮着背愤怒的站在角落里好像你是来抢食物的。 你报告了你的行动，但是贵族甩了甩手。%SPEECH_ON%噢佣兵，我知道这片土地上发生的一切。 你赢得了 %reward_completion% 克朗。%SPEECH_OFF%书记员突然开口，惊到了 %employer%。%SPEECH_ON%确实邪恶被摧毁而一切美好的事物能开始再生！ 现在，雇佣兵，请你离开。 我们这里还有重要的事情要谈。%SPEECH_OFF%哼，是的，当然。 你拿上报酬离开了。 | 你在马厩里找到了 %employer%。 马厩被清空了而且也没有马倌在附近。 看到了你，他快速与你握手。%SPEECH_ON%真高兴见到你，佣兵。 我已经听说了你的成功。 你为这片土地卸下了邪恶的脚拷并给了它新生的生命与活力。至少，目前。 走到卫兵那里然后他会带你去司库那里拿你应得的 %reward_completion% 克朗的。%SPEECH_OFF% | 你发现 %employer% 正站在一座新掩埋的坟墓。 几个司事坐在附近分享着一个羊皮水瓶。贵族耸肩。%SPEECH_ON%那个男孩留在了土里。 所以你不仅摧毁了邪能的源头，佣兵，你很可能还把它们从这片赶走了一些。 众神啊我希望如此。 你的报酬在司库那里。 他有你被许诺的 %reward_completion% 克朗。%SPEECH_OFF% | 你找到 %employer% 时在跟一个药剂师说话。 那个医师有一推车的尖锐工具，有些斜放在一盆红色的水里。 看着贵族，你看出来他最近刚包扎了下他的手臂。他招手唤你进去。%SPEECH_ON%一次野猪狩猎出了差错，佣兵。%SPEECH_OFF%医师整理干净并离开了，告诉贵族修养一个星期。%SPEECH_ON%好的好的，我有事情要解决。 首先是你，雇佣兵。 你的报酬在角落里，%reward_completion% 克朗和说好的一样。 谁知道亡灵们的邪能是不是真的从这片土地上驱逐了呢，但你完成了任务。%SPEECH_OFF% | %employer% 在你进入时正跟一个女人说话。 他发出了一段时间以来最奇怪的声明。%SPEECH_ON%我的小男孩留在了土里！ 他没有回来！ 我太高兴了！他死了！%SPEECH_OFF%贵族温柔的牵起他的手并向你点头。%SPEECH_ON%而那里正站着那个从这片土地驱离邪能的人。 你赢得了这 %reward_completion% 克朗，佣兵！%SPEECH_OFF% | 你看到 %employer% 与一个邋遢的小狗崽。 它漫步四周，扒拉着光滑的石头地板追着一根木棍到处跑。 贵族把木棍丢到你的脚边而小狗崽跃向它，撞到了你的靴子上。%SPEECH_ON%那条狗之前连动都不愿意动一下，但现在它玩的停不下来。 现在，如果我是个赌徒，我会打赌这跟你和那些亡灵发生的事有关，佣兵。干得好。 你的报酬是 %reward_completion% 克朗，如同约定的，或者你可以带走这只小狗。%SPEECH_OFF%你说你选小狗。 贵族惊讶的往后缩了一下。%SPEECH_ON%不，你得拿这些克朗。 小狗得跟着我。%SPEECH_OFF%汪汪。 | 你走进 %employer%的房间看到他盯着窗外。 他乐观诚挚的说道。%SPEECH_ON%活起来了。一切都活起来了。%SPEECH_OFF%他转身，露出手里拿着的袋子。 他走过来把它交给了你。%SPEECH_ON%%reward_completion% 应该都在这里。 干得好，佣兵，并且愿你这里的贡献让我们离彻底结束这场灾难更近一步。%SPEECH_OFF% | %employer% 用一大罐葡萄酒欢迎了你。 它有一股铁味，但你肯定不会指出来。 贵族充满活力地走向他的办公桌。%SPEECH_ON%干得好，佣兵。天知道没有你这样的人这片土地会变成什么样。 我向旧神们祈祷，很快有一天，我们能完全消除全部这些邪能！%SPEECH_OFF% | 一个卫兵在 %employer%的房间外遇见了你。 他看着你，特别瞩目着你肩上的 %companyname% 肩章。%SPEECH_ON%这里，佣兵。%employer% 非常忙，但他告诉我向你道谢。%SPEECH_OFF%你被交付了 %reward_completion% 克朗。 | 一个苍白，光滑皮肤的司库在通往 %employer%的大厅里接待了你。 他带着一袋克朗，快速地交给了你。%SPEECH_ON%你的报酬就在那，跟说好的一样。 我的领主正忙着和他的文书们怎么更好讨论解决这可怕的亡灵问题。%SPEECH_OFF% | 你发现 %employer% 正刮着胡子，一个疲劳而皱眉的女人为他举着一面镜子。%SPEECH_ON%吼，佣兵。嗷。嗨。%SPEECH_OFF%他把刮胡刀叩到一盆水里几下之后赶到了他的办公桌边。%SPEECH_ON%我的小鸟们已经告诉了我你的行动。 不只是那个，还有所有人都看起来好多了！ 孩子们再次开怀大笑，阳光更叫耀眼，庄稼也正长壮！所有人都很开心！%SPEECH_OFF%女人问她可不可以放下镜子。贵族打了个响指。%SPEECH_ON%你安静下。现在，佣兵。%reward_completion% 克朗，跟我们谈好的一样。%SPEECH_OFF% | 你发现 %employer% 不在他的房里，而是在一个只有微小的几根蜡烛照明的昏暗房间里。 有个人在这滴着水，潮湿的房间里被锁链吊着。 从他的表情来看，他看起来宁愿被绳子吊死。 贵族手叉在背后，同时一个戴着黑兜帽的人物用手指在一盘刀具上犹豫不决地划过。 你咳了一声。%employer% 转过来。%SPEECH_ON%啊是的，佣兵！我正等着你呢！ 这儿，%reward_completion% 克朗，如同约定的。 希望这次亡灵们会乖乖离开。 但是不论发生什么，你都因铲除那些邪能帮了很大忙。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "摧毁了亡灵天灾的据点");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isUndeadScourge())
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
			"objective1",
			this.m.Flags.get("Objective1Name")
		]);
		_vars.push([
			"objective2",
			this.m.Flags.get("Objective2Name")
		]);
		local distToObj1 = this.m.Objective1 != null && !this.m.Objective1.isNull() && this.m.Objective1.isAlive() ? this.m.Objective1.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) : 9999;
		local distToObj2 = this.m.Objective2 != null && !this.m.Objective2.isNull() && this.m.Objective2.isAlive() ? this.m.Objective2.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) : 9999;

		if (distToObj1 < distToObj2)
		{
			_vars.push([
				"objective",
				this.m.Flags.get("Objective1Name")
			]);
		}
		else
		{
			_vars.push([
				"objective",
				this.m.Flags.get("Objective2Name")
			]);
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Objective1 != null && !this.m.Objective1.isNull() && this.m.Objective1.isAlive())
			{
				this.m.Objective1.getSprite("selection").Visible = false;
				this.m.Objective1.setOnCombatWithPlayerCallback(null);
			}

			if (this.m.Objective2 != null && !this.m.Objective2.isNull() && this.m.Objective2.isAlive())
			{
				this.m.Objective2.getSprite("selection").Visible = false;
				this.m.Objective2.setOnCombatWithPlayerCallback(null);
			}

			if (this.m.Target != null && !this.m.Target.isNull() && this.m.Target.isAlive())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Current = null;
			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return false;
		}

		if (this.m.IsStarted)
		{
			if (this.m.Objective1 == null || this.m.Objective1.isNull() || !this.m.Objective1.isAlive())
			{
				return false;
			}

			if (this.m.Objective2 == null || this.m.Objective2.isNull() || !this.m.Objective2.isAlive())
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
		if (this.m.Objective1 != null && !this.m.Objective1.isNull())
		{
			_out.writeU32(this.m.Objective1.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Objective2 != null && !this.m.Objective2.isNull())
		{
			_out.writeU32(this.m.Objective2.getID());
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
		local obj1 = _in.readU32();

		if (obj1 != 0)
		{
			this.m.Objective1 = this.WeakTableRef(this.World.getEntityByID(obj1));
		}

		local obj2 = _in.readU32();

		if (obj2 != 0)
		{
			this.m.Objective2 = this.WeakTableRef(this.World.getEntityByID(obj2));
		}

		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

