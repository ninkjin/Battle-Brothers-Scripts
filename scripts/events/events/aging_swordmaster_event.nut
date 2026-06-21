this.aging_swordmaster_event <- this.inherit("scripts/events/event", {
	m = {
		Swordmaster = null
	},
	function create()
	{
		this.m.ID = "event.aging_swordmaster";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]你看到 %swordmaster% 费力地想要坐在树墩上。 当他慢慢蹲下时，你看到他那因难以弯曲而剧烈颤抖的双腿。 好不容易坐下后，他不由得长出了一口气。 他的剑被随意的丢在身旁。 它比拥有它的手还年轻，是一个替代品的替代品。 他并不喜欢它，但当他触摸它的时候，你会感觉到一把剑的想法，一个人是如何用它展示自己的，他是如何用它的锋刃砍杀别人的。 你转身离开，想让剑术大师独自静一静，但他已经注意到了你，开口喊道。%SPEECH_ON%嗨，队长，不是有意让你看到的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你还好吗？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "好吧，但我已经看到了。继续前进吧。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_17.png[/img]他颓然后仰，粗糙的手不停按摩着膝盖。 风轻轻吹过他那斑白的头发。%SPEECH_ON%老了。我越来越老了。 不是指我的年纪。 数年以前，我就已经开始变老了。 我是说我已经老了。 我想这年头我靠名声过活的而不是技术。%SPEECH_OFF%你立刻不同意，告诉他他是你见过的最致命的人之一。%SPEECH_ON%把这些甜言蜜语用在女人身上吧，队长。 我老眼昏花。你可能不愿意听这些话，但这是事实。 我不再健步如飞，双脚像灌了铅一样。 膝盖也不再灵活。 总有一天，我不能在战场上自保的。 我握剑的手已经没有知觉了。%SPEECH_OFF%剑术大师的另一只手时紧时松，仿佛十分不甘。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "感觉到什么了吗？",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_17.png[/img]%SPEECH_ON%什么都没有感觉到。我想是神经衰弱了。 有时我会忘记一些事情。 我不知道把鞋子扔到了什么地方。 我也时常觉得背后好像有人，但不确定是否是幻觉。 我不再能眼观六路耳听八方，这才是最致命的。 我不再出手如电，对剑意也不再能运用自如，时间是让人猝不及防的东西，晴时有风阴有时雨，争不过朝夕，又念着往昔，偷走了青丝却什么都没有留下。 我一直以为我会被另一个剑客打败。 某个天才。但我想我做得太好了。%SPEECH_OFF%剑术大师自嘲地笑了起来。 你问他是否害怕岌岌无名的死去。%SPEECH_ON%很久之前，我遇到你的时候就意识到了我不会生的光荣死的伟大。 他们会在书上写一个比我低的人如何杀死伟大的剑术大师。 这是愚蠢的想法。如果你想知道真相，我会告诉你的。 我害怕我所知道的就要来了。 我的身体会在最后时刻背叛我。 随着时间的流逝，我的身体将杀死我。 膝盖变得僵硬，肩膀变得疲惫，握剑的双手也没了力气。 我不怕死。 我做过太过恶事，深知地狱对我来说是应得的报应。 我的身体会先杀了我，然后死亡就可以拥有剩下的东西，那该死的黑色草皮。 作家和历史学家？ 去他们的吧。如果我想得到永恒的荣耀，我会独自面对。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我相信你有能力这么做。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_17.png[/img]老剑术大师开怀大笑。 %SPEECH_ON%噢，别碰它，队长。 扶我一把，我们继续赶路。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "时光流逝。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				local old_trait = this.new("scripts/skills/traits/old_trait");
				_event.m.Swordmaster.getSkills().add(old_trait);
				_event.m.Swordmaster.setHitpoints(this.Math.min(_event.m.Swordmaster.getHitpoints(), _event.m.Swordmaster.getHitpointsMax()));
				this.List = [
					{
						id = 13,
						icon = old_trait.getIcon(),
						text = _event.m.Swordmaster.getName() + "已经变老了"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_17.png[/img]你转身时听到了老剑术大师的叹息。 看来，跟上战队的步伐，对他来说像战斗一样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "时光流逝。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				local old_trait = this.new("scripts/skills/traits/old_trait");
				_event.m.Swordmaster.getSkills().add(old_trait);
				_event.m.Swordmaster.setHitpoints(this.Math.min(_event.m.Swordmaster.getHitpoints(), _event.m.Swordmaster.getHitpointsMax()));
				this.List = [
					{
						id = 13,
						icon = old_trait.getIcon(),
						text = _event.m.Swordmaster.getName() + "已经变老了"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 9 && bro.getBackground().getID() == "background.swordmaster" && !bro.getSkills().hasSkill("trait.old") && !bro.getFlags().has("IsRejuvinated"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Swordmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = this.m.Swordmaster.getLevel() - 5;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"swordmaster",
			this.m.Swordmaster.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Swordmaster = null;
	}

});

