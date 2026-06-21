this.monolith_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.monolith_destroyed";
		this.m.Title = "战斗之后";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_101.png[/img]{%SPEECH_START%失望啊。%SPEECH_OFF%%randombrother%看着被杀的尸体说道。他嗤之以鼻并吐了口口水。%SPEECH_ON%但我觉得用失望来形容并不准确。它们就像躺在那里一样，骨头和外套，就像我们打了一个壁橱。没有肉，没有血，让人不爽。而知道这一点，觉得这是真的，那真让我不安。%SPEECH_OFF%在这种情况下，你能说的只有事实有一定的真实性。如果不是为了满足欲望，为什么还要对暴力如此狂热？另一个雇佣兵叫你过去，打断了任何庄重的自省。%SPEECH_ON%队长，请过来看看。%SPEECH_OFF%你走过去，看到一颗头骨就像一个蛋在肩甲的床上似的。据你所知，它的身体其他部分都被摧毁和吹散了。剩下的是一块奢华的胸甲。上面布满了纹路和装饰，有着命运和历史的记载，还镶有红色流苏和由粗硬的毛发制成的梳子。你触摸金属，第二个你触碰的头骨粉化并飘走了。雇佣兵看到这个情形，有点尴尬地耸了耸肩。%SPEECH_ON%如果你有魔力，我不会告诉别人的。%SPEECH_OFF%你用拳头重重地打了一下雇佣兵的肩膀，并告诉他把这件装备放到存货清单中以备日后分配。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我应该仔细看看那件盔甲。",
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
			Text = "[img]gfx/ui/events/event_101.png[/img]{当人们开始离开时，你听到身后传来一个声音。%SPEECH_ON%……一定不是……%SPEECH_OFF%你转过身，世界在黑暗的隧道中变得更加阴暗，你的人和他们的声音随着黑暗渐渐消失，只剩下一位年迈的男子和黑暗尽头的一束光芒闪烁不安，肉体颤抖，恐怕无法支持。你慢慢走进去，试图找到说话者。他是一个狡猾的老人，弯着腰，背又弯着，双臂比剑柄还细。你回头看，发现被黑暗追逐，身后只有无边无际的黑暗。重新望向前时，那个人突然出现在你面前。他看起来很像，就像你曾经见过但又忘记了的一个人，也许是你在童年时见过的一个濒死的叔叔，在你四岁的冬天和他的最后一次相见。他手拿烛台，蜡滴在他的指节上，滚落到他的手腕上。%SPEECH_ON%你从来就不该是……从来就不是……从来就不该是，你，被称为伪王的那个人。%SPEECH_OFF%你在地上醒来。一群雇佣军用担心的眼神看着你。%SPEECH_ON%你还好吧，队长？%SPEECH_OFF%站起来，你告诉他们你只是短暂地睡了一会儿。你回头看黑色方尖碑，可以看到方尖碑的反射中只有你一个人的身影。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我很好。",
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

