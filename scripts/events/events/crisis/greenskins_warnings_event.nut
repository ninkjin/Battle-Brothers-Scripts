this.greenskins_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_warnings";
		this.m.Title = "在途中…";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_49.png[/img]你走出帐篷，看到一片被烧毁的荒地。 不是火的什么东西，把它经过的地方都熏黑了，也不是什么死了的东西，因为在火焰吞噬它们的肉时在尖叫。 在这片废墟的烟雾中，一队身材魁梧的兽人向前行进着，他们身边拖着被锁链锁住的人类奴隶，一群哥布林蹦蹦跳跳地在混乱中寻找乐趣。 还有… %randombrother%？这个雇佣兵戳了你一下，这个燃烧的世界瞬间消失。 剩下的就是你身边的佣兵了。%SPEECH_ON%抱歉吵醒你，先生，你的床上用品被那边的残烛烧着了。 我在它可能造成任何伤害之前就把它扑灭了。嘿，你还好吗？%SPEECH_OFF%点头，你告诉他离开，让队员们准备好第二天的行军。 你试着把梦中的记忆从脑海中抹去，但它却挥之不去，似乎并不想被遗忘。 | [img]gfx/ui/events/event_76.png[/img]一个男人从路旁的林间小路飞奔而来。 他衣衫褴褛，半张脸颊被撕开，舌头跳动着，除了喉咙里的惨叫和绝望的哀求外，再也发不出声音了。当那个人企图抢上前的时候，%randombrother% 向后跳了一步。 你拔出了剑，但那个陌生人只是倒在地上，背上布满了飞镖，皮肤上的伤口已经被毒液染成了绿色。\n\n 战队 保持了一段时间的警惕，但没有其他的事情发生。 大家一致认为这一定是绿皮干的，尽管似乎有证据表明兽人和哥布林都在这里活动… | [img]gfx/ui/events/event_97.png[/img]一个小伙子带着他的狗小跑着经过。 他停在人群前，拍了拍他的小杂种狗的头。%SPEECH_ON%你们是追杀绿皮的士兵？ 据我所知，那些大个子的很难被杀死，而矮个子的是一种很狡猾的生物。%SPEECH_OFF%你问那个人他来自哪里。他耸耸肩。%SPEECH_ON%离这里很远很远的地方。 我是一个流浪者，先生们，我和我的狗。 但是我在旅行中看到了很多。%SPEECH_OFF%%randomname% 冲了过来。%SPEECH_ON%你看到兽人和哥布林合作了？%SPEECH_OFF%这个男孩点头。%SPEECH_ON%是的！他们为什么不呢？ 嘿，好吧，你们不是我想象中的那种人。 祝你们地久天长，好梦不断。%SPEECH_OFF%他走过一些矗立的灌木丛。 你追过去，但当你追到另一边时，男孩和狗都不见了。 | [img]gfx/ui/events/event_94.png[/img]你先听到了苍蝇的叫声，然后才看到它们所制造的混乱。 一个小茅屋，简单的木制构架，一个漂亮的茅草屋顶，一些挂在绳子上的罐子，一个在风中旋转的风铃，给空气带来欢乐的木制编钟，草地上有三具残缺不全的尸体，一堆虫子在尸体上成群结队。%randombrother% 蹲在一具尸体前面，戳着血里突出的骨头。%SPEECH_ON%一定是兽人干的。那里的脚步声可能就是。%SPEECH_OFF%你点了点头，但注意到小屋的门上粘着几条飞镖。 你摘了一个，然后闻一闻。%SPEECH_ON%毒药。不仅仅是兽人在这里。%SPEECH_OFF%%randombrother% 嗅了嗅其中一个飞镖，点了点头。%SPEECH_ON%是，兽人和哥布林。 一起合作吗？我当然不希望这样。%SPEECH_OFF%如果它们是，那将是一场灾难，但现在你只能高兴地坐着，认为所有的证据都只是巧合。 | [img]gfx/ui/events/event_02.png[/img]你先看地图，然后再看眼前的景色。%SPEECH_ON%这里应该有一个小村庄。%SPEECH_OFF%%randombrother% 走过时，嘴里嚼着一个苹果，发出令人满意的嘎吱嘎吱的声音。%SPEECH_ON%嗯哼，也许要来只笔来记述一下，先生。%SPEECH_OFF%这个村庄成了一片废墟。 它的居民被挂在木桩上或任何仍然挺立的树上。 那些没有被绞死的人的尸骨堆在可能是城镇广场的中央。 盯着地面，你看到了从大屠杀中延伸出来的脚印。 小的，大的。 哥布林，兽人。%randombrother% 摇了摇头。%SPEECH_ON%他们肯定没有在合作，对吧？%SPEECH_OFF%你耸耸肩答道。%SPEECH_ON%我敢肯定兽人横扫而过，然后哥布林来了，捡起了遗骨，或者可能是反过来的。%SPEECH_OFF%佣兵点了点头，你的解释让他确信你们俩都知道这两件事很可能不是巧合。 | [img]gfx/ui/events/event_97.png[/img]你看到一个孩子蹲在河床上。 他正在用一根棍子在泥里画人物－小棍子一样的人，旁边有带角的大头盔和小帽子，即使是小棍一样的人也全副武装。%randombrother% 问孩子到底在做什么。%SPEECH_ON%画绿皮。我经常看见他们，他们在山上乱窜乱撞，我爸说就像敞开着门的食品间里进了老鼠。%SPEECH_OFF%你问他住哪儿。 他指了指附近山上树木繁茂的山坡。%SPEECH_ON%那边。可以很好地看到不少事情。 也希望你们去瞅瞅。%SPEECH_OFF%一位老人大声喊着孩子的名字，他答应了，放下了他的复古艺术工具，朝小山走去。%SPEECH_ON%我正在创作。你们玩得开心！ 不要踩到我的画！%SPEECH_OFF%现在你意识到简笔画是兽人和哥布林，但也许孩子只是在幻想。 | [img]gfx/ui/events/event_36.png[/img]你在路边发现一个小伙子，他把胳膊抱在胸前。 两只手好像不见了。 他抬头望着你，可能是你的气场让他向后倒去，这个可怜的人直挺挺地倒在地上，抬头望着天空，胖乎乎的前臂胡乱挥舞着。%SPEECH_ON%他们合作了。杀了…杀了每个人。 我不敢相信所看到的。 我总是说，如果他们来了，我会做好准备，其中一种或另一种。 但是现在他们是。合作了。%SPEECH_OFF%你问他在说谁或什么。 那人的胸脯紧绷着，痛苦歪歪扭扭地爬过他的脸，他咽下了最后一口气。 在他睁开的眼睛里，反射出一道弧形的光，这一切都是为了在死前最后看看这个世界。%randombrother% 搜查了他的尸体，但没有东西可以带走。 | [img]gfx/ui/events/event_95.png[/img]一个头骨图腾，皮质的皮肤从碎片上剥落下来，每个头都披着一件他们自己制作的可怕的斗篷。 鲜血染红了大地。 更多的骨头。肌肉和肌腱，未使用或未食用的东西。 营火造成的焦土，熄灭的灰烬。%randombrother% 在现场寻找线索。 他举起一件简陋武器的枪杆，在一个山羊皮包里找到了两支飞镖。%SPEECH_ON%这对一个人的手来说太大了，而这些显然是带有毒药的哥布林箭。 毫无疑问，绿皮来到这里，他们一起工作。%SPEECH_OFF%一起工作？那是一个可怕的想法，但似乎是真的。这些野蛮部落接下来会做什么呢？ | [img]gfx/ui/events/event_71.png[/img]你来到一间茅屋的废墟。 瓦砾堆上到处是骷髅，骨头参差不齐，在这最后的痛苦和绝望之地滚动。 一把锁放在本该是门的旁边的一堆灰烬里，暗示着里面的人被挡住了，而外面的人只是把这个地方烧了。%SPEECH_ON%先生，你应该看看这个。%SPEECH_OFF%%randombrother% 招手唤你过来。他站在一棵树前。 有一个死去的哥布林倚在树干上，两手摊开，空空的，脸上一副丑陋的表情，胸前插着一把干草叉。 一个死去的兽人站在它旁边，脑袋上插着一个铲子头。%randombrother% 不知道他们是否互相残杀。 你希望如此，但是他们致命的伤口看起来很像人类的行为，如果这是人类的行为，那么这些绿皮可能在一起工作。 这个想法让深深恐惧的想法。 | [img]gfx/ui/events/event_59.png[/img]难民们在路上，一群一群的难民，妇女们用襁褓裹着婴儿，用绳子绑在背后，磨破了她们的肚皮，男人们用干草叉当拐杖，剃光了胡须的修士们用手指在空中比划宗教仪式，低声祈祷。 你试着和他们交谈，但他们却睁大眼睛躲避你。 最后，一位老人轻声对你说话。%SPEECH_ON%不要去尝试了，先生，他们看起来太多了。 绿皮…他们昨晚来了。 兽人在村子里，哥布林在村子外面等着伏击一切逃跑的人。 民兵遭到屠杀。 只有我们这些胆小的人才能活下来，即使这样，也只有我们当中跑得最快的人才能活下来。%SPEECH_OFF%你问他是不是说哥布林和兽人在一起工作了。 他点头，拍拍你的肩膀。%SPEECH_ON%啊，我确定。旅途平安，陌生人。%SPEECH_OFF% | [img]gfx/ui/events/event_76.png[/img]路边站着一个打扮得漂漂亮亮的人。 他眼睛盯着前方，双手向两侧伸出，也许是为了平衡体内过量的酒精。 你抓住那个人，把他推来推去。 他的脸向前晃动，眼神空洞，眉毛的卷须像腐烂的小龙虾一样垂到脸颊上。 当他试图抓住你时，两只没有手的手臂拍着你的肩膀。 他的脸扭曲着用喉咙发声，反映出他所经历的野蛮。\n\n %randombrother% 迅速采取行动，砍倒了这个人。 陌生人向后倒去，他的貂皮大衣敞开着，露出一具被残忍虐待的裸体，现在你意识到，你宁愿看到一个男人身体的某部分，也不愿看到他们消失。 他受到的残害使他毁灭，那些刀痕和切口撑开了他的肉，就像破解谜题一样。 他的器官从缝隙中钻了出来，在紫色的绳索和包里舒展开来。这个人尖叫着。%SPEECH_ON%兽人！哥布林！兽人！哥布林！兽人！哥布…哥布林…%SPEECH_OFF%他的呼吸停止了。 谢天谢地，他已经死了。 他最后说的话有什么意义吗？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那是关于…",
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
		if (this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.Greenskins && this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Warning)
		{
			local playerTile = this.World.State.getPlayer().getTile();

			if (!playerTile.HasRoad)
			{
				return;
			}

			if (this.Const.DLC.Desert && playerTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			{
				return;
			}

			local towns = this.World.EntityManager.getSettlements();

			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(playerTile) <= 4)
				{
					return;
				}
			}

			this.m.Score = 80;
		}
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

