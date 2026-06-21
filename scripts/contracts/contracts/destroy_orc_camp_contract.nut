this.destroy_orc_camp_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Dude = null,
		Reward = 0
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.destroy_orc_camp";
		this.m.Name = "摧毁兽人营地。";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(this.m.Origin.getTile());
		this.m.Destination = this.WeakTableRef(camp);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Completion = 1.0;
		}
		else if (r == 3)
		{
			this.m.Payment.Completion = 0.5;
			this.m.Payment.Count = 0.5;
		}

		local maximumHeads = [
			20,
			25,
			30
		];
		this.m.Payment.MaxCount = maximumHeads[this.Math.rand(0, maximumHeads.len() - 1)];
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"摧毁 " + this.Flags.get("DestinationName") + "，位于%origin%的%direction%"
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
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setLastSpawnTimeToNow();

				if (this.Contract.getDifficultyMult() < 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.OrcRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(115 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Flags.set("HeadsCollected", 0);

				if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().get("Betrayed") && this.Math.rand(1, 100) <= 75)
				{
					this.Flags.set("IsBetrayal", true);
				}
				else
				{
					local r = this.Math.rand(1, 100);

					if (r <= 5)
					{
						this.Flags.set("IsSurvivor", true);
					}
					else if (r <= 15 && this.World.Assets.getBusinessReputation() > 800)
					{
						if (this.Contract.getDifficultyMult() >= 0.95)
						{
							this.Flags.set("IsOrcsAgainstOrcs", true);
						}
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
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsSurvivor") && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
					{
						this.Contract.setScreen("Volunteer1");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
					else if (this.Flags.get("IsBetrayal"))
					{
						if (this.Flags.get("IsBetrayalDone"))
						{
							this.Contract.setScreen("Betrayal2");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Contract.setScreen("Betrayal1");
							this.World.Contracts.showActiveContract();
						}
					}
					else
					{
						this.Contract.setScreen("SearchingTheCamp");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Flags.get("IsOrcsAgainstOrcs"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("OrcsAgainstOrcs");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "OrcAttack";
						p.Music = this.Const.Music.OrcsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						p.IsAutoAssigningBases = false;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.OrcRaiders, 150 * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "OrcAttack";
					p.Music = this.Const.Music.OrcsTracks;
					this.World.Contracts.startScriptedCombat(p, true, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Betrayal")
				{
					this.Flags.set("IsBetrayalDone", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Betrayal")
				{
					this.Flags.set("IsBetrayalDone", true);
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_combatID == "OrcAttack" || this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull() && this.World.State.getPlayer().getTile().getDistanceTo(this.Contract.m.Destination.getTile()) <= 1)
				{
					if (_actor.getFaction() == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID())
					{
						this.Flags.set("HeadsCollected", this.Flags.get("HeadsCollected") + 1);
					}
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
		this.importScreens(this.Const.Contracts.NegotiationPerHead);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_61.png[/img]{%employer%喘着气。%SPEECH_ON%该死。%SPEECH_OFF%他走到窗户前，往外看。%SPEECH_ON%我最近举办了一个骑士比武比赛，有一些争议。现在，我的骑士都不肯为我而战，直到这个问题得到解决。%SPEECH_OFF%你问他是否想要雇佣兵解决贵族间的争端。这个人突然大笑起来。%SPEECH_ON%天哪，卑鄙的人。我需要你去处理一些绿皮兽，他们正在%origin%的%direction%扎营。他们已经恐吓这个地区有一段时间了，我想要你回敬他们。这听起来是你感兴趣的事情吗，还是我必须去找另一个佣兵？%SPEECH_OFF% | %employer% 把脚搁在桌子上。%SPEECH_ON%佣兵，你对绿皮兽有什么看法？%SPEECH_OFF% 你摇了摇头。这个人扭头看了看。%SPEECH_ON%有趣，大多数人会说他们害怕，或者说他们是可怕的野兽，能够劈开一个人。但你……你不同。我喜欢这个。你想去%origin%的%direction%一个当地人称为%location%的地方吗？我们看到了一大群兽人，需要你去驱散他们。%SPEECH_OFF% | 一只猫坐在%employer%的桌子上，他抚摸着它，猫挤着身子摩擦，但突然间它发出嘶嘶声，咬了那个人，然后从你刚才走过的门跑了出去。%employer%抖了抖灰尘。%SPEECH_ON%该死的动物，刚才还很亲近，现在，嘿…%SPEECH_OFF%他咂了咂血从拇指上流出来的一滴血。你问他是否应该回来照顾他的伤口。%SPEECH_ON%好笑，佣兵。不，我想让你去%origin%的%direction%，击败那个地区的一群绿皮兽人。我们需要他们被摧毁，消散，无论你使用什么词语只要他们“消失”就行。这听起来就像是你愿意为我们做的事情吗？%SPEECH_OFF% | %employer%一边卷起自己的卷轴，一边解释他的困境。%SPEECH_ON%贵族间的争端导致我缺少合适的战斗人员。不幸的是，一群绿皮兽人选择了这个时候进入这一地区。他们在%origin%的%direction%露营。我无法同时整顿家中并应对这些该死的东西的袭击，所以我非常希望你能够为我们效力，佣兵…%SPEECH_OFF% | %employer% 扫了你一遍。%SPEECH_ON%你们够强壮，能对抗一只绿皮兽人了吗？你的手下们呢？%SPEECH_OFF%你点点头，假装这件事情只不过是从树上取一只猫。%employer% 微笑了一下。%SPEECH_ON%很好，因为我收到一大堆关于绿皮兽人出现在%origin% %direction%的消息。到那里去把他们全部消灭吧，很简单吧？这对你这样充满...自信的队长应该很感兴趣。%SPEECH_OFF% | %employer% 站起来喂它们的狗，那是一些农民可能想杀的食物。他手里沾着肉油拍拍手。%SPEECH_ON%那是我的厨师做的，你能信吗？太可怕，令人恶心。%SPEECH_OFF%你点点头，仿佛你能理解这个人生活在什么样的世界里，喂狗好食品变得司空见惯。%employer%将他的手肘放在桌子上。%SPEECH_ON%无论如何，送给我们肉的人通报说绿皮兽人正在杀他们的奶牛。显然，在%origin%的%direction%有一个兽人贼营。如果你们有兴趣，我希望你们可以去那里将他们全都消灭掉。%SPEECH_OFF% | 你看到%employer%正盯着一些卷轴。他抬起头向你示意坐下。%SPEECH_ON%很高兴你来了，佣兵。这里出现了一些兽人问题——它们在这个方向%direction%扎营了。%SPEECH_OFF%他放下其中一个卷轴。%SPEECH_ON%而我不能伤及自己的士兵。骑士们可是不能牺牲的。你们则正好合适。你怎么看？%SPEECH_OFF% | 当你走进%employer%的办公室时，几个人离开了。他们是骑士，剑鞘咔哒作响，藏在他们的长袍下面。%employer%欢迎您的到来。%SPEECH_ON%不用担心他们。他们只是在想最后一次雇佣的人出了什么事。%SPEECH_OFF%你挑了挑眉毛。%SPEECH_ON%别和我扯淡，雇佣兵。你和我一样明白这个行当，有时你们有不足之处，你知道这意味着什么……%SPEECH_OFF%你没有说什么，但是沉默片刻后，你点了点头。%SPEECH_ON%好的，很高兴你理解。如果你想知道，我飞快地，呃，派了一些人出去找到了%origin%%direction%的兽人。他们扎营在那里，我认为自那时以来他们应该移动了。你有兴趣为我消灭它们吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{对抗兽人可不便宜。 | 我相信你会丰厚支付。 | 谈谈钱。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不划算。 | 我们还有其他要事。}",
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
			ID = "OrcsAgainstOrcs",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_49.png[/img]{当你下令部下进攻时，他们遭遇了许多兽人......相互战斗？这些绿皮似乎分裂了，他们通过分割对方来解决分歧。这是一个令人毛骨悚然的暴力场面。当你打算让他们自己解决时，两个兽人向你挑衅，很快每个兽人都盯着你。好了，不能逃跑...拿起武器！ | 你命令%companyname%攻击，认为你已经掌握了兽人的上风。但他们已经武装起来了！而且......相互战斗？\n\n一个兽人把另一个兽人劈成两半，另一个则压碎了另一个兽人的头颅。这似乎是一种氏族冲突。很遗憾你没有稍等片刻让这些野蛮人解决他们的分歧，现在这是一个自由的游戏！ | 兽人正在互相战斗！这是一场绿色皮肤的德行，而你已经成为其中的一员。兽人对抗兽人对抗人，真是精彩的景象！让你的部下靠得更近些，你可能会安然无恙。 | 我的神啊，兽人的数量比你想象的还要众多！幸运的是，他们似乎正在相互残杀。你不知道他们是不同的氏族还是这只是兽人版的醉酒斗殴。无论如何，你现在正处于其中！}",
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
			ID = "Betrayal1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你杀完最后一个兽人，突然一群身穿重甲的士兵出现在你面前。他们的中尉走上前来，拇指勾在腰间佩剑的腰带上。%SPEECH_ON%嘿，嘿，你们真蠢啊。%employer%可不是那么容易忘记的。他还记得你背叛了%faction%上一次的事。这次算是……送你一点小礼物吧。%SPEECH_OFF%话音刚落，中尉背后的士兵们突然发起了进攻。准备好翻盘吧，这是个伏击！ | 你刚刚清洗剑上的兽人血迹，突然发现一群人向你走来。他们举着%faction%的旗帜，手持武器。你意识到自己中了埋伏，这些混账先让你先去干掉那些兽人！让他们见识一下吧！ | 一个人从你身后走过来，你甚至没注意他什么时候出现的。他武器精良，披甲戴盔，满脸喜悦地向你微笑着。%SPEECH_ON%晚上好，雇佣兵。对那些绿皮干得不错啊，对吧？%SPEECH_OFF%他停顿了一下，微笑消失不见。%SPEECH_ON%%employer%派我来问候你。%SPEECH_OFF%就在此时，一群人从路两旁潜出。这是个伏击！该死的贵族背叛了你！ | 战斗才刚刚结束，一群穿着%faction%颜色的武装人员出现在你们背后，排成队伍，盯着你们的战团。他们的领袖慢慢地向你们走过来。%SPEECH_ON%我很享受从你的冰冷的手中夺走你的剑的那一刻。%SPEECH_OFF%你耸了耸肩膀，问为什么会中了埋伏。%SPEECH_ON%因为%employer%永远不会忘记那些背叛他或者他的家族的人。你只需要知道这些就够了。当你死的时候，我再跟你说这些也没有任何用处。%SPEECH_OFF%准备战斗吧，这是个伏击！ | 你的战斗团队搜查了兽人营地，却没发现一个人。突然，几个陌生人出现在你的背后，他们的中尉带着恶意走到你们面前，胸前绣着%employer%的徽章。%SPEECH_ON%真遗憾，那些兽人没能把你们解决掉。如果你想知道为什么我会出现在这里，是因为我要偿还债务，欠%faction%的债务。你承诺完成某项任务，然而你并没有兑现。现在你就死吧。%SPEECH_OFF%你拔出剑，瞪向中尉。%SPEECH_ON%看起来%faction%即将失约一次。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", false);
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "Betrayal";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 140 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Betrayal2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你在你腿上抹去了剑上的血并收回鞘内。 伏击者死了，扭曲成这样那样的姿势。%randombrother% 走过来问你现在怎么办。 看起来 %faction% 不会是最友善的人了。 | 你将伏击者的尸体从你剑上踹开。 看起来 %faction% 现在起不会是最友善的人了。 也许下一次，当我同意为这些人做点什么的时候，我真的做到了。 | 好吧，非常明显，这里学到的是不要接一个你完成不了的活。 这块土地上的人们对那些不守承诺的人可真不怎么友好… | 你背叛了 %faction%，但是不要在这事上钻牛角尖。 他们也背叛了你，这才是最重要的！ 未来，你最好注意着点他们和任何带着他们旗帜的人。 | %employer%，从你脚下的士兵尸体判断，看来不再喜欢你了。 如果你要猜的话，这是因为你以前做了些什么－失败，背叛，背后说坏话，睡了一个贵族的女儿？ 这些全部都被你回想起来寻思着。 重要的是你们两个之间的裂缝不会轻易修复了。 你最好看着点 %faction%的人一段时间。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "只是为了报酬……",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SearchingTheCamp",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_32.png[/img]{战斗过后，你搜寻了兽人的营地。在废墟中，你发现了看起来像是沉重护甲和人类武器的东西，不过看上去已经不能用了。可惜的是，你没有找到它们原来的主人。 | 几个兽人已经被你击败，你查看了一下他们的营地。满地都是垃圾。简直就是个垃圾场。%randombrother%走上前来，在一个帐篷柱子上擦了擦他的靴子。%SPEECH_ON%先生，我们是继续前进还是继续寻找？%SPEECH_OFF%你已经看到了足够多，闻到了够臭烘烘的味道。 | 兽人的营地是一个摇摇欲坠的废墟，到处弥漫着它们的味道和废物。毫不奇怪他们如此好战，因为他们甚至连文明社会都是个陌生的词语。 | 虽然兽人被你打败了，但你还是在废墟中找到了一些人类的尸体。从他们的武器来看，他们像是像你一样的佣兵。真可惜...现在他们的所有东西都被烧毁了。 | 你的几名雇佣兵走遍了兽人营地的废墟，翻找着这个那个没用的小玩意儿。%randombrother%把手中血迹斑斑的剑收了起来。%SPEECH_ON%没有发现什么有用的，先生。%SPEECH_OFF%你点点头，准备带着队伍返回给%employer%。 | 战斗结束后，你在营地四处搜寻，但并没有发现任何有用的东西。你找到了一堆死亡骑士，他们苍白虫蛀的脸孔表明他们已经在这里有一段时间了。谁知道兽人拿他们来干什么。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候领工钱了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Volunteer1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_32.png[/img]{战斗已经结束，但仍然有人在叫喊。你告诉%randombrother%闭上嘴巴，因为他总是喜欢发出一些随意的低声或尖叫声，但他摇了摇头说这不是他。就在这时，一个手铐男子从曾经是兽人营地的灰烬中站了起来。%SPEECH_ON%晚上好，各位先生！我相信你们已经救了我。%SPEECH_OFF%他摇摇晃晃地走来，一团幽灵般扭曲的灰尘云在他身后旋转。%SPEECH_ON%显然，我非常感激，并且我想报答你们。你们是雇佣兵，对吗？如果是这样，我想和你们一起战斗。%SPEECH_OFF%他从地上捡起一把刀，手腕灵巧地舞动着，像是自己从小就拥有它一样。一个有趣的提议，变得越来越有趣... | 整理完手中的武器，一个声音从一座倒塌的兽人帐篷中传来。%SPEECH_ON%好吧，先生们，你们做到了！%SPEECH_OFF%你看着一个面带微笑的男人出现。%SPEECH_ON%你们救了我！我想用我的手来报答这个服务！%SPEECH_OFF%他伸出手，停顿了一下，然后又把手拿回去了。%SPEECH_ON%我的意思是为你战斗！我想和你们战斗，先生！如果你们能做到这些，那么我肯定是一个好伙伴，对吗？%SPEECH_OFF%嗯，一个有趣的提议。你抛给他一把武器，他轻松地接住了。他手舞足蹈地旋转着柄，试图把它插入一把看不见的剑鞘当中。%SPEECH_ON%我叫%dude_name%。%SPEECH_OFF% | 一个身穿破烂的破铁甲的男子向你冲过来。他的手臂被绑在背后。%SPEECH_ON%你们做到了！我简直不敢相信！对不起，让我解释一下我的骄傲。一天前，我们试图攻进营地时，我被兽人俘虏了。当你们出现时，我想他们马上要把我放在烤叉上了。我趁机逃脱，但现在我看到你们和你们的队伍可能值得加入。%SPEECH_OFF%你让这个人说重点。他如实地说了。%SPEECH_ON%我想为你们战斗，先生。我有经验——曾经在领主军队中，当过雇佣兵，做过其他事情。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "欢迎来到战团！",
					function getResult()
					{
						this.World.getPlayerRoster().add(this.Contract.m.Dude);
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude.onHired();
						this.Contract.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "你得到别处去碰碰运气了。",
					function getResult()
					{
						this.World.getTemporaryRoster().clear();
						this.Contract.m.Dude = null;
						return 0;
					}

				}
			],
			function start()
			{
				local roster = this.World.getTemporaryRoster();
				this.Contract.m.Dude = roster.create("scripts/entity/tactical/player");
				this.Contract.m.Dude.setStartValuesEx(this.Const.CharacterVeteranBackgrounds);

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getArmor() * 0.33);
				}

				if (this.Contract.m.Dude.getTitle() == "")
				{
					this.Contract.m.Dude.setTitle("幸存者");
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到%employer%那里，汇报了你的工作。他向你挥了挥手。%SPEECH_ON%拜托了，雇佣兵。我已经知道了。你以为我在这些地方没有间谍吗？%SPEECH_OFF%他朝着桌角的一个小包裹做了一个手势，你把它取了过来，然后那个人翻了一个手腕。%SPEECH_ON%那就已经足够了，现在请离开我的视线。%SPEECH_OFF% | 你向%employer%展示了一只兽人的头颅。他看着它，然后看着你。%SPEECH_ON%有趣。那么你已经完成了我的要求吗？%SPEECH_OFF%你点了点头。那个人微笑着，交给了你一个木制宝箱，里面有%reward%克朗的奖励。%SPEECH_ON%我就知道我能信任你，雇佣兵。%SPEECH_OFF% | 你回到时，%employer%盯着你看。%SPEECH_ON%我已经听说了你的事情。%SPEECH_OFF%他的声音里有一种奇怪的语气，让你迅速回顾了过去一个星期你所做的事情。是贵族女人在...不行，那不是可能的。%SPEECH_ON%兽人已经死了。干得好，佣兵。%SPEECH_OFF%他塞给你一个%reward%克朗的小包, 你松了一口气。 | 你走进%employer%的房间，坐下来，倒了一杯酒。贵族盯着你看。%SPEECH_ON%我敢说，这不是画成四份的罪行，如果我感觉友好，那就是绞刑罪，如果我不友好，那就是火刑罪。%SPEECH_OFF% 你喝完酒，然后把一颗兽人头砸在桌子上。杯子晃动着，在桌子上滚动。%employer%向后缩，然后冷静下来。%SPEECH_ON%啊，是的，你干得好。那不是我最好的酒。%randomname%，我的卫兵，在外面等着你。他会带着我们约定的%reward%克朗给你的。%SPEECH_OFF% | 你举起一颗兽人头给%employer%看。绿色的口张开，舌头伸出，可能会被误认为是獠牙。%employer%点点头，挥了挥手。%SPEECH_ON%请你对我的梦寄予怜悯，把它带走。%SPEECH_OFF% 你按照所说的去做。这个人摇了摇头。%SPEECH_ON%这些天我怎么能睡觉，这样东西被运来了。不管怎样，你在外面已经有%reward%克朗的报酬在等着你了，还有我的一个卫兵。干得好，佣兵。%SPEECH_OFF% | 你来到%employer%的房间，发现他正在观看一张卷轴上的图纸。他注视着你，纸片的唇翻了回来。%SPEECH_ON%你能相信我的女儿自认为是个艺术家吗？%SPEECH_OFF%他向你展示了卷轴。上面画了一个看起来非常像%employer%的人。被描绘的人正面对着一个刽子手。%employer%大笑。%SPEECH_ON%愚蠢的女孩。%SPEECH_OFF% 他把卷轴揉成一团，随意地扔到了一边。%SPEECH_ON%不管怎么说，我的间谍已经告诉我你的成功了。这是我们约定的报酬。%SPEECH_OFF%}",
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
						this.World.Assets.addMoney(this.Contract.m.Reward);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "摧毁了兽人的营地");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isGreenskinInvasion())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() + this.Flags.get("HeadsCollected") * this.Contract.m.Payment.getPerCount();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Origin, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.m.Origin.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
		_vars.push([
			"dude_name",
			this.m.Dude == null ? "" : this.m.Dude.getNameOnly()
		]);
		_vars.push([
			"reward",
			this.m.Reward
		]);
	}

	function onOriginSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/greenskins_situation"));
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

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
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

			if (this.m.Origin.getOwner().getID() != this.m.Faction)
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

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

