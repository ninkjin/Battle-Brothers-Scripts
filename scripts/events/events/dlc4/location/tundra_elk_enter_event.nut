this.tundra_elk_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.tundra_elk_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_142.png[/img]{在贫瘠的苔原里，你在一个小湖的周围找到了一个主要的狩猎场，所以你决定进行一次为期一天的短期捕杀。\n\n你很快就发现一只相当大的麋鹿正在啃吃稀少的苔原草。 就在你准备射杀的时候，麋鹿的脖子被抓住了，它的鼻子直接伸了出来。 它的骨头断裂，四肢弯曲，因为它们被瞬间的死亡抓住，但它没有倒下。 它的肩胛骨颤抖着，然后鳞茎移动，好像有拳头在它的皮毛下滚动。 突然，肉撕裂了，你可以看到一个光滑的蓝色肿块在伤口之间冒泡。 它的腿突然分开，躯干高高地升到空中，长长的粗骨拍击地面，像蛇一样的肌肉带缠绕在躯干上。 你相信麋鹿已经死了，但它的嘴却疯狂地呻吟着，就在它的脸从头顶到下颚像花朵一样裂开的时候。 另一个东西的脸完全显露出来，它向前推进，好像是由它正忙着收割的血迹所产生的。 当这个新怪物找到它的力量时，它用两条后腿抓住它，然后用它的手把麋鹿的皮毛撕下来，就像人撕下斗篷一样。 血和骨头飞溅。\n\n 一个比任何人高三倍高的丑陋的野兽转过身来，摸着它的四肢，拉紧它的手，扭开它的膝盖和肩膀，把它的头从一边转到另一边，肥厚的鼻孔像公牛一样张着。 眼窝都是骨头，蓝色的薄雾在眼窝里跳动，像是噼啪作响的暴风雨。 麋鹿美丽的鹿角被可怕的犄角给磨掉了。 一股冷风从它的嘴里卷起，你可以看到附近一棵树的叶子变得又冷又脆。 \n\n 你有一种不安的感觉，那就是这个怪物实际上根本不是一个怪物，而是一种短暂的灵魂，它以自己认为合适的方式显现出来，把自己作为混乱的一面雕刻在这个世界上，而不是别的什么。 正如你所想的，野兽把头转向你，把长长的指甲钩在尖牙的嘴角上，把嘴唇伸得很长，嘴角就是耳朵。%SPEECH_ON%啊，这就是我要去的地方，这就是我快乐的地方。 你为什么这么害怕，我不是一只普通的鹿吗？%SPEECH_OFF%它的头歪向一边，口水溢在下唇上，眼睛里满是顽皮的泪水。 你听说过这种生物的故事，北方人把它叫做伊吉洛克或冬天的野兽。 你知道它不是来这里说诗和玩游戏的。 你拔出剑来，却有一只手拍着你的肩膀。%SPEECH_ON%永远和你在一起，队长。%SPEECH_OFF%你转身看到战队在你身边准备战斗。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要毁掉这东西！",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
							this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						}

						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				},
				{
					Text = "我们得离开这里！快！",
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
			}

		});
	}

	function onUpdateScore()
	{
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

