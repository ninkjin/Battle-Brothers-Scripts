this.goblin_city_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.goblin_city_destroyed";
		this.m.Title = "战斗之后";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_119.png[/img]{哥布林先锋被击败后，你率领军队进攻城市进行洗劫。小型的哥布林被杀戮、割头或砍断头颅。更多的哥布林像蚂蚁一样在你周围匆忙行走，每个哥布林都扛着一些东西，比如人类的头骨或宝藏。其中一个疯狂地拖着一根被火烧着的旗杆，上面挂着一面旗帜，另一个则舞动着狼的头颅。你的士兵翻倒茅棚和棚屋，踢走倚靠着的人，任何呼吸着的东西都被杀死。\n\n哥布林使用的古老堡垒被你们细心的抢劫目光盯上。你进入大厅，发现一个盲哥布林在那里爬行，脖子上挂着一串人类的腿骨花环。这个绿皮在你的方向嘎嘎作响，毫无疑问感知到了你的存在，尽管它脸上痛苦的扭曲意味着它也感受到了它的同族被消灭的痛苦。你将这个绿色的皮革开膛破肚，让它在石板地板上死去。你的佣兵们在前面奔跑，进入了一个满是长老的议会室，他们在疯狂的狂暴中被杀死，四肢飞扬，手指四散，血液喷涌而出，弥漫在墙壁和桌子上。\n\n你走出到城堡院子。这里你发现一堆死去的人，有些被肢解，有些被踩扁，一些人则像火炬一样被塞满。在尸体之后你看见了狼骑手训练场。你放火烧了狼笼，并把它们的驯兽师扔进火里与它们同归于尽。一只狼逃了出来，身上披着火焰的斗篷，在城市里奔跑，汪汪叫着、嚎叫着寻找救助。你看着火焰迅速燃烧茅屋和草房。在你自己被火之中吞噬之前，你下令士兵撤退，看着整个城市毁于一旦。在野蛮人被处理完后，你清点了掠夺物品。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那是什么？",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_119.png[/img]{你数着战利品，策划这次哥布林屠杀战略的陌生人又出现了。他全身淋满了哥布林的血和内脏，你甚至看不清他的肤色。他手中拿着几个头皮和一个充满耳朵和鼻子的袋子，袋口还滴着血。他点了点头。%SPEECH_ON%旅行者，一切都好，一切都好。我们做得很好。%SPEECH_OFF%你问他是不是放火的。他点了点头。%SPEECH_ON%哥布林会在墙和地雷的迷宫中设立后卫。我关闭他们的逃生通道，把他们全部困在两堵墙之间，关闭出口，关闭入口，然后放火烧掉一切。他们很快就消灭了。看来你也过得不错。这些战利品你自己留着吧，我用不上。%SPEECH_OFF%他转身离开。你朝这个疯狂的勇士大喊，询问他要多少价格才能加入战团。这次他又回过头来了。%SPEECH_ON%嘿，嘿，哈哈，哈哈哈！旅行者！这个笑话，啊。喜剧。美妙。真是的。但我要毁掉每一个哥布林，我的工作不会被拖延。%SPEECH_OFF%说得不错，人的目的是自己的。但你还是很好奇。你问他外面还有多少城市。%SPEECH_ON%23个，哦，对不起，你问的是总共有多少个？我已经摧毁了23个，但还有，啊，两个，三个，嗯。我打赌有四千个。旅途愉快，旅行者。%SPEECH_OFF%这次他永远地离开了。你回头看着%companyname%，他们都非常同意：他们希望没有听到这些。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就这么几个，哏？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsGoblinCityDestroyed", true);
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

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

