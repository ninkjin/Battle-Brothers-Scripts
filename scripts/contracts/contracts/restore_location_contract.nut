this.restore_location_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Caravan = null,
		Location = null,
		IsEscortUpdated = false
	},
	function setLocation( _l )
	{
		this.m.Location = this.WeakTableRef(_l);
	}

	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(70, 90) * 0.01;
		this.m.Type = "contract.restore_location";
		this.m.Name = "重建工作";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 300 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"确保位于%townname%附近的废墟%location%"
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
					this.Flags.set("IsEmpty", true);
				}
				else if (r <= 30)
				{
					this.Flags.set("IsRefugees", true);
				}
				else if (r <= 60)
				{
					this.Flags.set("IsSpiders", true);
				}
				else
				{
					this.Flags.set("IsBandits", true);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"确保位于%townname%附近的废墟%location%"
				];
				this.Contract.m.Location.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Location))
				{
					if (this.Flags.get("IsVictory"))
					{
						this.Contract.setScreen("Victory");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("ReturnForEscort");
					}
					else if (this.Flags.get("IsFleeing"))
					{
						this.Contract.setScreen("Failure2");
						this.World.Contracts.showActiveContract();
						return;
					}
					else if (this.Flags.get("IsEmpty"))
					{
						this.Contract.setScreen("Empty");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsRefugees"))
					{
						this.Contract.setScreen("Refugees1");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("Spiders");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsBandits"))
					{
						this.Contract.setScreen("Bandits");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RestoreLocationContract")
				{
					this.Flags.set("IsVictory", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "RestoreLocationContract")
				{
					this.Flags.set("IsFleeing", true);
				}
			}

		});
		this.m.States.push({
			ID = "ReturnForEscort",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回 %townname%"
				];
				this.Contract.m.Location.getSprite("selection").Visible = false;
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
		this.m.States.push({
			ID = "Escort",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"护送工人前往%townname%附近的%location%"
				];
				this.Contract.m.Location.getSprite("selection").Visible = true;
				this.Contract.m.Home.getSprite("selection").Visible = false;
			}

			function update()
			{
				if (this.Contract.m.Caravan == null || this.Contract.m.Caravan.isNull() || !this.Contract.m.Caravan.isAlive() || this.Contract.m.Caravan.getTroops().len() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (!this.Contract.m.IsEscortUpdated)
				{
					this.World.State.setEscortedEntity(this.Contract.m.Caravan);
					this.Contract.m.IsEscortUpdated = true;
				}

				this.World.State.setCampingAllowed(false);
				this.World.State.getPlayer().setPos(this.Contract.m.Caravan.getPos());
				this.World.State.getPlayer().setVisible(false);
				this.World.Assets.setUseProvisions(false);
				this.World.getCamera().moveTo(this.World.State.getPlayer());

				if (!this.World.State.isPaused())
				{
					this.World.setSpeedMult(this.Const.World.SpeedSettings.EscortMult);
				}

				this.World.State.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.EscortMult;

				if (this.Flags.get("IsFleeing"))
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Location))
				{
					this.Contract.setScreen("RebuildingLocation");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("IsFleeing", true);

				if (this.Contract.m.Caravan != null && !this.Contract.m.Caravan.isNull())
				{
					this.Contract.m.Caravan.die();
					this.Contract.m.Caravan = null;
				}
			}

			function end()
			{
				this.World.State.setCampingAllowed(true);
				this.World.State.setEscortedEntity(null);
				this.World.State.getPlayer().setVisible(true);
				this.World.Assets.setUseProvisions(true);

				if (!this.World.State.isPaused())
				{
					this.World.setSpeedMult(1.0);
				}

				this.World.State.m.LastWorldSpeedMult = 1.0;
				this.Contract.clearSpawnedUnits();
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回 %townname%"
				];
				this.Contract.m.Location.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success2");
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
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% 提供了些面包和啤酒，看着很开心的自己吃了起来。 在闲聊了些你对 %townname% 的感觉后，他开始说正事了。%SPEECH_ON%这个地区以前很繁荣，但我们的许多资产被强盗抢劫、烧毁或接管。 我们需要你去 %location% 那里在 %townname% 郊外，清理并赶走任何占据者好让我们安全的派出材料并让我们的工人重建。%SPEECH_OFF%他越过桌子直直的看着你。%SPEECH_ON%你愿意帮助我们完成它吗？%SPEECH_OFF% | %employer% 咬了口苹果后丢给了你。 接住它，你看向他，不太清楚该做点什么。 当他什么也没说的时候，你咬一口，然后扔回去，谢谢他。%SPEECH_ON%没关系，佣兵。今天是个好日子，但是，当然，我有个活要交给你。 %location% 那里在 %townname% 郊外，我相信，窝藏着一群强盗。 我需要你做的是到那里去赶走他们好让我把它恢复到从前的样子。 你…意下如何？%SPEECH_OFF% | %employer% 叹着气从手中放下一串卷轴好像上面的消息过于沉重。%SPEECH_ON%我们从 %townname% 没有收到足够的克朗，而我相信是因为强盗占据了 %location%。这并没有被完全证实… 我真的应该多跟进些手下人的消息，但你知道情况是怎么样。%SPEECH_OFF%You shrug.%SPEECH_ON%不论如何，我希望你到那里去，找到问题，然后回我这里接受进一步指示。 听起来很简单，对吗？%SPEECH_OFF% | %employer% 坐在椅子上前倾，指着办公桌上摊开的地图上的一个点。%SPEECH_ON%%location% 那里在 %townname% 郊外，被强盗摧毁了。 现在，佣兵，我需要你的帮助来把那里夺回来并开始重建，至少我跟农民是这么说的。有兴趣吗？%SPEECH_OFF% | %employer% 叹气，一边呼气，另一边倒在椅子上。%SPEECH_ON%我小时候经常去 %location%。 那时候真是个富饶的地方，但是现在因为一些流浪汉它被摧毁了。 当然，我不是为了怀旧跟你说这些。 我需要你去那里把它夺回来！ 杀了这些强盗然后马上回来跟我报告。 这个简单的任务有兴趣吗？%SPEECH_OFF% | %employer% 把腿翘到办公桌上，踢倒几个空杯子。%SPEECH_ON%农民们又在抱怨了。打扰着我。 他们说 %location% 那里在 %townname% 郊外，被摧毁了。 我一般不会相信这帮蠢货的话，但是几个议员看起来确认了这个消息。 所以现在我得做点什么。%SPEECH_OFF%他手指转向你，笑着。%SPEECH_ON%%location% 正是你派上用场的地方。去那里杀了那些无法无天的流浪汉，然后回来跟我报告。 听起来怎么样？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{听起来挺简单。 | 我们来谈谈克朗。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我不这么认为。}",
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
			ID = "Empty",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{到达 %location%。你让手下展开慢慢进入这片区域。 你走进去，小心的接近那些建筑物，风呼啸着穿出窗户。 继续调查，看起来没有任何人在这里。 甚至也没有证据证明他们刚刚离开。 你集齐手下回去告诉 %employer%。 | %location% 令人意外的空旷。 你漫步在房子里，举起些布满灰尘的杯子掀翻几张草床，但是虫都找不到一个，更别提人。 这个地方完全就是被抛弃了。 你回去告诉 %employer% 消息。 | %location% 的边缘只有一个鹿角晃着，木头的微响声是这块地方唯一的生气。 如果任何人住在这里，他们很久前就离开了。 房子是空的。空洞着。 你从外面就看得出来里面没人。 旧神摧毁这里也没人会知道或在乎。悲伤。 最好跟 %employer% 报告这个“好”消息。 | %location% 被遗弃了，就像你猜的那样，但是看不到一个强盗或流浪汉。 倒也不能责怪他们不想住这里：尽管有几栋房子，周围的一切东西都让你处在一种边缘上。 老，破...闹鬼？好像这些是什么难以计量罪恶的藏身处。 或许 %employer%的工人会把它们拆掉重新开始。 | %location% 一个强盗都找不到。一般的房子被摧毁了，另一半空荡荡的。 几个 %employer%的工人可能可以把这个地方修整好所以你最好快去告诉他。 | 你找到一个风向标卡在土里还有旁边一头牛的残骸。 一个猪圈上长满了新鲜的绿草。 其中一个房子葱郁的爬满了藤蔓。 墓地的标记弯曲了还有些倒在地上。 你找到一个铲子还有边上一个洞。 水填满了空墓蓝鸟在里面洗澡。 你寻思这个地方是不是最后就这么放着，但不是你来做决定。 你回去找 %employer% 汇报情况。 | 你进入 %location% 让手下展开并搜索建筑。 不准备让这帮佣兵独自进行调查，你进入了一个附近的房子。 门洞大开并且几乎马上的你脚就提到了土上的一堆瓶瓶罐罐。 缓慢前进，你在角落里找到了几个死掉的小老师，它们的骷髅仍然呈疾走壮，在它们边上是只死猫。 横梁上有个鸟巢。 黄色的蛋在鸟巢中一闪一现，但你即没看到也没听到鸟。\n\n%randombrother% 穿过门走进来说什么都找不到。 如果强盗曾经在这里，它们很早就走了。 你告诉雇佣兵集合，因为是时候回去报告给 %employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我没想到。",
					function getResult()
					{
						this.Contract.setState("ReturnForEscort");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Bandits",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{你命令你的人展开面向 %location%。你手握利剑蹑手蹑脚地穿过这片区域。 随着你转过一个弯，你找到一个人蹲在粪坑边上。 他的膝盖因看到你摇摆。 当他伸手去取武器，你穿透了他，快速的把他的尸体踢下利刃并警告你的手下有强盗而他们正在从周围的建筑里快速涌出。 | %location% 很安静，但是不够安静。 时不时你听到木头受压的咔嚓声，锁链被移动的叮当声。 这里有人。你拔出剑命令你的手下准备战斗。 刚发出命令，一个强盗踢开门冲了出来，一大群同样叫嚣着的人跟在他后面。 | 强盗！如你所料。 不仅仅是他们在 %location%，他们看来完全不在乎有多显眼。 随着你的人汇聚向这个区域，强盗们懒散的收拾起武器好像他们解决过你这样的人。 | %location% 完全是空的-除了一大群强盗驻扎在中心，蹲在一个营火和上面的烤猪周围。 他们看了看你，又看了看猪，然后又看向你。 其中一个叉了块肉下来。%SPEECH_ON%该死的，先生，我们正想吃。%SPEECH_OFF%你拔出剑点头。%SPEECH_ON%我也想。%SPEECH_OFF% | 你找到一个强盗在 %location% 外面。他背着一个农民的尸体作为证据，足够告诉你得杀了他和他的朋友。 你命令你的人进攻。 | 强盗随着你靠近 %location% 匆忙的从营火冲出。意外的，他们武装起自己并冲出来保护他们新近获得的“领土。”}",
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
						p.CombatID = "RestoreLocationContract";
						p.TerrainTemplate = "tactical.plains";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.Template[0] = "tactical.human_camp";
						p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
						p.LocationTemplate.CutDownTrees = true;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditScouts, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Spiders",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_110.png[/img]{白色的东西像烟一样从 %location% 的房子里随风飘荡，但是建筑本身没有被破坏。 随着你靠近，一对又一对的红色眼睛从它们的窗户里亮起。 织网蛛出现，它们纤细的腿在木头上铛铛的作响，摩擦着起皱的屋顶，黑色的躯体从窗框漂出好像一片焦黑的蒲公英。 | 你发现 %location% 被遗弃了，但是白丝在每个角落都是，几条在随风翻腾。%randombrother% 碰了一根然后它带着他的手臂缩回去而他得切断它自救。 回头看，你看到织网蛛正冲向你，它们纤细的腿像剪刀般以恐怖的速度掠过地面，它们的下颚饥饿的敲打着。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.Music = this.Const.Music.BeastsTracks;
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "RestoreLocationContract";
						p.TerrainTemplate = "tactical.plains";
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Spiders, 90 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Refugees1",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_59.png[/img]{%location% 到处都是人，确实，但是它们不是强盗。 难民像一大群移动的垃圾堆在找地方落脚一样。 肮脏的男人，女人甚至小孩缓慢的走来走去，太过虚弱根本没注意到面前的佣兵团。%randombrother% 到你身边问该做什么。\n\n 如何他们要留在这里，%employer% 不会很高兴而且你很可能拿不到报酬。 另一边…看看他们这群不幸的人。 他们需要个地方安顿下来。 | 你放下望远镜摇摇头。 %location% 充满了－或者说全都是－难民。 比强盗好，你想，但还是个问题。%employer% 不会很高兴见到他们，你知道这个。 另一边，那里的人…衣衫褴褛…骨瘦如柴…精疲力竭…他们不该被再次赶回路上，是吗？ | %randombrother% 转身吐唾沫。 他腰间握拳并摇头。%SPEECH_ON%该死。%SPEECH_OFF%在你和你兄弟们面前是一群衣衫褴褛的难民。 二十，或者三十个。大部分是男人。 你认为剩下的人，女人和孩子，目前都躲在更里面的地方。 这群疲劳的人看起来太过无力，话都说不清。 他们只是互相瞥几眼还有时不时卑微的耸肩。\n\n 一个兄弟在你一边说。%SPEECH_ON%我们要想 %employer%的钱恐怕得把他们踢出去…%SPEECH_OFF%但是另一个从另一侧说…%SPEECH_ON%是的，但是看看他们。 我们真的可以把他们送回去吗？ 让他们留下吧，我说。%SPEECH_OFF% | 难民占据了 %location%，估计是因为什么地方在打仗。 他们搜罗了区域里的资源并且安定了下来。 你知道 %employer% 对于他们不会很高兴-他们看起来不像是本地人。%randombrother% 来到你一边向这群破败的陌生人点头。%SPEECH_ON%我可以带几个人赶走他们，长官。 很简单。%SPEECH_OFF% | 看不到一个强盗。 与之相对的，你找到一大群难民占据着 %location%。一大群疲劳的人们安定在这里：他们有锅在火上而且对于他们的新“家”显得挺开心。 但是 %employer% 不会乐意他们住在这里。 一点都不。你不想相信它，但是事实是如果你想拿到钱这些人就得走。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "把这些人踢出去。",
					function getResult()
					{
						return "Refugees2";
					}

				},
				{
					Text = "这些人无处可去。 就…别管他们了。",
					function getResult()
					{
						return "Refugees3";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Refugees2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_59.png[/img]{你命令手下赶出难民。 他们没有怎么反抗－大部分只是在埋怨世道残酷。 你只能想到你能拿到多少。 | %randombrother% 和几个雇佣兵受命赶他们出去。 幸运的是没有冲突，但是每个经过的难民跟你对视时都带着一股沉重，悲伤的表情。你耸耸肩。 | 难民被踢了出去。 其中一个看起来想说什么，但是闭上了嘴。 就好像他以前说过这些话，但他记得当时这些话是不起作用的，而现在这些话也不会起作用。 你享受他的沉默。 | 你让 %randombrother% 发了点食物给难民。 反正本来就要坏掉的：板砖一样的面包还有揭开盖子就闻起来要死了的汤。 难民们像你给了他们全世界一样接受了全部。 尽管他们没有道谢。 他们只是点头耸肩然后走开了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "滚远点，贱民！",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-2);
						this.Contract.setState("ReturnForEscort");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Refugees3",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_59.png[/img]{你留难民在那里。 最好不要回去找 %employer% 因为他对此不会很高兴。 | 男人，女人和孩子看起来受够磨难了。 你决定让他们留在这里。 | 这些人受够了这个世界的苦难。 你不认为他们能再挺过一段旅途并决定让他们就这么住下来。 | 这群被反复折磨的人们不应被从这里踢出去。 你决定让他们呆这里。 他们会把这里变得好起来的，尽管 %employer% 对于没有自己人在这里不会很高兴。 | %employer% 想要他自己的人住在这里，但你想这些人先到了。 除此之外他们看起来不像能再野外再活多久。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会在别的地方找到工作的…",
					function getResult()
					{
						this.World.Assets.addMoralReputation(2);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没能保护一个破败的 " + this.Contract.m.Location.getRealName());
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{战斗结束了，%location% 安全了。是时候回去找 %employer%。 | 你看了看战场，点了点头，庆幸自己肩上还有个脑袋可以点头。是时候回去找 %employer%。 | 尽管战斗艰苦，你集合手下准备回去找 %employer%。 | 战斗结束，你视察环境并准备着报告。%employer% 会想知道这里都发生了什么的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "已经解决了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "RebuildingLocation",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{你回到 %location% 看着工人们前往房子。 他们开始工作，堆起木头，竖起支撑柱，还有一群人在挖井。 看来你现在可以回去找 %employer% 了。 | 工人谢谢你带他们安全到达 %location%。 他们之后转身在区域里散开用手边工具开始了工作。 锤子和锯子发出的咯咯声和呼噜声在你身后回响，你离开了这里去找 %employer%。 | 大部分的工人进入了 %location% 并开始准备重建。 工头谢谢你带他们安全到达因为他知道世事险恶。 他还谢谢你没有背叛他们。 你带着笑容接受这份敬意后开始了回程去找 %employer%。 | 好，工人们都安全到站了。 你转身，回去找 %employer% 去拿你应得的报酬。 | 路途真是遥远，来来回回的，但是看起来 %location% 要好起来了。 在确认工人都安全了之后，你回去找 %employer% 拿报酬。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候拿报酬了。",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_98.png[/img]{%employer% 瞥了眼你进来。%SPEECH_ON%所以都办好了？%SPEECH_OFF%You nod. %employer% 起身给你指示：你要带一群工人回到 %location% 好让他们开始重建它。 | %employer% 听了你的报告点了点头。%SPEECH_ON%我有一群人要回到 %location% 好重建它。 我需要你护送他们。懂吗？很好。%SPEECH_OFF% | 收起些卷轴，%employer% 给了你下一步指示。%SPEECH_ON%我有一伙人要回到那里开始重建。 事关一大堆克朗，所以我需要你确保这些人安全到那里。 在那之后，回来拿你的报酬。%SPEECH_OFF% | %employer% 听了你的报告后坐下来。 他正在啜饮一杯眼镜蛇酒。%SPEECH_ON%消息？%SPEECH_OFF%你告诉他这个区域已经被清理了。 那人一口气喝完剩下的酒，然后放下杯子。%SPEECH_ON%很好…很好。现在带一伙我的工人回去帮忙重建。 一旦他们完事了，回来领报酬。%SPEECH_OFF% | %employer% 后靠着看你进来。%SPEECH_ON%我想你回来意味着 %location% 被清理干净了，对吗？%SPEECH_OFF%你确认了他想听到的。 他看起来很高兴，尽管你的工作还没结束：%employer% 要你带一群工人回到那里开始重建。 只要他们安全的到了那里，你就可以回来领报酬了。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "这应该要不了多久。",
					function getResult()
					{
						this.Contract.spawnCaravan();
						this.Contract.setState("Escort");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_63.png[/img]{%employer% 用一大袋沉重的克朗欢迎你回来。 他挥手示意你可以离开了，几乎没有跟你道谢。 不过嘛，去他妈和他妈的表面功夫。 一包克朗足够谢意了。 | 你进入 %employer%的房间而他示意你靠近。 他的一个手下教给你一大袋克朗。 你看着他。%SPEECH_ON%你怎么知道他们到了？%SPEECH_OFF%%employer% 羞涩地笑了。%SPEECH_ON%我在这片区域有眼线。 连鸟都会跟我说话…%SPEECH_OFF%这解释够多了。 | 回到 %employer%，你解释说 %location% 已经有序开始重建了。他谢谢你。%SPEECH_ON%好，看看，啊？ 一个受信用并且能办好事的雇佣兵。 真罕见。这是你的报酬。%SPEECH_OFF%其中一个手下递给你麻袋装的沉重克朗。%employer% 做了个手势。%SPEECH_ON%后会有期，佣兵。%SPEECH_OFF% | %employer% 在你回来时正在读书。 他给你看了个卷轴问你知不知道这是什么。你耸耸肩。%SPEECH_ON%我不是一个有学问的人。 不管怎样，不是书面的。%SPEECH_OFF%%employer% 转身耸肩。%SPEECH_ON%真遗憾。但你是个守口头承诺的人。 你信守承诺并且，相信我，这很少见。你的报酬在角落里。%SPEECH_OFF%报酬就在他说的地方。 你花了点时间做表面功夫然后拿上它离开了。 | %employer% 靠在椅子上，看起来沾沾自喜。%SPEECH_ON%我知道怎么挑。我是说佣兵。 很多我的同行都会雇你这样的人，但是他们总会搞砸，因为他们不知道如何从一只死狗的尾巴中判断一个好人。 但是你…我看到你那一刻就知道你会办好的。你的报酬，佣兵…%SPEECH_OFF%他把一袋克朗砸在办公桌上。%SPEECH_ON%都在这里，但我理解你，如果你想数一下的话。%SPEECH_OFF%你数了数－分文不差。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "轻松的克朗。",
					function getResult()
					{
						this.Contract.m.Location.setActive(true);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "帮助重建 " + this.Contract.m.Location.getRealName());
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
			ID = "Failure1",
			Title = "战斗之后",
			Text = "[img]gfx/ui/events/event_60.png[/img]{房子都毁了而且任何重建 %location% 的可能性都没了。 至少一段时间内是这样。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "该死！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "没能保护建筑行进队伍");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "战斗之后",
			Text = "[img]gfx/ui/events/event_71.png[/img]{你的士兵未能保护好%location%，所以你不应该期待任何报酬。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "该死！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "无法保护此区域。" + this.Contract.m.Location.getName());
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnCaravan()
	{
		local faction = this.World.FactionManager.getFaction(this.getFaction());
		local party = faction.spawnEntity(this.m.Home.getTile(), "Worker Caravan", false, this.Const.World.Spawn.CaravanEscort, this.m.Home.getResources() * 0.4);
		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("一队来自的工人和建筑材料的队伍" + this.m.Home.getName() + ".");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.setMovementSpeed(this.Const.World.MovementSettings.Speed * 0.5);
		party.setLeaveFootprints(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Location.getTile());
		move.setRoadsOnly(false);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(despawn);
		this.m.Caravan = this.WeakTableRef(party);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Location.getRealName()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.State.setCampingAllowed(true);
			this.World.State.setEscortedEntity(null);
			this.World.State.getPlayer().setVisible(true);
			this.World.Assets.setUseProvisions(true);

			if (!this.World.State.isPaused())
			{
				this.World.setSpeedMult(1.0);
			}

			this.World.State.m.LastWorldSpeedMult = 1.0;

			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.Location == null || this.m.Location.isActive() || !this.m.Location.isUsable())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Caravan != null && !this.m.Caravan.isNull())
		{
			_out.writeU32(this.m.Caravan.getID());
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

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local caravan = _in.readU32();

		if (caravan != 0)
		{
			this.m.Caravan = this.WeakTableRef(this.World.getEntityByID(caravan));
		}

		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		this.contract.onDeserialize(_in);
	}

});

