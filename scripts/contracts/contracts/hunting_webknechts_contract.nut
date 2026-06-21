this.hunting_webknechts_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_webknechts";
		this.m.Name = "狩猎织网蛛";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 450 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕城镇附近树林中的织网蛛于 " + this.Contract.m.Home.getName()
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

				if (r <= 10)
				{
					if (this.Contract.getDifficultyMult() >= 0.9)
					{
						this.Flags.set("IsOldArmor", true);
					}
				}
				else if (r <= 20)
				{
					this.Flags.set("IsSurvivor", true);
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
				local x = this.Math.max(3, playerTile.SquareCoords.X - 9);
				local x_max = this.Math.min(mapSize.X - 3, playerTile.SquareCoords.X + 9);
				local y = this.Math.max(3, playerTile.SquareCoords.Y - 9);
				local y_max = this.Math.min(mapSize.Y - 3, playerTile.SquareCoords.Y + 9);
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

				local tile = this.Contract.getTileToSpawnLocation(playerTile, numWoods >= 12 ? 6 : 3, 9, disallowedTerrain);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Webknechts", false, this.Const.World.Spawn.Spiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("一群织网蛛正在蹦蹦跳跳的前行。");
				party.setFootprintType(this.Const.World.FootprintsType.Spiders);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);

				for( local i = 0; i < 2; i = ++i )
				{
					local nearTile = this.Contract.getTileToSpawnLocation(playerTile, 4, 5);

					if (nearTile != null)
					{
						this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Spiders, 0.75);
					}
				}

				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Forest, true);
				roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);
				roam.setMinRange(1);
				roam.setMaxRange(1);
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
					if (this.Flags.get("IsOldArmor") && this.World.Assets.getStash().hasEmptySlot())
					{
						this.Contract.setScreen("OldArmor");
					}
					else if (this.Flags.get("IsSurvivor") && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
					{
						this.Contract.setScreen("Survivor");
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

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
					this.Contract.setScreen("Encounter");
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
			Text = "[img]gfx/ui/events/event_43.png[/img]{%employer% 挥手唤你进入他的房间。你注意到几个拿着草叉的人阴沉的盯着他的窗户外，尽管其中一个显然靠着墙睡着了。 你问这个定居点的镇长他想要什么。 他直接切入话题。%SPEECH_ON%附近的居民报告说有怪物在偷走儿童和狗之类的东西。 我不想放纵多疑和迷信，但是从这些报告中听起来很像是在说蜘蛛。 我的父亲会叫他们织网蛛，如果是真的或许它们在这片地方筑了一个巢而我需要你找到并摧毁它。 有兴趣吗，佣兵？%SPEECH_OFF% | 你看到 %employer% 正用两个叉子拉伸着蜘蛛网。 他把其中一个器皿转了一下把网缠在了一股绳上。 叹了口气，他终于看向你。%SPEECH_ON%我不想把佣兵带到这片地方，但我现在无计可施。 巨大的蜘蛛出现了，偷走牲口，宠物。 一个女士报告说她的婴儿被从摇篮里偷走，它睡的地方只剩下有一片网。 我需要这些可怕的生物被解决掉，它们的巢穴被摧毁。 有足够奖励的话，你会有兴趣吗？%SPEECH_OFF% | 你走到 %employer% 身边而他被你的阴影吓到。 他在椅子上挺起身点点头。%SPEECH_ON%啊，我刚刚没忍住。 没注意到你在这，佣兵，尽管你够吓人了，但这片地方传言有巨大蜘蛛。 我有理由相信这些故事，因为我去了一个农场看到了巨大的网和被吞噬的牲口。 我需要一个能行使绝对暴力的人，这是在说你，而且我需要这样一个人去找到这些怪物的巢穴并解决它们。有兴趣吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{你能拿出多少克朗？ | 我们来谈谈酬劳。 | 我们来谈谈克朗。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。}",
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
			Text = "[img]gfx/ui/events/event_25.png[/img]{你经过了一只死掉的牛，干瘪露骨，皮却没有任何日晒干裂的痕迹。%randombrother% 蹲下来用手指数了数刺口。他点头道。%SPEECH_ON%织网蛛干的，毫无疑问。 我认为它们毒倒了它后在被麻痹的身体上开始的进食。 一具新鲜的尸体意味着它们很近了…%SPEECH_OFF% | 你经过了一具被网包住的尸体倚着一颗孤树。 你切开丝线。 一个儿童的尸体从中滑出倒在地上。 它的脸皮包骨，死白的头上眼球深深的陷在眼窝里。 舌头也同样的干瘪，鼻子几乎不见了。%randombrother% 啐了口水点头说。%SPEECH_ON%没错。我们很近了。或者说，它们很近了。 如果这能安慰你们，这个男孩变成这样前就死了。 织网蛛的咬刺带毒，儿童无法存活多久。%SPEECH_OFF%好，好吧。是时候去找这些怪物了。 | 你路过一个小伙子躲在一辆翻过来的手推车下。 他拒绝出来，他的小脑袋像贝壳里的珍珠一样从里面向外探视。 You ask what he's doing. 他直白的解释道他在躲避蜘蛛而你应该离开。%SPEECH_ON%去找你自己的车。这个是我的。%SPEECH_OFF% 显摆起你的剑，你告诉他你要找的是蜘蛛。 他盯着你。点头说。%SPEECH_ON%那可是个坏主意，先生。 然后，不，我不知道它们去了哪里。 我来时跟着个商队而你看到商队了吗？ 不，你看不到因为他们现在都成蜘蛛沙拉了，所以在它们看到你跟我说话前快滚！%SPEECH_OFF%车啪地闭上。 你没兴趣把它再抬起来，但你在离开时好好的给它来了一脚。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "睁大眼睛。",
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
			Text = "[img]gfx/ui/events/event_110.png[/img]{织网蛛的巢穴就是一个被白丝环绕的土坑。 在它的边缘飘着细丝，它们对最微小的轻风都会做出反应。 随着你让战队向内挺进，网开始呈现一种有文明般的形态，好像你在冬日田园里散步一样，其中被紧紧裹住的猎物显示这地方刚建好不久：鹿，狗，人尺寸的茧毫无生气的挂在网上，如同漏嘴的食物掉在白毯子上一样。 一个黑影从纱幕后悠闲的晃出来，出现在前方，腿弯曲遮着什么，它的头伏在它们后好似这肮脏的生物被它自己的腿挡住了一般。 一只人手如可怕的奶嘴般在它的上颚中吸进吸出。 你来对地方了。 | 织网蛛巢穴很安静，战队到来的响声几乎如同虚构般，金属碰撞的叮当声在经过中显得额外尖锐。\n\n 你遇到个人倒挂在颗树上，他的整个身体被茧包住，只露出一张脸被丝拉扯着。 他请求你切断绑住他眼皮的丝，你照做了。 他的眼皮缓慢闭上，干燥的眼睛上的硬层随之裂开好像几天没有闭过一般。 但它们突然张开，男人在尖叫。 茧在他的腰间鼓起并裂开，喷涌而出的小黑蜘蛛冒了出来。 他的身体剧烈地颠簸着，虫群正在吞噬他，小蜘蛛漫入他的肺而他只能垂死尖叫着将它们咳出。 被吓到，你后退几步只看到一大群大得多的蜘蛛四面八方地从树边涌出。 | 巢穴很显眼，一片无冬的雪地，白色的网一块块地在每一棵树，每一片矮林，每一寸地面上批着。 你让战队径直进入，武器在手，而后你经过了被包起的尸体，它们的中心爆开变黑，以群小蜘蛛在器官上吸食着。\n\n  抬起头，你看到红色的眼睛在附近树上的树枝间闪起，整个蛛形纲植物园活跃了起来，它的看守者停留在树丛间弯着的腿与树枝难以区别，敌人就这么躲在视线中。 当一颗树突然完全展开，每一根树枝都展露成蜘蛛腿，你几乎拉了一裤子，这些木栖敏捷生物正降临到队伍上噼里啪啦地想要咬一口！}",
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
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_123.png[/img]{最后一只织网蛛被解决了，它的腿抱起好像要永恒的抱着杀死它的武器。 你对战队的出色工作点头，然后下令烧毁整个地方。 火快速的窜上丝网，摧毁着丝桥并燃起它们的连接。 整个巢穴被烈火席卷而它深处中的某处你可以听到被点着的小蜘蛛尖声的嚎叫声。 | 你走近最后的几只织网蛛边并审视它可怕的颚。 它仗着一套凶狠的上颌来作为某种牙龈护具，细长的嘴本体逆向排列着锋利的牙齿来撕碎任何试图逃跑的东西。\n\n 你下令烧掉整个巢穴。 随着火焰燃起，小蜘蛛的叫声从它们的窝中传出。 | 你准备回去找 %employer%，但得先把这巢穴完全烧干净。 战队站在火焰前听着小蜘蛛的尖锐叫声并时不时笑着像长腿的小火球一样跑来跑去的小虫子。 | 蜘蛛们被击败了，你下令烧掉这该死的地方并准备回程去找 %employer%。随着火越烧越旺，细小的蜘蛛从中跑出，它们照着火就好像夜晚的萤火虫一样。 几个佣兵开始了场看谁踩的多的即兴游戏，这场游戏以一个特别有野心的小蜘蛛几乎点着了一个佣兵的裤子结束。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "赶紧结束这件事吧，我们还有克朗要拿。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "OldArmor",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_123.png[/img]{消灭了织网蛛后，你命令战团搜索这些生物的巢穴，尽管佣兵们被命令不要独自游荡。你和%randombrother%一起四处转悠。你们一起发现了一棵树，这棵树的网线明显较少。当你们绕过去时，你们发现一名骑士的尸体靠在树干上。他的手放在一把断剑的剑柄上，另一只手完全缺失，只有手腕处的衣袖和腹部的残缺手臂。尸体躺在自己制造的巢穴中，一堆看起来像腐烂大黄杆和腐烂甲壳的灌木丛中，破碎的身体洞穴并散发着毒气。%randombrother% 点头说。%SPEECH_ON%真是太可惜了。无论他是谁，我敢打赌他会成为%companyname%的一名出色战士。%SPEECH_OFF% 的确，这看起来像是一位伟大战士的终结。你想给他安葬，但你没有时间。你让%randombrother%从尸体上取走他能拿到的东西，并准备返回%employer%。}",
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
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					item = this.new("scripts/items/armor/decayed_reinforced_mail_hauberk");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/armor/decayed_coat_of_scales");
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
			ID = "Survivor",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_123.png[/img]{战斗结束了，你见到一个人脚粘着网摆来摆去。 他的身体被蛛丝绑住了一半，还有更多的从他的腰间像被撕碎的裙子般摇摆着。 看来蜘蛛们在 %companyname% 到来时放下了他。 见到你他笑了起来。%SPEECH_ON%嘿，你们是雇佣兵吧？肯定的，我看得出来。你们不会无缘无故地来到这里，除非是为了钱，而且你们打得像被下了赌注的混蛋一样。野蛮至极。%SPEECH_OFF%你问他你能从解救他得到什么。 他抬起头，然后他的整个身体开始摇摆并且有时候让他摆的离你更远了。 他说，或许是向着你或者是他正面向的随便什么方向。%SPEECH_ON%是的，好问题！好吧，你或许在这看不出来，但我自己就是个佣兵，而且你恐怕不知道我的战团和队长全都被那群蜘蛛吃掉了！ 放我下来，我没有比你的战团更好的去处了。 当然前提是你愿意接受我。%SPEECH_OFF%你下令放下他并探讨该怎么做，然后回去找 %employer%。}",
			Image = "",
			List = [],
			Characters = [],
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
				this.Contract.m.Dude.setStartValuesEx([
					"retired_soldier_background"
				]);

				if (!this.Contract.m.Dude.getSkills().hasSkill("trait.fear_beasts") && !this.Contract.m.Dude.getSkills().hasSkill("trait.hate_beasts"))
				{
					this.Contract.m.Dude.getSkills().removeByID("trait.fearless");
					this.Contract.m.Dude.getSkills().add(this.new("scripts/skills/traits/fear_beasts_trait"));
				}

				this.Contract.m.Dude.getBackground().m.RawDescription = "你发现 %name% 挂在一棵树上，这个佣兵是一个被派去猎杀织网蛛的雇佣兵团的最后幸存者。 你救了他之后，他加入了战队。";
				this.Contract.m.Dude.getBackground().buildDescription(true);
				this.Contract.m.Dude.worsenMood(0.5, "他以前的战团被织网蛛干掉了");
				this.Contract.m.Dude.worsenMood(0.5, "差点被织网蛛活活吃掉");

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
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).getArmor() * 0.33);
				}

				if (this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).setArmor(this.Contract.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getArmor() * 0.33);
				}

				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_85.png[/img]{%employer% 在城镇入口碰到了你，边上还有一大群人跟在身边。 他热情的欢迎你，声称他派了个侦察兵跟着你，他见证了全程。 在他交付你的报酬后，居民们一个个的走上前，他们中的许多人不敢直视一个佣兵的眼睛，但他们献上了几个礼物以感谢为他们解除了织网蛛的恐怖。 | 你不得不寻觅 %employer% 的踪迹，最终在一个马厩里跟一个农民女孩在一起。 他从干草堆中抬起头，惊吓到了马们，它们轻声嘶唔并跺起脚。 半裸着，他说他带着你的报酬并交了过来。 注意到你在看女孩，他然后开始抓任何能碰到的东西，包括马的鞍袋里，并把它们交了过来。%SPEECH_ON%额，镇民们也都想献上一份。 你懂得，表达谢意。%SPEECH_OFF%很好。为了更多的“谢意”你问他会不会给你附近袋子里的任何东西。 | %employer% 拍手搓着欢迎你回来，好像你刚刚带了只火鸡而不是你胜利的可怕证据。 在支付你被承诺的报酬后，你听到些意外的行文。 镇长说一个失踪的镇民的资产不能被很好的分割所以，作为额外的谢意，你可以拿上剩下的。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "为镇子清除了织网蛛");
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
				local food;
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					food = this.new("scripts/items/supplies/cured_venison_item");
				}
				else if (r == 2)
				{
					food = this.new("scripts/items/supplies/pickled_mushrooms_item");
				}
				else if (r == 3)
				{
					food = this.new("scripts/items/supplies/roots_and_berries_item");
				}

				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
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

