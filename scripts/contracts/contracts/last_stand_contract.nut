this.last_stand_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.last_stand";
		this.m.Name = "保卫城镇";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
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

		this.m.Flags.set("ObjectiveName", this.m.Origin.getName());
		this.m.Name = "防守" + this.m.Origin.getName();
		this.m.Payment.Pool = 1600 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"前往%direction%的%objective%",
					"抵御亡灵"
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

				if (r <= 40)
				{
					this.Flags.set("IsUndeadAtTheWalls", true);
				}
				else if (r <= 70)
				{
					this.Flags.set("IsGhouls", true);
				}

				this.Flags.set("Wave", 0);
				this.Flags.set("Militia", 7);
				this.Flags.set("MilitiaStart", 7);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}
				else if (this.Contract.isPlayerNear(this.Contract.m.Origin, 600) && this.Flags.get("IsUndeadAtTheWalls") && !this.Flags.get("IsUndeadAtTheWallsShown"))
				{
					this.Flags.set("IsUndeadAtTheWallsShown", true);
					this.Contract.setScreen("UndeadAtTheWalls");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Origin) && this.Contract.m.UnitsSpawned.len() == 0)
				{
					this.Contract.setScreen("ADireSituation");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wait",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保卫%objective%并抵御亡灵"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Contract.m.UnitsSpawned.len() != 0)
				{
					local contact = false;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local e = this.World.getEntityByID(id);

						if (e.isDiscovered())
						{
							contact = true;
							break;
						}
					}

					if (contact)
					{
						if (this.Flags.get("Wave") == 1)
						{
							this.Contract.setScreen("Wave1");
						}
						else if (this.Flags.get("Wave") == 2)
						{
							this.Contract.setScreen("Wave2");
						}
						else if (this.Flags.get("IsGhouls"))
						{
							this.Contract.setScreen("Ghouls");
						}
						else if (this.Flags.get("Wave") == 3)
						{
							this.Contract.setScreen("Wave3");
						}

						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("TimeWaveHits") <= this.Time.getVirtualTimeF())
				{
					if (this.Flags.get("IsGhouls") && this.Flags.get("Wave") == 3)
					{
						this.Flags.set("IsGhouls", false);
						this.Flags.set("Wave", 2);
						this.Contract.spawnGhouls();
					}
					else
					{
						this.Contract.spawnWave();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wave",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保卫%objective%并抵御亡灵"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}

				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null)
					{
						e.setOnCombatWithPlayerCallback(this.onCombatWithPlayer.bindenv(this));
					}
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Contract.m.UnitsSpawned.len() == 0)
				{
					if (this.Flags.get("Wave") < 3)
					{
						local militia = this.Flags.get("MilitiaStart") - this.Flags.get("Militia");
						this.logInfo("民兵损失：" + militia);

						if (militia >= 3)
						{
							this.Contract.setScreen("Militia1");
						}
						else if (militia >= 2)
						{
							this.Contract.setScreen("Militia2");
						}
						else
						{
							this.Contract.setScreen("Militia3");
						}
					}
					else
					{
						this.Contract.setScreen("TheAftermath");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithPlayer( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.Music = this.Const.Music.UndeadTracks;
				p.CombatID = "ContractCombat";

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull() && this.World.State.getPlayer().getTile().getDistanceTo(this.Contract.m.Origin.getTile()) <= 4)
				{
					p.AllyBanners.push("banner_noble_11");

					for( local i = 0; i < this.Flags.get("Militia"); i = ++i )
					{
						local r = this.Math.rand(1, 100);

						if (r < 60)
						{
							p.Entities.push({
								ID = this.Const.EntityType.Militia,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/humans/militia",
								Faction = 2,
								Callback = null
							});
						}
						else if (r < 85)
						{
							p.Entities.push({
								ID = this.Const.EntityType.Militia,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/humans/militia_veteran",
								Faction = 2,
								Callback = null
							});
						}
						else
						{
							p.Entities.push({
								ID = this.Const.EntityType.Militia,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/militia_ranged",
								Faction = 2,
								Callback = null
							});
						}
					}
				}

				this.World.Contracts.startScriptedCombat(p, this.Contract.m.IsPlayerAttacking, true, true);
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_combatID == "ContractCombat" && _actor.getFlags().has("militia"))
				{
					this.Flags.set("Militia", this.Flags.get("Militia") - 1);
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

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = false;
				}

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
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_45.png[/img]{你发现%employer%正在帮助一个年轻的贵族男孩用弓箭瞄准一个稻草人。他扶正了男孩的背，命令他在射击前深呼吸。这个外行弓箭手点头照做了。箭矢被射了出去，它摇晃着击中地面然后弹起，旋转着飞进了一个马厩，几匹马受到惊吓发出了叫声。贵族拍拍男孩的背。%SPEECH_ON%相信我，我第一次的时候更糟，坚持下去，我一会儿就回来。%SPEECH_OFF%贵族走近你，摇了摇头，压低了声音。%SPEECH_ON%情况很糟糕，雇佣兵。这个年轻人不知道最近潜伏着什么危险，但你知道。我们有一个定居点，就是这里%direction%的%objective%，被…嗯，这个世界的弊病所包围。我没有多余的人手，这就是找你来的原因。去那里拯救村庄，你会得到丰厚的报酬，我可以向你保证！%SPEECH_OFF% | %employer%被找到时正盯着他的一把剑。他把它拔了出来，在钢铁映射的倒影中盯着他的脸。%SPEECH_ON%当我被教导如何使用这种东西时，假定的对手是人。现在？人们谈论死者，谈论绿皮，谈论巨大的野兽！%SPEECH_OFF%他猛地将剑插进鞘里，然后连剑带鞘扔在他的桌子上。他用手梳理着头发。%SPEECH_ON%在这里%direction%的%objective%需要你的帮助。它已经被那些…东西给包围了！我不知道他们是什么，只知道他们在不停的杀戮！我没有多余的人手，但如果你去那里帮助这个小镇，那么你将得到最丰厚的回报！%SPEECH_OFF% | 你发现%employer%坐在一位修道院院长和一位文书中间，他们正用颤抖下巴、咬牙切齿的老人声调互相大喊大叫。既然死者已经重新爬起，关于生命和死后世界的争论就变得非常激烈。贵族看到你后猛地站了起来。他急急忙忙向你走来，争论在背后激烈地进行着。%SPEECH_ON%感谢旧神，你在这里，雇佣兵。就在这里的%direction%，%objective%正被一支可怕的军队围攻。是亡灵，还是肮脏的东西，我不关心，我只知道我没有人力来自己保护城镇。去那里并确保那些人的安全，我会付钱给你的！%SPEECH_OFF% | 你发现%employer%正监督着一群司事将棺材放入地下。棺材被牢牢地钉上了，而且很匆忙：钉子从木头上歪斜出来，边上还有刮痕。看到你，贵族走了过来。%SPEECH_ON%那个盒子的居民决定回来。杀了一个孩子和一条狗。在卫兵把它原放倒之前差点还杀了另一个。%SPEECH_OFF%一股黑色的液体从棺材底部喷涌而出。掘墓人跳开，砰的一声把木棺扔在了坟墓里。%employer%摇了摇头。%SPEECH_ON%随着所有这些'亡灵'的爆发，我的军力已经被分散了。我刚刚得到消息，这里的%direction%的%objective%是又一个受到攻击的目标。佣兵，你会去那里帮忙拯救它吗？%SPEECH_OFF% | 你发现%employer%正在研究散落在他办公桌上的一堆书。他摇着头，脖子的每一次扭动仿佛都是在翻页。心烦意乱之下，他急忙招手叫你进去。%SPEECH_ON%别开玩笑了，佣兵，我们没时间了。我需要你去%direction%的%objective%。我收到的飞鸟传书告诉我它被攻击了，如果描述方式正确的话，更多这些该死的'死者'活过来了。你有兴趣去吗？报酬将会高于你的付出。%SPEECH_OFF% | 你发现%employer%正看着一些石匠把大幅切割的石头放在一起。他和你握手。%SPEECH_ON%再建一座修道院，佣兵，看起来怎么样？%SPEECH_OFF%看起来不错，但你指出路对面还有另一个修道院。贵族笑了。%SPEECH_ON%死者再次在大地上行走，而周围没有足够的长椅来坐下受惊的人们。听着，我把你叫到这里是因为我的部队已经分散的太开，试图处理这个…奇怪的不死现象。在这里%direction%有一个叫%objective%的镇子迫切需要帮助。我收到的飞鸟传书告诉我它受到了攻击，而你似乎正是有兴趣拯救它的人。当然是有报酬的。%SPEECH_OFF% | %employer%与一位司库还有一位指挥官正在交谈。司库说还有很多克朗，但指挥官直言不讳地说周围没有人可以付钱去打仗。你就像曹操一样进入房间并立即被撘话。%SPEECH_ON%佣兵！现在立刻就需要你的服务！我们在这里的%direction%有一个村庄，是一个叫%objective%的地方遭到了攻击，呃，他们是什么？%SPEECH_OFF%指挥官倾身向贵族耳语回答。他重新站直。%SPEECH_ON%受到的攻击来自…'亡灵'，当然。你愿意去那里保护那些可怜的人吗？%SPEECH_OFF% | 你最终在马厩里找到了%employer%。他正在给马装上马鞍，很快就意识到你在保持距离。%SPEECH_ON%我们害怕吗，佣兵？%SPEECH_OFF%耸肩，你告诉他你从不在乎野兽。贵族耸耸肩作为回答，然后骑上马，双腿越过鞍尾。%SPEECH_ON%随便你，我收到飞鸟传书说%objective%有麻烦，麻烦指的是一大群亡灵在敲门，而我不认为它们在给那些镇民送牛奶。如果你去那里帮助保护村庄，你回来时会有一个大袋报酬等着你。%SPEECH_OFF% | %employer%被找到时正走在他防御工事的墙上。他身边的守卫，个个身形异常挺拔，背脊挺直，目光尽职尽责的寻找危险。一见到你，贵族马上招手让你过去。你们一起凝视着雉堞之间。大地在你面前展开，巨大的森林变成了点，山脉变成了箭头，鸟儿成群结队。%SPEECH_ON%这里的%direction%坐落着%objective%。信使告诉我说它正受到某种难以置信的力量的攻击，准确地说是亡灵。是的，太难以置信了。无论是什么在冲击他们的城墙，我都没有人手来进行处理。但是你，佣兵，你的服务在当下是最合适的。你感兴趣吗？%SPEECH_OFF% | 你发现%employer%和一个憔悴的文书正盯着石板上的一具无头尸体。它的头在一个角落里，眼球倾斜，钢棒从它半塌陷的头骨中伸了出来。看到你，贵族伸出了邀请的手。%SPEECH_ON%没什么好怕的，佣兵。我相信你已经听说了，死者再次在大地上行走，随之而来的是关于原因的大量猜测。%SPEECH_OFF%文书抬起头，打断了他的话。%SPEECH_ON%或者如何…%SPEECH_OFF%微笑着，贵族继续道。%SPEECH_ON%不论如何，在这里%direction%的%objective%正被这些怪物袭击，呃，或者说被前人类袭击？但我没有人手可以派去救援。然而，你非常适合这份工作。你愿意接受吗？%SPEECH_OFF% | 当你进入他的房间时，%employer%正在聆听一名文书的耳语。文书用黄疸的眼睛瞟了你一眼，然后继续他的谈话。等他说完，两个人都点了点头，然后年长者离开了。他走的时候没怎么看你。%employer%喊出声。%SPEECH_ON%很高兴你在这里，佣兵！现在真的是可怕的时刻。我的人散布在这片土地上，处理着各种可怕的邪恶。我敢肯定你已经听说过，那些'死者'或者是什么东西，开始再次行走于大地上。它们正在攻击%direction%的%objective%。我没有多余的人手，只能依靠你的服务了，佣兵。你会帮助拯救这个小镇吗？%SPEECH_OFF% | %employer%正在聆听一群农民的恳求。你只赶上谈话的末尾，这名贵族愤怒的将他们挥开。随着执法者的喊叫，守卫们紧锣密鼓地护送他们出去，手段目前是平和的，如果他们愿意的话也可以是暴力的。他们走出了门，没有遭到进一步的抗议，尽管一名农民看了你一眼，用口型说了'救救我们'，然后转身离开。%employer%挥了挥手。%SPEECH_ON%好啊，见鬼，这不是雇佣兵吗！时机正好，我贪财的朋友。我在这里的%direction%有座镇子名叫%objective%，正急需帮助。它目前处于亡灵的围攻之下，至少他们说是亡灵。如果你去那里帮助保卫它，这里会有一大袋克朗等着你。你怎么说呢，恩？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{这对你来说值多少钱？ | 只要价格合适，我们可以保卫%objective%...}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 恐怕%objective%只能靠他们自己了。}",
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
			ID = "UndeadAtTheWalls",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_29.png[/img]{在接近%objective%时，%randombrother%突然在领头的位置叫出声来。%SPEECH_ON%长官，快来！%SPEECH_OFF%你赶紧去他那边往前看。那个城镇被一大片苍白的、摇摇晃晃、呻吟不断的亡灵给彻底包围了！%companyname%必须要杀穿它们才能进入城镇。 | 有一个人朝着%companyname%这边小跑过来。他捂着一只胳膊，鲜血从头上流下。他大喊。%SPEECH_ON%走，走开！这里除了恐怖什么都没有！%SPEECH_OFF%%randombrother%把这个陌生人扔在地上，拔出武器将他控制住。当你往前看时你让佣兵停手，%objective%已经被很多亡灵包围了。%companyname%必须要快速行动！ | 你在最后一刻及时赶到：%objective%的城墙已经遭到亡灵的攻击！ | 走过一条小道，你突然停下来。在你前方，%objective%正被一大群亡灵所包围。靠近你这边，有若干不知如何离群了的亡灵在游荡。%companyname%需要杀出一条通往%objective%的路！ | %objective%的城墙异常灰暗。等等，那不是木头，是亡灵！让你恐惧的是，这些苍白的怪物已经开始攻击，但你还有时间杀条路进去并拯救%objective%。拔出剑，你下令%companyname%准备战斗！ | 一群毫无阵型的亡灵已经在%objective%城墙外徘徊。你能看到防御者的头从城防后面探出来，并试图尽可能的不要暴漏自己。拔出剑，你告诉%companyname%他们必须一路杀进城里。 | 少量亡灵已经来到了%objective%的门口！门楼上的卫兵向你挥手示意，然后将手指竖在嘴唇上，最后指了指下面。看来这些可怕的怪物还没有开始攻击，或许是因为他们没注意到？你不确定，但你知道%companyname%只有一条进城的路，而且需要用剑开辟！ | 幸运的是，你发现%objective%仍然屹立不倒。不幸的是，城墙正在被一群苍白的亡灵攻击。%companyname%必须奋力杀入城中！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.spawnUndeadAtTheWalls();
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ADireSituation",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{你发现%objective%内的守卫们看起来好像已经有好几周都没有睡觉了，但他们却在笑着。显然，你们最终穿越了他们大门的糟糕旅途多少带来了点欢乐。 | %companyname%最终跌跌撞撞的通过了正门。里面的守卫们带着有趣的沮丧感，仿佛他们刚走出一场恐怖的战斗就目击了一个奇怪的玩笑。其中一个人拍了一下你的肩膀。%SPEECH_ON%雇佣兵，那看起来非常有趣，我手下的人需要这种提振，谢谢你。%SPEECH_OFF% | 放眼四顾，你看到守卫们都脆弱且骨瘦如柴，守卫着看上去已经半死不活的镇民。泥泞的道路上散布着粪便，垃圾，还有动物尸体。妇女和儿童正在一处临时墓地哭泣：一处沟渠，上面有罗列着名字的卷轴，新鲜的墨水刚刚又加上了另一个名字。 | 你进入%objective%的大门，发现几个守卫用瘦弱的手扶着长矛站岗。他们的衣服在骨架周围飘动，仿佛窗帘一般。一股饥饿感在空气中弥漫着，你能健康的身在此处就能引来饥渴的目光。其中一名防御者友好地跟你打招呼。%SPEECH_ON%我们很疲惫，也有点饥饿，但我们会撑过去的。我们还会战斗下去，你别怀疑这点。%SPEECH_OFF% | 当你穿过%objective%的大门，第一个欢迎你的是一只狗。它舔了舔你的腿并深深地闻着你的裤子。一个男人突然大喊着举着棍棒冒出，很快人和动物在泥泞的道路上跑了出去，两者似乎都在狂吠。那只杂种狗躲过了饥饿人群的迟缓拦截，然后消失得无影无踪。一个面带笑容的卫兵走了过来，用棍子支撑着自己。%SPEECH_ON%晚上好，佣兵。食物库存有点低，那只狗在一个到处空腹的地方是一个不错的猎物。%SPEECH_OFF%你问他们还能不能战斗，这个男人笑了。%SPEECH_ON%见鬼，我们只剩下战斗了！%SPEECH_OFF% | 穿过正门进入%objective%就像穿过常态的面纱进入地狱的深渊。村民们蹒跚而行，除了变得越来越饿外什么也做不了，而守卫们则像分享食物一样分享着笑话，一边抓着肚子一边痛苦的笑着。防御负责人走了过来。他胡须拉碴，满是疤痕，神情呆滞，眼神看上去很劳累。虽然他就站在你一英尺之外，但他就像从另一个世界里盯着你。%SPEECH_ON%很高兴你到了，佣兵。这段时间我们肯定需要你的帮助。%SPEECH_OFF% | 你穿过%objective%的大门，发现地狱本身在等待着你。守卫们如同疯人架起的骷髅一样各就各位。村民们则要么闲站着，要么躺在土里，要么用头顶着墙靠着。孩子们站在茅草屋顶上翻找茅草里的虫子。指挥防御的尉官直言不讳地欢迎了你。%SPEECH_ON%感谢来助，佣兵，但你应该呆在家里。%SPEECH_OFF% | 随着门卫们费力地推动着机关，%objective%的正门缓缓的打开。你走进镇子，发现一些司事正在路边挖一个巨大的沟。他们把尸体丢进去，并准备着点火焚烧尸体。指挥防御的尉官走了过来。%SPEECH_ON%有时死人会又动起来，但我们知道骨灰不会。好吧，也许骨灰也会，但它们对人造不成伤害。%SPEECH_OFF%你想提一下那可怕的臭味，但意识到他们可能很久以前就习惯了。 | 穿过%objective%杂乱的大门，你看到了一个或许早就屈服于亡灵大军的城镇。村民们沮丧且毫无目的地蹒跚着。几个守卫站在一辆货车旁边，挨家挨户分配口粮。你看到有些防御者在城防上入睡，手臂半悬在垛口上并握着武器，看起来像是被扔在角落里的玩偶。指挥防御的尉官走了过来。%SPEECH_ON%感谢来助，佣兵。我们中很多人都认为你不会来，毕竟这就是地狱。%SPEECH_OFF% | %objective%的正门打开了，你们穿了过去。在里面，你看到两名守卫正把一具尸体拉向一个烧着的尸体堆。一个女人抓着死者的靴子，乞求守卫让她再看一眼。他们不理会她，把尸体扔进火里，她则跌倒在火堆前，在她丈夫的皮肤噼啪作响时晕倒了。指挥防御的尉官走了过来，他拍了拍你的肩膀。%SPEECH_ON%很高兴你在这里，佣兵。%SPEECH_OFF% | 穿过%objective%的大门后，一个人抓住了你的衣领。%SPEECH_ON%你身上有食物吗？嗯？我能闻到，或者说你就是食物本身？%SPEECH_OFF%一个守卫用长矛的尾部将他推开。那个疯子揉着肚子，一边抓眉毛上的虱子吃一边说。%SPEECH_ON%你们带来了更多的剑，但是我们需要的不是剑！%SPEECH_OFF%警卫们把这个人带走了，同时这里的尉官走了过来。%SPEECH_ON%别理他，他过去比较胖，所以最近事态对他冲击很大。我们这里还有食物，只是必须要限量。你们这些佣兵的剑很受欢迎，毫无疑问，你们很快就要用到它们了。%SPEECH_OFF% | 你踏进%objective%的大门，闻到了肉被烧焦的气味。里面有一个还在阴燃的尸体堆，一名守卫站在旁边用棍子搅拌着灰烬，就像一个厨师炖着大锅里的东西。村民们站在烧焦的残骸边上，一边挥泪一边做着宗教仪式。这个城镇的尉官走了过来。%SPEECH_ON%攻击可能来自任何地方。死者会原活过来，而我们这是一个备受折磨的城镇。这一堆尸体曾是一家人。妻子在夜里去世，然后在黑暗的掩护下不断地吃啊吃。我们不得不烧掉所有的尸体。%SPEECH_OFF%尉官看到你皱了皱眉头，他微笑着放松气氛。%SPEECH_ON%所以，你今天过的如何？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们需要为即将到来的攻势做好准备...",
					function getResult()
					{
						this.Flags.set("Wave", 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 8.0);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave1",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_29.png[/img]{就在无聊的等待已经快要杀死你的时候，另一样东西出现并接手了这项工作：亡灵！%objective%的钟声响起，守卫们带着一种未曾预料的活力行动了起来。你命令%companyname%做好战斗准备。 | 正当你看着兄弟们打牌的时候，警钟响起。你瞟向当地的修道院，看到一个虚弱的老人正使出浑身解数鸣钟。守卫们以新的活力回应钟声。一个人在门楼里呼喊。%SPEECH_ON%他们来了，拿起武器，拿起武器！%SPEECH_OFF% | 就在你以为你已经和镇民一样就是站在那里慢慢地死亡时，大门打开，一个斥候从中飞驰而入。疲惫的马匹倒地并在泥地里滑动，骑手则跳下来安然无恙。他站起来大叫着。%SPEECH_ON%亡灵来了！我们必须做好准备！%SPEECH_OFF% | 一名站在瞭望塔上的人大喊起来。%SPEECH_ON%信息到来，小心头顶！%SPEECH_OFF%你抬头看到一支箭弧形地划过天空，晃动着落到离你只有几英尺远的泥地上。尉官从箭上取下卷轴，越读口唇越白，最后他把纸扔到一旁。%SPEECH_ON%是时候做好准备了，雇佣兵，死人来了。%SPEECH_OFF%他转向他手下的士兵。%SPEECH_ON%%objective%的保卫者们！拿起武器！%SPEECH_OFF% | 一个守卫大喊起来。%SPEECH_ON%大门打开了，难民进入中！%SPEECH_OFF%一小群零散的孩子蹒跚着穿过倾斜的大门。其中一人解释说，一群苍白的人就要过来了。尉官盯着你。%SPEECH_ON%最好让你的手下做好准备，佣兵。%SPEECH_OFF%亡灵正在朝这里前进，准备战斗！ | 一个斥候进入了%objective%，从一匹双腿沾血缺了尾巴的马上下来。这名骑手抱着一支缺了手的手臂，他的脸被削去了一只耳朵和一只眼睛。尉官冲了过去，两人交谈后斥候昏迷了过去。尉官叹了口气并站起来。%SPEECH_ON%亡灵正在进攻，准备战斗！将那匹马从痛苦中解脱！%SPEECH_OFF%你点了点头，命令%companyname%为战斗做好准备。当佣兵们进行准备时，一个穿着屠夫衣服的人走过来，用切肉刀将这匹马砍死。中尉拍了拍你的肩膀。%SPEECH_ON%嘿，如果能活过这波，我们至少会有东西可吃。%SPEECH_OFF% | 你在尉官的旁边坐下。他掰开面包。%SPEECH_ON%自你来到这里，一切变得异常寂静。%SPEECH_OFF%你咬了一口，问他是否在暗示你是死者的双重特工。他笑了。%SPEECH_ON%在最近这段日子可不能太确信。%SPEECH_OFF%就在这时，一个钟楼敲响，守卫冲向城墙，哭喊声和尖叫声响起，亡灵正在进攻！\n\n中尉套上头盔并将你扶起来。%SPEECH_ON%是时候证明你的价值了，佣兵。%SPEECH_OFF% | 一个守卫拿着皮革包裹的长镜，开始透过城墙的垛口窥视。他的手开始颤抖，手中的长镜摆脱皮革束缚摔碎在了地上。他指着前方尖叫道。%SPEECH_ON%亡，亡灵来了！准，准备战斗！敲响警钟！%SPEECH_OFF%你从城墙向外望，即使没有望远镜，也可以看到苍白色的浪潮正在向你袭来。你让守卫冷静下来，然后赶去让%companyname%准备好战斗。 | 一群狗来到了%objective%并嚎叫着想要进来。饥饿的居民们满足了它们的愿望，然后这些狗一进来被拿起刀镰的人们屠杀了。尽管如此，这些狗仍在不断往里钻，试图靠打斗和撕咬在屠宰场里找到一处安全之所。你朝城墙外看去，发现了它们愿意冒如此风险的原因：亡灵来了！它们正从地平线上蹒跚而来。\n\n你向钟楼上的一个人吹口哨并指向这一幕。他立刻站直了，速度快到头盔掉了下来，在石塔上发出叮当声。他匆促地开始鸣钟，巨大的钟声沉默了下方残酷的屠狗骚乱。人和狗都停下来抬头，一片沉闷的寂静笼罩着他们。慢慢的，死亡的声音，呻吟声和咆哮声渗透到空气中。守卫的尉官跳了出来，武器早已拔出。%SPEECH_ON%拿起武器，伙计们！拿起武器！%SPEECH_OFF% | 有一具亡灵死尸在%objective%的城墙外游荡。守卫们轮流用箭朝它射击。%SPEECH_ON%看那个，射中了他的脚！%SPEECH_OFF%另一位守卫准备射击。%SPEECH_ON%他还在走，瞄准他的头，你个笨蛋！%SPEECH_OFF%这次射击准确无误，箭矢穿透了空心的头颅，发出柔和的扑哧声。死尸的平衡短暂丧失，停顿了一下，然后又继续前行，仿佛刚刚想起了自己要干什么。另一名守卫摇了摇头，准备射击。他闭上了一只眼睛，然后缓缓地睁开了。他的手开始颤抖，箭杆敲打着木弓。%SPEECH_ON%拿，呃，拿起武器！拉响警报！%SPEECH_OFF%你从城墙向外看，发现一片灰色浪潮在地平线上浮现，颠簸着前进。亡灵正在进攻！ | 城镇十分安静，火堆发出微弱的噼啪声。你看着人们烧烤串在木叉上的老鼠，并切下肉块分享。看够了，你爬上城墙去找守卫们的尉官，此时他正用望远镜观察地平线。他冷峻的放下了望远镜。%SPEECH_ON%奶奶个腿的，它们来了。%SPEECH_OFF%他把瞄准镜递给你，你也看了下。一群因镜片扭曲了的的亡灵正在向%objective%蹒跚而来。尉官拿回了望远镜。%SPEECH_ON%是时候挣你的钱了，佣兵。%SPEECH_OFF% | 一个女人的尖叫声吸引了你回头看。正好看到一个男人从塔上跃下，然后被绳子扯断了脖子。尸体晃动着，在石墙上碰撞和扭曲。守卫们的尉官抿了抿嘴唇然后吐了口唾沫。%SPEECH_ON%该死，他应该在盯着地平线。%randomname%！爬上去，把绳子切了放他下来，然后接替他的岗位！%SPEECH_OFF%另一名守卫咕哝着照着命令去做，但当他爬到哨位时，他不再遵守任何命令。相反，他开始歇斯底里地喊叫。%SPEECH_ON%长官！长官！它们来了！所有那些苍白的家伙，它们来了！%SPEECH_OFF%尉官呼喊他的手下准备战斗，你也呼喊你的手下。这个人带着寄予希望的神情转向你。%SPEECH_ON%无论他们支付了你多少，我希望你每枚克朗都配得上，佣兵。%SPEECH_OFF% | 其中一个守卫找到了老鼠洞，这引起了人们沉重且难以置信的欢庆。在镇民欢呼和哭泣的同时，老鼠们被穿刺并烧烤的尖叫声愈加刺耳，守卫们的尉官走了过来。他微笑着观察着这个场景，但当一声尖叫穿透空气时他的脸色变了。所有人都转向了城墙，那边一个守卫正指着地平线，即使是在你站的地方也能看到他恐惧的目光。%SPEECH_ON%死人来了！他们要杀死我们所有人！我们没有足够的人手！%SPEECH_OFF%尉官告诉那个人放勇敢点，然后悄悄地转向你。%SPEECH_ON%准备好你的手下，佣兵，然后证明你配得上他们付给你的钱，不论多少。%SPEECH_OFF% | 一名守卫试图逃跑被捕，他跪在那的同时守卫们的尉官带着失望的神情来回踱步。%SPEECH_ON%我们一个多余的人手都没有，而你选择这样对待我们？%SPEECH_OFF%一个镇民扔出一团泥巴，虽然失手了，但意图很明显。%SPEECH_ON%活埋他！这样就少张吃饭的嘴！%SPEECH_OFF%就在农民们开始变得吵闹之际，城镇的钟声开始响起。一个站在哨塔上的人尽力大喊。%SPEECH_ON%它们来了！亡灵，就在地平线上！%SPEECH_OFF%尉官看着那名逃兵。%SPEECH_ON%如果你想赢回你的荣誉，那就现在。你打算战斗吗？%SPEECH_OFF%这个人迅速的点了点头。尉官转向你，但你举起了手。%SPEECH_ON%你无需问%company%这样的问题。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保卫城镇！",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave2",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_73.png[/img]{正当%companyname%休息并清理刀锋上的污秽时，钟楼上传来了又一个信号。亡灵再次进攻！ | 守卫们的尉官四处巡视以确保他的手下们在休息和喝水。正当他来找你谈话时，城镇的钟声响起，守望人大叫又一次攻击来袭！你笑着拍了拍尉官的肩膀。%SPEECH_ON%我们只是做我们该做的。还能更简单吗？对不对？%SPEECH_OFF%尉官点头，然后去让他的手下做好准备。 | 你看着%randombrother%清洗他的刀锋上的苍白肉块和浸血布料。%SPEECH_ON%旧神在上，它们真是留下了一团糟。%SPEECH_OFF%就在这时，一名守望人吹哨并大喊亡灵再次进攻！雇佣兵愤怒地甩掉了他武器上的一块大脑碎块。%SPEECH_ON%就在我才刚开始看到自己倒影的时候！%SPEECH_OFF%你帮助这个人站起来，拍了拍他的肩膀。%SPEECH_ON%相信我，没什么好看的。%SPEECH_OFF% | 其中一名守卫将一个硬面包撕成屑，开始分给大家。另一个守卫问他食物从哪里来，他直截了当地回答：%SPEECH_ON%在其中一个活死人的口袋里找到的。%SPEECH_OFF%吃饭的人都吐掉了食物，一个人甚至开始呕吐。你看着这些人开始打架，但很快被一名岗哨的哨声所打断。其中一座塔上的守卫正在指向地平线。%SPEECH_ON%他们又来了！准备战斗！%SPEECH_OFF%准备好战斗，外加尽可能不要从把你当午餐的尸体上搜刮食物。 | 当你的手下们休息和恢复时, 一名岗哨大喊：%SPEECH_ON%它们又来了！%SPEECH_OFF%战争很少能给人一个适当的休息，尤其是与亡灵的战争。 | 你看到%randombrother%正在用泥土擦拭他的脸。他顿了顿，瞟到了你的目光。%SPEECH_ON%泥浴，长官。你知道，为了清洗掉...血浴。%SPEECH_OFF%你翻了个白眼。就在这时，城镇的钟被敲响了，一名岗哨大喊起来，他发现另一次攻击即将来临！你告诉佣兵收尾他的'沐浴'，并准备战斗。 | 你发现%randombrother%正将灰色的内脏沫从他耳朵后面清洗出来。%SPEECH_ON%妈妈总是说要洗耳朵后面，但我想她没预见到这样的一团糟！%SPEECH_OFF%你告诉他，好的母亲是能够预见一切的。这个人大笑起来，然后点点头。%SPEECH_ON%是啊，她只会对我怒吼，问我从哪沾上的这一团糟！%SPEECH_OFF%就在这时，塔上的一个岗哨喊道亡灵再次进攻。你转向这名佣兵。%SPEECH_ON%好吧，是时候再次把自己弄脏了。%SPEECH_OFF% | 你发现其中一个农民正在一面石墙上刻线。看到你，他向你解释道。%SPEECH_ON%这只是在记录失去的人们。已经有这么多人了，我分不清他们的名字，但是我可以记数。%SPEECH_OFF%你顺着墙看过去，发现名字逐渐变成了数字。%SPEECH_ON%我们尽可能的记住他们，你知道吗？%SPEECH_OFF%你点了点头，然后岗哨喊叫起来，宣布另一次攻击即将到来。这个农民以请求的神情抓住了你的胳膊：%SPEECH_ON%告诉我你的名字，到时候我会替你刻上的。%SPEECH_OFF%你挣脱了他的手臂并怒视着他，让他畏缩了起来。%SPEECH_ON%我是一名杀手而不是你的朋友，你这个傻瓜。我的剑刃不碰你脖子的唯一原因是没人付钱。如果你再问我那个问题，我就会在那面墙上写上你的数字，并且是免费的，懂吗？%SPEECH_OFF%那个人点了点头。你也点了点头，离开去让你的雇佣兵们准备好战斗。 | 正当你和人们安下心来休息时，岗哨叫喊起来，城镇的钟也响了起来。另一次攻击即将到来！你命令%companyname%做好战斗准备。 | 你爬上%objective%的城墙，找到了守卫们的尉官。他叹了口气。%SPEECH_ON%它们又在攻击了。%SPEECH_OFF%你望向地平线，确实又有一波攻击正在接近。尉官去召集他的手下准备战斗，你也一样。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保卫城镇！",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave3",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_73.png[/img]{当所有的战士都在休息时，其中一名岗哨嗓音沙哑心灰意冷的喊出声来。%SPEECH_ON%又来了，它们又来了……%SPEECH_OFF%如果要%objective%幸存下去，%companyname%必须迎接挑战！ | 守卫中的一人凝视着火焰，双手颤抖。他自言自语，但渐渐变得更响亮，使大家都能听到。%SPEECH_ON%没错，我们要这么做！我们可以和谈！我们可以和他们谈判！我来谈，我去和他们谈！%SPEECH_OFF%这个人站了起来，几个人试图把他拉住，但他逃脱了。他跑到城墙上，一头扎了下去。你赶紧跑过去看着那个精神错乱的傻子穿过田野狂奔，直奔一大群亡灵！另一名守卫一边看一边开始发抖。%SPEECH_ON%旧神在上，还有更多要来？它们怎么可能有这么多？%SPEECH_OFF%你无视了他的话，看着疯子消失在尸群中。他们的队伍踉跄着把闯入者消耗掉，然后继续前进，就像一个苍白的池塘因为一块岩石的碰撞而短暂的波动。你高声呼喊着。%SPEECH_ON%战斗吧，伙计们！让我们再次投身战火之中！%SPEECH_OFF% | 岗哨中的一员发现了又一波即将到来的攻击！他尖叫到嗓子破音，然后昏倒了。%objective%的民兵已经要无计可施，希望这是最后一次攻击！ | 一名守卫吹响了警报，更多的亡灵正在接近。守卫们的尉官摇了摇头。%SPEECH_ON%旧神在上，它们没完没了吗？今天你确实是挣得了报酬，佣兵。%SPEECH_OFF%你想开个玩笑，说你应该赚更多的钱，但时机似乎不太合适。相反，你点点头，离开去让%companyname%准备好再次战斗。 | 当你和守卫的尉官交换战争故事时，一个民兵走了过来。你注意到他是负责看守城墙的人。他讲话直接了当。%SPEECH_ON%长官们，它们又攻击了。%SPEECH_OFF%接着他就转身向城镇军械库走去。你起身并帮助尉官也站起来。他带着简单而庄重的微笑拍了拍你的肩膀。%SPEECH_ON%再次投入战斗，是吗？%SPEECH_OFF%你只能耸耸肩。%SPEECH_ON%这就是我们来这的目的。战场见，尉官。%SPEECH_OFF% | 你凝视着%objective%城墙之外，看到又一波亡灵接近。之前袭击所带来的刺激已经消散殆尽，现在守卫们默默地看着这些尸体们向前踉蹌。守卫的尉官来到你身边。%SPEECH_ON%很荣幸与你并肩作战，佣兵。%SPEECH_OFF%你点了点头，回应道。%SPEECH_ON%嗯，荣幸，确实。%SPEECH_OFF%尉官看着你。%SPEECH_ON%你在想着你的报酬，不是吗？%SPEECH_OFF%你再次点头回应。%SPEECH_ON%我在想它所能买到的东西：暖和的床，更暖和的饭，还有更更暖和的女人。%SPEECH_OFF% | 你站在%objective%城墙上，遥望地平线。又一波攻击即将来临，但面对它再无兴奋。没有尖叫，也没有歇斯底里，都不再有了，就是简单的又来了。这只是一股肿胀、蹒跚、畸形的尸体大军，缓慢且不规律的向前移动着，仿佛在寻求被砍倒。你下令%companyname%做好准备。%randombrother%一半身子都被亡灵的碎末所浸染，他大大的张开双臂。%SPEECH_ON%长官，我觉得我们已经胜利了。%SPEECH_OFF%人们笑了，接着开始笑个不停，民兵们也加入其中，很快欢闹的气氛填满了空气，越来越近的亡灵呻吟声也加入其中，疯狂引发着疯狂。 | %randombrother%走近一个营火，把长长的内脏块从他的肩膀上甩了下来。一个农民眼巴巴地看着那些内脏，仿佛随时都准备好了开饭。雇佣兵笨拙的噗嗤一声坐下来。%SPEECH_ON%我要是再看到一个行尸走肉向我走来，仿佛这是午餐时间，我就……%SPEECH_OFF%他还没来得及说完，一个守卫在城墙上吹响了号角，发出了能让所有人听到的警报。他把号角放在身边，脸色通红，上气不接下气。%SPEECH_ON%……亡灵……它们又开始攻击了！%SPEECH_OFF%那个雇佣兵的脸一下子僵住了。他一言不发的站起来，慢慢地去武装自己。 | 一个农民站在%objective%的门口，他正在与门卫争论。%SPEECH_ON%放我出去！你们肯定已经打败了他们，我想回到我的农场。你们要知道，我有两头牛！%SPEECH_OFF%这个人两个手指向前指着，以防听众没有理解。他们耸了耸肩，打开了大门，但农民没有动。相反，他向后退了一步。%SPEECH_ON%转念一想，我的牛可以等着我回家。%SPEECH_OFF%在城墙外，你可以看到一大群亡灵从地平线上冒出来。不一会儿，警报信号传出，%objective%的人们忙碌着，拿起武器准备进行又一场战斗。 | 你沿着城墙见到守卫们的尉官。他正在和一些民兵分享面包，并给了你一块。你谢绝了并问他地平线上是什么。这个尉官指向田野。%SPEECH_ON%哦，没什么，它们只是又在进攻而已。%SPEECH_OFF%他递给你一个望远镜。透过镜头，你看到一大群尸体正向%objective%蹒跚而来。你放下望远镜问这个人为什么还没拉响警报。他耸耸肩。%SPEECH_ON%给这些人多一两分钟的时间。行尸走肉可能想要杀死我们所有人，但他们对此并不着急，你懂吧？%SPEECH_OFF%可以理解。你吃下了之前给你的那块面包，然后在一两分钟后去让%company%做好战斗准备。 | 其中一个民兵把一个活死人带进了城墙里面。他用链子牵着它，并将尸体的手臂砍掉了，本来是嘴的地方有一条长而耸拉的舌头。守卫们的尉官走了过来。他的脸涨得通红，像快要溺死需要呼吸的人那样进行咒骂。%SPEECH_ON%你他妈的大屁股混球屎蛋子在干什么？%SPEECH_OFF%那个民兵拽了下链子，将不死者拉倒在地上。他紧张地为自己辩解。%SPEECH_ON%也许我们可以从它们身上学到一些东西？了解它们为什么行动，了解怎样去，呃，让它们活过来？%SPEECH_OFF%在争论继续持续之前，一个喊声打断了人们。一名守卫站在哨塔上警告着另一次攻击。尉官转过身，拔出武器，急速将那个死人斩首。它没下巴的脑袋从脖子上滚落，舌头像是罐子里的蛇那样摆动着。尉官用力地拉住民兵的衣领。%SPEECH_ON%你别他妈再搞这种玩意了，明白吗？它们已经死了，就这么简单。现在他娘的拿起你的武器。%SPEECH_OFF%%companyname%已经准备好了，不需要你去讲。 | 你发现镇子里的铁匠正在锤炼%objective%'最好'的武器。他健壮的胳膊挥舞着锤子和夹钳，就好像它们是木棍一样。他手腕上有一个双纽线形状的纹身。飞舞的火花就好像萤火虫一样，他很快就注意到了你投射在他的露天铁匠铺周围的阴影。%SPEECH_ON%嘿，佣兵。%SPEECH_OFF%十分好奇并且确实无聊，你问他最近如何。他把一些钢铁压平并翻转，重复这个过程。%SPEECH_ON%自然没什么好的，倒也没那么糟。这个看着怎么样？%SPEECH_OFF%铁匠把刀子拿起来让你评估。在你回答之前，警报的钟声敲响，一大群人行动起来去保卫镇子。民兵们开始不断跑过，从他店铺的挂钩上拿走武器。他放下了刀子，笑了。%SPEECH_ON%噢，走吧，去打仗吧，佣兵。那只是一个修辞问题。%SPEECH_OFF% | %objective%的文书手拿一张羊皮卷四处走动。他用一个仆人的背作为衬垫写下他的所见。你很好奇在这个混乱的地方他到底看到了什么？这个人直截了当地回答你。%SPEECH_ON%研究情感。我感觉到悲伤是一种疾病，并且它正在这里蔓延。%SPEECH_OFF%这对于一个好奇而来的问题是一个奇妙的答案，所以你又追问了一遍他的研究。他忽视了问题并上下打量着你。%SPEECH_ON%以我的衡量标准，你的健康状况很好，佣兵。好吧，除了你的身体，你走起路来像一只残疾的狗，左转时会皱起眉头，这很容易注意到。但我可以看到痛苦没有阻碍你。事实上，我认为它...驱使着你。你在为失去的东西进行弥补吗？%SPEECH_OFF%在你回答他打算让他闭嘴之前，警报突然响起，人们开始忙碌起来为下一次亡灵的攻击做准备。当你回头时，抄写员已经走了，并站到了远处的角落里，正用他的尖羽毛笔猛烈地在他愁眉苦脸的仆人背上书写着。 | 当你准备安顿下来休息时，警铃响起，城墙上的守卫们伴随着大量的惊叫行动了起来。看起来亡灵再次发起了进攻！你匆忙赶去让%companyname%做好再次战斗的准备。 | 你注意到城墙的尖端被秃鹫染的一片漆黑。这些大鸟凝视着城镇，就像一支穿着斗篷的丧葬队伍。突然，一个民兵从哨塔的门里走了出来，用一根木棍砸中了其中一只鸟。随着一声短促的尖叫，其它秃鹫挪动着双爪，就像荷叶在摇曳的池塘上一样。接着，这个民兵又砸中第二只鸟的脑袋，这些食腐动物明白过来发生了什么，纷纷飞走。这个猎人抓住猎物的爪子并自豪地返回了哨塔。%SPEECH_ON%嘿。%SPEECH_OFF%守卫们的尉官轻轻拍了拍你的肩膀。当你转过身时，他朝自己肩头后面伸出大拇指。%SPEECH_ON%亡灵又要攻击了，我命令手下不要敲响警报。谁知道我们歇斯底里的叫喊会不会把更多那些混球引到这来。%SPEECH_OFF%貌似是个明智的主意。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保卫城镇！",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{你取得了胜利，但民兵可能输掉了战争：城镇守卫的损失太多，更多的居民正准备离开村庄，而不是留下来帮助守卫！ | 胜利，但代价是什么？在这场战斗中有太多的民兵阵亡，以至于%objective%的任何市民都不愿意接任他们的位置！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "总之是个胜利。",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 3);
						this.Flags.set("MilitiaStart", 3);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{战斗已经赢了，但是不是没有代价的。一些%objective%市民报名参加保卫城镇的队伍，而其他人正在打包准备离开。 | 你取得了战斗的胜利，但亡灵也让你付出了代价。虽然一些市民同意帮助民兵补充人员，但同样数量的人保持了距离并为最坏的情况做准备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "总之是个胜利。",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 6);
						this.Flags.set("MilitiaStart", 6);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_80.png[/img]{多么辉煌的胜利！不仅亡灵被击退，你的成功还让许多%objective%的市民加入了民兵，参加未来的战斗！ | 亡灵被击败的如此彻底，以至于许多%objective%的市民加入了民兵，以协助即将到来的战斗！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "胜利！",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 8);
						this.Flags.set("MilitiaStart", 8);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Ghouls",
			Title = "在%objective%…",
			Text = "[img]gfx/ui/events/event_69.png[/img]{当你准备战斗时，你注意到亡灵的队伍中有奇怪的身影：食尸鬼。这些生物一定在跟随亡灵大军以吃下它们杀死的任何东西，就像海鸥跟随着海上的渔船一样。 | 食尸鬼！这些恶心的生物在尸体中间蹦蹦跳跳地走着，这些可恶的野兽毫无疑问正在寻找下一餐。 | 不死族留下了很多死亡和垂死的人，毫不奇怪地，食腐动物开始跟随它们。在这种情况下，跟随着的是食尸鬼，这些丑陋的野兽正在咆哮和嘶吼声中渴望着下一餐。 | 如果你洗劫一间储藏室，老鼠一定会来。现在亡灵正在攻击%objective%，它们已经拥有了一批随从：食尸鬼。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保卫城镇！",
					function getResult()
					{
						this.Contract.spawnGhouls();
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TheAftermath",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{你凝视着战场，遍地都是死人、垂死的人、不死者和垂死的不死者。有心跳能喘气的活人们在尸体间徘徊，了结一切有着复活迹象的东西。随着战斗结束，这个城镇得到拯救，%employer%现在应该正等着你。 | 随着战斗结束，这个城镇得到拯救。是时候回到%employer%那去领上那一大笔报酬了。 | %objective%比你所知道的任何城镇都更像一个被洪水淹没的墓园。新旧尸体被冲的到处都是，鲜血和腐烂的污垢浸润着每个角落，恶臭让你想起曾在小溪旁发现的死狗，骨头滴落着腐败液体，身体被小龙虾及蛆虫啃食。\n\n不间断的攻击终于停止了，%objective%目前看起来安全了。%employer%现在应该正在等你，而你没有理由不尽快逃离这个可怕的地方。 | 终于，城镇被拯救了。农民们手拿长棍在战场上走来走去，仿佛鹈鹕试探危险的最危险的水域那样戳着土地。%randombrother%走了过来，一边清洗着刀刃上的污物，一边问是否该回去找%employer%了。你点了点头，回去领报酬当然还是越快越好。 | 战斗结束了。死者中既有农民也有民兵，每个尸体都有幸存者前来用哀号的影子将其裹好。至于那些不死者，好吧，无人关心。它们的尸体倒在那里仿佛它们的前来毫无目的，只是单纯给所触碰的一切带来了毁灭。它们尸体的景象和他们所代表的无意义混沌让人感到愤怒。不想再多呆一秒，你告知手下准备好回去找%employer%。 | 你和%companyname%作为胜利者站到了最后。这个城镇及其居民目前将幸存下去，你们可以回取找%employer%领取报酬了。 | 守卫的尉官感谢你拯救了城镇。你提到你在这里的唯一原因是有人付了你钱。他耸耸肩。%SPEECH_ON%我感谢雨水，即便我对其毫无掌控，不管你是否喜欢，我都要感谢你，雇佣兵。%SPEECH_OFF% | 战斗已经结束了，并且幸运地取得了胜利。亡灵的尸体如此无序的散布在地面上，以至于它们看起来与几个小时前踉跄的模样几乎没有什么不同。但是，那些刚刚死于战场的人则没有分享这种普遍的消沉。他们由哭泣的妇女和困惑的孩子照看着。你从这场面转开视线，命令%companyname%准备好回去找%employer%。 | 一名死者躺在你的脚边，旁边是一个亡灵的尸体。这是最奇怪的景象，因为他们均已不在属于这个世界，但是这个人还有生命。回想一下最近的记忆，你看到他挥舞着武器直到最后一刻，对于一名战士来说这是一种高尚的死法。但这个亡灵的尸体呢？它又如何呢？你会记住它用裸露的牙齿撕开了一个人的喉咙。也许这个尸体除了那个瞬间也有过不同的时候，当它还有家人时候，当它还是个为世界做好事的善人的时候。但是，现在它仅仅只是一个撕咬喉咙的怪物。它只会被铭记为这样。\n\n对%objective%不停歇的攻击终于停止了，于是你匆忙整理了战团，准备回到%townname%的%employer%处领取酬劳。领钱总是比再看去看这些该死玩意要好。 | 什么是死人？如果是被杀了两次的死人呢？那被杀死三次又怎么说呢？不幸，厄运，以及一个笑话。\n\n你走在战场上，召集着%companyname%的佣兵。%objective%镇目前得救了，现在你该回到%townname%的%employer%那里领取应得的薪水了。 | %randombrother%用一块布擦了擦额头，留下了一层恶心的苍白色污渍。%SPEECH_ON%该死，那是什么？是脑浆吗？长官，你能帮我弄干净吗？%SPEECH_OFF%你帮助那个人清理了自己。他站起来，双臂展开。他仍然被血、内脏以及其他无法形容的东西覆盖的满满的。%SPEECH_ON%我看起来怎么样？%SPEECH_OFF%他的笑容在暗淡的天空中闪耀着月亮的光辉。你拒绝回答他，只告诉他去找到其它佣兵。随着%objective%暂时得救，%employer%会期待战团返回%townname%，而战团则应该期待一笔应得的报酬。 | %randombrother%来到你身边，你们两个一起看着战场。你已经看到死者的家属出来寻找他们失去的亲人。他们悲哀的哭声尖锐而真实，非常令人不安的让人从嚎叫、呻吟的亡灵那种消沉中解脱出来。这个雇佣兵拍了拍你的肩膀。%SPEECH_ON%我去把同伴们召集起来，这样我们就可以回%townname%去领取我们的报酬了。%SPEECH_OFF% | 你看着女人们在战场上蹒跚而行，仿佛淋湿的家禽避开池塘的淤泥一样抬着裙子。当然，一旦她们找到她们要找的东西，她们就不再顾及清洁，跳进污泥中哭泣和嚎叫，把自己埋进那些带着恼人的冷漠杀死了她们父亲和丈夫的恐怖之物中。\n\n%randombrother%凑到了你旁边。%SPEECH_ON%长官，攻击停止了，同伴们已经准备好返回%townname%。就等你的命令。%SPEECH_OFF% | 守卫的尉官来到你的身边并和你握手，干燥的血渍随着握手碎开。他双手叉腰看着现场点了点头。%SPEECH_ON%佣兵，你做得很好，没有你我们做不到这个。我想给你更多的东西以表感谢，但这座城镇现在需要所有的资源来重建。我希望%employer%付给你应得的报酬。%SPEECH_OFF%你也希望如此。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们做到了！",
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
			Text = "[img]gfx/ui/events/event_04.png[/img]{你进入了%townname%，发现%employer%正在阳台上观望。就在一名卫兵把一袋克朗狠狠地甩进你怀中之际，他朝你喊道：%SPEECH_ON%佣兵！很高兴看到你回来！我的小鸟们已经告诉我了你的种种行迹，希望你好好花这些克朗！%SPEECH_OFF%还没等你开口，那个人就转身离开了。递给你克朗的卫兵也已经不见了踪影。农民们在你身边绕行而过，仿佛你是一个指向他们永远不会去的地方的路标。 | 你发现%employer%正在踢打一个孩子，最终用脚向胸口一踹，将他踢倒在泥土里。看到你，贵族从额头上擦去汗水并解释了一下。%SPEECH_ON%这不关你的事。%SPEECH_OFF%孩子跪伏在地上，一只手按着肚子，另一只手捂着流血的鼻子。慢慢的他站起来，双眼充血。一名仆人过来给他擦水，但贵族抢过抹布扔到了一边。%SPEECH_ON%你觉得这样可以让他学习？如果你想帮助别人，就帮助这个佣兵。他被欠下了%reward_completion%克朗的报酬。快点。%SPEECH_OFF%仆人点了点头，赶紧离开了。你待了一会，看着孩子继续被打。孩子没有哭也没有喊叫，因为他早已经习惯了这种惩罚。几分钟后，仆人突然重新出现，手里拿着一个袋子。他把它递给你并悄悄地建议你离开。 | %employer%弯腰俯身撑在桌子上，双臂僵硬，头低垂着，盯着一只死乌鸦。%SPEECH_ON%我今天早上在我的床上发现了这只乌鸦。就在那躺着，死了。你有什么想法吗？%SPEECH_OFF%你提出这可能只是一个玩笑。贵族嗤之以鼻。%SPEECH_ON%才怪，我认为这与你有关，佣兵。你在拯救那个城镇时表现得很出色，但也许它本不该被拯救？也许这就是这只鸟代表的意思。也许死亡会因为我没偿清债务而之后会找上门来。%SPEECH_OFF%你利用这个声明缓缓地转入到自己的报酬问题。尽管贵族说了一些胡话，但他还是设法短暂的保持了清醒，并支付了你%reward_completion%克朗。 | %employer%正在听一群文书的讨论，他们按年龄和资历排成了一定的次序。年轻人的一组保持沉默，只听到他们的鹅毛笔划过纸张的声音。年纪大的则在彼此争吵，不仅用道理还用音量来说服对方。这看起来是如今常见的场景，毫无疑问死人从坟墓中爬出给哲学思考者们带来了一些问题。无论如何，你大声打嗝引入自己的存在，恶心地打乱了他们的谈话。%employer%笑着向你挥手让你进来。%SPEECH_ON%啊，佣兵！一个能成事的人，来与那些只会喋喋不休的人交谈？%SPEECH_OFF%你摇了摇头，告诉他你只是为了报酬而来。贵族点点头。%SPEECH_ON%当然。你在拯救那个城镇时干得很好。我听到了许多你的英勇事迹。%reward_completion%克朗就在那角落里等待着你。%SPEECH_OFF%你穿过房间，皮靴拍打地面的微弱声音充斥着突然安静下来的房间。文书们扭头看着你，互相窃窃私语。你拿起一个包，听到克朗碰撞发出清脆的响声，也感到了喜人的重量。你悄悄地离开了，然而当门在你身后关闭的瞬间，文书们再次开始争吵。 | %employer%身边有几个女人，她们正在告诉他她们失去的父亲、丈夫和兄弟。他认真地点头，尽管偶尔会分神看一眼最年轻的女孩的胸部。%SPEECH_ON%是的，当然。非常可怕。可怕啊！等一下，佣兵！%SPEECH_OFF%他向你招手让你进来。女人们在你走进来时分开，最年轻的姑娘看了你一眼，迅速擦去眼泪，并做了一些青春期的整理。贵族看到这一幕，来回扫了眼你和她。%SPEECH_ON%咳咳，你的克朗就在角落里。现在你必须走了，我还有事情要处理。%SPEECH_OFF%他站起身，指向你的%reward_completion%克朗，然后一下子拉起了那位女士的手。%SPEECH_ON%现在，年轻的女裁缝，你说你的丈夫已故，生命中再无重要之人？绝对一个都没有了吗？%SPEECH_OFF% | 路上的狗啃了点东西。无论它曾经是什么，它曾经有生命，骨头和器官早已变得苍白和腐烂，尽管这些杂种狗的狂暴进食仿佛是在吃一块牛排。%employer%在专心致志的卫兵陪伴下会见了你。%SPEECH_ON%我的鸟儿们告诉我城镇得救了。你做得很好，雇佣兵，比我想象的还要好。你的酬劳，按照约定。%SPEECH_OFF%他递给你一个装有%reward_completion%克朗的小包。狗子们暂停下来转过头，牙间的肉摇晃着，狭黑的眼睛里闪烁着饥饿的空虚。卫兵们放低了长矛，狗子们不知如何正确的理解了，慢慢的回去吃他们的晚餐。 | %employer%低着头坐在椅子里。他沮丧地挥手示意你进入房间。%SPEECH_ON%我有一个可怕的消息。我的先知说我给我的土地和人民带来了诅咒。这就是死者为什么会再次复活的原因。%SPEECH_OFF%你耸耸肩，友好地表示先知所说的是胡说八道。贵族耸了耸肩。%SPEECH_ON%我当然希望如此。我们约定的是多少，%reward_completion%克朗？%SPEECH_OFF%你有夸大一下数字的冲动，但不敢得罪一个如此迷信的人。当你回答时，他对你的准确回答报以温暖的微笑。%SPEECH_ON%不错啊，佣兵。你通过了那个考验。我可能快疯了，但我不会被轻易糊弄。%SPEECH_OFF%你问自己的诚实是否会得到回报。这个人扬起了一只眉毛。%SPEECH_ON%你的脑袋还在自己的肩膀上，不是吗？%SPEECH_OFF%很有道理。 | %employer%正在他的阳台上。尽管卫兵们站的很近，紧盯着你，你还是凑到了他旁边。这个人挥动他的手臂指向了他所在的城镇.%SPEECH_ON%我知道你没有直接拯救这个城镇，但通过另一种方式，我认为你做到了。在任何地方阻止亡灵都和在这里阻止一样好。你同意吗？%SPEECH_OFF%作为问题的逗号，这个人就给了你%reward_completion%克朗的报酬。你接受了报酬并点了点头。他也点头回应。%SPEECH_ON%你同意了，我很高兴，因为我们可能还会需要你的服务。%SPEECH_OFF% | 你踏入%employer%昏暗的房间。窗户上挂着毯子，大部分的蜡烛都没有点燃。所有的光亮来自于一个文书手持的烛台，他烛光映红的脸部在烛台后宛如握着三叉戟的小恶魔。他朝你瞥了一眼，静静地放下烛台。当他退后时，就像跌入了黑色的池塘中，他无躯的脸部慢慢沉入黑暗之中。他还在那里，微微呼吸，斗篷沙沙作响，但你一点也看不到他了。%employer%招手让你进去。%SPEECH_ON%佣兵！旧神在上，你拯救了那个城镇。%SPEECH_OFF%你向前走去，扫了一眼周围摇曳的黑暗，有些是阴影，有些是人。%employer%递给你一个小包。一些反射烛光的硬币在其开口处闪烁着。%SPEECH_ON%%reward_completion%克朗，正如约定的那样。现在，请离开吧。我还有更多要研究，要学习的。%SPEECH_OFF%你拿起你的报酬慢慢离开。当门关闭时，你看到文书再次出现，像一个憔悴的幽灵，骨瘦如柴的手再次伸向烛光。 | %employer%在他的书房里。守卫们站立在四处的角落里，一位文书悄悄地绕着书架转悠，带着热情拉出卷轴，然后带着同等的失望将它们放回原处。你迅速被贵族招手叫进去，并同样迅速的被支付了报酬。%SPEECH_ON%干得好，佣兵。你已经成这片土地上某些地方的一位英雄了。见鬼，说不定你最终会被记录在其中一个这种卷轴上，永远为人所记忆。%SPEECH_OFF%你听到文书发出嘲弄的声音，%employer%朝着门挥了挥手。%SPEECH_ON%请出去吧？我有许多事情需要研究，而且时间太少了。%SPEECH_OFF% | 你进入%employer%的房间，发现他深深陷在椅子里。农民们在他两边争论不休，互相指责对方。%SPEECH_ON%这个人是个杀人犯！%SPEECH_OFF%被告发出不屑的声音。%SPEECH_ON%杀人犯？那只是一个意外！我以为他是那些亡灵的一员！%SPEECH_OFF%这次轮到另一个人发出不屑的声音。%SPEECH_ON%亡灵？他只是喝醉了！%SPEECH_OFF%情绪开始升高。%SPEECH_ON%噢，我听到了他在咆哮！或者嘟囔。%SPEECH_OFF%你的雇主绝望地向你挥手让你过来。%SPEECH_ON%佣兵，你救了那个城镇，干得好。这是你的报酬。%SPEECH_OFF%他将一个装满%reward_completion%克朗的袋子推过桌子。农民们都停了下来，盯着从袋子的开口处闪光的硬币。你拿起这个袋子，假装它对你来说太重了。%SPEECH_ON%哦，太重了！祝先生们有个好日子！%SPEECH_OFF% | %employer%欢迎你来到他的房间。%SPEECH_ON%我的鸟儿们告诉我城镇得救了。你干得很好，雇佣兵，尤其是在这个变得如此黑暗的世界中来说。你的%reward_completion%克朗的报酬，正如约定。%SPEECH_OFF% | %employer%正站在外面，朝着一个墓园凝视，自从你上次来访后，这里的居民已经明显增加了不少。他递给你一个装着%reward_completion%克朗的小包。%SPEECH_ON%你干得好啊，佣兵。你的事迹已经传遍了这片土地。一次胜利不能拯救我们所有人，但它把我们带上了正确的道路。如果我们要赢得这场与死者的可恶战争，我们需要尽可能多的精神和希望。%SPEECH_OFF%你拿起报酬，补充道雇佣兵需要尽可能多的克朗。你知道，为了保持'精神'高昂。贵族笑了。%SPEECH_ON%我只是在表现的道貌岸然，并非真的乐善好施。出去吧。%SPEECH_OFF% | %employer%的卫兵们带你进入他的房间。他周围有一些展开了的卷轴。破碎的羽毛笔散落在他的桌子上，就像有人在那里摔了一只鸟。%SPEECH_ON%佣兵！很高兴见到这些天的风云人物！你解救了那个镇子，干得好！%SPEECH_OFF%他扔给你一个装着%reward_completion%克朗的小包。%SPEECH_ON%一场保全了一座城镇的胜利，一场保全了人们希望的胜利。我应该多付你一些报酬。我的意思是，我虽然不会，但我应该。%SPEECH_OFF%你黯然接受你的报酬，点点头回复。%SPEECH_ON%是啊，重要的是心意。%SPEECH_OFF%贵族打了个响指。%SPEECH_ON%没错！%SPEECH_OFF% | 你发现%employer%深深地坐在椅子里，眉头则皱的更深。他的衣服闪烁着耀眼的富丽，烛台看起来比拿着它们的仆人更值钱。这个花哨的哀怨之人沮丧地向你挥手让你过去。他缓慢的，带着嘲讽的说道。%SPEECH_ON%人类的一场胜利。又一场让我们得以撑到明天的胜利。哼嗯，谢谢你，佣兵。%SPEECH_OFF%你慢慢地向前迈步，仆人们带着恐惧的眼神瞥了你一眼。你拿到了你的报酬，然后退了回去。%employer%现在挥手示意你离开。%SPEECH_ON%走吧。我希望能再次见到你，除非你变成畸形的死尸，那将很是遗憾。但转念一想，我们最终都会以变成那样作为终结，不是吗？%SPEECH_OFF%你什么话也没说，离开了。这场对抗亡灵的战争已经让这个贵族疲惫不堪。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "%objective%得救了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "保卫了" + this.Flags.get("ObjectiveName") + "免受亡灵摧毁");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCriticalContract);
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
					text = "你获得了[color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color]克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Origin, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "在%objective%附近",
			Text = "[img]gfx/ui/events/event_30.png[/img]{亡灵太多了，你不得不撤退。不幸的是，一个小镇没有这样的自由，因此%objective%被完全攻陷了。你没有留下来看看它的居民变成了什么样，虽然聪明人也可以猜到。 | %companyname%已经在战场上被亡灵大军击败！随着你的失败，%objective%很快被攻陷了。一群农民从城镇里逃出，而那些太慢的人则加入了漫无目的步履蹒跚的亡灵大军之中。 | 你未能阻止亡灵的前进！尸体们缓缓越过%objective%的城墙，吞噬并杀害了所有它们遇到的人。当你逃离现场时，你看到守卫们的尉官在亡灵的队伍中步履蹒跚的走着。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "%objective%陷落了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "没能协助" + this.Flags.get("ObjectiveName") + "免受亡灵摧毁");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnWave()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getNearestSettlement(this.m.Origin.getTile());
		local originTile = this.m.Origin.getTile();
		local tile;

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 5, originTile.SquareCoords.X + 5);
			local y = this.Math.rand(originTile.SquareCoords.Y - 5, originTile.SquareCoords.Y + 5);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(tile, originTile, navSettings, 0);

			if (!path.isEmpty())
			{
				break;
			}
		}

		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(tile, "Undead Horde", false, this.Const.World.Spawn.UndeadArmy, (80 + this.m.Flags.get("Wave") * 10) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("一大群行尸，向活着的人索取曾经属于他们的东西。");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.setAttackableByAI(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(originTile);
		c.addOrder(attack);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function spawnUndeadAtTheWalls()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getNearestSettlement(this.m.Origin.getTile());
		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).spawnEntity(this.m.Origin.getTile(), "Undead Horde", false, this.Const.World.Spawn.ZombiesOrZombiesAndGhosts, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("一大群行尸，向活着的人索取曾经属于他们的东西。");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(15.0);
		c.addOrder(wait);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(90.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(this.m.Origin.getTile());
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function spawnGhouls()
	{
		local originTile = this.m.Origin.getTile();
		local tile;

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 5, originTile.SquareCoords.X + 5);
			local y = this.Math.rand(originTile.SquareCoords.Y - 5, originTile.SquareCoords.Y + 5);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(tile, originTile, navSettings, 0);

			if (!path.isEmpty())
			{
				break;
			}
		}

		local party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(tile, "Nachzehrers", false, this.Const.World.Spawn.Ghouls, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		this.m.UnitsSpawned.push(party.getID());
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setDescription("一群找尸体吃的食尸鬼。");
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.setAttackableByAI(false);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(originTile);
		c.addOrder(attack);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Flags.get("ObjectiveName")
		]);
		_vars.push([
			"direction",
			this.m.Origin == null || this.m.Origin.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Origin.getTile())]
		]);
	}

	function onOriginSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( id in this.m.UnitsSpawned )
			{
				local e = this.World.getEntityByID(id);

				if (e != null && e.isAlive())
				{
					e.setAttackableByAI(true);
					e.setOnCombatWithPlayerCallback(null);
				}
			}

			if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.Origin.hasSprite("selection"))
			{
				this.m.Origin.getSprite("selection").Visible = false;
			}

			if (this.m.Home != null && !this.m.Home.isNull() && this.m.Home.hasSprite("selection"))
			{
				this.m.Home.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(2);
			}
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

