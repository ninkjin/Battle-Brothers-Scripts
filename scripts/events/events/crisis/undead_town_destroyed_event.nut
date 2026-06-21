this.undead_town_destroyed_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_town_destroyed";
		this.m.Title = "在路上…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_99.png[/img]{你碰到一头驴子站在一辆装满烧焦尸体的车旁。 一名男子站在它旁边，可以理解的是，他看起来衣衫褴褛。 他看着你，摇了摇头。%SPEECH_ON%希望你们不要去 %city%。%SPEECH_OFF%没有人会告诉陌生人你要去哪里，你只需问他为什么。 他第二次摇了摇头。%SPEECH_ON%行尸明白了吗。 恶疾在城里蔓延开来，那些即将死去的人又重新站了起来。 没过多久，整个地方都落入了那些不死的灵魂的手中。 据说这座城市现在由亡灵巫师统治，但谁知道呢。 我绝对不可能靠近那里去调查。%SPEECH_OFF% | 一个苍白的灰胡子人蹲在路中间。 他听到你来了，但没有回头看。 相反，他只是说话。%SPEECH_ON%在异象中看见你。你们所有的人。 正在纠正世间谬误道路上的佣兵，尽管你们可能不知道事情的本质，就像一个皇家婴儿不知道它的王权地位一样。 但是你们太迟了。%SPEECH_OFF%他的脑袋扭来扭去。 浓密的眉毛下露出一双白白的眼睛。 他缺了一个鼻子，他的嘴唇上布满黄色的皱纹。%SPEECH_ON%%city% 沦陷了！死者在街上游荡，被你称为亡灵巫师的人控制着。%SPEECH_OFF%你小心翼翼地走上前去，问他是怎么知道这些的。 脸色苍白的人手里拿着一个圆形的小玩意，上面的波纹荡漾开来，就好像一个神手里拿着一个池塘形状的东西。 图像在它的倒影中扭曲，来来去去，显示的事件无始无终。他笑着说。%SPEECH_ON%谁能比那个安排城市灭亡的人更了解这个城市的命运呢？%SPEECH_OFF%突然，这个陌生人的皮肉粉碎了，下面只露出空气，他的新身体的黑色碎片展开成一团蝙蝠。 你拔出剑，但那些动物却转身走开了，一边尖叫一边向地平线飞去。 | 在路边发现了两个人。 一个人站在画架前，一只手拿着画笔，另一只手里拿着调着各色颜料的调色板。 另一个人摆着姿势，双手放在头上，保持着绝对是恐怖的表情。 画家瞥了你一眼。%SPEECH_ON%唉，佣兵们。我猜你们要去城里面，对嘛？%SPEECH_OFF%你问他为什么这么说。 他紧张地把刷子放下。 你看他的画是一个黑暗的城市，蓝色的瘴气从高墙后升起，苍白的月亮令人窒息地压在头顶上。 一个画了一半的人站在前景中，映射着画家模特儿的表情。 没有丝毫动作，做模特的人回答了你的问题。%SPEECH_ON%%city% 已经被摧毁了。好吧，不是被摧毁了，而是被亡灵颠覆了。 据说苍白之人支配着那里。%SPEECH_OFF%你问情况是否属实。 画家挥舞着双手展示他的作品说到。%SPEECH_ON%如果不是我亲眼所见，这难道不是疯子的杰作吗？ 现在，请吧，我必须在可怕的记忆消失之前回去工作。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们输掉这场战争了么？",
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
		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_undead_town_destroyed"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_undead_town_destroyed");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"city",
			this.m.News.get("City")
		]);
	}

	function onClear()
	{
		this.m.News = null;
	}

});

