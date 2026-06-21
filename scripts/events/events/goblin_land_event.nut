this.goblin_land_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.goblin_land";
		this.m.Title = "在途中…";
		this.m.Cooldown = 16.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_46.png[/img]{你看见一只死去的哥布林。 这不是一般的哥布林－而是一只哥布林长老。 它浑身上下都透着一股衰老的迹象。 随身还有不少古怪的首饰。 这样一头哥布林可不会随便死在荒郊野外：它是被妥善下葬的。 这意味着一件事：你正在这些该死的绿皮的地盘上。 | 你在山坡下边看见一条死去的狗。 舌头耷拉在嘴边，眼睛因为腐烂的尸气而鼓胀欲出。 几根箭插在它的毛皮下边。%randombrother% 把它拔出来仔细检查这锋锐的金属刺。%SPEECH_ON%哥布林毒药。%SPEECH_OFF%你问为什么会用在一条狗身上。那人耸耸肩。%SPEECH_ON%用受惊的狗当箭靶，可能吧。%SPEECH_OFF% | 你看见一丛颜色异常艳丽的野花、杂草和灌木。 在那上边，几十只硕大的甲虫正疯狂的厮斗，闪着诡异光泽的甲壳迸发出冲撞声。 看起来它们正在争相抢夺这堆植物里渗出的汁液或是别的什么东西。%randombrother% 突然张口说。%SPEECH_ON%我好像在哪见过这样的东西。 像是某种标记。%SPEECH_OFF%你瞥了他一眼。%SPEECH_ON%怎么，这地方有人看场子吗？%SPEECH_OFF%他摇起头来。%SPEECH_ON%不。这是哥布林放在这儿的。 我们现在在它们的领地上了。%SPEECH_OFF% | 你们正在大路上行军，突然看见一只死去的兽人。 他好像没受什么伤，乍一看简直就像是睡着了一样。 但凑近一看，这兽人背上和腋下还插着十几只纤细的小箭。 你俯下身子四下打量，然后转向你的手下。%SPEECH_ON%要小心了，我们现在在哥布林的领土上。%SPEECH_OFF% | 你看见几块石头被排列成一个圆环。 中间摆着一个人的头骨，头盖骨已然不翼而飞。 颅腔里边盛着一些像是骰子或鸡骨头的小玩意儿。 这样充满原始宗教气息的装饰绝非偶然－你现在一定是在哥布林的领地里了。 | 在一个可怕的陷阱里边，你看见一条死去的鹿。 乍一眼看上去跟那些尖刺陷坑一般无二，只是那些削尖的木桩上很明显上了毒。 而只有一种东西会用这样的毒药：哥布林。 接下来的路得小心些了。 | 一堆焖烧的灰烬。周围几块焦黑的石头和木棍。 琳琅满目的兵器散落一地。 弯刃刀。还有一条死去的幼狼，脖子上挂着嚼头。 看见这一幕，你赶紧告诉手下们。%SPEECH_ON%我们在哥布林的领地，而且看起来它们不久前才离开。%SPEECH_OFF% | 地上散落着几只死去的小狼崽。 它们的母亲被开膛破肚，扔在一边，脖子上还戴着项圈。 一条血迹斑斑的足迹引向深草丛里。%SPEECH_ON%这是哥布林在抓捕它们的骑兽呢。%SPEECH_OFF%%randombrother% 站在你身边。 他指着那些小崽。%SPEECH_ON%听说哥布林最喜欢那些野生的。 一胎之中只挑选那些最强壮的。%SPEECH_OFF%你明白自己这是在哥布林的领地里了。 你叫手下们盯紧周围，别让那些狡猾的东西偷袭了我们。} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "小心点。",
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
		local myTile = this.World.State.getPlayer().getTile();
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.getTile().getDistanceTo(myTile) <= 10)
			{
				return;
			}
		}

		local goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getSettlements();
		local num = 0;

		foreach( s in goblins )
		{
			if (s.getTile().getDistanceTo(myTile) <= 8)
			{
				num = ++num;
			}
		}

		if (num == 0)
		{
			return;
		}

		this.m.Score = 20 * num;
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

