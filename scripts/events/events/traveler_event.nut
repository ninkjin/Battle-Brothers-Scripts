this.traveler_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.traveler";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你看见一个旅行者踟蹰而来，没精打采地低声念念有词像个丢了翅膀的石像鬼。 他的手杖在前方戳戳点点你甚至在很远就能听到路上石头被敲击的声音。 你命令你的人暂时停下等待，让这个陌生人靠近前来。\n\n等他终于靠近了，他抬头看来。 刚开始，你就只能看见他的鼻子，他的其余部分都藏在斗篷里。 他像一只瞎鼹鼠一样谨慎地嗅着和你的人形成了一种古怪的对峙。 你正准备问问他是否有什么麻烦的时候，他揭开了斗篷，展示了身形。 你面前是一个疲倦的家伙。 步履蹒跚。睡眠不足使他的眼角满是皱纹。 他微笑的时候脸上满是不正常的潮红。 他问他是否可以和你的队伍在一起待一段时间。 | 一个旅行者在路旁拦住了你的队伍。 他说他是在去 %randomtown% 的路上但是他需要休息。 接下来的问题显而易见：他想知道他是否可以和你的队伍一起过夜。 | 一个旅行者装着一货车个人物品迎面而来。 等他离你不远，你举起你的手示意他不要再继续靠近。 他声明他只是个流浪者而且他只是想去 %randomtown%。 在展示了自己手无寸铁之后，他问自己能不能和你的战队一起过夜。 | 一个吹着口哨的人沿着道路小跑着，一只狗伸着舌头在他身边兴奋地狂吠。 看到你的队伍，他把手杖戳进泥地里双手撑在上面。 聊了些天气之类的客套话，尤其是乌云压城山雨欲来之类的话。 他问他能不能在一群佣兵战队里躲一下雨。 一个奇怪的请求，对于挣血钱的人来说很少遇到这种请求。 | 一个人一手压着肩上上下颠动的铁锹另一只手拎着一大袋泥土。 你问他在干什么，他说他刚刚埋葬了他的兄弟并且正准备回 %randomtown%。这个袋子装着他的血亲长眠之地的泥土。 值得尊敬。这个人看起来疲惫不堪，确实如一个刚刚亲手埋葬了自己兄弟的人那样疲惫。 也许觉察到了你同情的目光，他问是否可以和你的战队在一起待一会儿。 | 你看见一个奇怪的人沿路蹒跚而行。 他穿着一个长斗篷而且一个肩膀上还勒着一个小背包。 他的眼睛盯着地面一直到看到你的脚才抬头。 看到你的战队，这个人很奇怪地毫不紧张。 事实上，他对你的出现非常乐于接受并且询问他是否可以和你们佣兵一起度过一个夜晚以便明天继续前往 %randomtown%。 | 一个带着草叉的人走过一片庄稼枯萎凋零的庄稼地。 他的脚踩着干旱龟裂的土地你看到带起一蓬蓬灰尘随风而去。 当他走到路上来的时候，你拦住他问他来自何方。 这人是个临时工并且正准备回家。 他在这里所做的一切工作都已经结束了，确实是。 舔舔干裂的嘴唇，这人想知道他能不能和你的战队一起过夜。 他肯定是需要休息一下，无论如何。 | 一个人携带一大桶工具与你的战队不期而遇。 这道路看上去怎么都容不下一个带桶的人和一整个战队佣兵同时通过，这个陌生人放下手里的桶并且高举双手解决了这个问题。\n\n你告诉他别紧张并且问他去哪里。 他解释道他是一个来自 %randomtown% 的石匠，但是他在本地的工作已经做完了。 他只是想回到自己那个离此地只有一天路程的家。 看上去又渴又累，这个人问是否可以和你的战队一起过夜休息以恢复体力继续前行。 | 一个身影出现在地平线，在热浪中模糊又闪烁。 那个身影看起来暂停了，毫无疑问也看到你了。 带着一点担心，你带着你的人前进并且很快遇到了一个携带着几个装满零碎东西背包的男人。 他坐在地上并且即使你靠近了也没站起来。 他解释说他连续多日赶路现在需要休息。 很自然的，他问可不可以跟你战队的人一起休息。 | 你遇到一个身体虚弱意志动摇的男人。 他解释说他在寻找他丢失的狗，但是他已经快要放弃了。 在掉头回家之前，他觉得如果能和你的战队一起休息一晚也许能帮他回复精力支撑他再找一天碰碰运气。 | 你在路边发现一个被秃鹰追踪的人。 他并没有受伤，只是精疲力尽。 他用沙哑的嗓子询问是否可以和你战队的人一起度过夜晚。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "今晚加入我们的篝火晚会吧。",
					function getResult( _event )
					{
						this.World.Assets.removeRandomFood(3);
						local n = this.Math.rand(1, 18);

						switch(n)
						{
						case 1:
							return "B1";

						case 2:
							return "C1";

						case 3:
							return "D1";

						case 4:
							return "E1";

						case 5:
							return "F1";

						case 6:
							return "G1";

						case 7:
							return "H1";

						case 8:
							return "I1";

						case 9:
							return "J1";

						case 10:
							return "K1";

						case 11:
							return "L1";

						case 12:
							return "M1";

						case 13:
							return "N1";

						case 14:
							return "O1";

						case 15:
							return "P1";

						case 16:
							return "Q1";

						case 17:
							return "R1";

						case 18:
							return "S1";
						}
					}

				},
				{
					Text = "不，你离远点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%男人从出生那天起就被请上战争的筵席。 正是自己的母亲陪着自己打了人生第一场战斗，而人生的最后一场战斗中也会哭喊自己母亲的名字。 要是我们能像发现他人的邪恶一样发现自身的邪恶就好了，那样的话当有人召唤战争时大家都会充耳不闻。 令人伤心的是人们不愿意自我反省因为那样会令自己心怀愧疚，更令人伤心的是当战争召唤的时候所有人的耳朵似乎比平时任何时候都要更灵光。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这就是我的回答，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C1",
			Text = "[img]gfx/ui/events/event_26.png[/img]你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%我几个月前才去过一个高峰附近。 那是我去过最高的山峰！ 我跟一个探险队一块儿去的。 某个大聪明把一个长管子对着天空一个劲儿地看并且觉得这物有所值。 不管怎样，我朝山下看看到了这样的一幕。 城市道路星罗棋布，构成像鼹鼠洞一样的地表拼图。 载重货车像小蚂蚁一样缓缓前行，售卖着从这些人这些动物和这些土地盗窃来的各种物资。 原本是森林的地方现在全是的大坑。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "人类当然不会毫无作为。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D1",
			Text = "[img]gfx/ui/events/event_26.png[/img]你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%感谢你们提供的鱼，先生们，但是我不得不拒绝。请听我解释。 那天我正在挖坑准备掩埋我的兄弟像传统那样土葬。 有个远方表亲就在我旁边。 他就住我隔壁，事实上确实如此。 这家伙死于疾病，某种我完全不知道的疾病，但除了他谁也没有感染这疾病我猜我们都逃过一劫。 他死的时候还是那么年轻。 你们知道那是个什么疾病吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我不知道。",
					function getResult( _event )
					{
						return "D2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D2",
			Text = "[img]gfx/ui/events/event_26.png[/img]%SPEECH_ON%不知道？我靠。唉算了我继续说，我得给他挖个墓穴，我敢肯定他不打算自己亲自挖。 我越挖越深直到我发现了一块大石头。 镐重重地敲打在石头上，把手柄都震断了我的镐也崩出个大白点。 我说我就日了，我挖了这大半天却要在这里停下没法再挖，就因为一块石头！ 但是我发现这块石头里面有骨头。 不是在上面，是在里面。 看起来很奇怪，但肯定是骨头不会错的。 从一个事不关己的旁观者态度来说死亡真是太熟悉了。\n\n不管怎么说，那个骷髅似乎在盯着我看，审视着我，对我说“你这货在这儿干什么？” 于是我赶紧爬出洞穴狂奔回家，我远方表亲的尸体就这么扛在肩膀上就好像是我在盗尸一样。 我不胜困扰。没法安眠。 我感觉我正躺在几百几千死掉的尸体上，有的尸体太古老了以至于都变成了石头或者其他什么鬼东西。 死人啊。一直往下挖。 什么都没有只有死人，我是说往下挖一直都是死人没别的！ 我都不知道该怎么做了我现在还在被死者困扰着应该是很明显的事情了对吧。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是的，有一点。",
					function getResult( _event )
					{
						return "D3";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D3",
			Text = "[img]gfx/ui/events/event_26.png[/img]%SPEECH_ON%后来我觉得不想埋葬我的远方表亲了。 换个思路，我把他的尸体焚烧之后把骨灰和剩下的一堆冒烟的东西都扔进了“一个”池塘。 我对自己喃喃自语，“表哥，你不会变成石头的”。\n\n但是后来我发现骨头被冲到岸边，有一条吃的肥肚油肠的大胖鱼被困在他的肋骨中间。 会被困住是因为狂吃海塞吧，我猜的。 我把这条鱼拎起来抓在手上，我的远方表哥，就这样在我手上。 这真让人感到无力。没有水这鱼只能鼓眼吹气半死不活。 但这时有一只狗跑过从我手里一口抢走了鱼。 狼吞虎咽一口就咽下去了因为就连它也知道吃了那东西这件事的本质是多大的罪行，我觉得是这样。 这就是我的一块远方表哥的下场。 躲过了吞噬尸体的饥饿岩石层却只是葬身鱼腹并且又给一只狗上了菜。 所以现在你知道我为啥不吃鱼了吧。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "哏。非常有趣的故事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%我参加了东部战役。 我驱赶着后勤补给车，带着无法计数的铠甲，武器，马匹，食物，你永远都想不到有多少。 狗日的，那至少是十年前了吧，我感觉是的。 那大概是最后一次人类全部精诚团结万众一心，我估计那些绿皮怪物也是一样。 这两股强大的力量相遇必然会互掐起来相互摧毁。 而我们现在却生活在一个混乱的时代流言迷信满天飞并且陌生人之间都能吹牛打屁胡扯。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你能一路顺风，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "F1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你们围着篝火坐着。大家议论纷纷，但旅行者讲了一些话，让你们在他离开后长久思索。%SPEECH_ON% 十年前，我参加了多次战役，兽人与人类的战争，一场战争的结束标志着时代的开端。我当时为骑兵，南部的泥泞和沼泽都不适合骑马，但是我们的指挥官坚决不退缩。一只兽人用长杆枪刺穿了指挥官的战马，击中了指挥官本人。把马带进那些泥淖……那是个可怕的想法。我听说北部的防线表现得更好，但这没有什么关系。没有一方获得了那场可恶的战斗胜利。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你能一路顺风，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%你看过绿皮一刀砍掉一匹马的脑袋吗？ 相当震撼。不过我也看过一匹马踢掉兽人的牙齿并且把这货一通狂踩成烂泥。 也许我们忘记了，我觉得是这样，马其实是比我们更适合战争的生物。 可怕而古怪的动物，当然，也很暴力。 对它们来说，动物经常捕杀其他动物，或者干脆自相残杀，猎杀对手的孩子甚至孩子的孩子。 女人们即喜欢我们又喜欢那个真是太特么操蛋了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你能一路顺风，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "H1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%啊，世纪之战啊。 嗯，我参加了。 先锋队。中央前线。 不，我不想谈这个话题。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你能一路顺风，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "I1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%世纪之战？ 谁没参加过呢？ 半个世界都在向那里进军，我发誓。 我是步兵大队的。 准确说来，是一位领主的步兵护卫。 我们保护他保护的很好直到兽人放出了他们的狂暴者。 从那以后，所有人都只想保护自己，就连保护自己都被证明很难做到。 我以前经常撒谎说我是怎么英勇作战杀出重围。 现在我不想吹了。事实上我的领主被一根链子抽到脸上抽死了而他的马倒下来压住了我我才活下来，那匹可怜的马是竟然是被吓死的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "接下来发生了什么？",
					function getResult( _event )
					{
						return "I2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "I2",
			Text = "[img]gfx/ui/events/event_26.png[/img] 旅行者停了下来，眼睛盯着篝火。 他用手杖探了探边缘。%SPEECH_ON%那大概是聊起战争这个话题我最不愿回忆的一个情景。 我终于醒来，雨已经到了我的鼻子了。 我昏迷中差点被淹死。 我从马的尸体下艰难地爬出来爬了鬼知道多久。 兽人和人类到处都是，死透的，快要死的，快被淹死的。 惨叫呻吟。不知道是谁发出来的。 我还记得那些泥浆。 我还记得我深陷其中。 一位女士，她的手臂比牛还强壮，她拯救了我。 他把我扔进一辆货车而我最后看见那个战场的是。啊对不起。 我必须停止这个话题。谢谢你让我和你们一起过夜。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你能一路顺风，旅行者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "J1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%我带领一支战队参加了世纪之战。 这可是是正义的事业。 人类对兽人！哇，多么壮观。 我的人在战场上死了一半，但是他们的牺牲拯救了整个大陆！ 我深情的感慨那些时光。谁又不是呢？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "一个高尚的故事，陌生人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "K1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%就在 %randomtown% 外他们在审判一个父亲。 如果考虑到他弄翻了货车造成的伤亡的话他已经谋杀了两个兄弟。 显然意犹未尽还想杀死更多人。 总共算起来，他至少杀了七个人。 自然，他们把这个人判处绞刑。 但是后来有一天我遇到了那人的儿子而他告诉我那天的绞刑只是一个文书错误。 他的父亲是个堂堂正正的汉子，完全没有任何利己之心却遭遇了仇家的报复。 更令人奇怪的是，这年轻人现在是个镇长！ 现在，这就是我记忆中的那个人杀了七个人的事件。就是这样！ 但我上一次去镇上的时候他们已经把那个吊死的尸体移进了合适的墓穴并且如果我没撞鬼的话墓碑上还有人送花。 我也不知道这种事情到底该信谁的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "人们总是努力想找到人性中的善。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "L1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%你们不是这一块儿唯一的雇佣兵战队。 我相信你们也知道，我也没有威胁的意思，但我只想告诉你一件事。\n\n两个星期前大概两到三个战队的人，就跟你们现在这样，在一个十字路口相遇并且显然那个路口装不下两方那么多人，于是他们干起来了。 就算有人活下来，活的人也不够把死尸运走。 我喜欢你的手下们。 他们都是好人。 但是在那边时请一定要小心。 杀人越货的掠夺者和强盗们还有上帝才知道什么鬼玩意儿在那里蠢蠢欲动。 你身处一个竞争激烈的杀戮市场中，佣兵。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们会小心的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "M1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%有一天一个小男孩偷了我的午饭，但是他得手之后不但不跑还就在我面前开始吃我的午饭。 我说，“把午饭还给我你这个臭流氓”，但是他说不。 我伸手去拿，但他那瘦骨嶙峋的腿与其说是鸡，不如说是猫。 我说这样可不行，我就问他为什么非要在我面前吃。 这简直是折磨，你看到的。 他说“因为我饿”。 我就说了，“那我也饿啊，赶紧还给我”。 很自然的，他还是说不行。 顺理成章的当他转身想跑的时候我一石头砸中他了并且减缓了他的速度所以我拿回了我的午饭。 \n\n 但是那边来了一个镇长的步兵护卫说叫我别动手。 我就问我为什么不能，他说“因为那是镇长的儿子”。 他也没惩罚我，只是警告我不要再犯。 我就跟他说，我这样说的，“告诉那个孩子以后别再盗窃了”。 他们说早就说过了，只不过我看上去比那个孩子更容易听话就是这么个事儿。 狗娘养的小镇，我敢拿我的袜子打赌这地方比魔鬼山还招人恨。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "复仇，是最甜的香料。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "N1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%世纪之战战场上的死亡都很奇怪。 兽人杀人可不是跟人类这样，他们杀人超快。 他们动起手来可不会给你留下时间哔哔赖赖。 尘埃落定之后我仔细研究过他们的手法。人被拆分的零零散散。 大块躯干，腿，胳膊，以极其不自然的裂缝分隔开的躯体。 痛快的死法也有。伸手一挥，脑袋飞了！ 而且尸体还会干缩和变硬。 大部分的尸体都是那个样子，就好像他们吓坏了只好尴尬地坐在原地不动一样。 大部分尸体早就不成人形了。 一个人死掉后就应该像是在睡眠的样子，你知道吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Aye.",
					function getResult( _event )
					{
						return "N2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "N2",
			Text = "[img]gfx/ui/events/event_26.png[/img]他继续道。%SPEECH_ON%有些人得到了所谓礼貌对待让你缓慢的死去，用刑暂停假惺惺地给你机会让你可以自己寻找舒服和慰藉，比如说把你卷成一个球把你滚来滚去啊什么的。 但是我要说一个人，拦腰被斩断了，但却没死。 我发现他了。 我告诉他赶紧闭眼因为我想只要他睡着了死神就会来拯救他。 但是他不想睡去。 他只是不停地呼吸，说话。 说他小时候养的小鸡，说他爸爸杀鸡的时候他有多难过。 说到一个小女孩，说到她变成一个妻子然后成为母亲。 他谈到了两个母亲，事实如此。%SPEECH_OFF%这个男人停了下来，盯着篝火。 他抬头看着你。%SPEECH_ON%我从来没想过半截人可以坚持这么久。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你的旅途顺利，陌生人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "O1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者说的一些话在他离开后很长一段时间仍留在你的脑海里。%SPEECH_ON%几个月前我看见一个人被雷劈了。他的名字叫 %randomname%。 我们以前开玩笑说他的嘴巴是个伐木场，咬一口如同伐木拉锯。 他的牙齿跟白蚁一样！ 不管怎么说，我发现他的脑袋在燃烧，咧开的嘴里面还在喷火，他的皮肉呈青紫色卷曲起来。 他身边的土地都被烤焦了，浓烟滚滚火花四溅。 不过他还活着。 于是我赶紧跑开去求援这时候我能听到身后传来一阵惨叫。 这狗日的雷电又劈了他一次！ 他被神惩罚了一遍又一遍。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好吧，愿他安息。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "P1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 旅行者谈到一些无聊的消息。%SPEECH_ON%他们在 %randomtown% 绞死了某个女士。我没看到绞刑现场，我看的时候她已经在绞架上荡来荡去了。 他们说她趁一个男人熟睡的时候把他脑袋给烤了。真是个婊子。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Interesting.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Q1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 旅行者谈到了犯罪及其惩罚。%SPEECH_ON%就在 %randomtown% 他们绞死了一个男孩因为他杀死了一个商人。 据说他扔石头把这个商人从货车上砸掉下来。 而他跑过去抢劫了商人的财产，但是这个被砸中的商人并没有昏迷，于是他拔出匕首而那个男孩也拔出匕首我猜最后应该是男孩赢了，当然他现在也在绞架上晃啊晃。 关于行刑有人说这孩子在绞架上又踢又蹬坚持了很久，甚至死透了还在抽搐着又蹬又踹。 也许他冰冷的双脚只是想寻找一点温暖。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Interesting.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "R1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 关于这个或那个的谈论很多，但旅行者变得有点不安，你问他在想什么。%SPEECH_ON%我听到一些谣言说坟墓都被掀了个底朝天。 他们在 %randomtown% 绞死了一个人说他盗墓，但是不幸的是还是能继续不断找到没有尸体的墓穴。 如今，我可不是一个迷信的人，但是连我都听说了死者不断从地下爬出来。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这只是道听途说。 你没什么好怕的。",
					function getResult( _event )
					{
						return "R2";
					}

				},
				{
					Text = "你听说的那些没错是真的。",
					function getResult( _event )
					{
						return "R3";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "R2",
			Text = "[img]gfx/ui/events/event_26.png[/img] %SPEECH_ON%切。好吧我算你说得对。 死者出来遛弯了是吧？ 哈哈！我会把这种故事留给小朋友。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Indeed.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "R3",
			Text = "[img]gfx/ui/events/event_26.png[/img] %SPEECH_ON%希望远古众神饶恕我假如要是我那该死的丈母娘从坟墓里爬出来她可不会对我有一点怜悯。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "一个可怕的展望。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "S1",
			Text = "[img]gfx/ui/events/event_26.png[/img] 你坐在火旁。 那个看上去很倒霉的家伙一边盯着火堆一边说。%SPEECH_ON%我听说有钱人有一种东西能让他们看到自己长什么样子。 镜子！对，就是这个东西。 真希望我也有一个。 我已经有…呃…我从来就没看过自己长啥样子。 也许只有在对着池塘的时候能看到一点模糊的影子吧，我觉得。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "有些东西最好还是不要被看到。",
					function getResult( _event )
					{
						return "S2";
					}

				},
				{
					Text = "我这里恰好有一面镜子。",
					function getResult( _event )
					{
						return "S3";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "S2",
			Text = "[img]gfx/ui/events/event_26.png[/img] 这人皱起了眉头。%SPEECH_ON%哦谢谢你，佣兵，这让我感觉好多了。我操。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不用客气。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "S3",
			Text = "[img]gfx/ui/events/event_26.png[/img] 这个男人盯着镜子就好像在看着自己的死尸一般。 他搓着下巴转动着脑袋，拼命地试图寻找到一个不让人失望的角度。%SPEECH_ON%如果我的老妈不是这个世界上最大的骗子那就是我被诅咒了。 你看那个丑鬼！%SPEECH_OFF%他递还镜子并且因为那丑脸而忍不住地笑起来。%SPEECH_ON%Well, 我想我再也不用疑惑为什么女人都离我远远的了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不用客气。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Wildmen && currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

