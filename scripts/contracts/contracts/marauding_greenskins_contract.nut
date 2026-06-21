this.marauding_greenskins_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Objective = null,
		Target = null,
		IsPlayerAttacking = true,
		LastRandomEventShown = 0.0
	},
	function setObjective( _h )
	{
		if (typeof _h == "instance")
		{
			this.m.Objective = _h;
		}
		else
		{
			this.m.Objective = this.WeakTableRef(_h);
		}
	}

	function setOrcs( _o )
	{
		this.m.Flags.set("IsOrcs", _o);
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.marauding_greenskins";
		this.m.Name = "绿皮肆虐";
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

		local myTile = this.m.Origin.getTile();
		local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(myTile);
		local goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(myTile);

		if (myTile.getDistanceTo(orcs.getTile()) + this.Math.rand(0, 8) < myTile.getDistanceTo(goblins.getTile()) + this.Math.rand(0, 8))
		{
			this.m.Flags.set("IsOrcs", true);
		}
		else
		{
			this.m.Flags.set("IsOrcs", false);
		}

		local bestDist = 9000;
		local best;
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.isMilitary() || s.isSouthern() || !s.isDiscovered())
			{
				continue;
			}

			if (s.getID() == this.m.Origin.getID() || s.getID() == this.m.Home.getID())
			{
				continue;
			}

			local d = this.getDistanceOnRoads(s.getTile(), this.m.Origin.getTile());

			if (d < bestDist)
			{
				bestDist = d;
				best = s;
			}
		}

		if (best != null)
		{
			local distance = this.getDistanceOnRoads(best.getTile(), this.m.Origin.getTile());
			this.m.Flags.set("MerchantReward", this.Math.max(150, distance * 5.0 * this.getPaymentMult()));
			this.setObjective(best);
			this.m.Flags.set("MerchantID", best.getFactionOfType(this.Const.FactionType.Settlement).getRandomCharacter().getID());
		}

		this.m.Payment.Pool = 800 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"杀死在%origin%附近肆虐的绿皮"
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

				if (r <= 5 && this.World.Assets.getBusinessReputation() >= 2250)
				{
					if (this.Flags.get("IsOrcs") == true)
					{
						this.Flags.set("IsWarlord", true);
					}
					else
					{
						this.Flags.set("IsShaman", true);
					}
				}
				else if (r <= 10 && this.Contract.m.Objective != null)
				{
					this.Flags.set("IsMerchant", true);
				}

				local originTile = this.Contract.m.Origin.getTile();
				local tile = this.Contract.getTileToSpawnLocation(originTile, 5, 10);
				local party;

				if (this.Flags.get("IsOrcs"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(tile, "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群凶残的兽人，绿皮肤，高耸于任何人之上。");
					party.getLoot().ArmorParts = this.Math.rand(0, 25);
					party.getLoot().Ammo = this.Math.rand(0, 10);
					party.addToInventory("supplies/strange_meat_item");
					local enemyBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(this.Contract.getOrigin().getTile());
					party.getSprite("banner").setBrush(enemyBase.getBanner());
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(tile, "Goblin Raiders", false, this.Const.World.Spawn.GoblinRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群淘气的哥布林，小而狡猾，不可低估。");
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 30);
					local r = this.Math.rand(1, 4);

					if (r == 1)
					{
						party.addToInventory("supplies/strange_meat_item");
					}
					else if (r == 2)
					{
						party.addToInventory("supplies/roots_and_berries_item");
					}
					else if (r == 3)
					{
						party.addToInventory("supplies/pickled_mushrooms_item");
					}

					local enemyBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(this.Contract.getOrigin().getTile());
					party.getSprite("banner").setBrush(enemyBase.getBanner());
				}

				this.Contract.m.UnitsSpawned.push(party.getID());
				this.Contract.m.Target = this.WeakTableRef(party);
				party.setAttackableByAI(false);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Origin);
				roam.setMinRange(3);
				roam.setMaxRange(8);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}

				this.Contract.m.Origin.getSprite("selection").Visible = true;
			}

			function update()
			{
				local playerTile = this.World.State.getPlayer().getTile();

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsMerchant") && this.Contract.m.Objective != null && !this.Contract.m.Objective.isNull())
					{
						this.Contract.setScreen("Merchant");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsOrcs"))
					{
						this.Contract.setScreen("BattleWonOrcs");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
					else
					{
						this.Contract.setScreen("BattleWonGoblins");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
				}
				else if (playerTile.getDistanceTo(this.Contract.m.Target.getTile()) <= 10 && this.Contract.m.Target.isHiddenToPlayer() && this.Time.getVirtualTimeF() - this.Contract.m.LastRandomEventShown >= 30.0 && this.Math.rand(1, 1000) <= 1)
				{
					this.Contract.m.LastRandomEventShown = this.Time.getVirtualTimeF();

					if (!this.Flags.get("IsBurnedFarmsteadShown") && playerTile.Type == this.Const.World.TerrainType.Plains || playerTile.Type == this.Const.World.TerrainType.Hills || playerTile.Type == this.Const.World.TerrainType.Tundra || playerTile.Type == this.Const.World.TerrainType.Steppe)
					{
						this.Flags.set("IsBurnedFarmsteadShown", true);
						this.Contract.setScreen("BurnedFarmstead");
						this.World.Contracts.showActiveContract();
					}
					else if (!this.Flags.get("IsCaravanShown") && playerTile.HasRoad)
					{
						this.Flags.set("IsCaravanShown", true);
						this.Contract.setScreen("DestroyedCaravan");
						this.World.Contracts.showActiveContract();
					}
					else if (!this.Flags.get("IsDeadBodiesOrcsShown") && this.Flags.get("IsOrcs") == true)
					{
						this.Flags.set("IsDeadBodiesOrcsShown", true);
						this.Contract.setScreen("DeadBodiesOrcs");
						this.World.Contracts.showActiveContract();
					}
					else if (!this.Flags.get("IsDeadBodiesGoblinsShown") && this.Flags.get("IsOrcs") == false)
					{
						this.Flags.set("IsDeadBodiesGoblinsShown", true);
						this.Contract.setScreen("DeadBodiesGoblins");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsWarlord") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Const.World.Common.addTroop(this.Contract.m.Target, {
						Type = this.Const.World.Spawn.Troops.OrcWarlord
					}, false);
					this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
					this.Contract.setScreen("Warlord");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsShaman") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Const.World.Common.addTroop(this.Contract.m.Target, {
						Type = this.Const.World.Spawn.Troops.GoblinShaman
					}, false);
					this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
					this.Contract.setScreen("Shaman");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Running_Merchant",
			function start()
			{
				this.Contract.m.Origin.getSprite("selection").Visible = false;

				if (this.Contract.m.Objective != null && !this.Contract.m.Objective.isNull())
				{
					this.Contract.m.Objective.getSprite("selection").Visible = true;
				}

				this.Contract.m.BulletpointsObjectives = [
					"将商人安全地送回%objectivedirection%的%objective%。"
				];
				this.Contract.m.BulletpointsPayment = [];
				this.Contract.m.BulletpointsPayment.push("一旦你到达，得到%reward_merchant%克朗。");
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Objective))
				{
					this.Contract.setScreen("Success2");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function end()
			{
				if (this.Contract.m.Objective != null && !this.Contract.m.Objective.isNull())
				{
					this.Contract.m.Objective.getSprite("selection").Visible = false;
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
				this.Contract.m.BulletpointsPayment = [];

				if (this.Contract.m.Payment.Advance != 0)
				{
					this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getInAdvance() + "克朗预付款。");
				}

				if (this.Contract.m.Payment.Completion != 0)
				{
					this.Contract.m.BulletpointsPayment.push("得到" + this.Contract.m.Payment.getOnCompletion() + "克朗当合同完成时。");
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Origin.getSprite("selection").Visible = false;
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% 颓然的身姿与间歇的呻吟表露着他的近况。 在用着颤抖的声音向你问候前，他揉按着自己的太阳穴。 %SPEECH_ON%一个绿皮部落正抢掠并惊吓着 %origin% 周遭的地区。他们谁也不放过。 {我的人太过害怕以至于无能为力。 | 我手下的许多人失去了对土地的忠诚。 | 我的人不打算去解决它，除非能得到非分的酬劳。} 你是人们阻止这些畜牲的最后希望。 如果他们继续为所欲为，我们可以能再也没有机会重建！%SPEECH_OFF%在继续之前，他缓慢地闭上了眼睛，叹了口气。%SPEECH_ON%他们是绿皮。他们去的任何地方都留下了痕迹。 应该不难找到，对吧？ 杀光它们，为人们复仇在 %origin%！%SPEECH_OFF% | %employer% 盯着窗外，然后问了一个简单的问题。%SPEECH_ON%你知道一个绿皮会对一个婴儿做些什么吗？%SPEECH_OFF%你转过头。 一个守卫在角落耸肩。 你回答了问题。%SPEECH_ON%Yes.%SPEECH_OFF%那个贵族点了点头，回到了他的办公桌前，开始了叙述。%SPEECH_ON%有一个绿皮部落在 %origin% 散播着恐惧。我需要你找到并杀光它们。 我做不到…他们也不行…好吧，消灭它们行吗？%SPEECH_OFF% | %employer% 将一只蜡烛置于书旁，眼神变得黯淡，注视着一下你无法阅读的文字。%SPEECH_ON%他们说绿皮在这片土地上有着漫长的历史。 你相信吗？%SPEECH_OFF%你耸耸肩，尽量给出了回答。%SPEECH_ON%如果你想在个世界上停留片刻，你就得战斗，而绿皮似乎已经存在了很久。%SPEECH_OFF%那人点头，似乎很满意你的观察。%SPEECH_ON%这里有许多绿皮在 %origin% 附近劫掠。他们正在烧掉他们遇到的一切，杀死所有人…我敢肯定，这很明显。 更加显而易见的是，我需要你，佣兵，找到它们消灭它们。你有兴趣吗？%SPEECH_OFF% | %employer% 在椅子上对自己笑着－他的头埋在了手里，就像某种小丑似的笑容。 这不是一个男人最好的样子。 他疲倦的看着你。%SPEECH_ON%绿皮再度泛滥起来。 我不知道它们在哪，只知道它们曾经去过的地方。 你知道那些痕迹对吧？%SPEECH_OFF%你点头并回答。%SPEECH_ON%它们留下了巨大的痕迹，我指的并不是它们的脚。%SPEECH_OFF%这个男人再次笑了，是痛苦的伤痕。%SPEECH_ON%好吧，显然我需要你为此做些什么。你愿意吗？%SPEECH_OFF% | %employer% 起身站在窗前，停下，摇了摇头，然后回到了自己的桌前。 缓慢慎重的坐下。%SPEECH_ON%起初我得到消息是强盗。 然后我听说是来自海岸的掠夺者。 接着越来越多的幸存者给出了消息。 现在你知道困扰我的难题是什么了吧？%SPEECH_OFF%You shrug.%SPEECH_ON%这重要吗？%SPEECH_OFF%The man raises an eyebrow.%SPEECH_ON%绿皮，佣兵。这就是它们的身份。 它们正在 %origin% 周围劫掠，我需要你去阻止它们。 现在这要紧吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{如果报酬合适，我们可以猎杀他们。 | 和绿皮作战可不便宜。 | 我们来谈谈克朗。}",
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
			ID = "DestroyedCaravan",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{一个商队。显然，没有什么还是完好的。 货车已经倾倒，驾车的人已经被杀害了。 你追寻着秃鹫的踪迹一路收集着证据。 如果屠杀并不一定是绿皮所为，那么巨大的脚印则证实了和他们相关。 你找到了正确的方向。 | 好吧，绿皮经过的道路并不难跟踪。 你偶然发现了一行燃烧的商队货车。 篝火是新鲜的，依旧在载重货车的木头上燃烧着。 商队人员与商人的尸体同样新鲜的，看起来他们在惊恐中死去。 继续前进，你可能还能抓住那些绿皮畜牲。 | 一个人从一棵孤独的树的四肢上垂下来，好像他从天空掉下来然后在那儿串了针。 树干前有两只死驴。 一辆货车已经完全被摧毁，车轮四散而落并且碎裂。 货物和货品散落在各处。 一处旧的营火舔炽着周围，寻找着可以燃烧的东西，越来越微弱。\n\n 这些是绿皮的杰作，你并不怀疑。 距离你找到他们不会太久了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们必须接近。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BurnedFarmstead",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{几缕青烟扭曲着从农庄废墟中升起。 一具尸体成陈列在门前。 其中的一半已经不见了。 剩下的那一半带有惊恐的表情，一根烧焦的手臂伸向某个不再存在的东西或者人物。 一些脚印散布在泥土和草丛中。 绿皮。你越来越接近了。 | 小农庄并没能存活下来。 你找到了被屠杀在四处的农夫，手中依然紧紧攥着草叉。 其中的一具草叉带着血液。那绝对并非人类所有。 你跟随着踪迹，明白即将找到这场犯罪的凶手。 | 一条死去的狗。另一个。 牧羊犬，你猜想，尽管一场暴行使得它们难以辨认。 他们的管理者似乎并不远－这表明他们在放出狗狗后逃走。 不幸的是，脚印告诉你这几个农夫还是遭遇了绿皮。 狗们打得很好，他们的主人打得很好。\n\n你接近了，继续前进，你将会遇到那些混蛋。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们必须接近。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DeadBodiesOrcs",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{兽人的作品并不难以辨认：它看起来是否精密而准确？ 如果是的，那么并非兽人。 你正在查看的是一连串的尸体和身体部位，身体所有者和缺失的人全都混合在一起。 需要花费一个星期才能将他们重新拼凑起来。 如果你继续前进，那么必定会遇到兽人。 | 你发现了一个被切成两半的人。另一个则是四分五裂。 还有一个脑袋已经不见了，被砸进了胸口。 还有一个严重的擦伤，当你查看的时候，每一根骨头都在咯吱作响并且晃动着，完全断裂了。 这是兽人的作品。 你确实找到了他们的踪迹。 | 一具尸体向后弯曲，头部碰到了脚后跟。 你在胸口发现了一个大洞，另一具尸体似乎被某些粗糙的锯齿状工具砍碎。 没有任何干净的地。 是的毫无疑问，这是兽人的作品。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "看起来我们即将狩猎兽人。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DeadBodiesGoblins",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你偶然发现一名男子倚着路标。 当你问他是否见过绿皮时，他前倾斜并跌落在地。 他的背部有一只飞镖。 我想这就是你问题的答案。 这也意味着你即将面对哥布林，而不是兽人。 | 兽人不会留下像这样混乱的局面。 你发现了一系列农民和他们的狗被杀。 但是这有点的混乱。 刺伤在这里，小刺伤在那里。 到处都是几支飞镖。 并提示着有毒。 这是…哥布林的作品。 他们一定不远。 | 一个人躺在草地上，一只飞镖扎在脖子上。 他的脸发紫，舌头抽出。 他的手紧紧地握着，好像他们在抓紧自己一样。 毫无疑问，这是一种令人讨厌，麻痹的毒药。 无疑，这不是兽人的作品，而是哥布林作品。 他们一定就在附近了…}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "看起来我们即将狩猎哥布林。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BattleWonOrcs",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_81.png[/img]{在你的人解决最后一个兽人之后，你环顾四周。 绿皮带来了地狱般惨烈的战斗。 是时候检查下队伍的伤亡，回去找雇主，%employer%。 | %employer%的人永远不会做你刚刚做的事。 只有 %companyname% 才能处理得了这些绿皮。 你为战队感到骄傲，但尽量不要表现出来。 | 战斗已经结束了，两个人的赌局也一样。 事实证明，在你从兽人的脖子上割下脑袋后，兽人也无法继续咬牙切齿了！ 你的雇主，%employer%，可能并不在乎这些野蛮的经验，但是他会为你今天的完成的工作支付酬劳。 | The orcs put up a fight that the holy men might have even dared to call righteous. 但是它们并没能比 %companyname% 更强，至少不是在今天！ | 你的雇主，%employer%，希望你杀死这些绿皮，而你确切完成了。 现在是时候检查下人员然后返回领取你来之不易的报酬了。 | 与兽人的战斗永远不是一项容易的任务，这一次也一样。%employer%的报酬可能使 %companyname% 更能咽下现在的艰难处境。 | 你的雇主，%employer%，最好他妈的为你与这些畜牲的战斗给两个子－想让它们倒下可并不容易！ 检查人员，准备回到雇主那去。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回 %townname%！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BattleWonGoblins",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_83.png[/img]{对于这样的卑鄙小人们来说，哥布林们确实懂得如何战斗！ 你的雇主，%employer%，应该会对你今天完成的任务感到满意。 | 你曾听过人们嘲笑哥布林的体格大小。 好吧，他们可能小，但他们全力以赴。\n\n统计下你的人员准备回到你的雇主，%employer% 那去，为了你的发薪日。 | 哥布林们像饥饿的狗杂种一样战斗。 饥饿，狡诈 ，杀人的杂种。 不幸的是它们的精明没能应用得更好。 恩，%employer% 会为这边的消息感到满意的。 | 你并不清楚这是否是一件好事，你的雇主，%employer%，并不能完全确定这里是否有哥布林。 如果他知道后，会减少我们的佣金吗？ 当然看着这些哥布林时，它们无疑已经失败了，但是该死的，它们清楚的明白该如何战斗。\n\n 无论如何，是时候统计人数，准备返回雇主那去交差了。 | 哥布林们死了。真是令人憎恶。 你的雇主，%employer%，应该会为你今天在此所作的事感到满意。 | 一堆死去的哥布林的仍然无法与一个兽人狂战士压倒性的高度相提并论。 但是，它们表现得很出色！ 遗憾的是，他们的努力在如此渺小的身躯上被白白浪费。 再说一次，如果他们的机智和狡猾装在了兽人的身上…旧神啊，这真是一个令人胆寒的想法！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回 %townname%！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Warlord",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_49.png[/img]{当你接近兽人战团的时候，你看到一个残忍的兽人军阀清晰的轮廓。 它的出现使得情况变得比原本想象中更加困难。 | 兽人中间有着一个巨大的督军。 这改变不了什么。好吧，也许改变了一点点，但是最终的目标仍然不变：将它们屠戮殆尽。 | 多么不幸的消息！一群兽人中被发现出现了一位兽人督军。 对于这位督军来说，这真是不幸。 你非常确信对于它来说，一定是费了九牛二虎之力才来到这里。 遗憾的是 %companyname% 将会毁灭它前面的努力。 | 兽人中有一位督军！ 他的体型与咆哮，不会有错了－你听见了它，就像一只熊正对着你的脸咧嘴狞笑！ 无所谓了，这只绿皮也会像其他人一样倒下。 | 一位督军。一位战争领主。一位可怖的兽人。 你感受到了。 一位如此巨大的绿皮出现在绿皮营地。 他们中的一位领袖。 他们中最强的战士。 这又有什么关系？ 这一点也不重要。 当然不！一点也不。 一切都会按照计划中的那样进行。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Shaman",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_48.png[/img]{当你接近的时候，你发现一缕陌生的烟雾升上天空。 它并不是黑色或者灰色，是紫色的，看起来像活物一般在绿色的卷曲中循环滑动。 哥布林群中有一位萨满！ | 一位萨满！你意识到这些狡诈的哥布林其中一个有着骨制首饰，斜眼，在他们笨拙的面孔中带着一丝寻常哥布林不会拥有的智慧。 这些是危险的绿皮，必须要小心！ | 唔，注意你的脚步。 哥布林队伍中出现了一位萨满！ 这是最危险的敌方战斗人员！ 不要轻视他矮小的体型或者重量… | 你曾经听说一些萨满可以从一个人的耳朵中抽取梦境。 你并不确信这是否是真的，但是你知道他们是狡诈的战士，而你即将面对他！ | 一个哥布林萨满…你无论在哪都知道这骨质外衣还有伪装斗篷！ 保持冷静，继续前进-将所有的绿皮屠戮殆尽，仅此而已！ | 萨满。一位哥布林萨满… 你曾听过关它们的恐怖魔法的故事，但并不是此时此刻。 让士兵们准备进攻！ | 一个哥布林萨满。你曾听过那些卑鄙的把戏能迷惑一个人的心智。 你现在疑惑 %employer%，你的雇主，是否被欺骗了以至于将你陷入此处。\n\n…不。不是吧？ | 一个哥布林萨满！你曾听过关于这些生物的邪恶故事。 其中一个是他们把黄蜂放入囚犯的耳朵！ 一个男人在喝了一些酒后信誓旦旦的告诉你，他曾亲眼看到蜜蜂把一个人的脑袋变成蜂窝！ 以他亲爱的舌头作为赌注！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Merchant",
			Title = "战斗之后…",
			Text = "{战斗结束后，你从一堆废墟中发现了一个令人惊讶的俘虏：一位商人。 身着沾血的绸衣，他对你感激不尽。 他向你询问是否能够将他带到 %objective%。很明显，他在道路上并不安全。 你耸耸肩，并开始考虑。 这个男人迅速的继续说了起来，将会给予了 %reward_merchant% 克朗的报酬，如果你愿意帮助他。 这比你心动的价格还要多一些… | 一个男人从一堆死去的绿皮中冒出来。 他并不是你雇佣兵中的一员，实际上是一个商人，双手被反绑在背后。 你询问他什么时候加入了这样一只“队伍”的时候，他耸耸肩，说他很少听说绿皮会留下俘虏。 他真的是十分幸运。\n\n 这个男人环顾四周，回过头来。%SPEECH_ON%我必须感谢你，佣兵，但如果情况不够明显的话，我必须声明在路上旅行已经难以让我感到安全了。 如果你把我完好无损的送到 %objective%，我将会很乐意，呃，付出 %reward_merchant% 克朗。 这对你来说听起来还行吧？%SPEECH_OFF% | 战斗结束之后，你注意到一位商人丑陋的坐在他死去的马旁。 一些难以控制的暴力终结了这个生物，现在商人遭遇了不幸。 他看了战场，然后看着你。 双臂交叉于鞍，他大声询问。%SPEECH_ON%战士先生，你能护送我到 %objective% 吗？如你所见，我的出行已经无法继续进行下去了，在场战斗中失败了…不是你的错！ 不，先生！但是，我真的必须去那个城镇。%SPEECH_OFF%他在你身旁停顿并悬挂了一个小钱包。%SPEECH_ON%我为你准备了 %reward_merchant% 克朗。 这听起来如何？%SPEECH_OFF% | 当你调查战场时，一个男人走到你身边，询问这里发生了什么。 擦拭刀片上的血，你告诉他好好看一下。 他咪起眼睛，不管出于什么原因，他向前踮起脚尖。%SPEECH_ON%啊，绿皮。一场可耻事件。好吧….%SPEECH_OFF%他跌倒了。%SPEECH_ON%Wait a old gods-damned minute. 绿皮？ 它们在这做了些什么？ 上天保佑，我不可能在此获得安全！战士！ 我将会支付你 %reward_merchant% 克朗，如果你能护送我到 %objective%，我发誓，它离这并不远，我无法独自一人前进。%SPEECH_OFF%他用拇指划过脖子，指着死了的绿皮。%SPEECH_ON%我不认为有人能付得起这样的代价，明白吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好，我们带你去 %objective%。",
					function getResult()
					{
						this.Contract.setState("Running_Merchant");
						return 0;
					}

				},
				{
					Text = "别挡我们的路。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Flags.get("IsOrcs"))
				{
					this.Text = "[img]gfx/ui/events/event_81.png[/img]" + this.Text;
				}
				else
				{
					this.Text = "[img]gfx/ui/events/event_22.png[/img]" + this.Text;
				}

				local merchant = this.Tactical.getEntityByID(this.Flags.get("MerchantID"));
				this.Characters.push(merchant.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到 %employer% 并将绿皮的脑袋掷于他的桌面。 他迅速的从那躲开了。.%SPEECH_ON%劳驾？%SPEECH_OFF%他对着那个点着头，你解释道那个肮脏的东西已经死了。 他从口袋中掏出一条手帕，开始擦拭血液。%SPEECH_ON%是的，我看得见。 这鬼东西本应该待在这，而不是让我起身躲开！ 靠的，佣兵…你的佣金在那个角落！ 然后离开的时候记得把我的仆人叫过来。 这必须有人清理下！%SPEECH_OFF% | %employer% 正在给一位女性讲着故事，当你进来时。 她对着你笑了几声并目不转睛的盯着你。 他看到了这些，并迅速的打发她出去，以免她被真正的男子气概迷晕。%SPEECH_ON%佣兵！你有什么消息吗？%SPEECH_OFF%你从麻袋中拿出了一个绿皮脑袋。%employer% 注释着它，撅起嘴唇，微笑，皱起眉头，似乎不清楚该拿他正注视的东西怎么办。%SPEECH_ON%好吧…好吧。你的报酬在这，如同约定的。%SPEECH_OFF%他从桌上拉开了一个木制箱子。%SPEECH_ON%当你出去的时候，把女孩带进来。%SPEECH_OFF% | 你将一个绿皮脑袋放在了 %employer%的办公桌上。 他打开卷轴，将绿皮的图纸与真实的样子进行了比较。%SPEECH_ON%哼，我会告诉学者们他们出现了一点…误差。%SPEECH_OFF%你询问是什么。%SPEECH_ON%他们把它画成灰色。 而这一个明显更加绿。%SPEECH_OFF%你高声质疑学者们画的是否就是绿色。 这个男人闭上了嘴巴并点了点头。%SPEECH_ON%哏。有趣的想法。好吧，门外的警卫会给你报酬。 让我看这个…标本。%SPEECH_OFF% | 当你进来的时候一位长袍男子站立在 %employer% 身旁。 他的脸埋入卷轴中，甚至你进来了也没有看一眼。 耸肩，你将一个绿皮脑袋从袋子中取出置于雇主的桌上。 这引起了陌生人的注意，他拿起了那个头颅！ 他抢走了它并立刻跑出了房间，甚至伴随着轻浮的嚎叫。 你询问到底发生了什么事。%employer% 笑了。%SPEECH_ON%那个学者一直期待着你的归来。 他们一直渴望学习一些新的东西。%SPEECH_OFF%这个男人拿出了一个袋子打开并数了数。 你询问道那个学者是否也会付钱给你。%employer% 耸肩。%SPEECH_ON%如果你能抓住他。 我的意思是并不是肉体意义上的－他们现在如此痴迷于自己的思索中，看起来我们在他的世界中就像不存在一样。%SPEECH_OFF% | %employer% 一只手抓着一只鸟，而另一只手上拿着一块石头。 你问他正在做什么。%SPEECH_ON%我想弄清楚哪个更值钱。手中的一只鸟，或者…或者一块石头…等一下…%SPEECH_OFF%你没有时间这样，并将一个绿皮脑袋放在他的桌面上，问道这个值多少。 那个男人放下了鸟，并将石头放在书架上。 他回身从手上拿出了你的报酬。%SPEECH_ON%我出这边的这个…出于好奇，我的问题已经被解决了。你的报酬，正如承诺的那样。%SPEECH_OFF%你在想这个人等下要如何抓住那只鸟，但最后决定不是为此费心了。 | %employer% 正在咳嗽当你回来的时候。 他瞥了你一眼，用手捂住了嘴唇。%SPEECH_ON%所以你肯定给我带来了好消息？%SPEECH_OFF%你耸耸肩，然后把绿皮的脑袋放在了桌子上，解释到它们已经全部被处理了。%employer% 瞥了一眼。%SPEECH_ON%所以一定是其他的什导致了我的疾病…但是是什么？ {女人？很可能是女人。 老实说，总是女人。 | 狗。人们说这些糟糕的杂种是不幸的预兆。 | 黑猫！是的，当然！ 我要把他们杀光！ | 小孩子。他们最近一直十分吵闹。 他们的笑声中到底在谋划着些什么？ | 也许是我吃了没煮熟的肉…又或者…我十分确定是那个住在山上的蠢女人。 | 我确实吃了无意间和老鼠分享的面包 不是那样，就是女人。 你知道那些东西是怎么回事，总是在传染和腐蚀我们，那些该死的女人！}%SPEECH_OFF%这个男人停了下来，然后摇了摇头。%SPEECH_ON%好吧，无论如何，你的报酬就在外面的守卫那。 是我们先前商定的价格，你可以去数数。 只有神灵才知道，我到底疏忽了些什么！%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "照顾劫掠的绿皮");
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
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Origin, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_20.png[/img]{在安全的到达 %objective% 后，商人转过身并对你表示感谢。 他手中拿出着一袋克朗，就像先前约定的一样，然后迅速的走向了城镇。 | %objective% 已经近在眼前，商人也看见了－你护送的这个男人嚎哭着，欣喜于赚钱或者是幸存了下来，无论什么它都是的这个男人能继续行商。 他跑入一家小酒馆，然后迅速的返回，手中带着一袋克朗。%SPEECH_ON%如同约定的，佣兵。 我欠你的远远不止于此。%SPEECH_OFF%你故意问他为此打算付多少钱。他笑了。%SPEECH_ON%我不敢为我的脑袋开价，因为我保证有人愿意为此付款！%SPEECH_OFF%你点了点头，表示理解并相当满意于目前的报酬。 | 在接近了 %objective% 之后，商人给予了你先前商定的报酬。 然后他迅速的跑开，继续前往去赚更多的钱，睡更多的女人。 | 你安全的把商人带到了 %objective%。他对你表示感谢，然后他迅速的走向附近的酒馆。 当他回来的时候，他手中拉着一袋克朗，就像是用袜子着一堆柚子。 他将它递给你。%SPEECH_ON%你的报酬，雇佣兵。你得到了我的感激。当然还有我的克朗。现在，失陪了…%SPEECH_OFF%他伸直衬衫和裤子，抬起下巴。%SPEECH_ON%…因为我要继续去赚钱了。%SPEECH_OFF%他转身并前进，步伐中透漏着一股守财奴的热情。}",
			Image = "",
			List = [],
			Characters = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "轻松的克朗。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Flags.get("MerchantReward"));
						return 0;
					}

				}
			],
			function start()
			{
				local merchant = this.Tactical.getEntityByID(this.Flags.get("MerchantID"));
				this.Characters.push(merchant.getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("MerchantReward") + "[/color] 克朗"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Objective != null ? this.m.Objective.getName() : ""
		]);
		_vars.push([
			"objectivedirection",
			this.m.Objective == null || this.m.Objective.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Objective.getTile())]
		]);
		_vars.push([
			"reward_merchant",
			this.m.Flags.get("MerchantReward")
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
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			if (this.m.Objective != null && !this.m.Objective.isNull())
			{
				this.m.Objective.getSprite("selection").Visible = false;
			}

			this.m.Origin.getSprite("selection").Visible = false;
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
		if (this.m.Origin.getOwner().getID() != this.m.Faction)
		{
			return false;
		}

		return true;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Objective != null && !this.m.Objective.isNull() && _tile.ID == this.m.Objective.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull() && this.m.Target.isAlive())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Objective != null && !this.m.Objective.isNull() && this.m.Objective.isAlive())
		{
			_out.writeU32(this.m.Objective.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		local objective = _in.readU32();

		if (objective != 0)
		{
			this.m.Objective = this.WeakTableRef(this.World.getEntityByID(objective));
		}

		this.contract.onDeserialize(_in);
	}

});

