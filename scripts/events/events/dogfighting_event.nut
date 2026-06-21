this.dogfighting_event <- this.inherit("scripts/events/event", {
	m = {
		Doghandler = null,
		Wardog = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.dogfighting";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%%doghandler% 请求你让 %wardog% 参加本地的斗狗比赛。 这听起来是个糟糕的主意，但是这个人继续解释说斗狗可以赚很多钱。 驯兽师所需要的只是二百克朗的赌注。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，但是我要和你一起去。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "不准做这种事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%townImage%你拿着一包克朗，跟着 %doghandler% 穿过寂寞的风和黑暗的街道。 很快，就没什么可看的了。 湿漉漉的鹅卵石，被月光照成白色，懒洋洋地把你带进城市的深处，不让那些喜欢白天的人看到。 突然，一个火炬燃烧起来，一个男人的脸，漂浮在黑暗中，对你说话。%SPEECH_ON%这条狗是来打架的么？%SPEECH_OFF%%doghandler% 点头。陌生人把火炬向前倾斜。%SPEECH_ON%那么好吧。这边请，先－生－们。 小心脚下，全是各种各样的尿。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就这么做吧。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我改变主意了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%townImage%跟着那人的火炬穿过黑暗，你来到一幢有滑动门的建筑前。 陌生人敲了几下门，门就开了，最后的敲门声好像是暗号。 你被领了进去，当你进去时，一张张斜视的脸在一旁看着。 很快的，你就听到了令人不安的咆哮和犬吠声。 这就是你来的目的，对吧？\n\n 楼梯会把引到竞技场，那里有一群人挤在一个临时搭建的由泥土和摇摇欲坠的栅栏围成的地方。 虽然目前还看不出是怎么斗狗，但场地另一边是一堆死狗，它们旁边坐着杀手，眼睛睁得大大的，满嘴鲜血，令人惊恐地喘着粗气。 当两只狗在竞技场上争得不可开交时，你瞥了一眼 %doghandler%。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是时候下注看看我们的杂种狗能做些什么了。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "This is bad. 让我们离开这里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_47.png[/img]在支付了二百克朗的赌注后，你和 %doghandler% 带着 %wardog% 进入了竞技场。\n\n它的眼睛扫视四周，当它的肩膀靠在你的裤腿上时，你会感觉到心跳加速。 站在你对面的是你的竞争对手：一个面目可憎的狗贩子和一个更像是狼的巨大野兽。 这只杂种狗失去了下唇，露出了一排锯齿状的牙齿，这些牙齿被打磨得比原来更致命。 它不平的身体上布满了疮痂和溃疡，但它的肌肉结构却很强健，%doghandler% 小声说这将是一场可怕的战斗。\n\n %wardog% 不停地叫着，向前猛冲，这条杂种狗体内充满了战斗的血液，只要你松开一只手，你就可以把你的战犬放开，就像你的对手那样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "上吧，孩子！",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "E";
						}
						else if (r <= 66)
						{
							return "F";
						}
						else
						{
							return "G";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				this.World.Assets.addMoney(-200);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]200[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_47.png[/img]两只狗向对方冲去，一眨眼就冲过了自己的那半边场地。 它们相撞了，粗糙的身体在它们的脚落地前互相弹开，它们继续冲锋准备二次相撞。 对手的狗在 %wardog% 面前把头放低，然后抬起后背，悄悄的把头伸到你的狗的脖子下面。\n\n%doghandler%的双手捂着脸，两眼从指缝间向外瞪着。 你看着 %wardog% 左右摇晃。 血从它的鼻子里喷涌而出。 你可以听到狗在试图踢过泥土时，腿发出的无助的刮擦声。 观众发出一阵嘲笑和大笑声。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不能介入。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "H" : "I";
					}

				},
				{
					Text = "这需要制止！",
					function getResult( _event )
					{
						return "J";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_47.png[/img]两只狗疾驰着穿过场地。%wardog% 头的位置更高，它的对手要低一些。 你惊恐地看着对手的杂种狗从低处跃起，用下巴咬住了 %wardog%的脖子。 他们在竞技场上翻滚而过，在猛烈的冲力下，%wardog%的喉咙被撕开了。 血喷得如此猛烈，以至于观众都向后跳去想要避开。 获胜的杂种狗回到它的主人身边，把一块破肉和肌肉扔在他的脚边。\n\n%wardog% 跌跌撞撞地穿过泥土。 它喘不过气来，喉咙皱着，呼哧呼哧地响，还含着口水。%doghandler% 跳过栅栏，跪在杂种狗旁边。 他试图盖住伤口，但没有用。 狗死的时候依然盯着你看。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				_event.m.Wardog.getContainer().unequip(_event.m.Wardog);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog.getIcon(),
					text = _event.m.Wardog.getName() + "死了。"
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_47.png[/img]这两条狗在冲上去之前短暂地咆哮了几声。 它们互相冲撞，同时试图咬对方的脖子，在赛场上滚作一团，就像某种毛茸茸的猛烈旋转的风车。\n\n%wardog% 把对手撞到栅栏上。 你看着你的狗把下巴伸到对手的脸上，一口咬住对手一只眼睛，另一口咬住对手一大块舌头。 被打败的杂种狗被撕成了碎片，毫不夸张地说，它输在错误地试图去咬你的狗的喉咙。\n\n你的对手大喊大叫，试图跳过栅栏，但观众把拉回来了。%doghandler% 拍拍你的背。%SPEECH_ON%轻松地赚了一笔，不是吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "看来战队还拥有最卑鄙和最坏的狗狗们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				this.World.Assets.addMoney(500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]500[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_47.png[/img]你决定不介入，而是让 %wardog% 继续战斗，对潜在的死亡顺其自然。 这样的选择很快就有了回报：你看着你的狗用它的后爪踩着竞技场周围的一个栅栏。 随着一记有力的登踏，它设法钻到对手肚子下面，在那里撕扯悬挂的睾丸，这真是一个恶心的求生本能展示。 可怜的杂种狗被阉割了，尖叫着，转过身来却把脖子直接伸进了 %wardog% 的嘴里。战斗很快就结束了，近乎仁慈的方式结束了，到此为止。\n\n 你去领取你的奖赏的时候，%doghandler% 拥抱正在摇尾巴的 %wardog%。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好孩子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				this.World.Assets.addMoney(500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]500[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_47.png[/img]你没有介入，并把试图翻越栅栏的 %doghandler% 拉了回来。 你们俩只能惊恐地看着这只凶猛的杂种狗一次次撕咬着 %wardog%的脸。 很快，你的狗就倒在地上，放弃了脖子。 血腥的撕咬紧随其后，%wardog% 很快就变成了一条死狗。 悲痛欲绝的 %doghandler% 只能瘫倒在地，掩面而泣。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				_event.m.Wardog.getContainer().unequip(_event.m.Wardog);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog.getIcon(),
					text = _event.m.Wardog.getName() + "死了。"
				});
			}

		});
		this.m.Screens.push({
			ID = "J",
			Text = "[img]gfx/ui/events/event_20.png[/img]你把你的投注票扔进了泥土里。%SPEECH_ON%操他妈的。%SPEECH_OFF%你飞快地一跃跳过栅栏，跑进了竞技场。%doghandler% 就跟在你的后面。 两只狗还在打架，但你一脚踢过去就把它们分开了。 这个驯兽师迅速抓住 %wardog%，把它从危险中拉了出来。 人群中嘘声四起，瓶子和玻璃杯纷纷飞了进来。 一个人吹一声口哨，让他们都安静下来。 他步入竞技场。%SPEECH_ON%这些人花钱是为了看血腥。 如果你不打算给他们，那么你最好找到另一种支付方式。 二百克朗怎么样？ 或者你直接把狗放回去。%SPEECH_OFF%人们正掰着指关节，拿出刀子，铁链和其他粗糙的武器。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿去这些狗屁克朗，然后。 我们带着狗离开。",
					function getResult( _event )
					{
						return "K";
					}

				},
				{
					Text = "这场战斗还是继续吧。",
					function getResult( _event )
					{
						return "L";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "K",
			Text = "[img]gfx/ui/events/event_20.png[/img]你拿出 %demand% 克朗，然后把钱交了上去。 人群发出嘘声，但场主再次吹响了哨子。%SPEECH_ON%闭嘴，你们这些家伙！ 他给了钱，所以他和他的蠢狗可以走了。%SPEECH_OFF%人群安静下来。 你开始离开，%doghandler% 跟在你身后，%wardog% 无精打采，四肢无力地挂在他的手臂上。 有些赌客会发出嘘声和吐唾沫，但那是他们做的最多的事情，你完全可以承受。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们回营地…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				this.World.Assets.addMoney(-200);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]200[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "L",
			Text = "[img]gfx/ui/events/event_20.png[/img]你命令 %doghandler% 把狗放下。他瞪大了眼睛。%SPEECH_ON%你不是认真的吧。%SPEECH_OFF%点头，你说你是。%wardog% 几乎没有清醒，鼻息在惊恐的警觉性和麻木的意识之间。 当 %doghandler% 还在犹豫的时候，你抓住狗，把它拉开。 你向人群点头，然后你的对手第二次释放他的凶残的恶犬。%wardog% 疲惫不堪，泪汪汪的眼睛抬头看着你，眨了眨眼睛，然后合上。 你把狗放下，你的对手的恶犬就带着兽性的狂暴扑向它。 你试着不去听在你脚下上演的恐怖死亡大戏。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们回营地…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Doghandler.getImagePath());
				_event.m.Wardog.getContainer().unequip(_event.m.Wardog);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog.getIcon(),
					text = _event.m.Wardog.getName() + "死了。"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 250)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Doghandler = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Wardog = this.m.Doghandler.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"doghandler",
			this.m.Doghandler.getNameOnly()
		]);
		_vars.push([
			"wardog",
			this.m.Wardog.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"demand",
			"200"
		]);
	}

	function onClear()
	{
		this.m.Doghandler = null;
		this.m.Wardog = null;
		this.m.Town = null;
	}

});

