this.orc_land_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.orc_land";
		this.m.Title = "在途中…";
		this.m.Cooldown = 16.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_46.png[/img]{一个石冢上面有一个不同寻常的头骨。 或许是为了纪念一个伟大的兽人战士。 无论它对那些绿皮有什么意义，它对你的意义很简单：你们现在在它们的地盘上。 | 在前进的过程中你遇到了一个刻着曲线花纹的木头图腾。%randombrother% 相信这些曲线表示夜空的痕迹，也许是这个或者那个星座的痕迹。\n\n%randombrother2% 吐了一口唾沫然后提醒到这些都表明我们在兽人的地盘上你最好注意这一点而不是在夜晚的火光下面做些什么无意义的事情。 | 你在草丛里面找到一具骨头。 肋骨弯曲的可怕－远远超过一个正常男人。 你想知道这个是否属于一个驴子，但是一个巨大并且奇怪的人形头骨的发现确认了你的想法：你们已经进入了兽人的地盘。 | 人头桩。 他们的肢体被挤成一堆。 他们已经被破坏的残缺不堪。 唯一能证明他们曾经是人类的是这些被遗留在这堆破碎血肉上的衣服碎片。\n\n%randombrother% 过来，点了点头。%SPEECH_ON%我们现在已经陷入这个该死的困境里面。 这里是兽人的地盘。%SPEECH_OFF% | 你遇到是一个人的身体，但不是他的头。 那个不见了。他的生殖器也不见了。 一起不见的还有他的手和脚。 标枪从尸体残余部位穿出，有人或者说是东西把剩下的地方当作令人恶心的练习靶。\n\n 仔细看了看武器，%randombrother% 点头并且转向你。%SPEECH_ON%是兽人，先生。我们现在已经在它们的地盘上并且，呃，很明显他们对闯入者不太友善。%SPEECH_OFF% | 你发现了一具被一个巨大斧头钉在树上的破碎骨架。 它大多只有胸腔其余的部分早就分崩离析。 长长的，弯曲的艺术作品被雕刻在树干上。%SPEECH_ON%这里是绿皮的地盘。%SPEECH_OFF%%randombrother% 边说边向你走来。 他摸了摸斧柄，斧柄的重量几乎和嵌入其中的那棵树一样扎实。%SPEECH_ON%从外表上看，这里是兽人的地盘…%SPEECH_OFF% | 你来到一个被仔细地放着一堆石头的小山坡上。 仔细观察，你发现岩石上有白色的雕刻。 每一幅画都展示了一个不同的故事－一个大型的野兽四处游荡并且不断残害画面上比它更小，更细的简笔角色。%randombrother% 嘲笑这些画。%SPEECH_ON%这是兽人的幻想－通过这样的事情，无论怎样。 我们是这些图画上的小人你们竟然不知道。%SPEECH_OFF% | 在一座山上的树枝上发现有块皮革防水布正在摆动。 这里有证据表明，在它周围有一个废弃的营地－一堆阴燃的火，模糊不清的脚印，一些奇怪的碎片。%randombrother% 指着这些东西。%SPEECH_ON%他们的气味仍然萦绕在这些东西上面。这是…兽人的味道。%SPEECH_OFF%%randombrother2% 咳嗽一声并且吐了口唾沫。%SPEECH_ON%你对狗屎有很强的嗅觉，老弟。%SPEECH_OFF%%randombrother%点了点头。%SPEECH_ON%不过，这不是胡扯。 我们在兽人的地盘上，伙计们。%SPEECH_OFF% | %randombrother% 走到一堆你们之前遇到的人类头骨面前。 他分析了他们致命的伤口－主要的事实是他们的身体已经不在这里了，斩首是一件可怕的事情。 他站起来，点头示意。%SPEECH_ON%兽人杰作，伙计们。 注意了，以免你也被挂在这。%SPEECH_OFF%你也点头告诉他们注意前方的危险。 | 有一种对荒野的感觉，也有一种对文明的感觉－你在这里得不到任何舒适感。 你有一种奇怪的感觉就像你刚刚闯入其他人的地盘。 一堆被剥夺了一切一度能够帮助确定他们是人类这个证据的可憎的尸体，并确定了一个简单的事实，那就是你现在已经进入了兽人的地盘。}",
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
		if (this.World.getPlayerRoster().getSize() < 2)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.getTile().getDistanceTo(myTile) <= 10)
			{
				return;
			}
		}

		local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements();
		local num = 0;

		foreach( s in orcs )
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

