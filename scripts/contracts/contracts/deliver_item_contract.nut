this.deliver_item_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Location = null,
		RecipientID = 0
	},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(70, 105) * 0.01;
		this.m.Type = "contract.deliver_item";
		this.m.Name = "武装信使";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local recipient = this.World.FactionManager.getFaction(this.m.Destination.getFactions()[0]).getRandomCharacter();
		this.m.RecipientID = recipient.getID();
		this.m.Flags.set("RecipientName", recipient.getName());
		this.contract.start();
	}

	function setup()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (this.m.Home.isIsolated() || s.isIsolated() || !this.m.Home.isConnectedToByRoads(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Home.getTile().getDistanceTo(s.getTile());

			if (d < 15 || d > 100)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10)
			{
				local distance = this.getDistanceOnRoads(this.m.Home.getTile(), s.getTile());
				local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

				if (this.World.getTime().Days <= 5 && days >= 2)
				{
					continue;
				}

				if (this.World.getTime().Days <= 10 && days >= 3)
				{
					continue;
				}
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[this.Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, this.Const.World.MovementSettings.Speed, false);

		if (days >= 2 || distance >= 40)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		}

		this.m.Payment.Pool = this.Math.max(125, distance * 4.5 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Distance", distance);
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"将货物交付给位于%objective%的%recipient%，目标在%direction%大概%days%路程。"
				];
				local isSouthern = this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState;

				if (!isSouthern && this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else if (isSouthern)
				{
					this.Contract.setScreen("TaskSouthern");
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
					if (this.Contract.getDifficultyMult() >= 0.95 && this.World.Assets.getBusinessReputation() > 750 && (!this.World.Ambitions.hasActiveAmbition() || this.World.Ambitions.getActiveAmbition().getID() != "ambition.defeat_mercenaries"))
					{
						this.Flags.set("IsMercenaries", true);
					}
				}
				else if (r <= 15)
				{
					if (this.World.Assets.getBusinessReputation() > 700)
					{
						this.Flags.set("IsEvilArtifact", true);

						if (!this.World.Flags.get("IsCursedCrystalSkull") && this.Math.rand(1, 100) <= 50)
						{
							this.Flags.set("IsCursedCrystalSkull", true);
						}
					}
				}
				else if (r <= 20)
				{
					if (this.World.Assets.getBusinessReputation() > 500)
					{
						this.Flags.set("IsThieves", true);
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
				this.Contract.m.BulletpointsObjectives = [
					"将货物交付给位于%objective%的%recipient%，目标在%direction%大概%days%路程。"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Destination) && !this.Flags.get("IsStolenByThieves"))
				{
					if (this.Flags.get("IsEnragingMessage"))
					{
						this.Contract.setScreen("EnragingMessage1");
					}
					else
					{
						local isSouthern = this.Contract.m.Destination.isSouthern();

						if (isSouthern)
						{
							this.Contract.setScreen("Success2");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

					foreach( party in parties )
					{
						if (!party.isAlliedWithPlayer)
						{
							return;
						}
					}

					if (this.Flags.get("IsMercenaries") && this.World.State.getPlayer().getTile().HasRoad)
					{
						if (!this.TempFlags.get("IsMercenariesDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("Mercenaries1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsMercenariesDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && !this.Flags.get("IsEvilArtifactDone"))
					{
						if (!this.TempFlags.get("IsEvilArtifactDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && this.Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("EvilArtifact1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsEvilArtifactDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && this.Flags.get("IsEvilArtifactDone"))
					{
						this.Contract.setScreen("EvilArtifact3");
						this.World.Contracts.showActiveContract();
						this.Flags.set("IsEvilArtifact", false);
					}
					else if (this.Flags.get("IsThieves") && !this.Flags.get("IsStolenByThieves") && this.World.State.getPlayer().getTile().Type != this.Const.World.TerrainType.Desert && (this.World.Assets.isCamping() || !this.World.getTime().IsDaytime) && this.Math.rand(1, 100) <= 3)
					{
						local tile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 5, 10, [
							this.Const.World.TerrainType.Shore,
							this.Const.World.TerrainType.Ocean,
							this.Const.World.TerrainType.Mountains
						], false);
						tile.clear();
						this.Contract.m.Location = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/bandit_hideout_location", tile.Coords));
						this.Contract.m.Location.setResources(0);
						this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).addSettlement(this.Contract.m.Location.get(), false);
						this.Contract.m.Location.onSpawned();
						this.Contract.addUnitsToEntity(this.Contract.m.Location, this.Const.World.Spawn.BanditDefenders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Const.World.Common.addFootprintsFromTo(this.World.State.getPlayer().getTile(), tile, this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
						this.Flags.set("IsStolenByThieves", true);
						this.Contract.setScreen("Thieves1");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "EvilArtifact")
				{
					this.Flags.set("IsEvilArtifactDone", true);
				}
				else if (_combatID == "Mercs")
				{
					this.Flags.set("IsMercenaries", false);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "EvilArtifact")
				{
					if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == this.Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "无法交付货物。");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "无法交付货物。");
					}

					this.World.Contracts.removeContract(this.Contract);
				}
				else if (_combatID == "Mercs")
				{
					if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == this.Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "无法交付货物。");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "无法交付货物。");
					}

					this.World.Contracts.removeContract(this.Contract);
				}
			}

		});
		this.m.States.push({
			ID = "Running_Thieves",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = true;
				}

				this.Contract.m.BulletpointsObjectives = [
					"跟踪盗贼的踪迹并找回你的货物",
					"将货物交付给位于%objective%的%recipient%，目标在%direction%大概%days%路程。"
				];
			}

			function update()
			{
				if (this.Contract.m.Location == null || this.Contract.m.Location.isNull())
				{
					this.Contract.setScreen("Thieves2");
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
			Text = "[img]gfx/ui/events/event_112.png[/img]{%employer%甚至还未开口，他已经把一个相当大的板条箱兜揽在了你手中。%SPEECH_ON%看看这，我需要运输的货物已经找到了一个合适的人送货了！真是太妙了！%SPEECH_OFF%他收敛了一下。%SPEECH_ON%我需要运往%objective%的货物，有个叫%recipient%的人在那里等着它。这箱看似不大，但我愿意为了它的安全支付不少克朗。你感兴趣吗？还是太重了，需要我的帮助？%SPEECH_OFF% | 你看见%employer%正在关上箱子。他看了一眼，好像被抓住了把柄。%SPEECH_ON%雇佣军！谢谢你的赶来。%SPEECH_OFF%他迅速地拍了几下箱子，甚至还用力倚在它上面像需要一个更坚实的锁一样。%SPEECH_ON%这里面的货物必须安全送到%objective%，有个叫%recipient%的人在那里等着它。因为这货物对某些人来说相当珍贵，他们会不惜一切代价来窃取它，所以我找上了你这样经验丰富的人。你有兴趣帮我完成这个任务吗？%SPEECH_OFF% | 当你进入%employer%的房间时，他和他的一个仆人正在钉上一个盒子。%SPEECH_ON%好见到你，佣兵。请稍等一下。不，笨蛋，把钉子那样拿着！我知道我以前打过你的拇指，但我不会再打了。%SPEECH_OFF%他的仆人勉强拿着钉子，而他则把它锤入木板。完成后，他擦了擦额头上的汗水，看向了你。%SPEECH_ON%我需要这个箱子交付给%direction%%days%路程的%objective%。你知道%recipient%吗？就是他。好吧，也许你不认识他。但我知道的是，这可能不是你通常的工作范围，但我愿意支付一笔不小的克朗让你完成。只要有克朗你就不会在乎，对吧？%SPEECH_OFF% | %employer%看到你时，双手合十。%SPEECH_ON%这可能是一个奇怪的问题，但你有兴趣给我送货吗？%SPEECH_OFF%你解释说，只要给出合适的价格，这样的旅程对你来说是一个受欢迎的转变，比起你周围一直发生的杀戮和死亡。这个人拍了拍手。%SPEECH_ON%太好了！不幸的是，我并不指望它会像你说的那样顺利。这件事足以引起不良关注，这也是我首先要雇佣佣兵的原因。你需要前往距离这 %days%左右 在 %direction% 的 %objective%, 将它交给叫%recipient%的人。所以，你看，这不会是你所说的“转变”，但如果你有兴趣，这会是一笔不错的报酬。%SPEECH_OFF% | %employer%的手下们正在一个货物旁站着。当他看到你时，他把他们赶走。%SPEECH_ON%欢迎，欢迎。见到你很高兴。我需要武装保卫以将这个包裹送到%objective%的一个名叫%recipient%的人手中。我估计对你们这样的队伍来说，这大概需要%days%。你对这件事有多少兴趣？%SPEECH_OFF% | [%employer%]在你进去的时候，双手抱后头，把脚放在桌子上，看起来有些过于放松，不太符合你的胃口。%SPEECH_ON%好消息，队长。你怎么看暂停杀戮和死亡。%SPEECH_OFF%他对你的回答皱起了眉头，但你没有回答。%SPEECH_ON%嗯，我以为你会乘机抓住这个机会。不过没事，这是个谎言：我需要你把一个包裹送到%objective%居住的那个人%recipient%那里。这个货物无疑引起了一些别有用心的人的注意，所以我需要你的人看守它。如果你有兴趣——你应该有——我们谈谈数字吧。%SPEECH_OFF% | %employer%欢迎你，挥手让你进去。%SPEECH_ON%很好，既然你来了，请你关上门好吗？%SPEECH_OFF%他的一名卫兵把头从角落里探出来。你微笑着把他推了出去。转身时，你发现%employer%正朝着窗户走来。他一边说着话，一边凝视着窗外。%SPEECH_ON%我需要一样东西……嗯，你不需要知道是什么，我需要这个‘东西’送到一个叫做%recipient% 的人那里。他正在%objective%等着它。这确实很重要，重要到需要有武装护卫%days%天的旅程，这就是为什么我向你和你的战团寻求帮助。你这个雇佣兵怎么说？%SPEECH_OFF% | 昏暗的蜡烛几乎令整间屋子变得黑暗，只有微弱的灯光勉强让你看到%employer%坐在桌子后面，而他的阴影则被闪烁的灯光投射在墙上。%SPEECH_ON%如果我付你足够的钱，你会拿起剑为我效劳吗？我需要将{一个小箱子 | 对我很重要的东西 | 有价值的东西}安全送到%objective%的%recipient%手中，需要%days%天路程，方向是离这里 %direction% 。这件事导致人为之死，所以你必须做好准备为此而战。%SPEECH_OFF%他停顿了一下，衡量着你的反应。%SPEECH_ON%我会写一封密封的信件，里面有交付物品后付款的指示，你需要将物品交给我在%objective%的联系人。你怎么看？%SPEECH_OFF% | 一名仆人让你等待%employer%，他说他马上就来。于是你等啊等，等到再次离开的时候%employer%大声开门走了出来。%SPEECH_ON%这位雇佣军，是谁？%SPEECH_OFF%他的助手点了点头，%employer%露出了微笑%。%SPEECH_ON%能在%townname%遇到你，真是太幸运了，好队长！”。\n\n这是至关重要的，我的一些贵重物品能够安全快速地到达%objective%。你就是我需要的人，因为没有普通的强盗敢袭击你和你的队员。\n\n是的，我想雇佣你们担任护卫。确保物品被送到%recipient%，当然不要绕路。我们可以愉快地合作吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈价钱。 | 你愿意为此出多少克朗？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{不感兴趣。 | 这和我们的旅行计划不顺路。 | 这不是我们要找的工作。}",
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
			ID = "TaskSouthern",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_112.png[/img]{一位维齐尔的市政大臣带着一队仆人走近，他们正朝着你的方向扛着一个适中大小的箱子。%SPEECH_ON%克朗王子，维齐尔需要你的帮助。请让这些仆人将箱子交给你，并将其运送到%objective%的%recipient%那里，这是一条往%direction%的路程，大约需要%days%。%SPEECH_OFF%市政大臣鞠了一躬。%SPEECH_ON%虽然这是一个简单的任务，但维齐尔愿意为完成任务支付丰厚的报酬。%SPEECH_OFF% | 你发现%employer%正在门厅等待。他在听着一排商人，每个商人都有自己的请求或提议，而手边的一位书记则在账簿上做着记录，账簿在大理石地板上一层接一层地展开。看到你，维齐尔响了响手指，一名离他不远处的人走了过来。%SPEECH_ON%克朗王子，陛下需要你的服务。将标有这个标签的货物交给%objective%的%recipient%，在道路上需要行进%days%。货物送到后，你会得到相应的报酬。%SPEECH_OFF% | 一个戴着孔雀羽毛帽的人向你靠近，似乎出现在你没注意的地方。他手里拿着账簿，但账簿上带有%townname%维齐尔及其护卫的徽章。%SPEECH_ON%%employer%想要雇用你的服务，克朗王子。你需要处理一种优质材料，当然必须将它装在箱子中并妥善封好，然后将其运往%objective%的%recipient%，这是在往%direction%的路上行进%days%。当货物被送达后，你将在现场得到报酬。%SPEECH_OFF%那人把羽毛拨开，短暂地摇了摇头。%SPEECH_ON%你认为这份工作符合你当前的金融愿望吗？%SPEECH_OFF% | 你首先被一只鸽子的便条所招呼，便条指向一个年轻的男孩，然后男孩带你去找一名仆人，仆人引你穿过一间充满裸女的后宫，最终带你进入一个富裕商人的房间。%SPEECH_ON%啊，你终于来了。我向我的债务人提出了一个简单的任务，居然要这么长时间才能完成？我得研究一下这个问题。%SPEECH_OFF%商人抛给你一个账簿，同时跌倒在一堆垫子中。%SPEECH_ON%请你将一箱货物交给%objective%的%recipient%，这是一条往%direction%的路程，需要行进%days%。你不需要打开货物，只需将其交付。如果你打开了货物，维齐尔会知道的。请相信我，克朗王子，维齐尔只喜欢听到好消息。这就是为什么我在这里，而不是在陛下那里。%SPEECH_OFF%这真是太客气了。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈价钱。 | 你愿意为此出多少克朗？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{不感兴趣。 | 这和我们的旅行计划不顺路。 | 这不是我们要找的工作。}",
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
			ID = "Mercenaries1",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{在路上，一群武装士兵挡住了你的道路。 | 他们向%objective%方向行进，其中几个人打断了你平静的旅行，他们武器和盔甲的声音充满了空气，当他们步入队列。 | 不幸的是，你的旅行不会是简单的。一些人挡住了你的路。显然他们是要阻止你前进。 | 一些有武器和盔甲的男人出来制造了一些金属障碍。他们的意图看起来是要确保你不能再前进。 | 一些人停了下来。你上前查看发生了什么，只看到一行武装士兵挡住了%companyname%的路。哎呀，这将非常有趣。}敌方中尉走到前面，用拳头猛击胸口。%SPEECH_ON%{我们就是%mercband%。我们屹立在你们面前。我们杀死了无法想象的野兽，是这个被众神遗忘的土地上的最后希望！ | 名字就是%mercband%，在这片土地上我们以分裂敌人的头颅，狂饮美酒和追求爱情而著名！ | 传说中的%mercband%正在你的面前。我们是%randomtown%的救世主，也是假国王的杀手！ | 看你的队伍，只是些零散的奴隶和贪婪的雇佣兵。然而我们，%mercband%，曾经杀死一百只兽人拯救了一座城市。你们还有什么可以吹嘘的呢？ | 你正在和%mercband%中的一员交流。对我们来说，普通强盗、肮脏的兽人、钱袋或者只穿裙子的人都不能逃脱我们的手心！}%SPEECH_OFF%当这个男子结束他的虚张声势和个人行话之后，他指着你正在搬运的货物。%SPEECH_ON%{既然你意识到你所处的危险，为何不把货物交给我们呢？ | 我希望你意识到了你所面临的是什么，卑鄙的雇佣兵，所以你最好确保你的人能在今晚安然无恙。只要你交出货物，我们就不用把你算在%mercband%的历史中。 | 噢，我猜你肯定想成为我们历史上的一部分，是吗？那太好了，你只需要不交出那个货物，我们就会用剑把你留在上面。当然，如果你把货物交给我们，我们也会放过你。 | 哦，这不是%companyname%吗。尽管我很想把你算在我们的胜利名单中，但作为雇佣兵之间，我可以给你一个机会。只要你交出那个货物，我们就会离开。这听起来怎么样？}%SPEECH_OFF%{嗯，总之请求还是很有泡沫的。 | 不过至少这场戏有趣。 | 虽然你欣赏一些修辞手法，不过这种危险的现实情况仍然很严峻。 | 尽管你欣赏这些华丽的言辞和夸张的表述，但这些人的单词实际上并没有使他们看起来更加危险。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "如果你想要它，就过来拿吧！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Mercs";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "这不值得为之丧生。带走那该死的货物然后离开。",
					function getResult()
					{
						return "Mercenaries2";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Mercenaries2",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{你不想打架，于是将货物交出。他们一边笑着接过货，一边说道：%SPEECH_ON%明智的选择，雇佣兵。也许有一天，你就能变成那个威胁别人的人了。%SPEECH_OFF% | 无论那货是什么，都不值得为之牺牲你手下的人。你将箱子交给雇佣兵，他们离开时嘲笑着你。%SPEECH_ON%就跟追妓女一样！%SPEECH_OFF% | 看上去，这并不是为了%employer%的交货服务而在牺牲你的手下。于是你将货物交出，雇佣兵接走后扔给你一枚克朗硬币，它旋转着掉进了泥里。%SPEECH_ON%去买个鞋油盒吧，小子，这项工作可不适合你。%SPEECH_OFF% | 雇佣兵手持武器，你不知道为了一个可能什么都不是的箱子，是否值得为之付出手下的生命。于是你点头，将货物交出。雇佣兵乐意接受，他们的中尉示意你离开时点了点头，表示尊敬。%SPEECH_ON%明智的选择，在我刚开始时，我也经历了很多这样的选择。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Hrm...",
					function getResult()
					{
						this.Flags.set("IsMercenaries", false);
						this.Flags.set("IsMercenariesDialogTriggered", true);

						if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "无法交付货物。");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "无法交付货物。");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 0.5);
						}

						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BountyHunters1",
			Title = "在路上…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{在路上，你遇到了一群赏金猎人。他们的囚犯喊着向你求救，声音嘶哑，他声称自己是个无辜的人。赏金猎人告诉你们滚开并去死。 | 你与一群全副武装的赏金猎人擦肩而过。他们拖着一个被从头到脚锁链束缚的男子。%SPEECH_ON%你不会想和这个人有任何关系。%SPEECH_OFF%其中一个人边说，边打了囚犯的脚背一下，那个男子尖叫着在满是血的双手和双膝匍匐到你面前。%SPEECH_ON%他们全是骗子！这些人会杀了我，明明我什么都没做！救救我，先生，拜托了！%SPEECH_OFF% | 你遇到了一群庞大的赏金猎人，你们两个奇怪地相互映照，尽管你们在这个世界上的目的显然不同。他们正在运送被铁链束缚并用抹布塞住嘴巴的囚犯。那个人对你大喊着，几乎是恳求，直到他的脸变成了红色。其中一个赏金猎人吐了口唾沫。 %SPEECH_ON%别理他，陌生人，继续上路吧。我们之间最好没有什么麻烦。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这不关我们的事。",
					function getResult()
					{
						return 0;
					}

				},
				{
					Text = "也许我们可以买下这个囚犯？",
					function getResult()
					{
						return this.Math.rand(1, 100) <= 50 ? "BountyHunters1" : "BountyHunters1";
					}

				},
				{
					Text = "如果你想要它，就过来拿吧！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Mercs";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 140 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Thieves1",
			Title = "露营时…",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你从短暂的小睡中醒来，转过身去，像寻找情人一样寻找着包裹。但是它不在那里，货物也不见了。你迅速站起身，命令士兵注意。 %randombrother% 跑过来说他追踪到了从事发现场出发的脚印。 | 正当你休息时，你听到营地某处有动静。你冲到那里，发现 %randombrother% 躺在地上，揉着后脑勺。%SPEECH_ON%对不起，长官，我刚刚想解手，他们趁机把物品偷走了。%SPEECH_OFF%你让他重复一遍最后一句话。%SPEECH_ON%该死的贼偷走了货物！%SPEECH_OFF%是时候追踪那些混蛋，把它找回来了。 | 自然，这不会是一次普通的旅行。不，这个世界太糟糕了，不可能是那样。贼似乎偷走了货物。幸运的是，他们留下了大量证据，也就是从搬运包裹留下的脚印和拖痕。他们应该很容易找到... | 你只想有一次从一个城镇到另一个城镇的愉快步行。但是，你和%employer%达成的协议又一次招来了麻烦。贼们不知何时潜入了营地并带走了货物。好消息是，他们没有成功地潜回去：你找到了他们的脚印，他们不会很难追踪。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们跟着他们的足迹走！",
					function getResult()
					{
						this.Contract.setState("Running_Thieves");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Thieves2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{贼的血液浓稠。你成功找到了雇主的货物，仍然在帐篷里面，全部锁好了。他不需要知道这次小小的远足。 | 哦，每件东西都在该在的地方。%employer%大人的货物被发现藏在了一个贼扭曲着的身体下。在戳穿他之前，你确保把他踹飞了。毕竟，不想在包裹上沾染血迹。 | 杀死了最后的盗贼之后，你和战团的人分散在强盗营地里搜寻着包裹。%randombrother%很快发现了它，容器仍然被一个死人牢牢抓住。雇佣兵亲自动手摆弄着尸体的手指，沮丧之下，只是把那讨厌鬼的胳膊斩了下来。你拿到了包裹，并更加紧握它，以备前行。 | 你看着倒毙的盗贼的尸体，心里犹豫：是否要告诉%employer%这件事。包裹看起来还好。除了有一些血迹和骨头外，你可以轻易将它擦干净。 | 这个包裹有点破损了，但没关系，还能用。好吧，上面沾满了血迹，一个贼的剥皮手指卡在了其中一个扣子里。除了这些问题外，每件事情都完美无缺。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回到它应该在的地方。",
					function getResult()
					{
						this.Flags.set("IsThieves", false);
						this.Flags.set("IsStolenByThieves", false);
						this.Contract.setState("Running");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EnragingMessage1",
			Title = "在 %objective%",
			Text = "{墓地被笼罩在雾中－亦或者是亡者散发的瘴气中。 等等…那是亡者！拿起武器！ | 你看到一个墓碑底下被挖出来的一个土坑。 泥污如碎屑般引向远处。 没有铲子…没有人… 随着你顺着线索，你遇到了一群呻咛低吼着的亡灵…正以一种饥饿的目光看着你… | 一个男人在一排排墓碑间徘徊。 他看起来在晃，好像随时都要昏过去。%randombrother% 到你身边摇了摇头。%SPEECH_ON%那不是人，先生。那是出没的亡灵。%SPEECH_OFF%他刚说完，远处的陌生人缓慢的转过来，光线下露出了他只剩一半的脸。 | 你到此地发现许多的坟墓都是空的。 不只是空，而是从地下挖出的。 这可不是盗墓贼干的…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{在行进途中，你注意到还有另一件东西在移动：货物。它的盖子在晃动，从侧边散发出奇怪的光芒。%randombrother%走近，看了看它，然后又看了看你。%SPEECH_ON%队长，我们应该打开它吗？还是我可以把它拿走扔到最近的池塘里，因为那东西肯定不对头。%SPEECH_OFF%你捅了他一下，问他是不是害怕了。 | 正当当你走在路上时，某物开始发出低哑的声音，那是%employer%给你交付的包裹。%randombrother%站在旁边，用棍子戳它。你把他打了回去。他解释道。%SPEECH_ON%队长，我们拖着的货物有些不对劲...%SPEECH_OFF%你好好看了看它。盖子的边缘泛着淡淡的颜色。你知道，在这样的空间中，火是无法燃烧的，而在黑暗中唯一会发光的只有月亮和星星了。你的好奇心开始占上风… | 货物停在你身旁的车里，在路线的倾斜和弯曲中颠簸着。突然，它开始嗡嗡作响，你发誓你看到盖子漂浮了一秒钟。%randombrother%瞥了一眼。%SPEECH_ON%你没事吧，队长？%SPEECH_OFF%就在他说完话，盖子向外爆炸，漩涡一般的颜色、雾气、灰烬、火热和野蛮的寒冷轰然爆炸。你举起手臂保护自己，当你透过胳膊肘偷看时，包裹完全静止，盖子已经盖上。你与佣兵交换了一下眼神，然后你们一起盯着货物看。这可能是一次不寻常的交付… | 一声低沉的嗡嗡声从附近传来。以为附近有蜜蜂窝，你本能地躲了下去，却随后发现声音来自于%employer%交给你的货物。容器上方的盖子从一侧晃到另一侧，冲击维持盖子的扣环和钉子。%randombrother%看起来有点害怕。%SPEECH_ON%我们就把它扔在这里吧。那东西不对劲。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我想知道发生了什么。",
					function getResult()
					{
						return "EvilArtifact2";
					}

				},
				{
					Text = "别碰那个东西。",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_73.png[/img]{好奇心让你神志不清地开始撬开盖子。%randombrother%后退了一步并抗议道。%SPEECH_ON%我认为我们应该让它呆着，先生。我是说，看看它。%SPEECH_OFF%你无视他的话，告诉士兵们一切都会好的，然后把盖子抬了起来。\n\n这一切并不好。爆炸将你打倒在地。可怕的形状和尖叫声在你周围旋转。士兵们本能地拿起武器，远程技能（对抗不死族）的唤鬼飞行器穿透地面。那里的地面隆起，并发出嘎嘎声。你看着手从坑里伸出来，拖出破败的身体。死人又活过来了，他们一定是要加入他们的队伍！ | 无视任何人的最佳判断，你撬开了货物。起初什么也没有。只是一个空的箱子。%randombrother%紧张地笑了起来。%SPEECH_ON%好吧......我想那就是结束了。%SPEECH_OFF%但这不可能就是全部了吧，%employer%为什么要让你运送一个空的容器呢，除非——\n\n慢慢地你从昏迷中醒来，耳朵里还在响。翻身后，你看到盒子已经完全消失了，只有一堆蓬松的锯屑留在原地。%randombrother%跑过来，把你扶起，拖你走向其他战团成员。他们指着，嘴巴动，大喊大叫。\n\n一个武装到牙齿的人群……正摇摇晃晃地向你们靠近？当你看清楚他们的时候，你意识到他们装备着旧木盾，上面画着奇怪的精神仪式，他们的盔甲形状和大小都是你从没见过的，好像它们是由刚学习这个行业的人制作的，但仍然很好地学到了他们迄今所学到的技能。这些像古老的……最早的人。 | %randombrother%摇摇头，当你准备拿起盖子时。费了一些力气，它被打开了，你迅速退后，准备迎接最坏的结果。但是什么也没有发生。盒子里甚至没有一个声音。你拿起一把剑，在空盒子里寻找一个秘密隔室或者什么的。%randombrother%笑了起来。%SPEECH_ON%嘿，我们只是运送一堆空气！我还以为那该死的东西太重了！%SPEECH_OFF%就在那时，盒子短暂地升起，旋转并砸在地上。它完美地、无声地破碎了，每一块木头都像古代的石头那样落在草地上。一个虚无的身影从分裂的仪式中瞪视着你，咧嘴而笑着，扭曲着。%SPEECH_ON%哦，人类，真好又见到你们了。%SPEECH_OFF%这声音让你毛骨悚然。你看着鬼魂冲入天空，然后猛地撞回地面，刺进土壤。不到一秒钟，地面就开始爆炸，尸体开始爬出来。 | 这个盒子吸引了你。 你毫不犹豫地打开货物，看看里面。 先闻后见——一股可怕的恶臭几乎让你几乎失明。 其中一名男子呕吐。 另一个干呕。 当你回头看盒子时，黑色的卷须状烟雾正从里面飘出，延伸得又长又远，边走边探查地面。 当他们找到他们要找的东西时，他们会潜入地下，像诱饵鱼一样拉出死人的骨头。 | %randombrother%和一些其他人试图帮忙，但它几乎就像无声的暴风雨在向你们推进。\n\n就在一瞬间，你们都被推倒，木箱的盖子高高飞起，被一群黑暗的灵魂的阵风卷起。它们在四处飞舞，搜索地面，然后集体站在了%companyname%的对面。在这里，你惊恐地看着虚无开始变成实体，灵魂的笼罩被骨架所替代，它们拥有武器，发出嘎嘎声的颚骨依然发出空荡荡的笑声。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "EvilArtifact";
						p.Music = this.Const.Music.UndeadTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;

						if (this.Flags.get("IsCursedCrystalSkull"))
						{
							this.World.Flags.set("IsCursedCrystalSkull", true);
							p.Loot = [
								"scripts/items/accessory/legendary/cursed_crystal_skull"
							];
						}

						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.UndeadArmy, 120 * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						this.World.Contracts.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact3",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{战斗结束后，您迅速冲回神器所在的地方，发现它悬浮在空中。%randombrother%跑到您身边。%SPEECH_ON%将它摧毁掉，长官，在它引起更多麻烦之前！%SPEECH_OFF% | 您的部队并不是战斗中唯一幸存下来的——那个神器，或者说那仍在跳跃的力量的剩余，仿佛一只无辜漂浮在您最后看到它的地方的球体。这个球体充满能量，时而发出嘈杂声，有时低声细语，说出您所不知道的语言。%randombrother%向它点头示意。%SPEECH_ON%摧毁它，长官。摧毁它，让我们摆脱这场噩梦。%SPEECH_OFF% | 这种力量并不适合这个世界！神器已经变成了一个拳头大小的球体，它悬浮在人类的脚底下，发出低鸣声，仿佛在唱着来自另一个世界的歌曲。这个球体似乎在等待着您，就像一只狗在等待它的主人一样。%SPEECH_ON%长官。%SPEECH_OFF%%randombrother%拉了拉您的肩膀。%SPEECH_ON%长官，请摧毁它。让我们不要再带着那个东西一步了！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们必须摧毁它。",
					function getResult()
					{
						return "EvilArtifact4";
					}

				},
				{
					Text = "我们是拿钱来完成任务的，所以我们会去完成。",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact4",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{你拔出剑站在神器前，缓缓地举起剑刃。%SPEECH_ON%不要这样做！%SPEECH_OFF%你扭头一看，看到%randombrother%和其他人怒视着你。黑暗笼罩着他们和你所能看到的整个世界。他们的眼睛发出红色的光芒，每说一句话就愤怒地跳动。%SPEECH_ON%你会永远燃烧！燃烧直到永远！如果你摧毁它，你也将燃烧！燃烧！燃烧！%SPEECH_OFF%你尖叫着回头，砍下宝物。它轻松地分成两半，一股颜色的波浪回荡着你的世界。汗水从你的额头上流淌下来，你发现自己倚在武器的簪杆上。你回头看到你的雇佣兵团凝视着你。%SPEECH_ON%先生，你还好吗？%SPEECH_OFF%你收起剑，点点头，但你从来没有感到如此恐惧。%employer%不会高兴的，但他和他的愤怒都见鬼去吧！ | 就在你想摧毁神器的想法闪过脑海的时候，一阵恐怖的尖叫声也随之而来。妇女和儿童尖声哭喊，他们的声音充满了恐惧，好像他们都在燃烧着。他们用几百种语言朝你尖叫，但你所认识的一种语言不断传来，而且每次都是同一个词：不要。\n\n你拔出剑，向后挥舞。神器嗡嗡作响，冒出烟雾。一股残暴的热量袭来。不要。\n\n你稳住握杆的手。\n\n达夫库尔。耶克拉。伊姆舒达。佩兹兰特。不要。\n\n你吞口水，稳准瞄准。\n\n不要。拉夫威特。乌尔拉。奥沙罗。埃布洛。麦吉卡。不要。不要。不要。做--。\n\n一刀斩下，词语消逝，神器掉到地上。你也跟着掉下来，跪在那里，雇佣兵团的一些人过来帮你站起来。%employer%不会高兴的，但你不禁感到，你刚刚拯救了这个世界，不再受到不必要的恐惧。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "完成了。",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);

						if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "无法交付货物。");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "无法交付货物。");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 0.5);
						}

						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact5",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_55.png[/img]{你摇了摇头，拿了另一个木箱，小心地把浮游神器放进去，然后盖上盖子。%employer%付了你不少钱，而且，你打算将这件事情做到底。但是出于某种原因，你不确定这个选择是自己的，还是这个奇怪的遗物正在指引着你的手。 | 你拿来一个木箱，把它举到神器上方，迅速地盖上盖子。几个雇佣军摇头叹气，这可能不是最好的主意，但出于某种原因，你感到被迫完成自己的任务。 | 更明智的做法是摧毁这个可怕的遗物，但更明智的判断再次失败。你拿来一个木箱，将它移动到神器上方，然后关闭盖子和插销。你不知道自己在做什么，但是当你准备上路时，身体充满了新的能量。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们应该继续前进。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "在 %objective%",
			Text = "[img]gfx/ui/events/event_20.png[/img]{当你走进城镇，%recipient%已经在等待着你。他匆忙接过货物。%SPEECH_ON%哦，哦，我没想到你能到达这里。%SPEECH_OFF%他粘糊糊的手指跳着舞，沿着携带宝箱的路线移动。他转过身去，对他的一个手下大喊一声。他们走了过来，递给你一只克朗的小包。 | 最后，你到了。%recipient%站在路中央，双手抱着肚子，脸上挂着狡猾的笑容。%SPEECH_ON%佣兵，我不确定你是否能成功完成任务。%SPEECH_OFF%你提起货物递给了他。%SPEECH_ON%噢，是吗？你为什么这么说？%SPEECH_OFF%他接过宝箱，把它交给一个披袍子的人，后者迅速地拿着宝箱离开。%recipient%笑着向你递过一只克朗的小包。%SPEECH_ON%这些日子的道路很崎岖，不是吗？%SPEECH_OFF%你明白他是在闲聊，想让你的注意力不要集中在你刚刚交的货物上。不管怎么样，你得到了报酬，这对你已经足够了。 | %recipient%对你表示欢迎，他的几个手下赶来接货。他拍拍你的肩膀。%SPEECH_ON%我猜你的旅程很顺利？%SPEECH_OFF%你省略了细节，问及自己的报酬。%SPEECH_ON%啐，佣兵本色。%randomname%，给这个人他应得的报酬！%SPEECH_OFF%一名%recipient%的保镖走过来，递给你一个小箱子。 | 经过一段时间的寻找，有人问你找谁。当你说出%recipient%的时候，他把你指向附近的一个围场，一个男人正在上面骑着一匹华丽的马四处走动。\n\n当你走向那个男人时，他驱车而来，并问那是否是%employer%要送来的货物。你点了点头。%SPEECH_ON%把它放在你脚下。我会去拿它的。%SPEECH_OFF%你没有这样做，反而询问你的报酬。那个男人叹了口气，吹响了一声口哨，让一个保镖匆忙而过。%SPEECH_ON%确保这个佣兵得到他应得的报酬。%SPEECH_OFF%最后，你把箱子放在地上并离开。} ",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "运送了一些货物");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "运送了一些货物");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "运送了一些货物");
						}

						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "在 %objective%",
			Text = "[img]gfx/ui/events/event_163.png[/img]{%SPEECH_START%啊，皇家子弟。%SPEECH_OFF%一个声音从附近的小巷传来。通常情况下这意味着你即将失去一些钱，但是一个男人却向你提供了黄金。%SPEECH_ON%我是%recipient%，那个包裹属于我。向%employer%问好，或者不要，我不在乎。%SPEECH_OFF%这个人窃窃私语，就像他来时一样快地离去了。 | %recipient%是个个子矮小的男人，扛着大臣的徽章和标志，就像你刚拿给他的木箱一样沉重。%SPEECH_ON%我给大臣许多东西，他用什么方式来回报我呢？皇家子弟的汗水。让吉尔德尔看到这个人未来的时候眨一眨眼吧。%SPEECH_OFF%你对此不置可否，部分原因是你想这可能是一个“测试”，看看你是否会同意他的话，自己变成大臣的敌人。这个男人盯着你看了一会儿，然后耸了耸肩，并继续说道。%SPEECH_ON%我在这儿有你的付款。这些钱都算好了，如果你想自己数一数，我不会介意。啊，我看你已经在数了。很好，全都在这儿了。现在快跑开，小皇家子弟。%SPEECH_OFF% | %recipient%正在指挥一群孩子。他很快就选中你，教育他们要好好学习，否则他们就会像你一样。孩子们被解散之后，这个男人带着一袋皇冠过来了。%SPEECH_ON%我的人告诉我，你已经到了，而且材料还很好。这是你的付款，皇家子弟。%SPEECH_OFF% | 你进入%recipient%的家，最后放下包裹，然后被仆人带走了。%recipient%从一张看起来很舒适的椅子上看着你，问你旅途如何。你说闲谈并不能填满你的口袋，然后询问你的报酬。这个男人挑了挑眉毛。%SPEECH_ON%啊，我用我善良、文明的态度冒犯了皇家子弟吗？我竟敢如此。好吧，你的报酬在角落里，完全按照约定来的。%SPEECH_OFF% | %recipient%正在对着一面镜子谈论鸟类的本质。当他在镜子里看到你时，他转过身来，就好像什么都没有发生一样地说话。%SPEECH_ON%一个皇家子弟。当然是大臣派来的皇家子弟。我想象不出你敢用眼睛亵渎这个箱子里的物料，但是我还是不能相信你们中有这种专业精神。但你可以期待我，你的报酬在角落里，而且已经按约定付全了。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "运送了一些货物");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "运送了一些货物");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(this.Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess * 0.5, "运送了一些货物");
						}

						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
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
		local days = this.getDaysRequiredToTravel(this.m.Flags.get("Distance"), this.Const.World.MovementSettings.Speed, true);
		_vars.push([
			"objective",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"recipient",
			this.m.Flags.get("RecipientName")
		]);
		_vars.push([
			"mercband",
			this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)]
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
		]);
		_vars.push([
			"days",
			days <= 1 ? "1天" : days + "天"
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

			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() || !this.m.Destination.isAlliedWithPlayer())
		{
			return false;
		}

		return true;
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

		if (this.m.Location != null && !this.m.Location.isNull())
		{
			_out.writeU32(this.m.Location.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		_out.writeU32(this.m.RecipientID);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		this.m.RecipientID = _in.readU32();

		if (!this.m.Flags.has("Distance"))
		{
			this.m.Flags.set("Distance", 0);
		}

		this.contract.onDeserialize(_in);
	}

});

