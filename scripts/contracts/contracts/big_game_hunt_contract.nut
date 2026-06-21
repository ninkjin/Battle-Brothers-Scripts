this.big_game_hunt_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Size = 0,
		Dude = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.big_game_hunt";
		this.m.Name = "大型狩猎";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
		this.m.MakeAllSpawnsResetOrdersOnceDiscovered = true;
		this.m.DifficultyMult = 1.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function setup()
	{
		local r = this.Math.rand(1, 100);

		if (r <= 40)
		{
			this.m.Size = 0;
			this.m.DifficultyMult = 0.75;
		}
		else if (r <= 75 || this.World.getTime().Days <= 30)
		{
			this.m.Size = 1;
			this.m.DifficultyMult = 1.0;
		}
		else
		{
			this.m.Size = 2;
			this.m.DifficultyMult = 1.2;
		}
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local maximumHeads;
		local priceMult = 1.0;

		if (this.m.Size == 0)
		{
			local priceMult = 1.0;
			maximumHeads = [
				15,
				20,
				25,
				30
			];
		}
		else if (this.m.Size == 1)
		{
			local priceMult = 4.0;
			maximumHeads = [
				10,
				12,
				15,
				18,
				20
			];
		}
		else
		{
			local priceMult = 8.0;
			maximumHeads = [
				8,
				10,
				12,
				15
			];
		}

		this.m.Payment.Pool = 1300 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult() * priceMult;
		this.m.Payment.Count = 1.0;
		this.m.Payment.MaxCount = maximumHeads[this.Math.rand(0, maximumHeads.len() - 1)];
		local settlements = this.World.FactionManager.getFaction(this.m.Faction).getSettlements();
		local other_settlements = this.World.EntityManager.getSettlements();
		local regions = this.World.State.getRegions();
		local candidates_first = [];
		local candidates_second = [];

		foreach( i, r in regions )
		{
			local inSettlements = 0;
			local nearSettlements = 0;

			if (r.Type == this.Const.World.TerrainType.Snow || r.Type == this.Const.World.TerrainType.Mountains || r.Type == this.Const.World.TerrainType.Desert || r.Type == this.Const.World.TerrainType.Oasis)
			{
				continue;
			}

			if (!r.Center.IsDiscovered)
			{
				continue;
			}

			if (this.m.Size == 2 && r.Type != this.Const.World.TerrainType.Steppe && r.Type != this.Const.World.TerrainType.Forest && r.Type != this.Const.World.TerrainType.LeaveForest && r.Type != this.Const.World.TerrainType.AutumnForest)
			{
				continue;
			}

			if (r.Discovered < 0.5)
			{
				this.World.State.updateRegionDiscovery(r);
			}

			if (r.Discovered < 0.5)
			{
				continue;
			}

			foreach( s in settlements )
			{
				local t = s.getTile();

				if (t.Region == i + 1)
				{
					inSettlements = ++inSettlements;
				}
				else if (t.getDistanceTo(r.Center) <= 20)
				{
					local skip = false;

					foreach( o in other_settlements )
					{
						if (o.getFaction() == this.getFaction())
						{
							continue;
						}

						local ot = o.getTile();

						if (ot.Region == i + 1 || ot.getDistanceTo(r.Center) <= 10)
						{
							skip = true;
							break;
						}
					}

					if (!skip)
					{
						nearSettlements = ++nearSettlements;
					}
				}
			}

			if (nearSettlements > 0 && inSettlements == 0)
			{
				candidates_first.push(i + 1);
			}
			else if (inSettlements > 0 && inSettlements <= 1)
			{
				candidates_second.push(i + 1);
			}
		}

		local region;

		if (candidates_first.len() != 0)
		{
			region = candidates_first[this.Math.rand(0, candidates_first.len() - 1)];
		}
		else if (candidates_second.len() != 0)
		{
			region = candidates_second[this.Math.rand(0, candidates_second.len() - 1)];
		}
		else
		{
			region = settlements[this.Math.rand(0, settlements.len() - 1)].getTile().Region;
		}

		this.m.Flags.set("Region", region);
		this.m.Flags.set("HeadsCollected", 0);
		this.m.Flags.set("StartDay", 0);
		this.m.Flags.set("LastUpdateDay", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				this.Contract.m.BulletpointsObjectives.clear();

				if (this.Contract.m.Size == 0)
				{
					if (this.Const.DLC.Desert)
					{
						this.Contract.m.BulletpointsObjectives.push("猎杀恐狼、织网蛛、食尸鬼、鬣狗和大蛇");
					}
					else
					{
						this.Contract.m.BulletpointsObjectives.push("猎杀恐狼、织网蛛和食尸鬼");
					}
				}
				else if (this.Contract.m.Size == 1)
				{
					this.Contract.m.BulletpointsObjectives.push("猎杀梦魔、巨魔和女巫");
				}
				else
				{
					this.Contract.m.BulletpointsObjectives.push("猎杀树人和林德虫");
				}

				this.Contract.m.BulletpointsObjectives.push("在%worldmapregion%的%regiontype%区域附近或其它地区进行狩猎");
				this.Contract.m.BulletpointsObjectives.push("任意时刻返回%townname%以领取报酬");

				if (this.Contract.m.Size == 0)
				{
					this.Contract.setScreen("TaskSmall");
				}
				else if (this.Contract.m.Size == 1)
				{
					this.Contract.setScreen("TaskMedium");
				}
				else
				{
					this.Contract.setScreen("TaskLarge");
				}
			}

			function end()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				local action = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getAction("send_beast_roamers_action");
				local options;

				if (this.Contract.m.Size == 0)
				{
					options = action.m.BeastsLow;
				}
				else if (this.Contract.m.Size == 1)
				{
					options = action.m.BeastsMedium;
				}
				else
				{
					options = action.m.BeastsHigh;
				}

				local nearTile = this.World.State.getRegion(this.Flags.get("Region")).Center;

				for( local i = 0; i < 3; i = ++i )
				{
					for( local tries = 0; tries++ < 1000;  )
					{
						if (options[this.Math.rand(0, options.len() - 1)](action, nearTile))
						{
							local party = action.getFaction().getUnits()[action.getFaction().getUnits().len() - 1];
							party.setAttackableByAI(false);
							this.Contract.m.UnitsSpawned.push(party.getID());
							local wait = this.new("scripts/ai/world/orders/wait_order");
							wait.setTime(15.0);
							party.getController().addOrderInFront(wait);
							local footPrintsOrigin = this.Contract.getTileToSpawnLocation(nearTile, 4, 8);
							this.Const.World.Common.addFootprintsFromTo(footPrintsOrigin, party.getTile(), this.Const.BeastFootprints, party.getFootprintType(), party.getFootprintsSize(), 1.1);
							break;
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
				this.Contract.m.BulletpointsObjectives.clear();

				if (this.Contract.m.Size == 0)
				{
					if (this.Const.DLC.Desert)
					{
						this.Contract.m.BulletpointsObjectives.push("在%worldmapregion%的%regiontype%区域附近猎杀恐狼、织网蛛和食尸鬼(%killcount%/%maxcount%)");
					}
					else
					{
						this.Contract.m.BulletpointsObjectives.push("在%worldmapregion%的%regiontype%区域附近猎杀恐狼、织网蛛、食尸鬼、鬣狗和大蛇(%killcount%/%maxcount%)");
					}
				}
				else if (this.Contract.m.Size == 1)
				{
					this.Contract.m.BulletpointsObjectives.push("在%worldmapregion%的%regiontype%区域附近猎杀梦魔、巨魔和女巫(%killcount%/%maxcount%)");
				}
				else
				{
					this.Contract.m.BulletpointsObjectives.push("在%worldmapregion%的%regiontype%区域附近猎杀树人和林德虫(%killcount%/%maxcount%)");
				}

				this.Contract.m.BulletpointsObjectives.push("任意时刻返回%townname%以领取报酬");
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home) && this.Flags.get("HeadsCollected") != 0)
				{
					if (this.Contract.m.Size == 0)
					{
						this.Contract.setScreen("SuccessSmall");
					}
					else if (this.Contract.m.Size == 1)
					{
						this.Contract.setScreen("SuccessMedium");
					}
					else
					{
						this.Contract.setScreen("SuccessLarge");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
				{
					return;
				}

				if (this.Flags.get("HeadsCollected") >= this.Contract.m.Payment.MaxCount)
				{
					return;
				}

				if (this.Contract.m.Size == 0)
				{
					if (_actor.getType() == this.Const.EntityType.Ghoul || _actor.getType() == this.Const.EntityType.Direwolf || _actor.getType() == this.Const.EntityType.Spider || _actor.getType() == this.Const.EntityType.Hyena || _actor.getType() == this.Const.EntityType.Serpent)
					{
						this.Flags.set("HeadsCollected", this.Flags.get("HeadsCollected") + 1);
					}
				}
				else if (this.Contract.m.Size == 1)
				{
					if (_actor.getType() == this.Const.EntityType.Alp || _actor.getType() == this.Const.EntityType.Unhold || _actor.getType() == this.Const.EntityType.UnholdFrost || _actor.getType() == this.Const.EntityType.UnholdBog || _actor.getType() == this.Const.EntityType.Hexe)
					{
						this.Flags.set("HeadsCollected", this.Flags.get("HeadsCollected") + 1);
					}
				}
				else if (_actor.getType() == this.Const.EntityType.Lindwurm && !this.isKindOf(_actor, "lindwurm_tail") || _actor.getType() == this.Const.EntityType.Schrat)
				{
					this.Flags.set("HeadsCollected", this.Flags.get("HeadsCollected") + 1);
				}
			}

			function onCombatVictory( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.start();
				this.World.State.getWorldScreen().updateContract(this.Contract);
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationPerHead);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "TaskSmall",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_63.png[/img]{你进入%employer%的房间。他正用孔雀羽毛剔着手指，用一端来去除污垢而同时晃动着另一端的色彩。他当着你的面轻蔑地说。%SPEECH_ON%我的守卫已经通知我说你对狩猎野兽感兴趣，对此我很高兴。报酬将按头颅数计算。小型野兽，织网蛛，吃尸体玩意，这类东西我相信对你而言不是问题，但是当地人害怕去直面这些。如果你像人们说的那样擅长你的工作，那么你就不应该在接受这份合同上拖沓。除掉我土地上的这些东西。要开始的话，有人在%direction%离这里%distance%%worldmapregion%地区目击了它们。%SPEECH_OFF% | %employer%将你迎进了他的房间。他拿起一卷先前在市场上散步时镇上宣读告示者给你的卷轴。%SPEECH_ON%啊，原来你是来狩猎野兽的。我以为你是来搞特殊…%SPEECH_OFF%他捏了捏你衬衫的边，笑了笑。%SPEECH_ON%表演的。好吧，都一样。野兽正在袭扰乡村，我很乐意付给你一笔可观的钱去处理它们。当然，报酬是按头颅数计算的，如果你一直锋芒不衰可以赚很多钱。如果你需要一个地方开始你的狩猎，去%direction%离这里%distance%%worldmapregion%地区。在那里你发现各种各样的八条腿的怪物和毛茸茸的怪物。不管是什么能吓倒普通农夫的东西，对你来说都应该不是问题，你个大块头。%SPEECH_OFF% | 你发现%employer%把他没穿鞋的脚放在桌子上，一群女人围在那在修剪。她们用拇指从他脚趾间抠下厚厚的泥土，仿佛是某个异像怪兽的诞生仪式。你清了清嗓子，那人也吃惊的用清嗓子回应。%SPEECH_ON%啊，是的，佣兵。如果你有兴趣的话，我这里有一个任务给你。%SPEECH_OFF%他不屑一顾地往你脚边扔了一个卷轴，上面列出了需要杀死的野兽。织网蛛，小狼啥的，没有太过可怕的东西。地图上的注释指向%direction%%worldmapregion%附近的区域。那个人打了个嗝。%SPEECH_ON%报酬将按头颅数计算，希望这样也更适合你。%SPEECH_OFF% | 你发现%employer%手里握着一根斧柄。斧柄和斧刃分界线的地方明显的劈了，昭示这这件武器寿命的结束。他把它扔到桌上，拍下手掌上的木屑。%SPEECH_ON%野兽在这片土地上游荡，我需要一些你这类人去把它们都杀光。你怎么说呢，恩？报酬将按头颅数计算。要开始狩猎的话，去%direction%的%worldmapregion%地区。各种乱七八糟的小型野兽在那造成不小的麻烦。%SPEECH_OFF% | %employer%将你迎入他的房间。他的桌子上满是卷轴，每个卷轴上都画着动物和野兽，甚至还可能有怪物。他嚼着浆果，一边说话一边喷出果汁沫。%SPEECH_ON%当地人说有一些很糟糕的麻烦出现了，尽管没有人给我一个准确的描述，说明到底是什么麻烦。说的都是怪物般的狼或八条腿的怪兽啥的。我没办法坐视不管，所以我要求你的服务。前往%direction%离这%distance%%worldmapregion%地区。如果你看到任何野兽，就当场杀死它们并取走它们的头。我会按照头皮数付钱。%SPEECH_OFF% | %employer%在与一群农夫的集会上与你会面。他声称据信是怪物的东西正在把内陆地区撕成碎片。一个农夫插嘴。%SPEECH_ON%野兽，一大群。用后腿走路的狼，巨大的蜘蛛，臭气熏天的吃尸体的玩意。%SPEECH_OFF%贵族挥挥手。%SPEECH_ON%好的，好的，足够了。佣兵，我需要你出发去猎杀这些生物。先前往在这里%direction%的%worldmapregion%地区，然后确保任何活着的野兽都被放倒在地。但记得将头颅带回来，我将会为每个头买单。当然，前提是你对此有兴趣。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈多少克朗？ | 如果你能付出合适的价格。 | 继续。 | 你臣民的安全对你来说值多少钱？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这并不值得我去跑腿。 | 我们不打算去%worldmapregion%追捕幽灵。 | 这不是我们要找的那类工作。}",
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
			ID = "TaskMedium",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_63.png[/img]{当你进入时，%employer%正在翻阅一本书。他抬起头招手让你过去。%SPEECH_ON%拿一支蜡烛来。%SPEECH_OFF%你从墙上取下一个炬台，贵族却挥舞着他的手。%SPEECH_ON%我说的是蜡烛，不是天杀的火把！你打算把我所有的书都烧成灰吗？就呆在原地别动。听着，这附近的的人们一直在谈论我已多年未曾听闻的邪恶事物。捕食你梦境的怪兽，大到胡子能塞人的巨兽，当然还有最糟糕的，知道自己有多美丽的美丽女人。%SPEECH_OFF%你对最后那个不太确定，但也没因此张口。这名贵族继续解释道，你要在他的领土上杀死你发现的每一个怪物。在这里%direction%的%worldmapregion%区域已经有目击，但你可以自由的去所有这些生物可能藏匿的地方猎杀它们。 | 你发现%employer%正与一些身穿黑斗篷的人集会。他们招手示意你过去，你迟疑的照做了。那个贵族问你是否知道如巨魔这样的怪物，或是那些以梦为食的生物。在你回答之前，他挥了挥手。%SPEECH_ON%都无所谓，我需要一些武装人员搜查%direction%的%worldmapregion%地区，看看是否有什么奇怪的东西。如果它不是有心跳的人类，就杀了它并带回它的头颅。我会为每个头皮付给你丰厚的报酬。当然，前提是它们真的存在。%SPEECH_OFF% | %employer%双手都拿着卷轴，却一个都没阅读，而是专注地盯着桌上的第三个卷轴。最后，他将两个卷轴扔开，并扫开了最后那个。他看着你。%SPEECH_ON%有传言说有怪物出没。巨人在吃牛和儿童。我也收到报告说有人在做恶梦，并因此杀了他们的邻居。以及还有一堆这附近一个漂亮女人的传言。我不知道她是否是某种邪恶生物，但一个在%direction%%worldmapregion%地区居住的美丽女人听起来只像是麻烦。%SPEECH_OFF%你点了点头。一个独自在陌生区域的女人，对有些人而言当然会是麻烦。贵族张开他的双臂。%SPEECH_ON%你能带你的战士去那个地方，找到真相和谎言之间的界限吗？如果你发现了某些蛇一样的或不是人的东西，将它杀死，把它的头带给我。%SPEECH_OFF% | 你发现%employer%正低头看书，蜡烛近得让书页边缘的半影都黯淡无光。就仿佛只有他才应该读这些文本一样。看到你，他挥手示意你过去。%SPEECH_ON%我收到了%direction%%worldmapregion%地区发生奇怪事件的报告。谋杀频发，不知何故。还有一些人就那么消失了。这从来不是好兆头。我不知道是邪教还是怪物所为，但我需要一些武装人员去那地方摆平它。如果你与超自然之物交锋，那么把它的头带回给我，我会丰厚地支付报酬。%SPEECH_OFF% | %employer%正爬在梯子上，在他最高的架子上翻找。他摇了摇头，招手示意你进来。%SPEECH_ON%我他娘的都不知道我在找什么。%SPEECH_OFF%你点了点头，告诉他来和你作伴。那个人爬了下来。%SPEECH_ON%很有趣，雇佣兵。听好，我从%direction%离这%distance%%worldmapregion%地区发生混乱的消息。没多少人会去住在那里，但真住那的人正在谈论行于大地的绝对恐怖。巨人，感染他们梦境的鬼魂，什么你能想到的都有。我需要你带领你的战团去平息那些“烫手”的东西，如何？记得带回你找到的任何非人怪物的头颅，我会为每个头颅付给你不错的报酬。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈多少克朗？ | 如果你能付出合适的价格。 | 继续。 | 你臣民的安全对你来说值多少钱？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这并不值得我去跑腿。 | 我们不打算去%worldmapregion%追捕幽灵。 | 这不是我们要找的那类工作。}",
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
			ID = "TaskLarge",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_63.png[/img]{%employer%坐在桌旁，房间里没有别人。你坐到了为你准备的座位上。他俯身向前。%SPEECH_ON%我的家族有着某种传说。我父亲遇到了这个传说，还有我父亲的父亲也是。我们不知道这传说从何而来。我曾期望在自己的有生之年亲眼看看这个传说，现在我觉得我已经看到了。在梦中，就在昨晚。%SPEECH_OFF%听到这个，你已经坐到了椅子边缘，因为中间有一个洞。你点了点头，他继续说。%SPEECH_ON%前往%direction%的%worldmapregion%地区。我相信传说是真的，一只巨大的野兽在那片土地上游荡。也许甚至不止一个！不管有多少，我需要最有经验的佣兵来寻找它。将头颅带回来，你会得到丰厚的回报。你愿意吗？%SPEECH_OFF% | 你进入%employer%的房间。他给你一个卷轴，上面全是你看不懂的字母。那个贵族说这是一段传奇。他双臂张开。%SPEECH_ON%树木大小的野兽在这些土地上游荡，我相信如此。在这里%direction%的%worldmapregion%。那里的农民在谈论令人那以置信的大怪物。但我愿意去相信。我想近距离看一看，这就是我为什么把你召集到这里来的原因。到那可怕的地方去，杀掉任何超凡的生物，把它的头放在我的脚前。%SPEECH_OFF% | %employer%将你迎入房间并直入主题。%SPEECH_ON%我要你去%direction%的%worldmapregion%地图。我记录许多关于巨兽在那片土地上游荡的流言，我相信它们的每一句话。树一样大的蛇，还有装成树也和树一样大的东西！不管它们是什么，我要你杀了它们并把头带回给我。或者鳞片，树枝，随便什么。我会为你带来每一个付钱。你对此感兴趣吗？%SPEECH_OFF% | %employer%给你一本书，有些书页是歪歪扭扭的。你认为这是对罕见材料的一种危险的冒犯，但对此你保持了沉默。这个贵族问你知不知道巨人，龙，海怪之类的东西。在你回答之前，%employer%把他的手指放在书打开的书页上。他的指关节敲打在一只比橡树还高的野兽的画上，一定程度上是因为是它看起来就像一棵橡树。%SPEECH_ON%我认为它们存在。我想它们现在就在%worldmapregion%，就在这里的%direction%。佣兵，我要你到那里去杀死所有你发现的邪恶生物。把他们的头带回给我。危险难以估量，但回报将是巨大的。你觉得自己能行吗？%SPEECH_OFF% | %employer%以即将将人派向必然的毁灭的面容欢迎你。不管怎样，他还是笑了，因为那不是他的毁灭。%SPEECH_ON%啊，很高兴看到一个武人。我相信你已经听说了，关于%worldmapregion%区域绝对怀孕着邪恶野兽的谣言满天飞。%SPEECH_OFF%你不确定你会在那用这个词，但还是点了点头。贵族点头回应。%SPEECH_ON%我在这个世界上信任的人不多，其中一个最近报告说，他看见一个无比巨大的生物，虽然他认为它有树那么高。另一个斥候也说像龙一样大的蛇在附近游荡。无论那里有什么，我需要你去%direction%的那片地区去，除掉任何滋扰它的东西。根据这些报告，这可能会是你这辈子做的最危险的事。你准备好了吗？你的手下准备好了吗？我不会雇一个有半分懈怠的人。%SPEECH_OFF%}   ",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们来谈谈多少克朗？ | 这可不是一件小事。 | 如果你能付出合适的价格。 | 像这样的工作最好有丰厚报酬。 | 你臣民的安全对你来说值多少钱？}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{我们不打算去%worldmapregion%追捕幽灵。 | 这不是我们要找的那类工作。 | 我不会让战团去冒险对付这样的敌人。}",
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
			ID = "SuccessSmall",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回来后把野兽的头颅倒在%employer%的地板上。他抬头从桌子后查看。%SPEECH_ON%这可真离谱。把钱拿给这人，再找个仆人来收拾这烂摊子。%SPEECH_OFF% | %employer%欢迎你回来，尽管他保持与你的距离。他盯着你的货物。%SPEECH_ON%不错的交差，佣兵。我会让我的人清点人头，然后按照我们的协议付给你钱。%SPEECH_OFF% | 杀戮工作按照%employer%的要求达成。他点头并挥手示意你离开。%SPEECH_ON%非常感谢，但我不想再多看这些恶心玩意一秒钟。%randomname%，快过来把钱交给他。%SPEECH_OFF% | %employer%欢迎你回来并查看你的货物。%SPEECH_ON%真恶心。痛快！这是你的报酬，正如约定。%SPEECH_OFF% | 你向%employer%展示收集的头颅，他摆动手指，嘴唇发出轻声计数。最后，他挺直了身子。%SPEECH_ON%我没空干这破事。%randomname%，是的，就是你这个仆人，过来数一下这些人头，然后按约定的金额为每个头给佣兵付钱。%SPEECH_OFF% | %employer%正在吃苹果，他走过去看你带了什么回来。他凝视着那袋可怕的兽首，咬下一大口苹果。%SPEECH_ON%灰常除色的橙果，用兵。%SPEECH_OFF%他迅速地咀嚼，大口吞下。%SPEECH_ON%去找那边我那拿着钱包闲站着的仆人。他会付清你应得的钱。%SPEECH_OFF%这个贵族把吃了一半的苹果扔了，然后又去拿了另一个。 | %employer%在你进入他的房间时带着个孩子。这孩子跑去看你带回了什么，然后尖叫着后退。这个贵族点头。%SPEECH_ON%想来那意味着你完成了我的任务。我的仆人%randomname%会清点头颅并付给你应得的报酬。%SPEECH_OFF% | 你把头颅拖进%employer%的房间。他挑了挑眉毛。%SPEECH_ON%你为啥非要把那些玩意全都拖到这来？看，你留下一滩污渍！你为什么不去叫一个仆人来，那就是他们存在的意义。旧神啊，这气味比那污渍还糟糕！%SPEECH_OFF%这个贵族向一个拿着钱包等候的人打了个响指。%SPEECH_ON%%randomname%，清点头颅，确保佣兵得到报酬。%SPEECH_OFF% | 你展开那袋头颅，把它们堆在%employer%的地板上。他站了起来。%SPEECH_ON%那下面没有垫东西，没错吧？%SPEECH_OFF%一个仆人跑过去，把头颅踢散开来，然后迅速的摇头否认。贵族点了点头，慢慢地坐了下来。%SPEECH_ON%好。那个谁，%randomname%，快去清点，然后给佣兵把这一摊东西的钱支付清。顺便说一下，雇佣兵，下次展示的时候弄简单点，好吗？%SPEECH_OFF% | 你把一袋野兽头颅和头皮拖进%employer%的房间。打开盖子，你开始将其向前倾斜。一个仆人瞪大了眼睛，冲过来猛的撞上袋子，将它倾斜回去。盖子因碰撞合上时夹住了他的手指，他发出一声哽咽的惨叫。%SPEECH_ON%谢谢你，雇佣兵，但是尊贵的主上希望我们清点时不要把这些东西弄的满地板都是。我会计算出总数，完成后就将钱付给你。%SPEECH_OFF% | %employer%评审你的工作。%SPEECH_ON%令人印象深刻。恶心。不是说你，是野兽。我的意思是虽然你这类人比较肮脏，佣兵，但是这些混球野兽实在就是卫生的对立面。%SPEECH_OFF%你既不知道卫生是啥意思，也不知道对立面是啥。你只是让他清点了头颅并付给你应得的报酬。 | %employer%清点头颅，然后向后仰起。他耸耸肩。%SPEECH_ON%我以为他们会更可怕。%SPEECH_OFF%你提醒说当它们还连在兽身上时，对一个人勇气的影响会有那么些许不同。这名贵族又耸耸肩。%SPEECH_ON%我想也是，但是我母亲的脑袋被刽子手剁下后，她在那篮子里瞪着世界的样子更加可怕。%SPEECH_OFF%对此你不知道该如何回复。你要求他将你应得的报酬支付给你。 | %employer%盯着你放在他地板上的兽头。一个拿着扫帚的仆人一个一个地数，从一堆中移除，加到另一堆中。当他完成计数后，他报告了他的数字，贵族点了点头。%SPEECH_ON%干得好，佣兵。仆人会拿给你报酬。%SPEECH_OFF%那个低出身的人叹气然后收起了扫帚。 | %employer%打开装有野兽头皮和头骨的袋子。他抿了抿嘴，嗅了嗅，又猛地将其合上。这名贵族命令他的一个仆人清点这堆残骸，然后按照协议付给你报酬。%SPEECH_ON%做得好，佣兵。镇上的人都很感激我花钱雇你来处理这件事。%SPEECH_OFF% | %employer%盯着你收集到的头骨和头皮吹了一声口哨。%SPEECH_ON%如果真有一声叹息，那将是一声地狱般的叹息。对于这种性质恶劣的工作，我应当考虑支付额外报酬，当然我是不会付的，但这个想法掠过了我的脑海，这才是最重要的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "狩猎野兽于" + this.World.State.getRegion(this.Flags.get("Region")).Name);
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color]克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "SuccessMedium",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回来后把野兽的头颅倒在%employer%的地板上。他抬头从桌子后查看。%SPEECH_ON%这可真离谱。把钱拿给这人，再找个仆人来收拾这烂摊子。%SPEECH_OFF% | %employer%欢迎你回来，尽管他保持与你的距离。他盯着你的货物。%SPEECH_ON%不错的交差，佣兵。我会让我的人清点人头，然后按照我们的协议付给你钱。%SPEECH_OFF% | 杀戮工作按照%employer%的要求达成。他点头并挥手示意你离开。%SPEECH_ON%非常感谢，但我不想再多看这些恶心玩意一秒钟。%randomname%，快过来把钱交给他。%SPEECH_OFF% | %employer%欢迎你回来并查看你的货物。%SPEECH_ON%真恶心。痛快！这是你的报酬，正如约定。%SPEECH_OFF% | 你向%employer%展示收集的头颅，他摆动手指，嘴唇发出轻声计数。最后，他挺直了身子。%SPEECH_ON%我没空干这破事。%randomname%，是的，就是你这个仆人，过来数一下这些人头，然后按约定的金额为每个头给佣兵付钱。%SPEECH_OFF% | %employer%正在吃苹果，他走过去看你带了什么回来。他凝视着那袋可怕的兽首，咬下一大口苹果。%SPEECH_ON%灰常除色的橙果，用兵。%SPEECH_OFF%他迅速地咀嚼，大口吞下。%SPEECH_ON%去找那边我那拿着钱包闲站着的仆人。他会付清你应得的钱。%SPEECH_OFF%这个贵族把吃了一半的苹果扔了，然后又去拿了另一个。 | %employer%在你进入他的房间时带着个孩子。这孩子跑去看你带回了什么，然后尖叫着后退。这个贵族点头。%SPEECH_ON%想来那意味着你完成了我的任务。我的仆人%randomname%会清点头颅并付给你应得的报酬。%SPEECH_OFF% | 你把头颅拖进%employer%的房间。他挑了挑眉毛。%SPEECH_ON%你为啥非要把那些玩意全都拖到这来？看，你留下一滩污渍！你为什么不去叫一个仆人来，那就是他们存在的意义。旧神啊，这气味比那污渍还糟糕！%SPEECH_OFF%这个贵族向一个拿着钱包等候的人打了个响指。%SPEECH_ON%%randomname%，清点头颅，确保佣兵得到报酬。%SPEECH_OFF% | 你展开那袋头颅，把它们堆在%employer%的地板上。他站了起来。%SPEECH_ON%那下面没有垫东西，没错吧？%SPEECH_OFF%一个仆人跑过去，把头颅踢散开来，然后迅速的摇头否认。贵族点了点头，慢慢地坐了下来。%SPEECH_ON%好。那个谁，%randomname%，快去清点，然后给佣兵把这一摊东西的钱支付清。顺便说一下，雇佣兵，下次展示的时候弄简单点，好吗？%SPEECH_OFF% | 你把一袋野兽头颅和头皮拖进%employer%的房间。打开盖子，你开始将其向前倾斜。一个仆人瞪大了眼睛，冲过来猛的撞上袋子，将它倾斜回去。盖子因碰撞合上时夹住了他的手指，他发出一声哽咽的惨叫。%SPEECH_ON%谢谢你，雇佣兵，但是尊贵的主上希望我们清点时不要把这些东西弄的满地板都是。我会计算出总数，完成后就将钱付给你。%SPEECH_OFF% | %employer%评审你的工作。%SPEECH_ON%令人印象深刻。恶心。不是说你，是野兽。我的意思是虽然你这类人比较肮脏，佣兵，但是这些混球野兽实在就是卫生的对立面。%SPEECH_OFF%你既不知道卫生是啥意思，也不知道对立面是啥。你只是让他清点了头颅并付给你应得的报酬。 | %employer%清点头颅，然后向后仰起。他耸耸肩。%SPEECH_ON%我以为他们会更可怕。%SPEECH_OFF%你提醒说当它们还连在兽身上时，对一个人勇气的影响会有那么些许不同。这名贵族又耸耸肩。%SPEECH_ON%我想也是，但是我母亲的脑袋被刽子手剁下后，她在那篮子里瞪着世界的样子更加可怕。%SPEECH_OFF%对此你不知道该如何回复。你要求他将你应得的报酬支付给你。 | %employer%盯着你放在他地板上的兽头。一个拿着扫帚的仆人一个一个地数，从一堆中移除，加到另一堆中。当他完成计数后，他报告了他的数字，贵族点了点头。%SPEECH_ON%干得好，佣兵。仆人会拿给你报酬。%SPEECH_OFF%那个低出身的人叹气然后收起了扫帚。 | %employer%打开装有野兽头皮和头骨的袋子。他抿了抿嘴，嗅了嗅，又猛地将其合上。这名贵族命令他的一个仆人清点这堆残骸，然后按照协议付给你报酬。%SPEECH_ON%做得好，佣兵。镇上的人都很感激我花钱雇你来处理这件事。%SPEECH_OFF% | %employer%盯着你收集到的头骨和头皮吹了一声口哨。%SPEECH_ON%如果真有一声叹息，那将是一声地狱般的叹息。对于这种性质恶劣的工作，我应当考虑支付额外报酬，当然我是不会付的，但这个想法掠过了我的脑海，这才是最重要的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "狩猎野兽于" + this.World.State.getRegion(this.Flags.get("Region")).Name);
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color]克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "SuccessLarge",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你把猎物的残骸拖进%employer%的房间。他向后一跳，就仿佛你驯服了这野兽并要骑着它来征服一般。那个贵族紧抓着胸口，重新坐下。%SPEECH_ON%旧神啊，佣兵，如果你不是那么傻，你应该它留在院子里，然后带我去看。%SPEECH_OFF%你耸耸肩，问及了你的报酬。他问你是怎么杀死它的。你把话题折回到报酬问题上。贵族抿了抿嘴。%SPEECH_ON%好吧。仆人！把这个顽固的野兽杀手的金币给他。%SPEECH_OFF% | 你把野兽的尸体拖到院子里，然后呼叫%employer%。他走到窗前，向下看了很长时间。%SPEECH_ON%这是真的还是你在开玩笑？%SPEECH_OFF%你叹了口气，拔出剑来，扎进一只大眼睛里。砰的一声，它泄了气，将黄色的液体喷溅到了周围的土上。贵族吹着口哨，咋了咋舌。%SPEECH_ON%旧神啊，真希望你没这么做！我马上派仆人给你拿报酬来！%SPEECH_OFF% | 你征召了一头驴，让它帮忙把被杀死的可憎之物拖进城镇。它轻轻一摇耳朵，无声地凝视着它那扭曲的超凡的行李。%employer%在他的居所之外会见你。他站到怪兽残骸边上，用拇指和食指的凹槽托住下巴。%SPEECH_ON%令人震撼，我无法想象它在活着和战斗时的样子。%SPEECH_OFF%点着头，你告诉他外面毫无疑问还有更多类似东西，并且你下次狩猎时他应该一起来。他摇了摇头。%SPEECH_ON%我将拒绝那个提议，佣兵。这是你的报酬，然后我命令你把那头驴还给它的主人。%SPEECH_OFF%一个农夫一边用布擦着前额一边大步走来。%SPEECH_ON%这东西叫骡子，如果你想借这该死的东西，你可以用问的！%SPEECH_OFF% | 你把野兽的残骸切碎，然后一件件地拖进%employer%的房间。当尸块堆积起来后，他用一块布捂住鼻子。%SPEECH_ON%所以神话是真实的。这些野兽真实存在。%SPEECH_OFF%几个仆人把肉块重新拼在一起，构成了一个畸形的怪兽形象，虽然每当他们松手就会碎开。这名贵族点了点头，打了个响指。%SPEECH_ON%把钱付给雇佣兵，再把我的顾问叫来。%SPEECH_OFF% | %employer%的一个手下拿着刻刀站在一边，准备好凿开野兽的残骸。他咧嘴大笑。%SPEECH_ON%我家族的姓氏可以被刻在骨头上，用作斧头或剑的柄。%SPEECH_OFF%你告诉那两个人不要什么都不要碰，除非他们先把报酬付给你。那名贵族笑了。%SPEECH_ON%没必要这么暴躁，雇佣兵。这会儿我的一个仆人正在拿来你的报酬，如果你敢再用这种腔调说话，我不管你是怪兽杀手还是啥都会割下你的舌头。%SPEECH_OFF%你用手扶着剑柄表达你的耐心，并开始在脑海中倒计时。值得每个人庆幸的是，仆人在数到零之前到达了。 | %employer%像个孩子一样对着这些野兽的残骸拍手叫好。%SPEECH_ON%讲述我事迹的故事将会无比伟大。我要用这些骨头来做武器的握柄，然后讲述我如何获取这些野兽脑袋的故事。%SPEECH_OFF%你点头。听起来不错。反正历史书上也不会记载你的名字。你要求你的报酬。%employer%点着头，目光没有离开那些生物，打了几个响指。%SPEECH_ON%仆人！把这个人的金币给他！%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.Assets.addMoney(this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected"));
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "狩猎野兽于" + this.World.State.getRegion(this.Flags.get("Region")).Name);
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local money = this.Contract.m.Payment.getOnCompletion() + this.Contract.m.Payment.getPerCount() * this.Flags.get("HeadsCollected");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color]克朗"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		local dest = this.World.State.getRegion(this.m.Flags.get("Region")).Center;
		local distance = this.World.State.getPlayer().getTile().getDistanceTo(dest);
		distance = this.Const.Strings.Distance[this.Math.min(this.Const.Strings.Distance.len() - 1, distance / 30.0 * (this.Const.Strings.Distance.len() - 1))];
		_vars.push([
			"killcount",
			this.m.Flags.get("HeadsCollected")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
		_vars.push([
			"worldmapregion",
			this.World.State.getRegion(this.m.Flags.get("Region")).Name
		]);
		_vars.push([
			"direction",
			this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(dest)]
		]);
		_vars.push([
			"distance",
			distance
		]);
		_vars.push([
			"regiontype",
			this.Const.Strings.TerrainShort[this.World.State.getRegion(this.m.Flags.get("Region")).Type]
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onIsTileUsed( _tile )
	{
		return false;
	}

	function onSerialize( _out )
	{
		_out.writeU8(this.m.Size);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Size = _in.readU8();
		this.contract.onDeserialize(_in);
	}

});

