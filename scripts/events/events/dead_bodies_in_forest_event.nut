this.dead_bodies_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.dead_bodies_in_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_02.png[/img] {当队伍穿过树林的时候，%randombrother% 在前面大声喊叫起来。 你顺着他手指的一排灌木丛之后看去。 当你向他走过去之后，你看见了他眼中的一切：三具尸体被挂在一棵树上。 他们发紫的脸庞和灰白的双脚在摇摆着，旋转着。有时风吹起来，他们便偶然面面相觑，令人不寒而栗。%randombrother% 注意到他们身上挂着木牌，上面写着他们各自的罪行。 “小偷，”读到一个。“妓女”另一个。“叛徒”最后一个。 已经看得够多了，你告诉你的人可以继续赶路了。 | 森林不会给你任何放松的机会，哪怕是一条能让人走下去的小路或幽径。 它是幽深而无情的，似乎并不希望你待在那里。 你很快就发现它也不想要任何其他人待在那里：一具尸体被发现缠绕在荆棘丛中，双腿弯折，手臂扭曲，所有这些都与他们的预期目的相吻合。 残余的嘴巴因惊恐而张大，眼睛因某种最后的折磨眯成一条缝。%randombrother% 追上你，他上下打量着这些尸体，然后点了点头。%SPEECH_ON%只要一声令下，就把这些尸体打扫干净，当然别指望让我们清扫这些荆棘。 但我要说的是，这人被迷失在这种地方，没有动物会发现他。 不过是个死人，对任何人或任何事没有任何用处。%SPEECH_OFF%你用手指着一只蚂蚁，它在不经意地乱翻死人的牙齿。 你的兄弟笑着摇了摇头。%SPEECH_ON%你确定他不也是迷失在这里吗？%SPEECH_OFF% | 你抬头盯着森林的树冠，观察光束进入的角度。 当你明白自己的想法时，%randombrother% 看起来很沮丧地走过来。%SPEECH_ON%先生，你应该来看看这个。%SPEECH_OFF%你点头告诉他带路。 他把你带到一个空地上，虽然不是真的叫空地。\n\n腿。到处都是断腿。有的是从脚踝处切断，有的从大腿处，还有从中间的其他地方。 它们杂乱无章地散落一地。 它们就这样，有些单独放在那，另一些则是成串地缠绕在一起，有些是和棍子一起在地上立着，就像是在开什么行走的玩笑似的，还有些甚至像是被扔进了树林里，在那里它们无力地躺在树枝上，或者倒在树根边。 有一只被串在一根烤肉叉上，小腿肚被烤成了黑色，就好像有人跑开，把它就这么扔在早已燃尽的余灰上。\n\n那个发现这些恶心玩意儿的兄弟站在你身旁。%SPEECH_ON%没有身体，先生。只有…腿。%SPEECH_OFF%你看向那个雇佣兵，但他能做的也就是耸肩。%SPEECH_ON%我们一块身体的部位都没有发现，先生。 我的意思是，不管怎么样，总该会有上半部分才对。 你觉得这里面有什么含义吗？ 我是说，到底谁会做这种事？ 卸掉人腿然后带走其他部分？%SPEECH_OFF%你不以为然地摇了摇头。看够了这些，并且脑子里也没有这些问题的答案，你匆匆地带领你的手下离开这片空地继续前进。 | 你停在一条小溪边洗漱，喝点东西，但是在你喝下第一口之前，%randombrother% 抓住了你的肩膀。 他指向上游。一个女人的尸体面部朝下漂浮在水上，她的长发扭曲活泼地荡漾着。 你感谢这位佣兵将你从死亡降临的这个世界的任何恶疾中拯救出来。 | 树冠厚实而扭曲。 无论上面有什么光都几乎不能穿透，当你的人前进时，阴影做成的织物层层包围着他们。 但在前方，你看到一根光柱在森林中闪烁。 很显然，这是别人先看到的。 而且这是他们看到的最后一件东西。\n\n在那道亮光中，一个男孩仰卧在一棵树上。 他的头昂着，双手向上张开。 紫色的污迹弄脏了他的手掌。%randombrother% 走上前然后果断地摇了摇头。%SPEECH_ON%毒浆果，这该死的孩子没机会活下来。%SPEECH_OFF%你回头看向战场兄弟，询问他是不是走得很安详。 那人又摇了摇头。 %SPEECH_ON%No.%SPEECH_OFF% | 一具尸体，或者说，它只是一具躯干。 胸部敞开，灰黑的内脏四通八达，就这么柔软地垂在那里。 你不知道它是个男人还是女人，但这肯定是个被刀切得远小于原来尺寸的成年人。 你想不到什么样的生物会这么做，尽管 %randombrother% 认为这可能是一个意志非常坚定的人所干的事。 | 你发现一具女人的尸体，背靠在树上。 她的胸口有一把刀，伤口迅速致命，就好像她本来还活着走得好好的然后突然死了。 在她上方，另一个女人挂在树枝上荡来荡去。 她的衣服是红色的。 尸体的头向前倾斜，好像在盯着她犯下的罪行，挂在那里的绳子在无声的风中呻吟。 | 你遇到了一片战场。 人，盔甲，武器，没有一个是有用的。 死者是被某种你不想学的纯粹的残暴弄这样的。 泥土上的脚印表示着这里曾经发生过什么大事，留下了毁灭和灾难的尾迹，并且没有给你任何冲动让你跟随这些脚步的去向。 | 向前走，你发现一个背上有几支折断的箭的死人。 更多的刺伤，凶手设法把他的弹药一件一件地取回。 那个人手里拿着一封情书，目的地显然是一个信中提及的女人。唉，真浪漫。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧。",
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();

		foreach( s in this.World.EntityManager.getSettlements() )
		{
			if (s.getTile().getDistanceTo(myTile) <= 6)
			{
				return;
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

