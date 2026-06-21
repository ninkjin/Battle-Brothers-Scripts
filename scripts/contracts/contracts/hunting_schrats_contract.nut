this.hunting_schrats_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_schrats";
		this.m.Name = "闹鬼的森林";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕城镇附近树林中杀人的东西于" + this.Contract.m.Home.getName()
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

				if (r <= 20)
				{
					this.Flags.set("IsDirewolves", true);
				}
				else if (r <= 25)
				{
					this.Flags.set("IsGlade", true);
				}
				else if (r <= 30)
				{
					this.Flags.set("IsWoodcutter", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				local disallowedTerrain = [];

				for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
				{
					if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local mapSize = this.World.getMapSize();
				local x = this.Math.max(3, playerTile.SquareCoords.X - 11);
				local x_max = this.Math.min(mapSize.X - 3, playerTile.SquareCoords.X + 11);
				local y = this.Math.max(3, playerTile.SquareCoords.Y - 11);
				local y_max = this.Math.min(mapSize.Y - 3, playerTile.SquareCoords.Y + 11);
				local numWoods = 0;

				while (x <= x_max)
				{
					while (y <= y_max)
					{
						local tile = this.World.getTileSquare(x, y);

						if (tile.Type == this.Const.World.TerrainType.Forest || tile.Type == this.Const.World.TerrainType.LeaveForest || tile.Type == this.Const.World.TerrainType.AutumnForest)
						{
							numWoods = ++numWoods;
						}

						y = ++y;
					}

					x = ++x;
				}

				local tile = this.Contract.getTileToSpawnLocation(playerTile, numWoods >= 12 ? 6 : 3, 11, disallowedTerrain);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Schrats", false, this.Const.World.Spawn.Schrats, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一种树皮和木头组成的生物，蹒跚混迹于林木之间，它的根穿透着土壤。");
				party.setFootprintType(this.Const.World.FootprintsType.Schrats);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);

				for( local i = 0; i < 2; i = ++i )
				{
					local nearTile = this.Contract.getTileToSpawnLocation(playerTile, 4, 7, disallowedTerrain);

					if (nearTile != null)
					{
						this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Schrats, 0.75);
					}
				}

				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(5);
				roam.setMaxRange(10);
				roam.setNoTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Forest, true);
				roam.setTerrain(this.Const.World.TerrainType.SnowyForest, true);
				roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);
				c.addOrder(roam);
				this.Contract.m.Home.setLastSpawnTimeToNow();
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
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					this.Contract.setScreen("Victory");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					local tileType = this.World.State.getPlayer().getTile().Type;

					if (tileType == this.Const.World.TerrainType.Forest || tileType == this.Const.World.TerrainType.LeaveForest || tileType == this.Const.World.TerrainType.AutumnForest)
					{
						this.Flags.set("IsBanterShown", true);
						this.Contract.setScreen("Banter");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);

					if (this.Flags.get("IsDirewolves"))
					{
						this.Contract.setScreen("Direwolves");
					}
					else
					{
						this.Contract.setScreen("Encounter");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
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
			Text = "[img]gfx/ui/events/event_62.png[/img]{你看到一个镇的告示板铺满了用锈得不行的钉子钉起的便宜碎布甚至叶子组成的告示。%employer% 偷偷摸到你身边。%SPEECH_ON%我们一直在等着你们这类人，佣兵。 人们不停的在森林里失踪而我没有足够的资源去把他们找回来。 我听说树动起来杀了砍它们树杆的伐木工，但天知道是不是真的。 我需要你的战队进到森林里看看是什么导致的这场混乱。有兴趣吗？%SPEECH_OFF% | %employer% 在指间翻着一片树皮，像赌徒玩硬币一样。 他叹了口气把它丢过桌子。%SPEECH_ON%我最近接到各种关于伐木工和小贩在森林里失踪的故事。 有人说是树活了过来向人复仇，但在我听来像是胡言乱语。 不论如何，我准备好了一些硬币来帮助“解决”这个问题而且我愿意花掉它。 怎么说，佣兵，有兴趣看看是什么怪物在骚扰这镇子吗？%SPEECH_OFF% | 一堆锯木末摆在 %employer%的工作桌上而他的眼睛死死的盯着这小墩木屑。 他挥手唤你进去，视线没有一丝转移，并维持着说道。%SPEECH_ON%这里的伐木工报告说人们正在森林里接连失踪。 他们说是树在搞鬼，什么由木头和根茎组成的怪物。 我有部分相信他们在隐瞒一宗谋杀且不愿意承认罪行，但是或许这吓人故事是真的。 不论如何，我手上有硬币想要看到结果，而你正是接这种活的，对吧？%SPEECH_OFF% | 进入 %employer%的房间，你的靴子踩到了一块劈下来的木头。 它翻滚着用平的一面落在了地上，圆树干和树皮正在上方面向着你。 这位镇长拍了拍手。%SPEECH_ON%所以它没动！ 啊，你肯定在寻思我在说什么。这儿。%SPEECH_OFF%他丢给你一张画，画着看起来是个带着手臂的树。他继续道。%SPEECH_ON%我听说树正在活过来。 连一个备受我信任的伐木工朋友也说，非常严肃地说，某种树内的灵体野兽占据了木头和根茎并用它们作为武器。 不论外面的是什么，我需要一群杀手去找它。 你和你的战队能胜任吗？%SPEECH_OFF% | %employer% 正坐在一根树干上被农民们围着。 几分钟后他张开手。%SPEECH_ON%看到了吗！没什么不正常的！ 这就是棵树！一棵树，明白吗？%SPEECH_OFF%农民们并没有被说服并开始说森林里的怪物形状就像真树一样。 叹了口气，%employer% 向你甩甩手。%SPEECH_ON%好吧，我们招点雇佣兵？ 这合各位心意吗？ 你怎么说，佣兵。 我们有硬币付你而且有会杀人的树给你去狩猎。听起来不错？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{当然感兴趣。 | 我们来谈谈酬劳。 | 我们来谈谈克朗。 | 这需要你花费一些。 | 去森林里捉迷藏？算我一个。 | %companyname% 可以提供帮助，只要价格合适。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我不会带着伙计们去森林里乱逛。 | 我不这么认为。 | 我拒绝，伙计们更喜欢已知的血肉之敌。}",
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
			ID = "Banter",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_25.png[/img]{战队越来越紧张，一个战队在森林里找会杀人的树时这样也是情有可原。 每次树枝的蹦脆声都让伙计们拔剑相向，其中一个人在一片落叶掉到衣服领里的时候直接尖叫了起来。 你的敌人什么都没做就已经接近胜利了！ | 这片森林使伙计们不安。 你告诉他们鼓起勇气，因为敌人不论怎样都在那里，很显然害怕不会有任何帮助。 你们，%companyname%，才该是被畏惧的，这些该死的杀人树在你们完事的时候会希望你们只是群普通伐木工！ | %randombrother% 把武器抬到肩上摇摇晃晃地走着，双臂夸张的摆着。 他在打量着森林里的树叶。%SPEECH_ON%嗨队长，你说我们把这里的一棵树砸了，今天到这吧！ 给他们看一堆木头根啥的，没人分辨的出来。 如果他们有问题就跟他们说这帮树皮家伙还挺能咬的！%SPEECH_OFF%伙计们笑了起来，你告诉这个佣兵你会考虑的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "注意脚下。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_107.png[/img]{当站着巡视四周土地时，%randombrother% 喊道远方有什么东西在动。 你走到他身边，他指了指一片树叶并拔出了剑。 一颗苍天大树正向你冲过来，像老人在熟悉的图书馆书柜间蹒跚的左右摇晃。 你拔出自己的剑并命令伙计们组成阵型。 | %randombrother% 正坐在一颗倒着的树上突然惊叫着跃起去拿武器。 你转过去看到那颗树被抬到半空中，土成块的洒落着，原本扎根的地方只留下一个大湿坑，就好像它在那栽了几万年一样。 它倒向它更健康的同胞就像一个醉汉倒在朋友肩上一样。 缓慢的，它转过身来，一双眼睛从它的树干深处发着绿色的荧光，它尖锐的树枝环绕着它，张开的阴影如同一张网般掠过战队。 你拔出剑命令伙计们组成阵型。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Direwolves",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_118.png[/img]{你在远处发现几双绿色荧光的眼睛。 无疑是树人本体，于是你命令你的人趴下悄悄靠近。\n\n到一个坡顶时你发现一颗树的树干周围围着一圈冰原狼。 它们蹲在它身下如同骑士宣誓效忠一般。 你的到来并非没有被察觉，树人发出远古的低咛倾身向前。 它脚跟的生物咆哮着转过身来，仿佛受到命令一般。 你不确定该怎么理解这种动植物间的所属关系，但是 %companyname% 一样会击溃它们。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Contract.addUnitsToEntity(this.Contract.m.Target, this.Const.World.Spawn.Direwolves, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_121.png[/img]{树人被消灭了，它们树状的遗体现在与一颗普通的树并无大异。 你挖下战利品和证据好带回 %employer%。 | 你看了看一颗倒树，然后看了看倒下的树人。 这两个之间你几乎看不出差别，这让你不禁怀疑起了你这辈子越过的所有那些所谓的死树。 不再深想，你命令队伍拿上战利品作为战斗的证据并准备回去找 %employer%。 | 树人被击倒了，每一个都像场间休息的打手一般倒在树林间。 你走到其中一个根茎下想好好看看，但是现在它看起来跟周围的其他树没有区别。 你命令战队尽可能收集战利品好展示给 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "完成了。",
					function getResult()
					{
						if (this.Flags.get("IsGlade") && this.World.Assets.getStash().hasEmptySlot())
						{
							return "Glade";
						}
						else if (this.Flags.get("IsWoodcutter") && this.World.Assets.getStash().hasEmptySlot())
						{
							return "DeadWoodcutter";
						}
						else
						{
							return 0;
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Glade",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_121.png[/img]{你正要离开战场，%randombrother% 说周围看起来长得挺好的。 你转身看了看周围发现他说的没错：树人选择了一片美丽的树林里筑的窝，应该出于什么好理由。 而既然树人把它作为一个好家，这肯定意味着木材质量非常不错。 你命令人们利用这片高质量的林间空地，在时间和精力允许的情况下尽可能多的砍点树。 收获的木材确实非常优良。\n\n 你离开这临时伐木场时天上下起了雨。}",
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
			],
			function start()
			{
				local item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/trade/quality_wood_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "DeadWoodcutter",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_121.png[/img]{离开时一个亮光吸引了你的注意。 你转身来到一只树人的树干边。 一把斧头深埋在木头里。 苔藓看来很久前便侵蚀了握柄，但是这工具的金属部分毫无问题，一点锈都没有。 刮掉苔藓，下面露出了紧握着的木手指。 顺着手指看过去，手腕在树干处化入了树纹。 你跟着那条纹路继续找到一张木脸，还有一个变形的深洞，像一张褐蜡制成的脸就这么被漫长的时间融化了一般。 头盔的轮廓在脸周围扭曲，下面还有块胸甲板凸起，就像一个猎杀者的蓄水池。\n\n你摇摇头取出了斧子，摆脱同时把木头手指掰下它的握柄。 变形的脸平淡的观察着你的窃行，它的目光从它失去光泽的毁灭一刻保存至今。 你没有逗留在这番景象前并带着斧头回到了战队中。}",
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
			],
			function start()
			{
				local item;
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/woodcutters_axe");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/hand_axe");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/fighting_axe");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/greataxe");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_62.png[/img]{你发现 %employer% 正在用木头雕一个玩具。 他把木屑从桌上吹下并拍手抖掉锯末。 他把玩具立着放下，形似一个吃了太多甜点的骑士，但是它很快就倒了下来。 叹着气，他转身向你求助。 你拖着树人的头进入房间并让它翻前覆后在地板上滚到它落在一个角上为止。这位镇长点点头。%SPEECH_ON%不错，佣兵。%SPEECH_OFF%他拿来了你被承诺的报酬。 | %employer% 被你的归来，还有你带到他门口的树人遗体所震惊。 他俯身打量它，对于其源头愈发难以置信。 像猫把弄飞虫被摘下来的翅膀一样他用脚翻弄着那堆。%SPEECH_ON%我没想过你会把这些带回来，但该死，如果你没干掉这些树杂种的话。 好，我去拿你的报酬。%SPEECH_OFF%他拿来了约定的克朗给你。 | %employer% 在你找到他时正削着一把椅子的扶手。 他抬头看向你，而你展示了树人的遗体。 他起身拿起一片碎片，走到他的椅子坐下仔细观察它，但他的椅子在屁股下崩开并轰的一声拍到地上，如同他一直以来的计划就是要制造这个噪音。%employer% 把他的工具丢到盒子里。%SPEECH_ON%天啊我要，好吧，我最好不要那么野蛮地去威胁他们。 我想那就是让我变成这样的原因。%SPEECH_OFF%你点头，说激怒旧神是不明智的。 你还提道让佣兵无偿工作也是不明智的。 这位镇长跳起身跑去拿来一袋克朗。%SPEECH_ON%当然，佣兵！你不用手把手教我这些事！%SPEECH_OFF% | %employer% 正在一片矮林下。 他手摆在肚皮上看着天空。 他笑起来指向一片云，好像有人应该在他身边去看，但他孤身一人并一言不发。 你丢出一块树人到他脚边并问他有没有带着你的报酬。 他拿出一个袋子，之前不知为何被忽视的。%SPEECH_ON% 几个伐木工目击了你与它们的战斗并已经把故事转告给了我。 我不相信树人是真的。 会杀人的树听起来更像孩子们的疑神疑鬼，但我想还有东西要学。干得好，佣兵。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除镇上的活树");
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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/disappearing_villagers_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setAttackableByAI(true);
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
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
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

