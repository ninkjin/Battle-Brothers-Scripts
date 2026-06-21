this.trade_black_book_event <- this.inherit("scripts/events/event", {
	m = {
		Translator = null
	},
	function create()
	{
		this.m.ID = "event.trade_black_book";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_174.png[/img]{一个人靠近了营地。 你离开你的帐篷发现他拿着一杆金色的长矛站在外面，枪杆像树枝一样突出些尖锐的棱角。 尽管武器看起来很具威慑性，但一对水罐和一个金色物件挂在上面使它有了其他用途。 那人自己把斗篷掀开露出一张非常奇特和苍白的脸，上面没有一根毛发。 他用完美的谈吐介绍他自己。%SPEECH_ON%你好陌生人，我的名字是尉迟绿洲。 我在这片土地上寻找着两件东西，其中一个我了解到在你的手中。 这是一篇关于自然，不，死亡存在的深刻文本。 我相信你的一个手下已经解开了它秘密的一部分，在这一点上，它它对你没有多大用处了。%SPEECH_OFF%%translator% 点头，声称只要他看向书页，他便不能解读出更多的内容并且怀疑某些人能做点什么。 尉迟吹了个口哨然后你回头看他。 那人伸出三根手指。%SPEECH_ON%为了书，我愿意用这些东西中的一样来交换：一个这片土地的忠实信徒称作镀金者的拥抱的金盾，我的两个罐子，喝下后，会让一个人强化到超越你想象的程度，或，看你们是佣兵，50000克朗。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们用这本书换金盾。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们用这本书换两个罐子。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们用这本书换50000克朗。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Translator.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "A2",
			Text = "[img]gfx/ui/events/event_174.png[/img]{一个人靠近了营地。 你离开你的帐篷发现他拿着一杆金色的长矛站在外面，枪杆像树枝一样突出些尖锐的棱角。 尽管武器看起来很具威慑性，但一对水罐和一个金色物件挂在上面使它有了其他用途。 那人自己把斗篷掀开露出一张非常奇特和苍白的脸，上面没有一根毛发。 他用完美的谈吐介绍他自己。%SPEECH_ON%你好陌生人，我的名字是尉迟绿洲。 我在这片土地上寻找着两件东西，其中一个我了解到在你的手中。 这是一篇关于自然，不，死亡存在的深刻文本。%SPEECH_OFF%那人伸出三根手指。%SPEECH_ON%为了书，我愿意用这些东西中的一样来交换：一个这片土地的忠实信徒称作镀金者的拥抱的金盾，我的两个罐子，喝下后，会让一个人强化到超越你想象的程度，或，看你们是佣兵，50000克朗。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们用这本书换金盾。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们用这本书换两个罐子。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们用这本书换50000克朗。",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_174.png[/img]{尉迟短暂的鞠了个躬，当他起身的时候他拿着一面盾牌。 第一眼，它看起来就是个边缘镀金的普通铁盾，但是突然一个黄色光球开始环绕外缘，一圈一圈的跳动着。%SPEECH_ON%他们称呼它为镀金者的拥抱，因为传说上帝的神性参与到了它的制造过程中。 看，如果你把这个转向你的敌人，光会变得如此耀眼以至于让你的敌人失去视野。 你看得出来，现在光还很昏暗，因为我们不是敌人，陌生人。%SPEECH_OFF%那人伸出他的手。 你给了他书，而他给了你盾。 他甚至没有看向书，只是单纯的放置起它并举起他的长矛。 你问他要拿这些文献做什么。他笑道。%SPEECH_ON%谁知道呢。或许我只是要把它还回去，哼？又或许不会。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你追寻的第二个东西是什么？",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				local book;

				foreach( item in this.World.Assets.getStash().getItems() )
				{
					if (item != null && item.getID() == "misc.black_book")
					{
						book = item;
						break;
					}
				}

				this.World.Assets.getStash().removeByID("misc.black_book");
				this.List.push({
					id = 10,
					icon = "ui/items/" + book.getIcon(),
					text = "你失去了 " + book.getName()
				});
				local item = this.new("scripts/items/shields/legendary/gilders_embrace_shield");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_174.png[/img]{尉迟把他镀金的长矛向前倾。 它的锋利度令人震惊，像个铁匠梦里打出来但从没被任何凡人的手铸成过。 那对罐子滑下来然后他抓住了它们的带子并递了过来。 你给了他书而他也放开了罐子。 不想被下毒，你要求他喝一口两个罐子里的液体，而他情愿的照做了。 抹了抹嘴，他点头道。%SPEECH_ON%我很偏好它的风味和效果，请不要为你的怀疑和迟疑浪费更多这个东西。%SPEECH_OFF%那人把书放到了他斗篷里的什么地方，拿起他的装备，并开始走远。 你问他准备拿这些文献做什么。他笑道。%SPEECH_ON%谁知道呢。或许我只是要把它还回去，哼？又或许不会。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你追寻的第二个东西是什么？",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				local book;

				foreach( item in this.World.Assets.getStash().getItems() )
				{
					if (item != null && item.getID() == "misc.black_book")
					{
						book = item;
						break;
					}
				}

				this.World.Assets.getStash().removeByID("misc.black_book");
				this.List.push({
					id = 10,
					icon = "ui/items/" + book.getIcon(),
					text = "你失去了 " + book.getName()
				});
				local item = this.new("scripts/items/special/trade_jug_01_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
				this.World.Assets.getStash().makeEmptySlots(1);
				item = this.new("scripts/items/special/trade_jug_02_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_174.png[/img]{尉迟点头。%SPEECH_ON%把书和你的战箱拿过来。%SPEECH_OFF%你把书丢给他然后把战队的宝库拿到这个人面前。 他从斗篷中伸出双臂并缓慢的倾向前。 克朗像溪流一样从袖子中流出，无穷无尽，然后再一个瞬间男人把他的双臂举了起来。%SPEECH_ON%你的 %reward% 克朗应该到齐了。%SPEECH_OFF%你让手下数了数硬币，而它刚刚好那么多。 你抬头说他很幸运，但他已经在收拾东西准备离开。%SPEECH_ON%保重，陌生人。%SPEECH_OFF%他走前，你问他准备拿这些文献做什么。他笑道。%SPEECH_ON%谁知道呢。或许我只是要把它还回去，哼？又或许不会。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你追寻的第二个东西是什么？",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				local book;

				foreach( item in this.World.Assets.getStash().getItems() )
				{
					if (item != null && item.getID() == "misc.black_book")
					{
						book = item;
						break;
					}
				}

				this.World.Assets.getStash().removeByID("misc.black_book");
				this.List.push({
					id = 10,
					icon = "ui/items/" + book.getIcon(),
					text = "你失去了 " + book.getName()
				});
				this.World.Assets.addMoney(50000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]50,000[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_174.png[/img]{尉迟转过身。%SPEECH_ON%哼？%SPEECH_OFF%你解释道他说过他来这里找寻两样物品。 其中一个是那本书，另一个呢？他笑道。%SPEECH_ON%这一片有一个城镇叫达根泰尔。 镇子没了但是有些住在那的东西依然在游荡。 一个他们称呼为“鬼”的东西。 我想找到它并和它说话。%SPEECH_OFF%当你想从他那儿询问更多信息时他单纯的用一个充满敬意的鞠躬告别。%SPEECH_ON%谢谢你的温柔交易，陌生人。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我希望我们把书给他是正确的…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsLorekeeperTradeMade", true);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.Flags.get("IsLorekeeperDefeated"))
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasBlackBook = false;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.black_book")
			{
				hasBlackBook = true;
				break;
			}
		}

		if (!hasBlackBook)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.militia")
		{
			local brothers = this.World.getPlayerRoster().getAll();
			local candidates_mad = [];

			foreach( bro in brothers )
			{
				if (bro.getSkills().hasSkill("trait.mad"))
				{
					candidates_mad.push(bro);
					break;
				}
			}

			if (candidates_mad.len() == 0)
			{
				return;
			}

			this.m.Translator = candidates_mad[this.Math.rand(0, candidates_mad.len() - 1)];
		}

		this.m.Score = 150;
	}

	function onPrepare()
	{
	}

	function onDetermineStartScreen()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			return "A2";
		}
		else
		{
			return "A";
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"translator",
			this.m.Translator != null ? this.m.Translator.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Translator = null;
	}

});

