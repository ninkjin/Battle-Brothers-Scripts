this.hunting_sand_golems_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_sandgolems";
		this.m.Name = "活沙";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 850 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕在城镇附近沙漠中杀人的东西于" + this.Contract.m.Home.getName()
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 10 && this.Contract.getDifficultyMult() >= 1.15)
				{
					this.Flags.set("IsEarthquake", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				local disallowedTerrain = [];

				for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
				{
					if (i == this.Const.World.TerrainType.Desert)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local mapSize = this.World.getMapSize();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 8, 12, disallowedTerrain);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Ifrits", false, this.Const.World.Spawn.SandGolems, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("由活生生的石头组成的生物，被南方烈阳的灼热火燎塑造成型。");
				party.setFootprintType(this.Const.World.FootprintsType.SandGolems);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);

				for( local i = 0; i < 1; i = ++i )
				{
					local nearTile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, disallowedTerrain);

					if (nearTile != null)
					{
						this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.SandGolems, 0.75);
					}
				}

				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(8);
				roam.setMaxRange(12);
				roam.setNoTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Desert, true);
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

					if (tileType == this.Const.World.TerrainType.Desert)
					{
						this.Flags.set("IsBanterShown", true);
						this.Contract.setScreen("Banter");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsEarthquake"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Earthquake");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.World.Contracts.startScriptedCombat(properties, false, true, true);
					}
				}
				else if (!this.Flags.get("IsEncounterShown"))
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
			Text = "[img]gfx/ui/events/event_162.png[/img]{%employer% 抬起头看起来好像在用他的鼻梁接待你。 是一声讥讽，但是他确实让你进去了。 维齐尔拍了拍手，一个仆人带着张卷轴到你身边，打开它，并读道。%SPEECH_ON%伊弗利特群被目击出现在沙漠里。 一个逐币者－这是在说你，旅行者－将…%SPEECH_OFF%维齐尔再次拍了拍手。%SPEECH_ON%可能是他，仆人。 可能是他。注意你的言辞。%SPEECH_OFF%你知道佣人想说不是他写的卷轴，但他闭上了嘴。 他回到刚才的声明上。%SPEECH_ON%…将因驱散那些灼沙回到自然状态收到丰厚的物质奖励。 上述怪物的消除将被报以 %reward% 克朗。%SPEECH_OFF%卷轴收了回去，仆人侧握在它，并横向移出了场地。 你再次看向了维齐尔，但他的注意力不在你身上，一个奴隶少女正在喂他吃葡萄。 | 一个名叫 %employer% 的维齐尔接见了你，尽管这场会谈中的体面全部集中于官僚事物的方面。%SPEECH_ON%逐币者，伊弗利特在沙漠中潜伏。 为助了结此事而召你前来。 如果你拒绝接受 %reward% 克朗的报价，我们将会再召一个替代你。%SPEECH_OFF% | 你进入房间，发现几个维齐尔被掩埋在奴隶少女们的身体下。 有很多嬉笑和挑逗的肌肤接触，但是最引人注意的是没有人注意到你站在这里。 除了一个老些的人拖着脚走到你身边弯下腰。%SPEECH_ON%逐币者，维齐尔 %employer% 为一个捕猎伊弗利特的任务要召一个逐币者。%SPEECH_OFF%老人瞟了眼，然后挺起身。 他接下来的这次开口就没那么多咬文嚼字了。%SPEECH_ON%它们是群大个儿沙子混账，而且它们正在郊区胡作非为。 我警告你它们不是来搞笑的，所以不要让这排场和金子诱惑你干你不该做的。如果你接受，报酬会是 %reward% 克朗。%SPEECH_OFF%挺起身并清了清嗓子，老人大声的问道。%SPEECH_ON%你是否受召？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我很感兴趣，继续。 | 捕猎这样的敌人可不便宜。 | 这需要你花费一些。 | 在沙漠中追捕幻象。 有什么不喜欢的呢。 | %companyname% 可以提供帮助，只要价格合适。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我不会带领这些人在沙漠中徒劳地追逐。 | 我不这么认为。 | 我拒绝，伙计们更喜欢已知的血肉之敌。}",
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
			Text = "[img]gfx/ui/events/event_161.png[/img]{在追踪神秘的伊弗利特时，你遇到一个脚如同皮革一般的老妇人。 她见到你鞠躬。%SPEECH_ON%啊，逐币的奴隶，你要找的是伊弗利特，对吗？ 当然。我从你的脸上看得出来。%SPEECH_OFF%她停下来指向一个你正朝向的沙丘。%SPEECH_ON%我们在这土生土长，明白吗？ 我们和它们一体，而当我们放逐、伤害，或者对他人残忍时，沙会选择被害的一方。 害怕的不应是怪物，而是它被创造的原因，因为那个原因渗透着这片沙地，而且以那个原因你将杀死的不过是一个怪物而非盐化永恒催生着它们的水。%SPEECH_OFF% | 你路过了沙漠中的一个井。 一个人交给你一桶水，说着下面的水无穷无尽。 视线内看不到一个农场，你有理由相信水足够一个人永远免于干渴。 不过他确实看来感受到你来这里有别的目的。%SPEECH_ON%我想你要找的是伊弗利特，是不是？%SPEECH_OFF%点着头，你问他怎么知道的。他咧嘴一笑。%SPEECH_ON%因为我看到过它们，以及它们做了什么，所以我相信要不了多久一支职业军队或者逐币的奴隶回过来解决它们的纠纷。 伊弗利特是一种复仇的怪物，且它只会屈服于将它驱出大地的力量：残忍。%SPEECH_OFF%喝完了水，你向他的交谈致谢并继续上路了。 | 几具尸体倒在沙上。 有的滑下了半坡沙丘。 另一个倒在底部，又一个远于底部。 看起来是被丢过去的。 尸体并没被沙尘覆盖暗示着死亡时间并不长。 看起来用难以置信的力量粉碎这些人的东西之后花了点时间破坏剩下来的东西，在一些点上砂得骨头都露出来了。 伊弗利特肯定不远了…}",
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
			Text = "[img]gfx/ui/events/event_153.png[/img]{第一眼看，是个幻象。 沙漠在远方模糊地摇动着，而对于不知情的人或者精疲力竭的人，这些景象的变幻会被看成他们想看到的样子。 就是这种时候伊弗利特会转身撕碎人类并把肢体丢的沙地上到处都是，你才意识到这完全不是什么臆想出来的怪兽。 它是一种噩梦般的生物，一股旋转着的沙云夹着点石头摆动着成一种人形。 而随着它向前倾你意识到它在对领地上全副武装的陌生人的反应上跟人一样：暴怒。 | The sand dunes ahead slip from top to bottom, the sands curling toward you like a sheet being pulled off a bed. 但是一颗石头冒出土然后一个又一个，而在第一颗石头扬起的时候你意识到这是一个伊弗利特。 一声低吼摩擦着发出，沙风的碰撞摩擦出的低沉怒吼。 伊弗利特呈现一种摇摇晃晃的，脱节的人形，以石为骨，以沙为血肉，而它正向前冲刺。 | 你看到伊弗利特用膨胀着的手臂一样的东西倒向地面。 沙从手臂中吹出，摩擦着一具尸体沁到沙漠里，力量撕碎着衣服，之后是血肉，最后至白骨露露，而当伊弗利特完事后它转过身，向你发出一声凶狠的低吼。}",
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
			ID = "Earthquake",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_160.png[/img]{你刚走到一个沙丘的顶峰，脚底的沙丘便立刻开始流动。 你发现自己正在沉没并在大地完全吞噬你之前爬了出来。 随着你翻下坡，你发现临近的沙丘正以相似的方式塌缩着，你的胃颤抖起来，并非出于恐惧，而是因为地面本身正剧烈的摇晃着。 当一切停歇时，你起身并站稳脚跟。 伊弗利特正站在坑边缘俯视着你。 它们向你尖叫，结晶化的沙尘尖锐的摩擦着。你被包围了！ | 你停下脚步叹息。 沙漠一望无际，而当你寻思你的视野正在缩减时。 你过了一会才回过神来地面在摇晃，而随着沙地摇动你正被吸入。 你从险境中翻滚开，发现自己正翻下一个沙坡。 在底部，你快速站起身拔出武器来面对你早知道就在那里的东西：伊弗利特。 他们站在沙丘的边缘，看笼中鼠般俯视着你。 它们的身躯如沙云浮石，断断续续的呈着可能是人的形状。 它们低吼一声，冲了下来！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_160.png[/img]{战斗结束了，但是伊弗利特并没有被完全消灭。 组成它们躯体的沙起泡翻腾，如骨般形成框架的石头愤怒地晃动，颤抖。 你可以听到的嘶嘶声完全不是源于某种怪兽，而明显是人的声音。 它们嘶嘶着，声音贴着你的耳朵。 你转身却一无所获。 它们再次在你身后嘶嘶着，这一次当你转身时声音没了，而沙石皆如自然状态般安定了下来。 野兽被消灭了，和寄宿在它们中的东西一起。是时候回去找 %employer%。 | 伊弗利特们被消灭了，但是躯体看来只不过是某种更为邪恶存在的容器。 你瞟到灵体翱翔向地平线，但或许只是沙漠产生的小幻觉。 很难说清是怎么回事，除了伊弗利特的兽性被击败了而且 %employer% 该为此付你报酬。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "完成了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_162.png[/img]{你试图进入 %employer%的房间，但是一个卫兵止住了你。 眉来眼去了一阵，你告诉他你维齐尔正等着你。 卫兵低头俯视你。%SPEECH_ON%他等着你，他不想看到你。 这是两件不同的事，逐币者。 侦查兵确认了你在沙漠中的作为。 这是你的报酬，和谈好的一样。 现在离开。我说离开！%SPEECH_OFF%卫兵跺了跺脚，整大厅的卫兵跟着他一起跺了起来并看着你。 现在，尽管你不是什么天才，但你能感受到或许是时候离开了。 | %employer% 从堆满枕头和女人的王座上俯视着你。 女奴隶，从她们身上的锁链看来，但或许只是她们的情趣。 忧愁的面容诉说着另一种可能。 维齐尔开口，但这场发言就好像一出给所有听者的戏而你只是其中一个演员。%SPEECH_ON%逐币者，我的小鹰们告诉了我你的作为。 伊夫利特被消灭而且它们的巫术不再构成威胁！ 这正是我的金子的力量。 这份工作经过我们双方认同，在此 %reward% 克朗的报酬现在是你的了。%SPEECH_OFF%随着一个仆人交给你一包硬币，维齐尔轻蔑地向你挥了挥手。%SPEECH_ON%滚%SPEECH_OFF% | You find %employer% turning an hourglass one way and back again. 沙子被均衡的分在两个半球中。 墙边站满了低着头的仆人。 在相邻的墙边是一排坐垫，上面坐着群艳俗的女人，她们的头发正被拷着锁链的女人照料着。 The Vizier slams the hourglass down. 他蹲在它后面，他的眼睛看着两边的球体，瞳孔直直地盯着中间。 你终于意识到其中的沙子并没有在正常的流动，而是愤怒的旋转着。%SPEECH_ON%伊夫利特们都被解决了，我的鹰们告诉过我了。 逐币者，你完成了你受召的任务，为此你将被给予 %reward% 克朗。 我希望你在沙漠中的时光不仅给了你战斗和战争的经验，也给了你沉思的想法。%SPEECH_OFF%你不确定他在说什么。 他猛地把沙漏抬起并再次开始把它两边踮。 沙子随着它们弹来弹去击拍打着。 一个仆人交给你一包硬币而你以最快的速度离开了房间。 | 你回去找 %employer% 看到这位维齐尔低头坐在一个长沙发上。 几个老人正替他锤着背或擦着脚。 房间另一边，一个女人伸展开来。 她全裸着而她的眼睛目不转睛的盯着维齐的眼睛，而他也盯着她的。 他好像你根本不在这个房间里一样说道。%SPEECH_ON%仆人，将黑绳系着的紫色袋子交给这个逐币者。 逐币者，你在解决那些被称为伊夫利特的沙漠之灵干得不错。 我的金子驱使你进入了那片沙漠，而我的金子奖励了你，所以让书记员知道，实际上是我的金子解决了这个麻烦，而工具，这位逐币者，则被公正的奖励了。%SPEECH_OFF%一个仆人将一个紫色的袋子嘟到你的手臂上。 维齐尔诉使一个老人将手肘按入他的屁股缝呻咛了一声。%SPEECH_ON%需要我命令你离开吗，逐币者？%SPEECH_OFF% | 一个没有眉毛的老人接待了你，将你停在 %employer%的门前。 他将一个袋子塞到你的臂间。%SPEECH_ON%里面有 %reward% 克朗，维齐尔同意过的。%SPEECH_OFF%他环视一圈寻找窃听者并在看到你是唯一一个耳听范围内的人时点了点头。%SPEECH_ON%伊夫利特们不止是恶魔，它们是被冒犯的灵体，而你让它们自由了。 但它们可能会回来，因为像 %employer% 这样的人除了一瀑布的金子没什么好给这世界的，而且他们忘记了在瀑布下有许多被压碎或溺水的人。%SPEECH_OFF%你不确定他指的是什么，但是一个靠近中的卫兵结束了这场对话而老人扇了你一巴掌。%SPEECH_ON%滚，逐币者！拿上你的报酬并滚出我的视线范围！%SPEECH_OFF% | 在一切可能性中，一群猫欢迎着你进入了 %employer%的房间。 你勉强看到维齐尔在一片毛球的另一边与一群同样被逗乐的围观者一起。\n\n 你低头看到猫推着一块木头，上面摆着一个包。 你抬起头。 轮廓们正屏住呼吸。 叹了叹气，你弯下腰捡起袋子。 一个窃视者起身鼓掌但是被严厉的教训小声点。 它们的任务完成了，猫咪们落下在地板上散开，打着瞌睡或梳着毛或用爪子挠漏下来的日光。 你很确信 %reward% 克朗就在袋子里，但是不想再在房间里呆一秒，你走出来数你的钱。}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "为城市解决了伊弗利特");
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
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/mirage_sightings_situation"));
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

