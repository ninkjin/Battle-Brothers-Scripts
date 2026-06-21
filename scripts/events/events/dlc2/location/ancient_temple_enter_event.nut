this.ancient_temple_enter_event <- this.inherit("scripts/events/event", {
	m = {
		Volunteer = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.location.ancient_temple_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_111.png[/img]{只有寺庙入口的一半可见，剩下的已经沉入地下，仿佛不确定是棺材还是陵墓。沿着可见的浮雕上，你可以看到石制的饰面上有一组被扔出的方桌和一些带着钱袋逃跑的人，而这些人正在逃离一个看起来像是拿着鞭子的装甲骨骼。有些雇佣兵似乎不太愿意进去，但你认为有其他人也有和他们一样的感觉，所以这个地方就没有被破坏。\n\n你点燃了火炬，以一个佣兵的勇气和强盗的决心进入。搜寻好物资后，你蹲下身子，把腿挂在地上，跳下去走台阶。你的靴子在大厅里打响声响，你前面挥动着火炬，好像在看声音回荡的样子。回头看去，地面上的光线勾勒出你的同伴们的身影，就像是一群满意地完成工作的埋葬者。%volunteer% 摇了摇头说也要跟着你一起行动。其余成员则共同同意守卫外围。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要进去了。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "忘记那些垃圾，我们继续前进。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_111.png[/img]{大厅的墙上铺满了大规模的军事马赛克，这些马赛克更适合整个战役而不是任何一场单独的战斗。特别是其中一个地方，似乎可以一直伸展到走廊的尽头，描绘了一群身穿盔甲的人肆虐整个野蛮人部落，数量之多已经失去了人性，变得难以辨认，就像是一群虫子一样。你手中的火把发出微弱的光亮，以一种橙色的生命赋予战场的艺术，角落里展现着正义的折磨和愤怒的描绘。在锁步奔跑的力量和分散的群体之间，看起来像是秩序与混乱的冲突，尽管秩序肯定会胜出，但正是混乱本身推动着胜利的到来。\n\n%volunteer%吹了声口哨。你看到他手中的火把在远处闪烁着，像是一个幻觉。你跑过去，发现他手中拿着一个装有奇怪液体的小瓶子。佣兵把火把挥向了墙上的一处凹陷。一根大理石柱子居中，柱底是一群骷髅。%SPEECH_ON%我在那个基座上发现了瓶子。那儿还有两个，但是它们在门后面。%SPEECH_OFF%你问佣兵为什么他没有告诉你那些骸骨。他耸了耸肩。%SPEECH_ON%他们没呼吸，那我就不在乎了。你想去试试其他两个瓶子吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们开始吧。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/tools/holy_water_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你发现下一个药瓶组合在一个腰高的大门后面。瓶子本身被一个没有翅膀的石像鬼的爪子托住，它从天花板上悬垂而下。在大门前的石板上有几个字形，但这些文字非常古老，即使不是这样你也不确定能不能很好地读懂它们。突然，一声声音在头顶上响起。%SPEECH_ON%一群鸟在田野上时，猎人来了。猎人拉开弓，大喊起来，仿佛在痛苦中。几只鸟飞了起来。猎人杀了它们。更多的鸟飞了起来，猎人同样击杀它们，并开始哭泣，收集它们的身体。更多的鸟飞来了。猎人在哭泣和杀戮。他几乎没有时间上弦并不得不停下来擦拭他的眼睛。一只鸟转向他的朋友，并说他应该去安慰那个人。这只鸟的朋友回答了什么？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "注意他的眼泪，观察他的手！",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "必须拯救一个处于崩溃边缘的人。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "啁啾。 啁啾啁啾啁啾？",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "什么？",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_111.png[/img]{声音沉默了一会儿，然后又回来了。%SPEECH_ON%正确!%SPEECH_OFF%在古老的机械的震动下，门滑动着，石像鬼降下来，瓶子的刚硬守卫以 stoic aplomb （冷静冷静）凝视着。你抓住瓶子，紧紧地抱在怀里，仿佛巨大的石头结构会活过来把它拿回去一样。你挥舞着火炬大喊要求知道谁在说话。声音笑了，但仅此而已。%volunteer%看着你耸了耸肩%SPEECH_ON%我们得到了宝藏，难道不能再试试吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不妨看看。",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "看起来很危险。 让我们现在出去吧。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/tools/holy_water_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你摇了摇头。第一瓶液体是巧合，可能是其他强盗失败的最终结果。你很幸运。第二瓶液体附带着一个声音，询问你一些无意义的话。够了。你命令%volunteer%离开寺庙，带着两瓶液体和理智离开。\n\n外面，你看到%companyname%，正在踢打着一个仍在鲜血淋漓的尸体。他们说，那个男子在你在底下的时候跑出了寺庙。一个佣兵递来一张纸条。上面画着瓶子，显示液体像倒在蚂蚁上的熔化金属一样排出了亡灵。%volunteer%嘲笑道。%SPEECH_ON%好吧，我想这解释了这些是干什么的了。%SPEECH_OFF% 你点了点头，问死者身上是否还有其他东西。另一个雇佣兵耸了耸肩。%SPEECH_ON%他走到出入口说'一个武装的人，一个钢铁伙伴，我给你出一个谜语'，然后我就杀了他。他似乎很危险。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许是回答一个谜语的最好方法。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_111.png[/img]{最后一个瓶子在另一个门后面，从建筑角度看，这个门令人不安。这里不仅有石头条，还有扭曲的铁钩及受过伤的火山渣和矿渣，门不在胸部高度，而是在你的脚踝处。瓶子本身在进一步的高处，这意味着你必须把手伸到墙下，再次抬起来才能得到它。声音回来了。%SPEECH_ON%一切都从我而来，一切最终都将是我。当人类走过这片大地时，我会跟随他的脚步。%SPEECH_OFF%你站在沉默中，看着%volunteer%。他耸了耸肩。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "灰尘。",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "你去死吧！",
					function getResult( _event )
					{
						return "I";
					}

				},
				{
					Text = "帮我踢那个门，%volunteer%！",
					function getResult( _event )
					{
						return "J";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你刚说完，大门便砰然上升。你默默地看着剩下的缝隙。%volunteer%蹲下来，把手伸到门顶下面，试图拿到瓶子。他用手指刮着它的玻璃，而大门的尖顶则像一只熊在不情愿地让人刷牙时开始零散颤抖。男人终于用两根手指掐住了瓶子，并反手接住了它。他站起来，把瓶子递给你。%SPEECH_ON%很简单，对吧？%SPEECH_OFF%你点了点头，然后转身用火炬喊道，大声要求知道谁在说话。没有回答。在黑暗中进行了简短的搜索，没有发现藏身之处，但找到了一些零碎的纸条和画有图案的笔记。这些页面似乎表明这些瓶子只需注入液体即可杀死亡灵。还有一张有一个丑陋的女人画上去的黏纸。你并不在乎谁在这里，你把瓶子拿出来回到了%companyname%。他们一听到你的声音就拔出剑，但看到你的脸后就羞怯地把剑又插回了鞘中。%SPEECH_ON%对不起，船长，以为你已经死了。还好你只是一个行走的死尸。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧, 我们现在就有解决那个问题的瓶子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/tools/holy_water_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你话一出口，门就嘎吱一声打开了。你注视着剩下的缝隙。%volunteer%蹲下，一只手插入门顶，另一只手牵取小瓶，手指在玻璃上刮着，同时门顶震动着。突然又传来那个声音。%SPEECH_ON%去你自己吧？你说啥，伙计！%SPEECH_OFF%说完，门闩坏了，门尖与%volunteer%的手臂相碰。他痛叫着，你跪在地上，拉起它，可它比预想的要重，你松手时，门像是断了线的风筝一样砰的一声，他的手臂这里只剩下了一条轮廓，那里的血液喷溅出来。你包扎伤口，帮他向出口走去，同时挥舞着火炬驱赶任何潜在的伏击者。在离开时，你停下来看了看你们在第一瓶药水旁发现的骷髅。你用小瓶滴了一滴，抹在你的手指上，没有反应。接着你把手指放在骨头上，它炸出嘶嘶声和烟雾。%volunteer%笑了。%SPEECH_ON%这就是为什么你是队长，先生。这种直觉可以带你走得更远！%SPEECH_OFF%你再也没有听到神秘声音，也不想成为一个神经病，因此对%companyname%没有提到这个谜题。%volunteer%的伤并不会毁了他。这只是为了这些古老瓶的微不足道的代价。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "景观如此, 很高兴有人按照这个价格支付。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
				local injury = _event.m.Volunteer.addInjury([
					{
						ID = "injury.pierced_arm_muscles",
						Threshold = 0.25,
						Script = "injury/pierced_arm_muscles_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Volunteer.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Volunteer.worsenMood(1.0, "在一座古墓的旅行中受伤");
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/tools/holy_water_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "J",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你受够了这些狗屎事。无论这声音是来自古代还是来自某个小丑，你都要彻底弄清楚。你向后退了一步，用靴子猛踢大门。第一下就将门轨弄成了倒 V 形，第二下门便断成了两截。很快，那个尖细的声音又回来了。%SPEECH_ON%喂!你不能那样做!%SPEECH_OFF%你清理了锈迹斑斑的碎片和锋利的尖刺，蹲下来看着一个男人跳进这个小房间。他跌落下来像是一只掉下悬崖的小鹿，并将瓶子从原本的位置打碎了。你抓住了他的脚，把他从铁篱笆间拖了出来。他紧握着发抖的手，%volunteer% 按着他的咽喉放着一把剑。%SPEECH_ON%我没恶意，我什么都没干。我只是开了个玩笑，什么事没有。%SPEECH_OFF%你询问他是谁，问他是不是在第一个瓶子里杀了那些人。%SPEECH_ON%我叫 %idiot%，那些人不是骷髅，他们是行尸走肉，然后他们闻到了瓶子里的东西就像喝醉了一样晕过去了。看呐，先生，我什么都没想干坏事!只是想开个小玩笑，没别的意思。我会为了自己的活命做任何事情!差不多所有的事情!%SPEECH_OFF%他看起来很担心。你看着 %volunteer%，他耸了耸肩。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，很好。 你可以加入我们。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return "K";
					}

				},
				{
					Text = "不, 那不会发生。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return "L";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"cripple_background"
				]);
				_event.m.Dude.getSprite("head").setBrush("bust_head_12");

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(_event.m.Volunteer.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "K",
			Text = "[img]gfx/ui/events/event_111.png[/img]{在黑暗中，这个人的眼睛闪闪发光，每一次的瞥视都像落下的余烬。%SPEECH_ON%你是认真的吗？我可以加入你们？太好了！%SPEECH_OFF%他慢慢地站了起来，好像急促的行动会导致更快的背叛。他伸出一只手，但你没有握。%SPEECH_ON%我叫%idiot%。我只有半个脑袋，其他都是木头和浆糊。当然了，我是引火物。开个玩笑。引火物。明白了吗？%SPEECH_OFF%你看着%volunteer%，后者将剑刺入这个人的胸膛。这个傻瓜的脸紧张了，当他低下头，看着剑刺穿了他的心脏。%SPEECH_ON%嘿，我想你杀了我。%SPEECH_OFF%%volunteer%点了点头。%SPEECH_ON%是啊。我杀了你。你还有几秒钟时间。讲话？%SPEECH_OFF%这个谜语人思考了一会儿。%SPEECH_ON%好吧，我没有准备任何话，但是...因为...你...问了...%SPEECH_OFF%他死在了这个词和刀下。佣兵清理了血迹，并搜寻了尸体，只在他的口袋里找到了发霉的老鼠骨头。当他放开尸体的时候，它发出空洞的撞击声。你蹲下来摸摸这个人的头骨，发现他说的并不是玩笑，它真的有一半是木头做的！你看着%volunteer%，后者耸耸肩。%SPEECH_ON%他要是拉出一坨金子来我也不会在意，我可不想忍受他的嘴巴。再说，看看他的眼睛！这个傻瓜就像是蝙蝠一样瞎眼一样。%SPEECH_OFF%这个谜语人的眼睛是一种空白的灰色。谁知道他在这个寺庙里待了多长时间呢。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "啊，好吧。 这两个瓶子是我们的了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "L",
			Text = "[img]gfx/ui/events/event_111.png[/img]{你没有时间理这个傻瓜。你任由他溜走，听着他的脚步声在黑暗中哧哧地嘲笑，就像是一个熟悉的洞穴中蝙蝠的扇翅声。不久之后，你听到他要逃跑，但没等他跑远，%companyname%就发出连绵不断的吼声并击倒了他，只有一声短暂的尖叫声。当你浮出水面的时候，你发现雇佣兵正在踢打这个笨蛋的尸体并抢走任何值钱的东西，大多只是一堆拙劣的谜语。\n\n%volunteer%笑了笑，把看起来很神奇的瓶子放进了物品栏。你命令士兵准备再次出发。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "仍然是一次成功的旅行, 所有的情况都考虑到了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Volunteer.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.Injury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Volunteer = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		else
		{
			this.m.Volunteer = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"volunteer",
			this.m.Volunteer != null ? this.m.Volunteer.getNameOnly() : ""
		]);
		_vars.push([
			"idiot",
			this.m.Dude != null ? this.m.Dude.getNameOnly() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Volunteer = null;
		this.m.Dude = null;
	}

});

