this.witchhut_destroyed_event <- this.inherit("scripts/events/event", {
	m = {
		Replies = [],
		Results = [],
		Texts = []
	},
	function create()
	{
		this.m.ID = "event.location.witchhut_destroyed";
		this.m.Title = "战斗之后";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Texts.resize(7);
		this.m.Texts[0] = "你是谁？";
		this.m.Texts[1] = "你怎么知道我是谁？";
		this.m.Texts[2] = "谁是古人？";
		this.m.Texts[3] = "什么是达库尔？";
		this.m.Texts[4] = "绿皮是人类吗？";
		this.m.Texts[5] = "你为什么叫我假国王？";
		this.m.Texts[6] = "我梦想的是什么？";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫全部被击败，你们割下他们的耳朵、嘴唇、鼻子和脚趾，为根彻底铲除他们。他们的背包被清空，里面的物品被粉碎并掩埋在尘土中，肉块或动物的部分被倒在一起然后迅速被烧毁。当火焰升腾时，小木屋里的女巫似乎从无处出现，抓住了你的胳膊。你的士兵拔出剑，但你们示意他们停手。你让他们继续清理战场，然后进入小木屋。回头看时，你看到一些士兵正在尿在火堆上。\n\n在小屋里，你坐在原地。在桌子上，你发现一包手绢包裹着一个东西。女巫捏住它的角落，用手指捻着它。她抬起头，微微点了点下巴，掌心朝上翻转双手。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B0",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫微笑着。%SPEECH_ON%一个森林小屋里的老巫婆。其他的都只是谣言。%SPEECH_OFF%你盯着她看了很久，发现追究这个问题已经没有太大的价值了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[0] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_115.png[/img]{她凝视着包裹着的物品。%SPEECH_ON%我甚至不知道你叫什么名字，雇佣兵，我也没有丝毫的兴趣去关心。这不是关于你是谁，而是关于你是什么。%SPEECH_OFF%她转动手，好像在跟随一首歌。%SPEECH_ON%远古的血液在你的身体内流淌着。它在我们所有人的身体内都有，但是在你身上，尤其强烈。%SPEECH_OFF%她的鼻子皱了皱，哼了一声，然后狂笑着呼出气来。 %SPEECH_ON%它就在那里，如果我能闻到它，那么整个世界都能闻到它。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[1] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_115.png[/img]{她轻拍手绢，桌子下传来了敲击声。她回答道：%SPEECH_ON%古代人比我们还要早得多。真正，绝对早于我们的时间。想象一下一个国家，现在想象一个统治国家的国家。一个帝国，那样是正确的。现在想象一个支配帝国的帝国。这种难以想象的力量留给世界带来了极大的复仇，并将消耗它的垂死日子来毁掉那些毁掉它的人。%SPEECH_OFF%你问这个帝国是否已经灭亡。女巫微笑了。%SPEECH_ON%我认为没有，但我并不真正知道。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[2] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B3",
			Text = "[img]gfx/ui/events/event_115.png[/img]{耸耸肩，向后靠斜，女巫让你重复名字。“达夫库尔(Davkul)。”她摇了摇头。%SPEECH_ON%我没有听说过这个达夫库尔。你说他是一个所谓的神？好吧，他没有与我交谈过。%SPEECH_OFF%你盯着她，试图从她的眼中窥探到一个隐藏的真相，但她的回答似乎很真诚，你改变了话题。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[3] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B4",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫咯咯地笑了起来。%SPEECH_ON%我倒希望如此！你见过兽人腿之间长了些什么吗？如果我知道它不会把我撕成两半，一头插在我身上，用另一头当手套，我真是不介意试试！%SPEECH_OFF%你扬起眉毛，点了点头，好像在说“当然了”。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[4] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B5",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫面具上出现了一道裂缝，她皱起了嘴唇。%SPEECH_ON%我什么时候叫过你这个名字？%SPEECH_OFF%你指了指门，又指了指桌子，回答道。%SPEECH_ON%我走进来之后，你说我要寻找真相，你知道伪王的梦境。%SPEECH_OFF%女巫无聊地拍了拍手帕，然后抬头看着你。%SPEECH_ON%那么，卖剑客，你有我的道歉，我不记得这种事了。我只是一个脆弱而老朽的女人，我比看上去要老，但我不是在耍嘴皮子。%SPEECH_OFF%你继续追问，但她只是更加拒绝透露。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[5] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "Dream",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫俯身。她用手触摸你的脸，你感到她的皮肤粗糙，手指深深地插进你的脸颊，像半打核桃一样。她按摩你眼角的位置，敲敲你的太阳穴。一直微笑，然后她缩回去。%SPEECH_ON%你去找贵族和富人，他们会付给你金币，作为回报，你冒着生命的危险，屠杀和杀戮所有可以屠杀和杀戮的东西。日复一日，你不知道自己是否只有这个用处，然后高贵的人关上门不再理会你和你的所作所为。你听到他们在里面欢笑、嬉闹，音乐响起，妇女们开怀大笑，举行狂欢节。你拿着一袋金子和沾满血迹的收据来到了这里，你到了酒馆，买了个妓女，给吟游诗人一枚硬币，让他唱一首歌，你甚至在最便宜的酒窖里也能品尝到好酒的味道，但是那种可怕的感觉仍然在你的脑后，你认为自己生来就是热血沸腾的，而这种暴力和死亡并不是手段，而是一种目的。这就是你现在想要做的和你将来要成为的人。%SPEECH_OFF%她停了下来，叹了口气，继续说道。%SPEECH_ON%雇佣兵，谎言的力量等同于一个人相信谎言的欲望。你生活在一种强大的谎言中，这种力量不会轻易消失。我恳求你，只要做你能理解的事。%SPEECH_OFF%现在她对你的恐惧并不是因为你自己，也不是因为你的武器，甚至不是因为你所在的集体，而是因为她现在对某个未知事物的认识。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我是谁？！",
					function getResult( _event )
					{
						return "WhoAmI";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "WhoAmI",
			Text = "[img]gfx/ui/events/event_115.png[/img]{你站起来对着那个女人大喊要求回答。她扇了你一巴掌，你僵直了一下，往后退了一步。一滴血滑下你的脸颊，你把它擦在袖口上。女巫抓住手绢，把它甩开，露出下面的黑曜石刀。它比你记忆中更加锋利，一道鲜明的自我镶嵌在刀刃上，仿佛你向着镜子打开了一扇门。巫婆坐回到座位上，把武器推到桌子的另一边。%SPEECH_ON%没有更多的问题了，佣兵。我所知道的只有这么多，你需要知道的也只有这么多。我们达成了一项协议，这就是结束了.%SPEECH_OFF%你拿起匕首问她做了什么，但她拒绝回答。然后你问她是否还有像她这样的人。她开心地笑了起来。%SPEECH_ON%愿天堂保佑，不会有的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们完了，我应该离开了。",
					function getResult( _event )
					{
						return "Leave";
					}

				},
				{
					Text = "那么，你已经实现了你的目标。 死吧，女巫！",
					function getResult( _event )
					{
						return "Kill";
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/weapons/legendary/obsidian_dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Leave",
			Text = "[img]gfx/ui/events/event_115.png[/img]{你和那个女巫告别后，她没有多说什么。走出去，有人问她说了什么，还有人提到了性冒险。你认为你在咧嘴笑，但你真的不知道。这次谈话让你感到困惑，只能依靠你所知道的：命令队伍继续上路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该出发了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsWitchhutLeft", true);
			}

		});
		this.m.Screens.push({
			ID = "Kill",
			Text = "[img]gfx/ui/events/event_115.png[/img]{女巫交叉着手指点了点头，你也点了点头。然后你拿起黑曜石匕首，猛地将其插进她的胸膛。她的流血与你所认识的男男女女一样。她痛苦地咳嗽，就像所有活着的生物一样。她向后摇摆，眼睛充满恐惧，就像你以前认识的很多人一样。你抽出匕首，踢了她一脚。她吼叫着，手掌抓住了捕梦网和蜘蛛网，她的肘撞向一个木制餐具板，所有的餐具都发出空心的咔哒声，散落在小屋里。她拿着一把黄油刀，手指虚弱地握住，目光直视着你。她咳了一声，两声。她放开黄油刀，用拳头拍打胸口，喷出一股血花，溅到她的下巴上。她抬起头来。%SPEECH_ON%我们有约定，佣兵。%SPEECH_OFF%你将匕首收回，并点点头。%SPEECH_ON%没错，你和雇佣兵有约定，你得到了你想要的。而我呢？我和这个世界达成了协议，要把你和你的同类消灭干净。说了这么多，祝你好运。%SPEECH_OFF%女巫的头低垂在地板上，身体变得无力。当你走出小屋时，战团问发生了什么事。你告诉他们焚烧小屋，准备上路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该出发了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsWitchhutKilled", true);
			}

		});
	}

	function addReplies( _to )
	{
		local n = 0;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!this.m.Replies[i])
			{
				local result = this.m.Results[i];
				_to.push({
					Text = this.m.Texts[i],
					function getResult( _event )
					{
						return result;
					}

				});
				n = ++n;

				if (n >= 4)
				{
					break;
				}

				  // [034]  OP_CLOSE          0      4    0    0
			}
		}

		if (n == 0)
		{
			_to.push({
				Text = this.m.Texts[6],
				function getResult( _event )
				{
					return "Dream";
				}

			});
		}
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		this.m.Replies = [];
		this.m.Replies.resize(6, false);
		this.m.Results = [];
		this.m.Results.resize(6, "");

		for( local i = 0; i < 6; i = ++i )
		{
			this.m.Results[i] = "B" + i;
		}
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

