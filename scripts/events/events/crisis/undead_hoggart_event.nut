this.undead_hoggart_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_hoggart";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]行军穿过一片雾，雨水也是热的，你发现一个人影站在路中间。 他手里拿着一支带金属环的火炬，无疑是一个想要用火炬来吸引人注意的人。 当你走近时，他放下手里的火炬，照出一张熟悉得出奇的脸，但是你不敢用手指碰他。 你命令他宣布自己的身份。%SPEECH_ON%你们是一群佣兵，哼？%SPEECH_OFF%你告诉他这不是一个名字。 他清了清嗓子，脸上泛着柔和的橘红色，透过暴风雨的黑暗向外张望。%SPEECH_ON%我的名字是巴纳巴斯。 你们是不是佣兵？%SPEECH_OFF%你小心地穿过小路，靠近那个人。 他把火炬挥到一边。%SPEECH_ON%是的，我想也是。 我的兄弟，我需要一个人…我是说，我不能….%SPEECH_OFF%你点头听他说话。%SPEECH_ON%他从坟墓里出来了，现在你需要派人来照顾他。%SPEECH_OFF%那人点了点头，把火把朝远处一个有着昏暗亮光的地方一挥。%SPEECH_ON%他在那个方向。我会给你 %reward% 克朗，看看你们这些佣兵会怎么做。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，引路吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "这不是我们的问题。",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_76.png[/img]你告诉那个人带路，带着 %chosenbrother%，让另一个佣兵在你不在的时候负责。 巴纳巴斯带你下了山坡，来到一处房产的围栏边，那里有一座大小适中的石屋。 烛光在窗外闪烁。巴纳巴斯凝视着前方。%SPEECH_ON%没人在那里。这里唯一的人就是霍加特。%SPEECH_OFF%这个名字…巴纳巴斯的脸… 你抓住那个人，把他推到栅栏里，问他是不是强盗的兄弟。巴纳巴斯迅速点了点头。%SPEECH_ON%是啊，就是我！怎么了？%SPEECH_OFF%你告诉他，霍加特几乎毁灭了 %companyname%，为了报仇，你杀了他。 巴纳巴斯举起双手。%SPEECH_ON%如果是这样，那就对了。 霍加特所做的只是把财产留在家里。 父亲去世后，我们负债累累－债务我们无力偿还。%SPEECH_OFF%你拔出匕首，刺向他的喉咙。他摇了摇头。%SPEECH_ON%我不是来这里伏击或抢劫你的。 房子已经卖出去了。 这是我们家的事。 但是霍加特…他回来了，他不会离开。%SPEECH_OFF%你看着巴纳巴斯的肩膀。 有一个黑影站在房子前面，它的轮廓被窗户的灯光照亮了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧。让我们去看看。",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "我们在这做个了断吧。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "这不再是我们的事了。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_76.png[/img]血缘关系不是那么容易被打破的。 无论巴纳巴斯怎么说，总有一天他会来找我们战队的，这一天寒冷而宁静，复仇的火焰不会轻易熄灭。\n\n 你叫那个人带路，他一转身，你就在他腋窝下捅了一刀，刺穿了他的心脏。 他什么也没说。 他只是跪倒在地，面对着他兄弟的背影和他从小到大的家。 他坐在那里，瘫倒在地，奄奄一息，雨水噼噼啪啪地打在火炬上，直到它发出死亡一般的嘶嘶声。%chosenbrother% 吐了口水。%SPEECH_ON%好办法，先生。%SPEECH_OFF%他搜查尸体，发现了一把闪亮的匕首。 也许是一个刺客的工具，也许是一个没落家族的最后传家宝。 不管怎样，你拿着它回到 %companyname%。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就是这样。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local item = this.new("scripts/items/weapons/named/named_dagger");
				item.m.Name = "巴纳巴斯的匕首";
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_76.png[/img]这不是你的问题，也不应该是。 霍加特已经死了，这就是你需要的，或者你想知道的，而不是他和他的家族那些事。 你把巴纳巴斯留在雨中，返回 %companyname% 去制定新的行程。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们手上有够多的亡灵问题了。",
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_76.png[/img]抛开更谨慎的判断，你去看看这是不是真的霍加特。 你朝他走去，他一边咆哮一边回头张望。 这确实是霍加特，但他只是对你咆哮了几声，然后又转过头去盯着他的家。 你拿出剑，小心地靠近。 从近距离看，你可以看到这个人的头被缝回到了别人的身体上，从盔甲和装束上看似乎是个骑士。\n\n 真是浪费时间。你把剑往后一挥，最后一击落在了霍加特身上－但一只微弱的蓝色的手伸了出来，把锋刃停下来，就好像你碰到了一块石头。 慢慢地，一张幽灵般的脸转向了你，与霍加特无关，看着你。 他尖叫了一声，然后又消失在死人的躯体里。\n\n 巴纳巴斯站在你们旁边。%SPEECH_ON%如果能那么容易地做到这件事，我就自己做了。%SPEECH_OFF%这里似乎有一股强大的邪恶力量在作祟。 你需要找到一个不同的解决方案。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们需要烧掉这个房子。",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "%chosenbrother%，分散这个幽灵注意力！",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Witchhunter != null)
				{
					this.Options.push({
						Text = "让我们去找 %witchhunter%。卑鄙的灵魂是他的长处。",
						function getResult( _event )
						{
							return "H";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_76.png[/img]霍加特把手伸向他的家，似乎想从远处抓住什么。 他的咆哮变成了轻柔的呻吟。 一个变形了的，干瘪了的舌头吐出几个字。%SPEECH_ON%我们的…我们的…总是…%SPEECH_OFF%你瞥了眼房子，然后又看了看 %chosenbrother%。他点头。 这房子得毁掉。 你四处走动，决定从里面点燃这个地方，把火把从窗户里扔进去，并点燃茅草屋顶。 即使在雨中它也会着火。 霍加特咆哮着，身体向前倾去，伸出双臂，双手用指尖伸向远处。 幽灵从他的肩膀上冒了出来，半透明的手臂抓住了霍加特的脑袋，试图把他拉回来。 死者咆哮着试图向前跑去，他的头在缝线处撕裂着。他尖叫道。%SPEECH_ON%我们的。我尽力了。唉。太难了！%SPEECH_OFF%缝线松了，他的身体向后翻了个跟头，脑袋被撕开了，掉进了泥里。 蓝色的幽灵摆脱了脖子，尖叫着冲向夜空，在雨中闪着微光，直到消失。\n\n 巴纳巴斯走过去坐在霍加特身边，死者的眼睛茫然地盯着吞噬他们童年家园的烈火。%chosenbrother% 从霍加特尸体处取回盔甲，他的人头也在那。 你想和巴纳巴斯谈谈，但他拒绝说话。 你明白了，所以没有催促他离开，当你离开的时候，火焰依然不会在雨中熄灭。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我猜就这样了吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/armor/named/black_leather_armor");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_76.png[/img]你向 %chosenbrother% 耳语说要攻击霍加特，但只是为了转移附身的幽灵的注意力。 佣兵点头，立即开始工作，拔出武器，向前冲去。 可以预见的是，一只蓝色的手臂伸出来了，它那可以确信的半透明形状与 %chosenbrother%的武器交相辉映。 他向四周看了一下这环环相扣的场景，发出了尖叫声。%SPEECH_ON%现在！%SPEECH_OFF%你跳上前去挥动你的剑。 幽灵尖叫着转过身来，但已经太迟了。 你的利刃穿过了霍加特的脖子，一刀把他的头砍了下来，他的头从他的胸口滚进了泥浆里，而他的身体向后乱甩。 幽灵只好独自面对这个世界了，它尖叫着，在空中盘旋，在它新发现的自由中除了混乱什么也没有。%chosenbrother% 看着霍加特身上的胸甲，他摇了摇头。这该死的东西坏了。\n\n 一群人突然跑过院子，手里拿着火把和剑。 一个特别有钱的家伙领导着他们。%SPEECH_ON%是你吗，巴纳巴斯？ 我想我告诉过你不要再踏进我的地盘！%SPEECH_OFF%你向他们解释发生了什么事。 这个人，宣称是土地的买主，点头，说他带了一个牧师来解决这个问题，但现在你办到了，他付给你一笔可观的克朗。 你回头一看，巴纳巴斯和霍加特的脑袋都不见了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "赚了一笔快钱。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(300);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]300[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_76.png[/img]%chosenbrother% 说 %witchhunter% 可能知道此时该怎么办。 你同意了，跑去找女猎巫人。 你回来时，他先估计了一下情况，然后看了看藏在口袋里的厚书。 他点了点头，边读边喃喃自语。 最后，他打了响指。%SPEECH_ON%这是一只双头鬼魂，两个鬼魂缠绕在一起。 在这种情况下，一个是是霍加特的，另一个是个身首异处的家伙。 一个灵魂被狠狠地抛弃是很简单的，但是两个结合在一起是一种恶毒和愤怒的力量。 如果我们只是简单地摧毁身体或头部，两个灵魂将被捆绑在一起，并将永远萦绕在这片土地上。 有些甚至撞向了天空。 不幸的是，他们发现的不是天堂，而是无尽的混乱和愤怒所带来的地狱。 我相信霍加特的灵魂，或者是任何把他和这个世界联系在一起的东西，比另一个人的灵魂更强大。 他一生中所经历的坎太多了，不可能在最后一口气的时候就结束了，这就是他在老家游荡的原因。%SPEECH_OFF%你打断女巫猎人，问了一个最关键的问题…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们如何阻止他？",
					function getResult( _event )
					{
						return "I";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_76.png[/img]%witchhunter% 挤出一个微笑。%SPEECH_ON%向他道歉。%SPEECH_OFF%不确定你是否听对了，你重复了他的话，女巫猎人点了点头。%SPEECH_ON%啊，道歉。我也是认真的。 许多人充满了仇恨，或是充满了欲望，以至于任何失败都把自己化作一种难以想象的强大能量。 你杀了这个人。 是你颠覆了一个连最轻微的停顿都无法容忍的生命，更不用说最终的失败了，那就是死亡。 现在是你结束煎熬的时候了。 我想道歉就可以了。%SPEECH_OFF%巴纳巴斯迈步上前解释，又一次的，霍加特的工作只是为了确保遗产留在家族之内。 他所做的一切都是为了家族。 他不是一个邪恶或残忍的人，他只是在做他认为正确的事情。%witchhunter% 伸出一只手，好像在说“看”。%SPEECH_ON%好的，你去吧。队长，听。 你们之间的宿怨就要过去了。 这是另一回事。 没有人配得上这种命运。 发自内心地向他道歉，你就可以彻底的结束他的痛苦。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好的。什么都没有",
					function getResult( _event )
					{
						return "J";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "J",
			Text = "[img]gfx/ui/events/event_76.png[/img]你向霍加特走去。 他咆哮着，盯着你看了一会儿，然后回望着他的家。 你又谨慎地走了一步，来到他面前。 他呆滞干瘪的眼睛瞪着你，但这次他没有把目光移开。你说道。%SPEECH_ON%霍加特…%SPEECH_OFF%亡灵人向后一靠，眼睛怀疑地眯着，手摸着胸口。 他的声音似乎从一具借来的尸体的深处舒展出来。%SPEECH_ON%霍…加特…我…尽力了…%SPEECH_OFF%点着头，你把你的拇指抵住你的声带。%SPEECH_ON%我知道你尽力了。 我是说，我不知道你一开始就想这么做，但现在我知道了。 听着，你兄弟把一切都告诉我了。 如果我知道的话，我就不会接受那份合同了。你没有…%SPEECH_OFF%你瞥了一眼正在点头的 %witchhunter%。你继续道。%SPEECH_ON%霍加特，你不值得去死。 不是这样的。如果我处在你的位置，我也会这样做的。 但是我没有站在你的立场上。 我无法理解你是谁，你在做什么。 我只是在做别人付钱让我做的事。 我无法收回我所做的一切，我所能做的只是说…我对不起你。 你不应该承受这种痛苦，我很抱歉。%SPEECH_OFF%霍加特呆滞低垂的眼睛又盯着你看了一会儿，然后他的身体突然晃了晃，向前倒了下去。 两个鬼魂出现了，一只在泥泞的土地上扭曲着，射击着，当它直冲地平线时，蓝色光芒的泪珠在石头上闪烁。 但另一个灵魂依然存在，现在发出微弱的金色光芒，它只是朝家飘去。 巴纳巴斯跟着它，而你们紧随其后。 你们一起绕过一个角落，朝庄园的后边走去，霍加特的幽灵就停在那里。%SPEECH_ON%我所做的一切，都是为了这个。 现在它不再属于我了。归你了。%SPEECH_OFF%当巴纳巴斯伸出手去触摸时，他的鬼魂渐渐消失，闪闪发光的灰尘从他的触摸中飘散。 你注意到这里的泥土被翻了起来，一个板条箱正沉入雨水中。 把它拖起来打开，你会发现一把巨大的剑，上面装饰着霍加特的姓。 巴纳巴斯看起来和你一样震惊。%SPEECH_ON%家族的传家宝。他说这用来作为遗产，永远不会卖掉，他认为这是独一无二的。 当我告诉他必须这么做时，他从城市跑回来告诉我他在赌博中输掉了这把剑… 我再也没跟他说过话。 我对他说的最后一句话是，他不是一个好流浪汉，是世上最糟糕的兄弟。 现在我知道真相了。 你给我和我的兄弟带来了安宁，佣兵，而这种安宁正是我想要记住的。 请，就像我兄弟说的那样，收下这个传家宝。%SPEECH_OFF%你拿起剑，祝巴纳巴斯安好。 你最后一次看到他的时候，他正坐在泥里，身体蜷缩着，颤巍巍的，哭泣着，周围都是雨，直到一个人也没有了，只有一个温暖的家庭和一场伴随着金色闪电轰鸣的暴风雨。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧，霍加特。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(1);
				this.Characters.push(_event.m.Witchhunter.getImagePath());
				local item = this.new("scripts/items/weapons/named/named_greatsword");
				item.m.Name = "霍加特的传家宝";
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		if (!this.World.Flags.get("IsHoggartDead") == true)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_witchhunter = [];
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter")
			{
				candidates_witchhunter.push(bro);
			}
			else
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		if (candidates_witchhunter.len() != 0)
		{
			this.m.Witchhunter = candidates_witchhunter[this.Math.rand(0, candidates_witchhunter.len() - 1)];
		}

		this.m.Other = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"chosenbrother",
			this.m.Other.getName()
		]);
		_vars.push([
			"witchhunter",
			this.m.Witchhunter != null ? this.m.Witchhunter.getName() : ""
		]);
		_vars.push([
			"reward",
			"300"
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
		this.m.Other = null;
	}

});

