this.scientist_in_the_mountains_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.scientist_in_the_mountains";
		this.m.Title = "在山上…";
		this.m.Cooldown = 150.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_42.png[/img]在你路过山顶的时候看到了一番奇特的景象：一个人坐在一个奇怪的木制装置里，把它倾斜到一个足以致命的悬崖边。 他的眼睛上方有一条围巾，他拉下了围巾。%SPEECH_ON%喂,陌生人。看来你要记录历史了！ 因为人类支配着这匹普通的马，让它跑得比自己所知道的还要快，所以我要支配鸟类…好吧，我们不能骑鸟，但我可以，正如你从这台机器上看到的，模拟它们。 时间和空间的枷锁将被解除，就像这些木翼将我升入空中！%SPEECH_OFF%这个“奇妙装置”配有踏板、木辐条和薄薄的匆忙缝制的防水油布。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你需要停下来，你这样只会害死你自己。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "将有一场有趣的热闹可看。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "C" : "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_42.png[/img]你向前一步，说明这件事的本质。%SPEECH_ON%好吧…先生。什么鸟能从这么高的地方飞起来？ 鸟不是简单地用翅膀推动自己向上飞吗？ 你会把自己丢下悬崖，如果把希望寄托在你的机器能工作上，但你内心深处知道它不会工作。%SPEECH_OFF%面容憔悴的山区科学家看着他的脚。他郑重地点头。%SPEECH_ON%可以做些修改，我想。 你有一双鸟的眼睛，好心的先生。 我还要谢谢你。 我将告诉人们你的伟大智慧！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "没错，我很聪明。",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_42.png[/img]{你退后一步让他飞行。 他把脸裹在围巾里，然后坐在机器的座位上。 他做了几次深呼吸，然后踩下踏板向前。 它很快到了崩溃的边缘。 那个男人像一种尖叫的蝙蝠一样从皮翅膀中被甩了出去。 他旋转着设备，好像要爆破一大堆木头中的石墙，真是糟糕的设计。 过了一会儿，你听到他最后降落地点传来微弱的嘈杂声。引人入胜的！ | 这名男子把他的机器推下了边缘，在最后一刻跳上了座位。 他们俩都跌下了悬崖，只听见一声短暂的尖叫。 但是，尽管困难重重，这个人很快又出现了！ 他的新发明像喝醉了的蝴蝶一样左右摇摆，但他仍然在空中。%SPEECH_ON%我做到了，神啊，我做到了！看着我…%SPEECH_OFF%突然，一只尖叫的猎鹰刺穿了他的一只翅膀。 这只鸟盘旋着再次攻击，扯断了另一只翅膀。 你挥挥手想把那只杀人鸟吓跑。%SPEECH_ON%嘿，嘿！%SPEECH_OFF%机器摇摇晃晃，慢慢地开始下降高度。 当那个人踩着踏板使劲去弥补时，辐条开始断裂，片刻之后，整个东西都裂开了，你只能看着这个憔悴的科学家坠入地狱。 猎鹰只是蹲在悬崖上，看着它的敌人死去。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好一场表演！",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_42.png[/img]{你不顾更好判断，让那个人飞。 他用围巾把脸裹得严严实实的，好像这样可以使他免于即将到来的硬着陆似的。 他深吸了一口气，推开他的装置，在最后一刻跳了进去，仿佛他是在和他的情人一起浪漫地自杀。 人和机器很快就消失了。 当那个人突然再次出现时，你开始大笑。 他疯狂地踩着踏板，翅膀使劲地拍打着。 他四处航行，绕着这个方向，那个方向，慢慢地越来越高。%SPEECH_ON%我做到了！神啊，我做到了！ 看看我能飞多高！%SPEECH_OFF%他向上射进云层，木头辐条发出的吱吱嘎嘎的声音消失了。%SPEECH_ON%噢，噢啊！%SPEECH_OFF%那是你最后一次见到或听到他。 | 男人把机器推下边缘，跳上座位，就在它摇摇晃晃地滑过边缘的时候。 在尖叫中，这名男子爬回了这个装置。 他从那简陋的木架的最后一根尖上跳了下来，把自己推回到悬崖边，在那里他死命地挣扎着。 你冲过去把他拉上来。 他的机器轰然一声撞向地下深处，那是一种预示着毁灭的柔和的喧嚣。 这个自负的家伙，朝你点了点头。%SPEECH_ON%谢谢你，先生。我突然清醒了一下。 鸟是干什么的？ 它不会从很高的地方起飞，它会随心所欲地起飞！ 我要重做这个项目！ 谢谢你救了我的命，先生。%SPEECH_OFF%在你看来，这已经是最好的结果了。 总之，队员们非常愉快。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "令人惊叹的科学。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Mountains)
		{
			return;
		}

		this.m.Score = 25;
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

