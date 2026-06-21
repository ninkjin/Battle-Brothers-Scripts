this.greenskins_investigation_event <- this.inherit("scripts/events/event", {
	m = {
		Noble = null,
		NobleHouse = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_investigation";
		this.m.Title = "在 %town%…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_31.png[/img]当你补充你的货物并让队员们休息的时候，城堡的领主 %nobleman% 来找你。 他说城堡里有个哥布林逃跑了，他想让你去追踪它。%SPEECH_ON%我问过我的人了，但是他们蠢的连自己的屁股都找不到，真该挖出他们的眼睛吃了。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我们要搜查食品储藏室。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B1";
						}
						else
						{
							return "B2";
						}
					}

				},
				{
					Text = "我们要搜查大厅。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "E1";
						}
						else
						{
							return "E2";
						}
					}

				},
				{
					Text = "我们要搜查武器库。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "H1";
						}
						else
						{
							return "H2";
						}
					}

				},
				{
					Text = "我们没时间帮忙。",
					function getResult( _event )
					{
						_event.m.NobleHouse.addPlayerRelation(-5.0, "拒绝 (Denied)" + _event.m.Noble.getName() + "一个恳求/请求");
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_31.png[/img]你搜索食品储藏室，打开门，看到一层又一层的食品，从奶酪到腌肉，再到挂在墙上挂钩上的蔬菜。 藤条制成的筐吸引了你，但当你想过去品尝的时候，一个身影从你身边掠过。 你转身，手里拿着利刃，刺向那个拿着破瓶子向你冲来的哥布林。 它马上就死了，把地板弄得一团糟，弄坏了几包面粉。 这个绿皮被杀死了，你冷静地把它拖到 %nobleman% 那里。贵族用手拍了拍屁股。%SPEECH_ON%非常厉害，佣兵，但你非得一路把它拖到这里来吗？ 我的仆人们将不得不擦洗地板好几个星期！%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这很简单。 ",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助了 " + _event.m.Noble.getName());
				local food = this.new("scripts/items/supplies/wine_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了葡萄酒"
				});
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_31.png[/img]你下楼到食品储藏室去开门。 在里面，你发现一个又一个摆满食物和商品的架子。 还有一个男人和一个女人在角落里做爱。 他们像一对畜生一样尖叫，并遮住自己的身体，男的用了一个湿面粉包，女的战略性地躲到一个瓜架子后边。 他清清嗓子。%SPEECH_ON%求你了，先生，不要告诉 %nobleman%。%SPEECH_OFF%你甚至不知道这是贵族的妻子，但现在很高兴知道了。 男人提出了一个交易。%SPEECH_ON%你看，我只是个马童。 我不能给你金子或者别的什么，但是一个著名的格斗家要在这里呆一个星期，我可以拿他的盾牌给你。 这是一件漂亮的东西，我保证你会喜欢的。 我只请求你不要告诉领主！%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你的领主会听到的。 ",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我会为你保密的。 ",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_31.png[/img]这似乎是与 %townname% 建立稳定关系的良机，这也是最好的方法来摧毁刚才那段偶遇促成的关系。 你回到 %nobleman%的房间，报告你的发现。 他的脸变红了，手上青筋暴起。%SPEECH_ON%我知道了。我知道了。我他妈的知道了！ 怎么是那个马童干的？ 我不会被这样侮辱的！%SPEECH_OFF%他向他的警卫伸手示意。%SPEECH_ON%给我拿个铁钳过来，要铁匠烧红的。 带我的妻子去塔楼。 我一会儿再收拾她。 还有你，佣兵，谢谢你把这个消息带给我。 至于哥布林，它已经被找到并处理了。 你不必再为此担心了。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "真是个野蛮的家伙。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助了 " + _event.m.Noble.getName());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_31.png[/img]你决定不告诉贵族他的妻子做了什么。 这对小情人穿好衣服，急匆匆地走出食品储藏，马童停下来告诉你，当你离开城堡时，他会把盾牌准备好。 与此同时，你要向帮了你一把的领主报告。%SPEECH_ON%唉，你不用再为自己担心了，佣兵。 那个哥布林是在马厩里被发现的。 其中一匹马把它踹出了谷仓！ 我得奖励一下那个马童，你看他的马能当兵！%SPEECH_OFF%哼，当然。\n\n 当你离开城堡时，马童就在那里，手里拿着一个形似盾牌的袋子。%SPEECH_ON%给你，拿走这个。小心点。 再次感谢你，佣兵。%SPEECH_OFF%你告诉他最好以后不要再犯。他摇了摇头。%SPEECH_ON%不！她值得我这么做。 回头见，佣兵。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "有些人真是不长记性。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.World.Assets.addMoralReputation(-1);
				local item = this.new("scripts/items/shields/faction_heater_shield");
				item.setFaction(_event.m.NobleHouse.getBanner());
				item.setVariant(2);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E1",
			Text = "[img]gfx/ui/events/event_31.png[/img]你调查了大厅，看看这个绿色的小矮子是不是留下了脚印。 走在走廊上，你听到附近一个房间里传来两个女人的尖叫声。 你拔出剑闯进来。 一个记录员和司库站在办公桌上，一个哥布林跳上跳下，试图用刀割他们的脚踝。 你随意地走过去，刺穿它的胸膛，然后把它像串起来的松鼠一样放上去。 人们冷静下来，感谢你的工作。你点头。%SPEECH_ON%随时效劳，女士们。%SPEECH_OFF%他们清清嗓子，露出紧张的微笑。 你回到 %nobleman% 那里，并得到了你的报酬。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这很简单。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助了 " + _event.m.Noble.getName());
				this.World.Assets.addMoney(100);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得[color=" + this.Const.UI.Color.PositiveEventValue + "]100[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E2",
			Text = "[img]gfx/ui/events/event_31.png[/img]你认为大厅是一个很好的地方，开始你的搜索。 仅仅经过几次迂回曲折之后，你就听到从账房传来一阵令人不安的噪音。 拔出你的利刃，你在门边放松，然后用肩膀把它打开，把你的武器对准任何可能站在另一边的东西。 不是哥布林，而是一个吓得跳起来的年轻人和老人，他们的裤子都掉在地上，他们靠着的办公桌上有一桶洒了的黄油。 房间里的气味…糟透了。\n\n 穿好裤子，年轻的人说他是司库，而年长的人告诉你他的职位是记录员。 司库很快给了你一大堆硬币，让你对这些微妙的事情保持沉默。你大笑。%SPEECH_ON%我不会被这个把戏骗的。 如果我拿了这些硬币，你就跑去告诉你的主人是我偷的，不是吗？ 还有什么比确保我被判死刑更能保护你们自己呢？%SPEECH_OFF%司库后退，记录员走上前。 他是个上了年纪的人，身上有股蜡味。%SPEECH_ON%在我的宝库中，有许多属于我自己的东西，而不是属于我的主人。 这些东西你可能会很感兴趣。 有药剂，饮品，还有一些像你这样的战士能用到的东西。 还有…我还会奉上一条战犬！ 一个本地的驯兽师欠我一个人情，现在正是去拜访他的好时机！%SPEECH_OFF%当你仔细考虑这个想法时，记录员紧张地笑了。 如果你把他们交上去，谁知道会发生什么事。 肛交者这种事你漠不关心，但全国各地的领主都认为这种淫乱是可耻的。 如果 %nobleman% 是这样的家伙，你可能通过“揪出”这两个人来获得好感。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这个城堡的主人将决定你们的命运。",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "我会为你保密的。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_31.png[/img]你关上房间的门，急忙奔向 %nobleman%。你向贵族解释你所看到的。 当你讲完的时候，他说那个哥布林被发现淹死在一条污水沟里，现在已经脱离了它的痛苦。%SPEECH_ON%至于肛交者，是有，那又怎样呢？ 你四处看看了吗？ 城堡这种环境会使人产生荒谬的欲望。 在目所能及的地方全是坚挺的鸡巴，没有地方释放它们。 Do I like it? 不，当然不。 绝对是恶心的存在，真的。 但如果我惩罚每一个这样的行为，我会留下一堆稻草人和农场牲畜，我甚至不能确定后者。%SPEECH_OFF%他挥手叫你走开。%SPEECH_ON%哥布林的事儿已经处理好了，佣兵，我没有什么别的话要对你说。 不过，如果可以的话，请告诉仆人们，你找到他们的那个房间需要打扫。 我不想在一团屎雾中查看税收。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Oh.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_31.png[/img]你决定把他们的秘密隐藏起来，假设记录员会给你他所承诺的。 你离开时，老人点了点头。%SPEECH_ON%我会在院子里等你，佣兵，还有你欠的一切。 非常感谢你对这件事保持沉默。%SPEECH_OFF%当你回到 %nobleman% 那里时，解释说哥布林已经找到并处理了。 鉴于你不负责任，他把你白白地打发走了。\n\n 在外面，记录员确实等着你。 他一只手牵着绳子，另一只手拿着袋子。 他把这些都交给你了。%SPEECH_ON%再次向你表示感谢，佣兵。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我应该多干保密的事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				local item;
				item = this.new("scripts/items/accessory/poison_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/accessory/antidote_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/accessory/berserker_mushrooms_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/accessory/wardog_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "H1",
			Text = "[img]gfx/ui/events/event_31.png[/img]如果你是城堡里被追杀的哥布林，你会去哪里？ 把你自己想象成一个小不点，你会得出结论，武器库将是你开始搜寻的最佳地点。 当你到了那里，你发现一个学徒站在门外，试图把门关上。 他大叫地说哥布林在里面，并且已经杀死了铁匠。 拔出你的利刃，你让学徒站到一边。\n\n 又一次的，门就被撞开了，一个像破桶做的稻草人模样的哥布林跌跌撞撞地走了出来，从头到脚全副武装，前面笨拙地拿着盾牌和长矛。 无视所见的荒谬，你趁乱而上，刺穿这个畜生的头颅，立刻杀死它。 当你拔出剑的时候，所有的盔甲和武器都掉了下来，就好像你杀死了一个举着它们的幽灵。\n\n 学徒很快握了握你的手，然后跪倒在地，为失去铁匠而哭泣。 没时间流眼泪了，你拿着哥布林的头，回到 %nobleman% 那里领取奖赏。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这很简单。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助了 " + _event.m.Noble.getName());
				this.World.Assets.addMoney(100);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得[color=" + this.Const.UI.Color.PositiveEventValue + "]100[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "H2",
			Text = "[img]gfx/ui/events/event_31.png[/img]好吧，如果你是敌方要塞里的一个小矮人，你首先要去的地方就是武器库。 当你到达那里时，你没有发现任何哥布林，而是有一个小孩从一个面朝下趴在地板上的人身上拔出匕首。 凶手丢下武器，举起双手。%SPEECH_ON%我别无选择！ 没的选择！%SPEECH_OFF%你问那孩子他和那死人是谁。他很快解释道。%SPEECH_ON%我是学徒，这是…是铁匠。 现在，这是不得不做的。不得不！ 你不知道这个人把我搞得多惨！ 每次我犯错，他就惩罚我，好像我是一个弑君的白痴！看到了吗？%SPEECH_OFF%他拨开一缕头发，露出烧伤的球根状伤疤。 他松开头发，举起一只手，那只手的小指怪怪的，呈直角，另一只手完全没有小指。 他开始脱靴子，但你阻止了他，明白了重点。 学徒双手紧握在一起，他的小指伸出来，就像一个高傲的贵族在啜饮美酒。%SPEECH_ON%你在找哥布林，对吗？ 告诉他们是哥布林干的！ 我会…听着，我不是一个很好的武器制造者，但是我可以打造一把无人能及的剑，而且我会尽我所能打造给你。 我只要求你我之间保守这个秘密。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "如此罪行不可被宽恕！",
					function getResult( _event )
					{
						return "I";
					}

				},
				{
					Text = "我会为你保密的。",
					function getResult( _event )
					{
						return "J";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_31.png[/img]你关上门，锁上，确保凶手不能逃跑。 随着学徒的尖叫和门上的砰砰声，你回到了贵族那里。\n\n %nobleman% 听了你的报告，点了点头。%SPEECH_ON%嗯哼，是的。铁匠不是第一个被那个男孩杀死的－我们这里发生了一连串的谋杀案，但始终没能找到罪犯。 许多人相信他，因为他用锤子敲打他的手，把他的脸放在火把上。 马童甚至看到他割下一只老鼠的鸡鸡。 他是个精神失常的人，但你现在给了我们他所作所为的确凿证据。 很出色，佣兵！你要找的那个哥布林已经被干掉了，但是这个…这比捕猎一些绿皮要好得多。 鉴于此你的报酬加倍！%SPEECH_OFF%贵族朝他的记录员打了个响指，然后开始发出命令，表面上是发出执行令。 他不可思议地长篇大论来描述事件的后勤保障：马匹，绳子，刀片，钳子，火堆，以及一长串让无聊的士兵们高兴几个小时的恐怖场景。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "非常好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助了 " + _event.m.Noble.getName());
				this.World.Assets.addMoney(200);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得[color=" + this.Const.UI.Color.PositiveEventValue + "]200[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "J",
			Text = "[img]gfx/ui/events/event_31.png[/img]你关上门，锁上，确保凶手不能逃跑。 随着学徒的尖叫和门上的砰砰声，你回到了贵族那里。\n\n %nobleman% 听了你的报告，点了点头。%SPEECH_ON%嗯哼，是的。铁匠不是第一个被那个男孩杀死的－我们这里发生了一连串的谋杀案，但始终没能找到罪犯。 许多人相信他，因为他用锤子敲打他的手，把他的脸放在火把上。 马童甚至看到他割下一只老鼠的鸡鸡。 他是个精神失常的人，但你现在给了我们他所作所为的确凿证据。 很出色，佣兵！你要找的那个哥布林已经被干掉了，但是这个…这比捕猎一些绿皮要好得多。 鉴于此你的报酬加倍！%SPEECH_OFF%贵族朝他的记录员打了个响指，然后开始发出命令，表面上是发出执行令。 他不可思议地长篇大论来描述事件的后勤保障：马匹，绳子，刀片，钳子，火堆，以及一长串让无聊的士兵们高兴几个小时的恐怖场景。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "非常好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				local item = this.new("scripts/items/weapons/arming_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestTown;

		foreach( t in towns )
		{
			if (!t.isAlliedWithPlayer())
			{
				continue;
			}

			if (!t.isMilitary() || t.isSouthern() || t.getSize() < 2)
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 4)
			{
				bestTown = t;
				break;
			}
		}

		if (bestTown == null)
		{
			return;
		}

		this.m.NobleHouse = bestTown.getOwner();
		this.m.Noble = this.m.NobleHouse.getRandomCharacter();
		this.m.Town = bestTown;
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
		_vars.push([
			"nobleman",
			this.m.Noble.getName()
		]);
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
		this.m.Noble = null;
		this.m.Town = null;
	}

});

