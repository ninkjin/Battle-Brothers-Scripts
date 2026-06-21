this.civilwar_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_warnings";
		this.m.Title = "在途中…";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_76.png[/img]你在路上碰到一个陌生人。 他凝视着你，一群绵羊和狗在他身边闲荡。%SPEECH_ON%嗯，难道你不准备为 %noblehouse% 而战吗？ 我听说，王国里的其他家族在因为某种我不知道的原因争吵。 我只知道他们会来我家问我，“%randomname%，要么加入我们，要么被我们绞死！”，而我会说“没问题”，因为平静生活被贵族摧毁也是生活的一部分，生活就是不公平的。%SPEECH_OFF% | [img]gfx/ui/events/event_91.png[/img]在你行军的时候，有个女人站路边。 她上下打量着你的印记。%SPEECH_ON%嗯哼，我不认识这个。 不过贵族们很快就会要求你为他们服务。%SPEECH_OFF%你问她什么意思。她耸肩。%SPEECH_ON%据我所知，那些夸夸其谈的人对皇室婚姻的失败感到愤怒。 关于战争或诸如此类的蠢事的声音越来越多。 他们贵族总是为一些事情喋喋不休，只是时间的问题，直到他们彼此交战，或让我们这些穷人为他们做这件事。%SPEECH_OFF% | [img]gfx/ui/events/event_17.png[/img]一个坐着抽烟斗的老人用一种朦胧的眼光久久地凝视着你。%SPEECH_ON%雇佣兵，嗯？在未来的日子里，你会有很多活可以接。%SPEECH_OFF%你问他是什么意思。他把烟斗擦干净，发出咔嚓咔嚓的响声。%SPEECH_ON%噢，你知道的。贵族们又在炫耀了。 战争即将来临，毫无疑问－不能让这么好的天气白白浪费掉。%SPEECH_OFF% | [img]gfx/ui/events/event_75.png[/img]一个信使走了过来，他的挎包里空荡荡的。%SPEECH_ON%唉，我没什么消息，但如果你有兴趣的话，我有一些谣言。%SPEECH_OFF%你点头。他笑了。%SPEECH_ON%大概是这样。现在，贵族们有时会让我把文件寄出去。 有时我也会偷听他们的谈话。 我听到的很多关于军队的言论，很多诸如“我们要征服他们”之类的言论。 所以，佣兵，你马上就有很多活要接了。%SPEECH_OFF% | [img]gfx/ui/events/event_97.png[/img]%SPEECH_ON%嘘。嘘！嘿！%SPEECH_OFF%你转过身，看到一个男孩从灌木丛中探出头来。 他对你微笑。%SPEECH_ON%嘿，我有话要说。 战争马上就要来了。%SPEECH_OFF%你不是很相信这个小矮子。 你问他怎么知道的。他又笑了。%SPEECH_ON%我给一个穿丝绸裤子的人打水。 他说，“我可以给你们一些糖果，或者给你们一些思考的东西。”我说，告诉我一些好消息。 他说，“贵族们要开战了。”这就是我要告诉你的。%SPEECH_OFF%这个孩子停顿了一下。%SPEECH_ON%喂，你不会碰巧有糖果吧？嘿…嘿！%SPEECH_OFF%你把孩子的头推回灌木丛。 | [img]gfx/ui/events/event_75.png[/img]一个老人和一个皮肤白皙的姑娘在路上遇见你。 她把一根发辫搭在肩膀上，用一双迷人的眼睛瞥了你两个相貌较好的男人一眼。 在你开口之前，她问你是要为什么而战，是 %noblehouse% 还是 %noblehouse2%。%SPEECH_ON%他们说王子和公主私奔了，说这是爱情的问题。那不是梦吗？%SPEECH_OFF%你耸耸肩。这位老人咳嗽了几声，吐了几口唾沫。%SPEECH_ON%女人，不要用你的幻想去打扰佣兵。 对不起，雇佣兵，她脑子里有这些想法，我也不知道是从哪儿来的。 家家户户都在谈论战争，但毫无疑问，战争不会比一个欢蹦乱跳的王子或某个公主更可怕。 经济学！这就是问题所在。 长期存在的贸易协定正在分崩离析，就像当初签署它们的那张纸一样。 让我告诉你，当他们…%SPEECH_OFF%这个老家伙慢吞吞地说着一些你听不懂的话。 你更喜欢那位女士的故事，尽管听起来很可笑。 | [img]gfx/ui/events/event_75.png[/img]你看见一个人坐在路标顶上。 他正在勒紧琵琶上的琴弦，测试琴声。%SPEECH_ON%嗯哼，那样更好，你不同意吗？只要同意就行。%SPEECH_OFF%你点头，你问他在做什么。 他从路标上跳下来，像个小丑一样在表演结束时拉伸胳膊和腿。%SPEECH_ON%练习！战争即将来临，我能在风中听到它的声音，随着战争的到来…为了…为了…拜托，你能做到的，娱乐！没错！ 对我来说，任何一个夜晚快乐的呼唤都是对我的呼唤－在很多方面，让我告诉你。%SPEECH_OFF%他踮起脚尖，咧着嘴笑。 你从未见过一个笑容更白的男人，而你却有一种强烈的冲动要把他的笑容深深地涂黑。 吟游诗人在小路上翩翩起舞。%SPEECH_ON%别担心，佣兵，贵族们互相厮杀，像你这样有才能的人永远都不会缺少工作。今天！%SPEECH_OFF% | [img]gfx/ui/events/event_16.png[/img]你越来越多地遇到抱怨贵族家族战争的农民与商人。 你处于佣兵的地位，他们同时也会问你打算为哪个贵族而战。 如果这些谣言是真实的，那么 %companyname% 将会从这两个自命不凡的贵族之间获得巨大的财富。 | [img]gfx/ui/events/event_45.png[/img]你在路上遇到许多赌徒。 他们插上小旗子，代表这片土地上所有的贵族。 赌徒正在写笔记，并看了看他的卷轴。%SPEECH_ON%现在记住，这场贵族之战在短期是不会有结果的。 见鬼，我们大多数人都会被征召入伍。 但所有幸存的人将在一年后回到我身边。 从那里，我们会把钱支付给那些押注于获胜的贵族家族的人。干不干？%SPEECH_OFF%歪着脸、松着嘴的农民耸肩。%SPEECH_ON%听起来很划算！%SPEECH_OFF%赌徒咧嘴一笑，金门牙微微一闪。%SPEECH_ON%很好！%SPEECH_OFF%他把赌注装在一个袋子里，然后满载而归，并且很可能再也不会回来了。 真是可耻，下层社会的人都是些什么狗屁东西。 | [img]gfx/ui/events/event_75.png[/img]在你的旅行中，你不断听到一个特别有趣的谣言：贵族家族正在为战争做准备。 如果是真的，%companyname% 可以赚很多硬币，特别是它选对了获胜方。 | [img]gfx/ui/events/event_23.png[/img]近来，一个接一个的农民都在讲同样的故事。 事实上，每次你见到他们时，他们似乎都在重复这句话…\n\n 战争。战争就在他们的嘴边。 贵族家族正在为一些你不太关心的事情争吵，但这意味着战争，战争意味着佣兵的克朗，克朗是好的，所以战争是好的。 如果这些传言是真的，%companyname% 应该仔细衡量自己的选择，并选择一个贵族来应付即将到来的冲突。 | [img]gfx/ui/events/event_80.png[/img]你已经注意到，贵族家族的招聘人员正忙着把年轻的男性从家里拉出来。 征兵并不是什么新鲜事，但通常情况下，你还是需要小伙子来种田。 如果出身高贵的人把这些都留给了女性，那就意味着有某个东西更重要，而这个东西无疑是一场酝酿中的战争。 %companyname% 应该为最坏的情况做好准备－好吧，为其他人做最坏的准备。 有钱人之间的战争是成为佣兵的最好时机！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴知道。",
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
		if (this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.CivilWar && this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Warning)
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
				if (t.isSouthern())
				{
					continue;
				}

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
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"noblehouse",
			nobles[0].getName()
		]);
		_vars.push([
			"noblehouse1",
			nobles[0].getName()
		]);
		_vars.push([
			"noblehouse2",
			nobles[1].getName()
		]);
	}

	function onClear()
	{
	}

});

