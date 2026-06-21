this.incense_trade_event <- this.inherit("scripts/events/event", {
	m = {
		Dancer = null
	},
	function create()
	{
		this.m.ID = "event.incense_trade";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_144.png[/img]{当你穿越雪原时，一个奇怪的人走到了路上。你可以看到他肩上系着绳子，远处的黑色风筝在他上空翱翔，飘忽旋转，仿佛他在把自己当成自己制造的木偶。他的脸看起来像是一个能够制造这样玩意的人，一种疯狂的扭曲，对着他自己想了数年的一个笑话咯咯地笑着。他黑色的肤色在北方很不常见，而当他说话时，他知道你的语言。%SPEECH_ON%你们身上有怪东西，好闻的怪东西。那是什么呢，不是肉，不是柔软的人肉，也不是鸟肉，也不是嗷嗷待哺的狗崽子肉。那……它真的是肉吗？哦天啊，那是香料！看，让我先抽一口甜蜜的香味，然后我给你点东西作为回报。就一点点，我甚至会为它付款。%SPEECH_OFF% 你的手放在了剑柄上。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "嗯，好吧。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 66 ? "B" : "C";
					}

				},
				{
					Text = "我不这么认为。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Dancer != null)
				{
					this.Options.push({
						Text = "肚皮舞者（%bellydancer%），你认识这个人吗？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_144.png[/img]{你告诉他他可以闻他想要的，只要最后付钱给你就可以了。他同意了，走到你的车旁，长长的风筝在头顶上飘荡着，像是永恒的秃鹫，在白雪的迷雾中掠过。他俯身探进车厢，每次呼吸都会令他的鼻子冒出冷气。他找到了香炉，并露出了微笑。%SPEECH_ON%啊，是啊，我已经很多年没有闻到这么好的香气了。%SPEECH_OFF%他把夹在手臂中的香炉交给了你，随后掏出一个大钱袋子放在了车尾。你数了数里面的钱，比在任何地方出售这些香料都要多得多。他转向你，握着香炉。%SPEECH_ON%公平的交易吧？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "男人知道自己爱什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local crowns = 0;
				local stash = this.World.Assets.getStash().getItems();
				local incense_lost = 3;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.incense")
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						crowns = crowns + item.getValue() * 2;
						stash[i] = null;
						incense_lost--;

						if (incense_lost <= 0)
						{
							break;
						}
					}
				}

				this.World.Assets.addMoney(crowns);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + crowns + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_144.png[/img]{你放开了剑柄，同意了这个狡猾但看似无害的请求。你说他要付预付款才能看一看你的车。男子点了点头，拿出了几个克朗。然后他骑着车绕到了后面。他把自己的鼻子塞进去，像猪一样扫荡着四周。\n\n突然间，他抓起几罐香料，扯掉了盖子。所有的尘土和粉末四处飞扬，雪地变得短暂而鲜艳。然后那个男人在烟雾中跳舞嬉笑着，你本想去打晕他，但他用鸢尾花的缆绳套住了你，自己却勇敢地逃跑了，嬉笑着，香气如流星般消逝。你勃然大怒，并在摆脱那该死的鸢尾花缆绳后检查了造成的破坏。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "到底是什么鬼东西。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();
				local incense_lost = 3;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.incense")
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						stash[i] = null;
						incense_lost--;

						if (incense_lost <= 0)
						{
							break;
						}
					}
				}

				this.World.Assets.addMoney(15);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]15[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_144.png[/img]{肚皮舞者%bellydancer%向前走，凝视雪地，意外地大声想知道那是否是他的父亲。疯狂的男子走了出来，他的黑风筝跟在他后面像尾风中的秃鹫一样，然后他的脸充满光芒，两人拥抱了起来。这个人显然是%bellydancer%的失散多年的父亲，一个香料商人，他曾经向北旅行，却被野蛮的野蛮人袭击并奴役，在那里逃脱。他狂笑着。%SPEECH_ON%我已经很久没有闻到好的香料了，我可以从几英里以外就闻到你的货车。你的母亲%bellydancer%，她怎么样？%SPEECH_OFF%肚皮舞者的微笑消失了。他提到，她一直保持希望，直到她力竭为止。那个带风筝的人庄严地点点头，但也是意料之中的。他说，让她嫁给曾经的残影是不对的，而他自己，没有回家的希望，也离开了。男子掏出一把刀刃不像你以前见过的华丽武器。他说，这是家族传承已久的宝贝，他在北方所有的年份都把它保管好了。%SPEECH_ON%最好你把它拿走并使用它，免得这里的野蛮人把我吃掉，用它当牙签。%SPEECH_OFF%男子深情地微笑，两人拥抱了一段时间。你好奇地问他为什么把风筝带着，他回答说，这是恐惧的工具，用来驱赶危险的动物和像野蛮人一样的人。你告别了这个人，建议%bellydancer%如果需要的话，也可以离开，但他摇了摇头。%SPEECH_ON%儿子和父亲不能走同一座镀金的大道，因为我们知道，在它的终点，我们将像在它的开始时一样在一起。%SPEECH_OFF%他用自己的母语对他父亲说了几句话，然后两人离开了。就这样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死，这香是真不错。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dancer.getImagePath());
				local item = this.new("scripts/items/weapons/named/named_qatal_dagger");
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_144.png[/img]{你让那个人让开，否则...他照着指示做了，尽管他两手着地，手指空无一物地在嗅到的气味上寻找。你回头看了几眼，确保他没有跟踪。他站在白雪覆盖的荒野上，凝视着你的马车。然后他只是一道黑影，消失了，他的风筝在你认为他所在的地方翩翩起舞，最后也消失了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "无法逃脱这些奇怪的家伙。",
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
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local candidates_items = [];

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.incense")
			{
				candidates_items.push(item);
			}
		}

		if (candidates_items.len() < 3)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_dancer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.belly_dancer")
			{
				candidates_dancer.push(bro);
			}
		}

		if (candidates_dancer.len() != 0)
		{
			this.m.Dancer = candidates_dancer[this.Math.rand(0, candidates_dancer.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bellydancer",
			this.m.Dancer != null ? this.m.Dancer.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Dancer = null;
	}

});

