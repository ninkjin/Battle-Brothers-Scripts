this.traveler_south_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.traveler_south";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_171.png[/img]{你遇到一个带着家里年轻男孩的男人在沙漠里游荡。 他欢迎你坐在篝火边并问你是否想听听沙漠和南方的故事。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "很高兴加入你们的篝火。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "不，你离远点。",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]{男人接着开始说起了古代帝国－至少他所了解的部分。%SPEECH_ON%很难说那究竟是什么，你知道吗？ 很难说之前到底发生了什么。 我瞟到 %randomcitystate% 的图书馆里过，被我所了解的事情给吓到了。 你知道我们最古老的文献是什么吗？古代文献。 你知道这些古代文献都写了些什么吗？更多的古代文献。 我们不清楚我们的时间线到底可以追溯到多久远以前。 我们在现在，或许未来的某天我们的后代会觉得我们就像神话一样，至于我们都不理解的秘密呢？%SPEECH_OFF%他在空中交叉他的手指。%SPEECH_ON%Gone.%SPEECH_OFF% | 他用一个拨火棍挑动着营火。%SPEECH_ON%他们说伊弗利特产自人们的残酷。 当我们对他人作恶时有一股力量，一股看不见的力量，被我们压迫着。 当我们大规模的杀戮时，这股力量被曲过整个缝隙，但当我们对一个个体作恶时，一些非常可怕的恶，这时候这股力量就会折断。 产生一个洞，通过那个洞产生了修正的力量。 这个修正的力量被我们称作伊弗利特。 因这股修正的力量我们会试图做出补偿，通过把那些制造出洞的人的尸体字面意义上的和这些透明力量合为一体。%SPEECH_OFF%他把拨火棍放在一边。他苦笑着。%SPEECH_ON%他们是这么说的。%SPEECH_OFF% | 尽管是个老人，但他还是像年轻人那样四肢灵活地交叉着双腿。 他无疑坐在许多个篝火边过。 他像面前的营火般温暖的跟你说道。%SPEECH_ON%我在这片沙漠经历过了许多个夏天。 但是我的儿子们，不幸的走在我前面的儿子们，他们会问，我们怎么在不同的季节分辨时间？ 用什么来标记经历的每一年？%SPEECH_OFF%一个褶皱的手指举起，并指向上面。 他向你眨了眨眼。%SPEECH_ON%星象。它们划过天际的规律只要人们愿意关注就可以察觉。 我还想象这些星星或许是其他的境界，另一个无法想象的地方。 或许我们死时会去的地方，但这是异端言论，当然，只在我们之间讨论，好吗？%SPEECH_OFF% | 男人从一杯不明内容的饮料中嘬了一口。 他闻着饮料并再次品了一口之后把它放下并伸展身体。%SPEECH_ON%你知道的，我有时候期盼着我镀金道路的终点。 它对我很好，这么些年，但我看得出来我在这可怕世界的灾难之间行走，我越早离开越好。 我觉得如果我呆在这太久到时候这个世界会发现我溜了开来，拿着收据，并在我的单据上写着苦难时过着好日子。%SPEECH_OFF%你问他为什么这么想。他耸耸肩。%SPEECH_ON%直觉。你也有的，逐币者，我毫不怀疑。 毕竟，你和其他人怎么撑过这么长时间的，就这么踏过各种恐惧和死亡？ 这个世界上的某个地方有个记录者，一个伟大的记录员，或许是镀金者，或许是什么别的，但生活并不意味着无尽的好事。 在某个时间点，总有一天，会有一个大的，不好的一刻。%SPEECH_OFF% | 你一坐下，老人就向后仰靠着好像你们是老朋友一样开始说。%SPEECH_ON%看到你在这很有趣，逐币者，尽管穿着盗匪的服饰。 这里，单纯人在一个单纯的时代。 但我想你也同样注意到一个更伟大的过去。 有一种感觉，那就是在我们之前有一个很长很长的历史。%SPEECH_OFF%你点头。很显然。那人点头回应。%SPEECH_ON%这很好。这展示了你的探索天性，即使只是了解到许多人和物在我们之前走过这些沙地。 许多…许多人甚至没有考虑到这一点。 他们住在这而现在。 在某种程度上，我嫉妒他们。 以自己的身份存在，而且只以自己的身份存在，整个世界就在你脚下，这一定是什么感觉。%SPEECH_OFF%他后躺并盯着天空。%SPEECH_ON%我想大多数人都不相信他们会死。%SPEECH_OFF% | 你坐下来，老人向后靠着，手里拿着一份卷轴和一份书简。 他读起来，时不时抬头。 你不知道他是在读上面的文字还是他能够自然的同时读两本书。%SPEECH_ON%你知道古代帝国是怎么陷落的吗？ 他们说是因为大地的一次大爆炸。%SPEECH_OFF%他用他的手模仿沙地中爆炸的样子。%SPEECH_ON%一次火山喷发。不过那看起来太过简单了，不是吗？ 一个火山灭掉了整个帝国？%SPEECH_OFF%你回应到你最好的佣兵也可能被后脚踝的一个小割伤致残。 不再能好好走路，转向，甚至只是支撑，他会从下而上的崩溃。 那个老人盯着你看。%SPEECH_ON%嗯，很有道理。 或许这个火山摧毁了这个帝国对自己的最后一点控制。 在那之后...谁知道发生了什么呢。 混沌，也许吧。那可恶的东西。%SPEECH_OFF% | 你坐下了然后那个人几乎马上就开始说话了。%SPEECH_ON%我听说一个异端教派在活动。有关什么“达库尔”。 好吧，我要说的是：从声音上看，他们是认真的那种。%SPEECH_OFF%你问他是否知道谣言以外的东西。他耸耸肩。%SPEECH_ON%只知道那是一种死亡崇拜，它不是起源于这里。 至少你不会听到南方人承认这个达库尔玩意是从这儿开始的。 不，不，一定是那些北方无赖想出了一个像这个死亡之神这样可怕的想法。%SPEECH_OFF%他古怪的笑道。你想他没有什么实际的料，并且只是把它提出来看看你的回应。 | %SPEECH_ON%是的是的，坐下吧。%SPEECH_OFF%你坐下来，然后那人就说起来了。%SPEECH_ON%沙漠的其中一个怪异现象是它会同时保存和抹去所有东西。 你能理解我在说什么吗？ 如果你死了，沙子会把你整个淹没，但是你，你的尸体，永远不会真的消失。 它会被淹没。 如果我们开始向沙漠底下挖我们肯定会找到尸体，宝藏，有的人甚至说整座城市。%SPEECH_OFF%你对此难以置信，但是他竖起了根手指。%SPEECH_ON%呲呲呲，不要这么不假思索的否定，逐币者。 这是个饥饿的世界而且，愿我的道路金光闪耀，我们现在现在知道的这些城市完全可能很快就会消失。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "愿你的道路永远被镀上金光。",
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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.SquareCoords.Y >= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 6)
			{
				return;
			}
		}

		this.m.Score = 10;
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

