this.roaming_beasts_desert_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.roaming_beasts_desert";
		this.m.Name = "狩猎野兽";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕造成恐慌的野兽于" + this.Contract.m.Home.getName()
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 40 || this.World.getTime().Days <= 15 && r <= 80)
				{
					this.Flags.set("IsHyenas", true);
				}
				else if (r <= 80)
				{
					this.Flags.set("IsSerpents", true);
				}
				else
				{
					this.Flags.set("IsGhouls", true);
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10);
				local party;

				if (this.Flags.get("IsHyenas"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Hyenas", false, this.Const.World.Spawn.Hyenas, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群贪婪的鬣狗在捕猎猎物。");
					party.setFootprintType(this.Const.World.FootprintsType.Hyenas);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Hyenas, 0.75);
				}
				else if (this.Flags.get("IsGhouls"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Nachzehrers", false, this.Const.World.Spawn.Ghouls, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群找尸体吃的食尸鬼。");
					party.setFootprintType(this.Const.World.FootprintsType.Ghouls);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Ghouls, 0.75);
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Serpents", false, this.Const.World.Spawn.Serpents, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("巨大的蛇正扭动着前行。");
					party.setFootprintType(this.Const.World.FootprintsType.Serpents);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Serpents, 0.75);
				}

				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(2);
				roam.setMaxRange(8);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
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
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsHyenas"))
					{
						this.Contract.setScreen("CollectingHyenas");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("CollectingGhouls");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSerpents"))
					{
						this.Contract.setScreen("CollectingSerpents");
						this.World.Contracts.showActiveContract();
					}

					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsWorkOfBeastsShown") && this.World.getTime().IsDaytime && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 9000) <= 1)
				{
					this.Flags.set("IsWorkOfBeastsShown", true);
					this.Contract.setScreen("WorkOfBeasts");
					this.World.Contracts.showActiveContract();
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
					if (this.Flags.get("IsHyenas"))
					{
						this.Contract.setScreen("Success1");
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("Success2");
					}
					else if (this.Flags.get("IsSerpents"))
					{
						this.Contract.setScreen("Success3");
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{进入 %employer%的房间，你发现他正在一张放满了人体部件的布上。他抬头看着你。%SPEECH_ON%这些曾经是野兽杀手，宣称是，现在他们成了这个样子，这些是从他们派去的任务中回收回来的。%SPEECH_OFF%维齐尔点头然后几个助手过来卷起了布。 肉和内藏缩在一起从两边流出。 仆人卷起布，背上肩触发了，一只断手懒散的在一段晃荡。%employer% 拍拍手。%SPEECH_ON%我的麻烦住在沙漠里，一群残暴的野兽在收割本地人口。 我望进永恒之火里并受到引导来寻找一个逐币者来帮助解决这个怪物问题。 你，逐币者，觉得 %reward% 克朗足够作为购买你临时效忠的份额吗？%SPEECH_OFF% | 你走进 %employer%的住所，但是十足的卫兵墙阻止你靠的更近。 他站在带有向下的短楼梯的王座的座上。 他向下走，每一步都充满非常谨慎，来到地面。 一个人回头看他，维齐尔点了点头。 他转身看你并交给你一个卷轴。 上面写着一群难以界定的生物在 %townname% 的领地里制造混乱。如果你找到并摧毁上述怪物你会以适宜的方式得到报酬，%reward% 克朗。 | %employer% 被一后宫半裸的女人围绕着。 他举起一只断手，令人意外的，女人们比起恶心更多表现出欣赏。 随着他看到你，维齐尔放下了手并在其中一个女人的肩上擦了擦手，这次引来了一点厌恶，虽然还保持着奴隶的沉默。\n\n%employer% 向一个仆人打了个响指，他奔跑过来拿着一罐葡萄酒。 维齐尔叹气赶走了仆人并再次打了个响指。 第二个仆人意识到他被召唤并走上前来，急匆匆的递给你一个卷轴并大声说：%townname% 附近有目击到怪物而且他们要尽快被消灭。\n\n 对此委托的报酬并没有那么大声的喊出来。 与之相对，仆人点了点上面写的一个数字：%reward% 克朗。 | %employer% 俯视着一张如此庞大以致没法摆在任何桌子上，而是分开铺在大理石地板上的地图边。 看起来不太必要，因为一张地图可以轻松的保持足够清晰度，但你将你的观察闭在心里。 维齐尔走过纸并指向一个地方。%SPEECH_ON%野兽出现在了王国的这一块并且以我不同意的方式摧毁了它。 我在那里有更重要的事情要处理。%SPEECH_OFF%他指向地图上另一个区域，看起来只像一片空旷的沙漠。他继续道。%SPEECH_ON%所以我需要一个像你一样的人，逐币者，去解决这些游荡的怪物。 事成，你就会被慷慨的奖励 %reward% 克朗。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们再来谈谈报酬。 | 我们干这个工作。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我祝你好运，但我们不会参与其中。}",
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
			ID = "WorkOfBeasts",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_161.png[/img]{沙漠中的血迹，足够厚到可以停在沙子上。 你跟着斑点般的印记到了一个大沙丘并越过顶峰。 在另一边一系列的残肢分散在坡下。 躯干。没有脸的尸体。 沙地中的深印引向这个区域远方。 你没能赶上来救这些人，但是你很近了。 | 你来到一个带有井的小屋边上。 门开着，门板斜着挂在一条破碎的铰链上。 拔出剑，你慢慢的推开它并找到一堆可能曾经是个人的糊状物。 好血从天花板滴下来并且小屋的另一边有一个洞，造成这破坏的东西像它来的时候一样暴力的离开了的。 野兽一定很近了。 | 尸体散落在一个沙漠井周围。 随着你靠近，一双手扒到井边缘爬出一个人。 是个老人。 他抬腿越过墙坐在那，喘着气。 他指向周围耸耸肩。 看起来野兽们刚刚就在这，但你错过了它们。 你拿出水壶递给老人，但他赶走了你。 他眼中看得出巨大的痛苦，但他努力不让你看出来。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingHyenas",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_159.png[/img]{你不确定，因为你对这些生物也没有多少了解，但你看着这些鬣狗，感到一股鄙视。 它们身上有翻过垃圾的痕迹，一群只知道欺凌弱者的蠢货，尽管他们有足够的数量和力量去为他们的食物战斗。 只是在见到了你，到了它们自己的生死存亡的一刻，才下定决心展示野兽本能。 你切下它们的头并准备回去找 %employer%。 | 鬣狗是一群卑鄙的生物，但他们不好对付。 就算在死后你也不得不反复劈砍脖子才能有一些进展，割下头则花了更多的时间。 但是很快事就办完了而你准备把头和皮带回去给 %employer%。}",
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
			ID = "CollectingGhouls",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_131.png[/img]{战斗结束了，你走到一个死食尸鬼边蹲下。 如果不是因为一扇扭曲牙齿形成的门，你可以很轻松的把头放进野兽巨大的喉咙里。 比起继续瞻仰面前的牙科灾难，你拿出一把刀切下了它的头。 你举起战利品并命令 %companyname% 跟着做。毕竟，%employer% 会需要不止一个头来作为证据的。 | 食尸鬼的尸体平躺着一动不动，看起来更像岩石而不是野兽。 苍蝇已经在它的嘴里偶合，在充满泡沫的死亡残骸上播种生命。 你命令 %randombrother% 拿走它的头，因为 %employer% 需要证据。 | 死食尸鬼散落在周围。 你蹲在其中一只边上然后看向它的嘴。 它的肺里涌出一大股恶臭。 用布遮住鼻子，你拿了把匕首切下了头。 你命令几个兄弟跟着做因为 %employer% 会想看点证据。 | 一个死掉的食尸鬼是非常特别的样本。 你不得不寻思它在生态圈里是什么样的定位。 形似隐居野人，偏色的肌肉像个捕食者，还有它的头比起血肉更像石头。 好奇心放在一边，你命令 %companyname% 开始收集头皮作为证据给 %employer%。}",
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
			ID = "CollectingSerpents",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_169.png[/img]{你蹲在其中一条沙漠大蛇面前。 从一端到另一端，你可以躺平几次并依然达不到它的全长。 真是一条特别的蛇。 你开始剥皮好作为证据带回给 %employer%。 | 大蛇都被切成片了而你把好的部分堆在一起－大部分是它们扁平的头和奇妙的尾巴－好作为完成任务的证据交给 %employer%。}",
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
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 在你回来时已经在他的宫殿外等着你了。 他让几个穿着丝绸袍子的人站在两旁。 当你放下鬣狗的尸体，这些人赶快把尸体抬走了。 维齐尔留在这里，身边跟着几个守卫。 他打了个响指然后一个仆人交给你一箱克朗。维齐尔点头。%SPEECH_ON%很出色，逐币者。我们会利用好你适时带来的这些包裹的。%SPEECH_OFF%包裹？你以为你是来解决怪物问题的。 随着守卫赶你走出广场，你看到一个学者开始用量角器测量尺寸而另一个立起底座开始绘画。 | %employer% 站在他门口，尽管你被隔在一个挺远的地方。 相对的，他的仆人们来接待了你。 他们拿走了鬣狗的毛皮丢到了银光闪闪的手推车上。 仆人们蹦蹦跳跳的像他们来的时候一样快的跑了。 维齐尔吹了声像鹰呼啸向猎物一样的口哨。 你抖了一下，但只是来了另一对仆人，手里拿着一堆克朗。 其中一个面朝天背诵着。%SPEECH_ON%逐币者，这个工作，你干的很好，看看箱子，你便能发现你的口袋如泉涌。%SPEECH_OFF%仆人弹了下舌头低下头来，嘴角高高扬起。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "清除该地区的鬣狗");
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
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 欢迎你进入他的王座室。 它里面堆满了看起来非常重要的人，但是你还是被带进去了。 短暂停驻了一下，因为你不太确定人们是否会接受，你耸耸肩后甩了食尸鬼们的残骸出来。 血，脏器还有头涌过地面，但是旁观者们声都没吱一下。\n\n你能听到的只有维齐尔轻轻靠近的脚步。 他盯着这些残骸，手拍在面前好像某种科学家，然后他打了个响指，一大群仆人赶来清理了现场。 其中一个拿着笔和纸的人记着笔记。 当一切都完事了维齐尔转身回到王座上沉默的坐下。 现在你唯一听到的只有一个宝箱被拖过来的叮当声。 全部 %reward% 克朗如同约定的一样交给了你，然后你在悄悄的催促下离开了房间。\n\n 回头，你看到人群注意力转回到了开始祈祷的维齐尔。 | 一个人把你拦在了 %employer%的房间外面。 他身边有几个瘦巴巴的人拿着笔和账目。 他们下到你收集到的食尸鬼边开始记录文书。 每一个人写完后便撕下那页纸交给第一个人比对笔记。 很满意，他交给你一包 %reward% 克朗。%SPEECH_ON%愿你的道路金光闪耀，逐币者。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "清除该地区的食尸鬼");
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
		this.m.Screens.push({
			ID = "Success3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_162.png[/img]{你在花园里见到了你的雇主。 他拿着一双剪刀看着你。%SPEECH_ON%我想任务完成了？%SPEECH_OFF%点头，你拿出大蛇头并丢到地上。 它低沉的落地并滚到维齐尔的脚边慢慢的滚开。%employer% 坚定的看着你。%SPEECH_ON%没有必要搞戏剧性，逐币者，好好完成任务才会给我留下好印象。 My guards will furnish your purse a weight of %reward% 克朗，我们谈好的。%SPEECH_OFF% | 你拖着大蛇皮走向 %employer%，但是一个穿着羽毛头巾的人阻止了你。 他说话听起来像胡言乱语，偶尔也会漏掉一些词。 看起来他受雇于维齐尔，而且他要拿走大蛇的残骸。 你看向 %employer%，他点头确认这是他的意思。 他同时还注意到了你脸上在担心报酬的表情。 他骄傲的大声说。%SPEECH_ON%不用担心，逐币者，这里只有你带过来的蛇。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "清除该地区的大蛇");
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
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_helpful = [];
		local candidates_bro1 = [];
		local candidates_bro2 = [];
		local helpful;
		local bro1;
		local bro2;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isLowborn() && !bro.getBackground().isOffendedByViolence() && !bro.getSkills().hasSkill("trait.bright") && bro.getBackground().getID() != "background.hunter")
			{
				candidates_helpful.push(bro);
			}

			if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates_bro1.push(bro);

				if (!bro.getBackground().isOffendedByViolence() && bro.getBackground().isCombatBackground())
				{
					candidates_bro2.push(bro);
				}
			}
		}

		if (candidates_helpful.len() != 0)
		{
			helpful = candidates_helpful[this.Math.rand(0, candidates_helpful.len() - 1)];
		}
		else
		{
			helpful = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro1.len() != 0)
		{
			bro1 = candidates_bro1[this.Math.rand(0, candidates_bro1.len() - 1)];
		}
		else
		{
			bro1 = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro2.len() > 1)
		{
			do
			{
				bro2 = candidates_bro2[this.Math.rand(0, candidates_bro2.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else if (brothers.len() > 1)
		{
			do
			{
				bro2 = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else
		{
			bro2 = bro1;
		}

		_vars.push([
			"helpfulbrother",
			helpful.getName()
		]);
		_vars.push([
			"bro1",
			bro1.getName()
		]);
		_vars.push([
			"bro2",
			bro2.getName()
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
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

			this.m.Home.getSprite("selection").Visible = false;
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

