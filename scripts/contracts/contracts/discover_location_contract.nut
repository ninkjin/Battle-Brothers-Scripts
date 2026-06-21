this.discover_location_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Location = null,
		LastHelpTime = 0.0
	},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(75, 105) * 0.01;
		this.m.Type = "contract.discover_location";
		this.m.Name = "寻找地点";
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

		this.contract.start();
	}

	function setup()
	{
		local locations = clone this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		locations.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
		local lowestDistance = 9000;
		local best;
		local myTile = this.m.Home.getTile();

		foreach( b in locations )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			if (b.isDiscovered())
			{
				continue;
			}

			local region = this.World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
			{
				continue;
			}

			if (region.Discovered < 0.25)
			{
				this.World.State.updateRegionDiscovery(region);
			}

			if (region.Discovered < 0.25)
			{
				continue;
			}

			local d = myTile.getDistanceTo(b.getTile());

			if (d > 20)
			{
				continue;
			}

			if (d + this.Math.rand(0, 5) < lowestDistance)
			{
				lowestDistance = d;
				best = b;
			}
		}

		if (best == null)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Location = this.WeakTableRef(best);
		this.m.Flags.set("Region", this.World.State.getTileRegion(this.m.Location.getTile()).Name);
		this.m.Flags.set("Location", this.m.Location.getName());
		this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		this.m.Payment.Pool = this.Math.max(300, 100 + (this.World.Assets.isExplorationMode() ? 100 : 0) + lowestDistance * 15.0 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentLightMult());

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Bribe", this.beautifyNumber(this.m.Payment.Pool * (this.Math.rand(110, 150) * 0.01)));
		this.m.Flags.set("HintBribe", this.beautifyNumber(this.m.Payment.Pool * 0.1));
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"找到%direction%%region%区域附近%distance%%location%。"
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

				if (r <= 15)
				{
					this.Flags.set("IsAnotherParty", true);
					this.Flags.set("IsShowingAnotherParty", true);
				}

				this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(10, 40);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"在%direction%%region%区域的附近寻找%location%"
				];

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Flags.get("IsShowingAnotherParty"))
				{
					this.Flags.set("IsShowingAnotherParty", false);
					this.Contract.setScreen("AnotherParty1");
					this.World.Contracts.showActiveContract();
				}

				if (this.TempFlags.get("IsDialogTriggered"))
				{
					return;
				}

				if (this.Contract.m.Location.isDiscovered())
				{
					if (this.Flags.get("IsTrap"))
					{
						this.TempFlags.set("IsDialogTriggered", true);
						this.Contract.setScreen("Trap");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("FoundIt");
						this.World.Contracts.showActiveContract();
					}
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

					if (this.Time.getVirtualTimeF() >= this.Contract.m.LastHelpTime + 70.0)
					{
						this.Contract.m.LastHelpTime = this.Time.getVirtualTimeF() + this.Math.rand(0, 30);
						local r = this.Math.rand(1, 100);

						if (r <= 50)
						{
							this.Contract.setScreen("SurprisingHelpAltruists");
						}
						else
						{
							this.Contract.setScreen("SurprisingHelpOpportunists1");
						}

						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "DiscoverLocation")
				{
					this.Contract.setState("Return");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "DiscoverLocation")
				{
					this.Contract.setState("Return");
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

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsAnotherParty"))
					{
						this.Contract.setScreen("AnotherParty2");
					}
					else
					{
						this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% 正看着一张画得很差的地图，然后看着你，仿佛你要为此负责一样。%SPEECH_ON%看呐，雇佣兵，这是一件奇怪的任务，但你似乎很有头脑。这里有个黑色区域，你愿意前往那里并试图找到%location%吗？它位于或靠近%region%地区。%SPEECH_OFF% | 你走进了%employer%的房间，他把一张地图猛地推到了你的面前。%SPEECH_ON%{佣兵！是时候去探险了！看这个未被勘测的地点，%direction%%region%地区有一个未知的位置叫%location%，你能接受吗？ | 好的，这可能看起来很奇怪，但我需要一个被称为%location%的地方被找到和标出在地图上。我们的地图缺少这个区域的信息，但我相信它位于或靠近%direction%的%region% 地区。去吧，找到它，并带着坐标回来，你会得到适当的报酬。 | 还有这个世界上的部分区域人类尚未发现和探索。我正在寻找位于或靠近%direction%%region% 的%location%。我对它所知甚少，但我知道它的存在。所以，去为我找到它，你会得到适当的报酬。 | 我需要一个被发现的地方，佣兵。它位于或靠近%direction%的%region%。普通人称它为%location%，但无论它是什么，我需要知道它的具体位置，明白吗？找到它，你就会有丰厚的报酬。 | 我需要一名士兵和探险家，佣兵，我认为你就是能够胜任这两项工作的人。现在，在你指责我不肯多雇用一些工人之前，让我们只说我有足够的克朗让你来做这件事。怎么了？嗯？好吧，我知道一个叫做%location%的地方，但我不知道它的确切位置，除了它位于%direction%的%region%这块地区。找到它，标在地图上，你将得到士兵和探险家两份工资的酬劳！}%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{报酬是多少？ | 我们会以合适的价格找到它。}",
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
			ID = "FoundIt",
			Title = "在%location%。",
			Text = "[img]gfx/ui/events/event_57.png[/img]{你用瞄准镜观察到了%location%，并将其标记在你的地图上。好简单。是时候回到%employer%那了。 | 好了，现在已经是时候回到%employer%那里了，因为寻找%location%比你想象的更容易。将其位置标记在地图上之后，你停下来笑了笑并摇了摇头。真是好运气。 | %location%出现在视野中，你立即发挥你绘图能力的极限将其标注在地图上。%randombrother%问是否只是这些就完成了任务，你点了点头。不管难还是容易，%employer%都会给你付钱。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候回去了。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Trap",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_07.png[/img]%location%已经被发现——战团%companyname%也被发现了。“利他主义者”（之前指引你的人）正在那里，现在他身边有一群强壮而不友好的人。%SPEECH_ON%{哦，看上去你终于能够遵循指示。当这个白痴告诉你在哪里见面时，伏击就很容易了。无论如何，杀了他们！ | 嘿，雇佣兵，见到你身在此地有点奇怪吧。哦等等，不是啊。杀了他们！ | 该死，你们花的时间太长了！什么，你们连走到自己坟墓的简单指示都不能遵循？愚蠢的雇佣军，真没脑子。好，让我们结束这一切，杀了他们！}%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.BanditTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "DiscoverLocation";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditRaiders, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpAltruists",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_76.png[/img]{一个人友好地挥手走了过来。你拔出了一半的剑作为回应，他笑了。%SPEECH_ON%很多人对%location%很感兴趣，所以我不能责怪你如此戒备。看，我告诉你确切的位置，就在这里的%direction%方向，%terrain%，%distance%的距离。%SPEECH_OFF%他开心地走开了。%SPEECH_ON%我不知道我做的是好事还是坏事，但这就是我喜欢的乐趣！%SPEECH_OFF% | 一群世故的探险者！他们在路中间停了下来，半身陷在泥中，半身被树叶覆盖，全部不经意的伪装。其中一个人揉了揉额头，仔细地打量着你，然后笑容扩大了。%SPEECH_ON%嗯，我知道一个搜索者当我看到时。你在找%location%，对吧？好吧，你运气真好，我们刚从那里回来！把你的地图给我，我会告诉你确切位置的。你看，%terrain% %distance%的%direction%方向离我们不远。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "非常感谢。",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 20 && this.Contract.getDifficultyMult() > 0.95)
						{
							this.Flags.set("IsTrap", true);
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpOpportunists1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_76.png[/img]{陌生人是一个独自行动的人，保持着距离，一只脚站在路上，另一只脚向着逃脱的方向挪动。%SPEECH_ON%嗨！%SPEECH_OFF%他环视着你的人，慢慢地露出了微笑，仿佛能感觉到我们的无助。%SPEECH_ON%你们在寻找%location%吗？ 嗯，好吧，我告诉你们，把%hint_bribe%克朗交给我，我会告诉你具体在哪里！如果你带着剑追杀我，我会比你眨眼间都不见了！%SPEECH_OFF% | 你看着陌生人走到路灯下，遮住眼睛以保持脸部的神秘感。%SPEECH_ON%你看起来像那种在寻找某物但不知道在哪里的人！ %location%就是那样棘手。我知道它在哪里，而你也可以通过支付%hint_bribe%克朗得知其所在。我是你们见过的最快的短跑运动员，所以最好不要拿出闪闪发光的剑来吓唬我。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好的，这是克朗。现在讲吧。",
					function getResult()
					{
						return "SurprisingHelpOpportunists2";
					}

				},
				{
					Text = "不需要，我们自己会找到它的。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SurprisingHelpOpportunists2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_76.png[/img]你接受了这个人的提议，他果然兑现了他的承诺并讲解了细节。%SPEECH_ON%你看，它就在那儿，离我们现在的位置%distance%%direction%%terrain%。非常容易。%SPEECH_OFF%他边走边吹着口哨，毫无疑问这对他来说是一次十分容易的赚钱机会。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "知道了。",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Flags.get("HintBribe"));
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Flags.get("HintBribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "AnotherParty1",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_51.png[/img]{当你和%companyname%准备旅途时，%randombrother%说有位男子想直接和你谈话。你点点头，让他来见你。他是个忧郁的矮个子，说%townname%的“统治者”除了贪婪什么都不关心%location%。当然是这样，那有什么问题吗？那人点点头。%SPEECH_ON%看，我有些人对于一直将%location%保密很感兴趣。如果你找到了它，嗯，先找我谈谈。我们会让你赚大钱的。%SPEECH_OFF% | %companyname%开始准备寻找%location%之际，一名男子靠近你，将一张纸条递给你，然后无言离开。纸条上写道：把%locationC%留在原地。如果你找到它，找我们谈。我们用克朗换你的保密。%townnameC%的统治者不需要知道任何事情！ | 一名男子走近战团，你发现几个贫穷家庭的眼光盯着他们。你不确定他是否是他们的代表，但不管怎样，他向你提议，声音低沉。%SPEECH_ON%听着，佣兵。如果你去找%location%，先来找我们。%townname%的统治者不需要将他们的贪婪和渴望权力带到那个地方。交给我们，好吗？我们会好好报酬你。%SPEECH_OFF%在你还没有开口说话之前，他就直起身继续走了。当你回头看路时，那些家庭已经不在了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我会考虑的。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_51.png[/img]{当你前往%townname%时，一个陌生人出现在路上。他是你之前跟他交谈过的那个人，但这次他手里拿着一个手提包。%SPEECH_ON%{你没有理由告诉这个城镇的统治者%location%的位置。把它的秘密留给我们，你不知道我们拥有什么传家宝和历史。为了你的沉默，我们愿意支付%bribe%克朗作为报酬。先生，请收下。 | 听着，雇佣兵，我知道你只讲一个语言，那就是钱的语言。如果你保持沉默，就把这个手提包当做我们的感激之情。你不必告诉%townname%的统治者%location%在哪里。那个地方属于我们的家族。那些小小的统治者只会因为贪婪和追求权力而破坏它。那么，你愿意接受吗？里面有%bribe%克朗。你只需要拿走它而不说话。}%SPEECH_OFF% | 进入%townname%，你被一个熟悉的面孔拦住了：就是你在第一次离开之前所见到的那个人。但这次他带着一个手提包。%SPEECH_ON%{%bribe%克朗作为你的沉默费。不要告诉这个城镇的统治者任何事情，它就是你的。他们不需要知道我们的交易，他们只需要不知道这个地方在哪里。它对我们来说很重要，有着无法估量的历史，而他们所做的只是洗劫和掠夺。请接受。 | 拿着这个，里面有%bribe%克朗。那是我们为了你的沉默而准备的报酬。%townname%的统治者将利用你的信息来掠夺%location%，因为他们知道我们与之有亲戚关系，而且，呃，我们在这里早已失宠。我们几乎没有什么剩下的，所以，请让我们保留我们的传家宝和老房子。}%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我不这么认为。只有我们的雇主会知道它在哪里。",
					function getResult()
					{
						return "AnotherParty3";
					}

				},
				{
					Text = "我们成交。 你和其他人都不会知道它在哪里。",
					function getResult()
					{
						return "AnotherParty4";
					}

				},
				{
					Text = "如果可以两次获得报酬，为什么只收一次呢？",
					function getResult()
					{
						return "AnotherParty5";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你拒绝了他的请求，他跪在地上大声哭泣，让%companyname%乐此不疲。他哭着说他把他家族的历史托付给了好色之徒和高利贷者。你告诉他你不在乎。 | 当你告诉他你没有背叛原雇主的意向时，他很生气，企图攻击你，愤怒地伸手来扑你。%randombrother%把他推开，并拔出刀威胁要杀了他。那人退后了，在路边坐下，抽泣着。其中一人递给他手帕以示同情。 | 你再次拒绝了这个人的请求，他苦苦哀求。你又再次拒绝了他。你忽然发现你以前曾和一两个女人做出过这样的事情。这样做并不好看。你对他说了这些话，但是情感太过强烈，他再次开始哭泣，唉声叹气地说他家族的名声将因经营%townname%的贪婪混蛋而被毁掉。你告诉他，如果他自己经营这座城市，他所谓的家族名声不会受到损害。但是这并没有止住他的眼泪。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让路。",
					function getResult()
					{
						return "Success1";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AnotherParty4",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你同意向那个男人出售你的远征计划细节。他为此感到过度高兴，但是%employer%并不是这样想的。显然，一个小孩子看到了这个交易，并向%townname%的首领报告了你的背叛。你在这里的声誉无疑受到了一些伤害。 | 一方面，你拯救了这个男人所谓的家园，使其免遭那些掌管%townname%的人的破坏。另一方面，那些掌管%townname%的人很快就听到了你的所作所为。你应该更加注意一个小镇的人口的谣言传播能力。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "嗯，%employer%应该给我们更多的薪水。",
					function getResult()
					{
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "出卖了位置。" + this.Flags.get("Location") + "转交给另外一方");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "AnotherParty5",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]你告诉那个人，你会保密他家的位置。当他庆祝的时候，你去告诉%employer%他们的%location%在哪里。从两方面得到报酬确实很赚，但受到双方的仇恨就不一样了。但做雇佣兵他们还能期望什么呢？",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那些人永远不会学习。",
					function getResult()
					{
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail * 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 1.5, "向竞争对手泄露信息");
						this.World.Contracts.finishActiveContract(true);
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
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer%欢迎你回来。你递给他最近绘制的地图，他看了看，用手背拍打着上面的标记。%SPEECH_ON%当然就在这里了！%SPEECH_OFF%他咧嘴笑了笑，付了你应得的报酬。 | 你手里拿着新地图，走进了%employer%的房间。他接过地图看了看。%SPEECH_ON%好吧，我会想这也太容易了，但协议就是协议。%SPEECH_OFF%他递给你一个袋子，里面装着应得的报酬。 | 你向%employer%汇报了%location%的位置。他点了点头，拿出纸笔把你地图上的笔记抄了下来。你好奇地问他怎么知道你没有撒谎。这个人坐在椅子上向后靠着，双手合十放在肚子上。%SPEECH_ON%我雇了一位跟随你们战团的追踪者。他比你来得早，你只是确认了我已经知道的事情。希望你不介意我们采取的措施。%SPEECH_OFF%你点了点头，认为这是明智的做法，收取报酬离开了。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "被雇来寻找 " + this.Flags.get("Location"));
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
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		local distance = this.m.Location != null && !this.m.Location.isNull() ? this.World.State.getPlayer().getTile().getDistanceTo(this.m.Location.getTile()) : 0;
		distance = this.Const.Strings.Distance[this.Math.min(this.Const.Strings.Distance.len() - 1, distance / 30.0 * (this.Const.Strings.Distance.len() - 1))];
		_vars.push([
			"region",
			this.m.Flags.get("Region")
		]);
		_vars.push([
			"location",
			this.m.Flags.get("Location")
		]);
		_vars.push([
			"locationC",
			this.m.Flags.get("Location").toupper()
		]);
		_vars.push([
			"townnameC",
			this.m.Home.getName().toupper()
		]);
		_vars.push([
			"direction",
			this.m.Location == null || this.m.Location.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Location.getTile())]
		]);
		_vars.push([
			"terrain",
			this.m.Location != null && !this.m.Location.isNull() ? this.Const.Strings.Terrain[this.m.Location.getTile().Type] : ""
		]);
		_vars.push([
			"distance",
			distance
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
		_vars.push([
			"hint_bribe",
			this.m.Flags.get("HintBribe")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.Location == null || this.m.Location.isNull() || !this.m.Location.isAlive() || this.m.Location.isDiscovered())
		{
			return false;
		}

		return true;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Location != null && !this.m.Location.isNull() && _tile.ID == this.m.Location.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Location != null && !this.m.Location.isNull())
		{
			_out.writeU32(this.m.Location.getID());
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
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		this.contract.onDeserialize(_in);
	}

});

