this.gladiators_vibes_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator1 = null,
		Gladiator2 = null
	},
	function create()
	{
		this.m.ID = "event.gladiators_vibes";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_155.png[/img]{%gl1% 看着 %gl2% 拔着他的眼睫毛，用它武器刀刃的反光当镜子。%SPEECH_ON%你的背看起来又厚又结实，%gl2%。就是那样，伙计。%SPEECH_OFF%角斗士转身点头。%SPEECH_ON%谢谢，我用它来撑起这个战队。%SPEECH_OFF% | %SPEECH_ON%准备好！准备好！%SPEECH_OFF%%gl1% 半蹲着喊道。%gl2% 赶上来拍了拍他的屁股喊道“走！”。 他深蹲远超过九十度角。%SPEECH_ON%很紧！%SPEECH_OFF%%gl2% 确认。%SPEECH_ON%多紧？%SPEECH_OFF%%gl2% 将一只手收回，缩成拳头，然后揍了他屁股一拳。 然后他来回挥动他的手，就像碰到了热锅一样。%SPEECH_ON%比维齐尔的钱包还紧！%SPEECH_OFF%%gl1% 结束了他的深蹲站起来，然后他们胸肌撞胸肌。%SPEECH_ON%到你了，伙计！我们走！%SPEECH_OFF% | %SPEECH_ON%嘿，看看这个。%SPEECH_OFF%%gl1%的胸部弹跳着，一次一边的弹着。 你跟他说“好胸”准备继续走，但他抓住了你。%SPEECH_ON%他们不是胸部，是胸肌。 而且他们很美。嘿。说他们很美。%SPEECH_OFF%一个乳头弹起，然后是另一个，前后来回。 叹气，你说了他们很美。%gl1% 点头并从眼中抹走了点什么。%SPEECH_ON%谢谢，队长。%SPEECH_OFF% | 你发现 %gl1% 和 %gl2% 一起做卧推，后者随着他上上下下读着一张卷轴。%SPEECH_ON%%randomcitystate% 传说有美女。%SPEECH_OFF%他回头看向那个举着他的人。%gl1% 瞥了你一眼然后回到他的锻炼中去。%SPEECH_ON%九十八。九十九。一百！好，反过来。%SPEECH_OFF%%gl2% 翻过身，%gl1%的手拍打他的胸脯和腹部。%SPEECH_ON%好，再重复一百遍。%SPEECH_OFF% | %gl1% 举起四只手指。%gl2% 举起六只。 翘起头，%gl1% 笑了。%SPEECH_ON%一晚上？%SPEECH_OFF%另一个角斗士点头。%SPEECH_ON%是的先生，一晚上。%SPEECH_OFF%%gl1% 笑着问他们是不是都是女人。%gl2% 迟疑了一下。%SPEECH_ON%好吧，那时有几个男人在那。 但我们没有，你懂得，碰啊什么的。 我们很亲近就是了，因为有一次他在下面，然后我以这个姿势在他身后－%SPEECH_OFF%你走过来鼓了个掌，不是在轻喝，而是告诉角斗士保持专注。 你理解路上可能又长又无聊，但这有点过了。 | %gl1% 活动起他的肱二头肌。%SPEECH_ON%我能用一个手臂扭断一头驴的脖子。%SPEECH_OFF%摇着头，%gl2% 问他那么他在同时活动两支手臂。%gl1% 翘起头作为回应。%SPEECH_ON%很显然我计划一次同时干掉两只驴，伙计。%SPEECH_OFF%你打断他们，告诉他们不会在完成 %companyname%的主要工作前杀什么动物，而这些任务只是有时是关于杀动物。 | %gl1% 坐在 %gl2% 旁转向一边。他说。%SPEECH_ON%把你的手放我背上。 肩膀正中间那里。%SPEECH_OFF%另一个角斗士没有疑问或好奇就这么照做了。 相对的，%gl1% 伸展着，把他的手夹在两块巨大的肌肉中间。%SPEECH_ON%你喜欢这种力量吗？%SPEECH_OFF%再一次，没有任何讽刺或难以置信，%gl2% 给与回应。%SPEECH_ON%这太棒了，伙计！ 我能听到我的手骨在咔嗒作响！%SPEECH_OFF%你想管一下，但是技术性的说没有人受伤…目前为止。 你让两个角斗士继续他们的，嗯，兴趣爱好。 | %SPEECH_START%就这么我把她从水果车牵过来然后我们享受着美好时光的时候她父亲走了进来。 他下巴脱臼似的说不出话。%SPEECH_OFF%%gl1% 点了点头。%SPEECH_ON%所以我跟他说，看着这个。 然后我后退并慢慢的展示我的双臂，慢悠悠的，她从地上被抬起。%SPEECH_OFF%%gl2% 拍响另一个角斗士泛油光的胸肌。%SPEECH_ON%你撒谎！那是一派胡言！%SPEECH_OFF%角斗士举起它的手。%SPEECH_ON%以镀金者的光之名，还有其他什么呆呆地盯着我身体的神，这是真的。 我的擎天柱充满力量。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "开心就好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator1.getImagePath());
				this.Characters.push(_event.m.Gladiator2.getImagePath());
				_event.m.Gladiator1.improveMood(1.0, "感觉强壮和美丽");

				if (_event.m.Gladiator1.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Gladiator1.getMoodState()],
						text = _event.m.Gladiator1.getName() + this.Const.MoodStateEvent[_event.m.Gladiator1.getMoodState()]
					});
				}

				_event.m.Gladiator2.improveMood(1.0, "感觉强壮和美丽");

				if (_event.m.Gladiator2.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Gladiator2.getMoodState()],
						text = _event.m.Gladiator2.getName() + this.Const.MoodStateEvent[_event.m.Gladiator2.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_155.png[/img]{%gl1% 冲进你的帐篷。%SPEECH_ON%队长！快，%gl2% 需要帮助！%SPEECH_OFF%你冲出帐篷找到 %gl2% 坐在篝火前。 他在颤抖。%gl1% 告诉你他做了个噩梦。%SPEECH_ON%他梦到他瘦到难以举起一篮子苹果。 女人对他吐痰。 孩子恐惧着远离他。 而且他去了竞技场，只是他得坐在座位上！%SPEECH_OFF%%gl2% 悲伤的向上看。%SPEECH_ON%它们甚至不是什么好座位，队长。 甚至都不是好座位。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那只不过是个噩梦。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator1.getImagePath());
				this.Characters.push(_event.m.Gladiator2.getImagePath());
				_event.m.Gladiator2.worsenMood(1.0, "做了个不强壮不漂亮的噩梦");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Gladiator2.getMoodState()],
					text = _event.m.Gladiator2.getName() + this.Const.MoodStateEvent[_event.m.Gladiator2.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.gladiators")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gladiator" && bro.getFlags().get("IsPlayerCharacter"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		local r = candidates.len() - 1;
		this.m.Gladiator1 = candidates[r];
		candidates.remove(r);
		local r = candidates.len() - 1;
		this.m.Gladiator2 = candidates[r];
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gl1",
			this.m.Gladiator1 != null ? this.m.Gladiator1.getName() : ""
		]);
		_vars.push([
			"gl2",
			this.m.Gladiator2 != null ? this.m.Gladiator2.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.Math.rand(1, 100) <= 90)
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onClear()
	{
		this.m.Gladiator1 = null;
		this.m.Gladiator2 = null;
	}

});

