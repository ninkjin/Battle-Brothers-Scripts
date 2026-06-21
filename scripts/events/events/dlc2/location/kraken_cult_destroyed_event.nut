this.kraken_cult_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.kraken_cult_destroyed";
		this.m.Title = "战斗之后";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_105.png[/img]{触手横七竖八的在沼泽地上缠成一团烂肉，以至于你不仅杀死了克拉肯，还毁灭了这个它称之家的地方。每一个长虫般的残骸都长满了沼泽苔藓，是一块丰沃的农田，用于孵化出你所看到的那个女人不断吃下的那种蘑菇。你蹲在一堆尚未收获的蘑菇旁边，就像猫玩弄没翅膀的蛾子一样戳弄它们的菌盖。蘑菇在被触摸时缩起来了，%randombrother%看着它们。%SPEECH_ON%真菌学家可能知道这些是什么。%SPEECH_OFF%你点了点头，是啊，可能。你继续前行，踩烂了脚下的蘑菇，涉过漂浮在沼泽中的残肢和带血的斗篷，触手无脸的尖端上树叶状的口部倒在了一起，舌头像鞭子一样耸拉着。那个女人藏在了一堆藤蔓的后面，你像一个寻找财富的人一样拨开藤蔓。她冲你笑了一下。%SPEECH_ON%你听到它了吗？你听到它的美吗？%SPEECH_OFF%一边叹气，你告诉她蘑菇控制了她的思想，这些蘑菇在这里是有原因的，而克拉根在现身前就已经将她控制，用她来将每个人带到这里。她笑的越来越开心，只是再次问你是否听到了它的美。你告诉她，你听到了它的死亡。她的眉头皱起。%SPEECH_ON%死亡的悲鸣？这就是你的想法吗？我的天，才不是。陌生人，那是求救的叫声。你不明白吗？这意味着还有更多克拉肯存在！更多！也许有数百个！现在他们醒来了！全都醒来了！%SPEECH_OFF%你向后退了一步，关上了藤蔓的帘幕。%randombrother%告诉你战团发现了一些东西。有一瞬间，你想拯救这个女人，但你知道这是不可能的。你知道她所处的困境，并任由她。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，让我看看发现了什么。",
					function getResult( _event )
					{
						if (this.World.Flags.get("IsWaterWheelVisited"))
						{
							return "C";
						}
						else
						{
							return "B";
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_105.png[/img]{这个怪兽实在太大了，以至于死的时候无法正常倒下，只能张着可怕的巨口向前斜立，就像堡垒上被打了一个洞一样。一名雇佣兵就像研习中的僧侣一样盘腿坐在克拉肯的顶部。另一名雇佣兵正在戳怪兽的眼睛，直到一只眼睛破裂，眼窝的边角噗嗤的溅出液体。你问雇佣兵们发现了什么重要的东西，其中一人招手让你走到怪物的巨口边上。由于牙床已经松弛，现在牙齿都向下垂着，如同恐怖塔楼的边缘，一排排利齿上挂着衣服和血肉，因为太过巨大使得整个残肢都被卡在其间。同样在那里的还有一个剑刃。\n\n你伸手进入口腔拔出了剑刃，然后用布擦拭干净。翻转剑刃，你发现在剑刃的中线上有着符文，旁边还标注了数字，这意味着这永恒之物却锻造于某个特定的时间和地点。它的钢材是如此的光彩耀人，仿佛是由星光塑造而成。不幸的是，它没有握柄。这个剑刃的华丽程度暗示着它不适合用区区普通剑柄搭配。将剑刃放入仓库后，你告诉手下们从'万兽之王'那里尽可能多的收集东西，准备离开这个可怕的地方。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们胜利了",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/special/legendary_sword_blade_item");
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
			Text = "[img]gfx/ui/events/event_105.png[/img]{这个怪兽实在太大了，以至于死的时候无法正常倒下，只能张着可怕的巨口向前斜立，就像堡垒上被打了一个洞一样。一名雇佣兵就像研习中的僧侣一样盘腿坐在克拉肯的顶部。另一名雇佣兵正在戳怪兽的眼睛，直到一只眼睛破裂，眼窝的边角噗嗤的溅出液体。你问雇佣兵们发现了什么重要的东西，其中一人招手让你走到怪物的巨口边上。由于牙床已经松弛，现在牙齿都向下垂着，如同恐怖塔楼的边缘，一排排利齿上挂着衣服和血肉，因为太过巨大使得整个残肢都被卡在其间。同样在那里的还有一个剑刃。\n\n你伸手进入口腔拔出了剑刃，然后用布擦拭干净。翻转剑刃，你发现在剑刃的中线上有着符文，旁边还标注了数字，这意味着这永恒之物却锻造于某个特定的时间和地点。它的钢材是如此的光彩耀人，仿佛是由星光塑造而成。不幸的是，它没有握柄，你立刻开始将事情联系起来：一把华丽到无与伦比但却没有手柄的剑，与世隔绝的水磨里一名奇怪的老人和没有剑刃的握柄。你觉得你知道该带着它去哪。你将它放入仓库后，命令战团搜刮其它所有值得带走的东西，包括所谓的'万兽之王'身上的东西。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们胜利了",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/special/legendary_sword_blade_item");
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
	}

	function onPrepare()
	{
		this.World.Flags.set("IsKrakenDefeated", true);
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

