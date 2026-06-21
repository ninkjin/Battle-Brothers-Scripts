this.disowned_noble_reminisces_event <- this.inherit("scripts/events/event", {
	m = {
		Disowned = null
	},
	function create()
	{
		this.m.ID = "event.disowned_noble_reminisces";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]你发现 %disowned% 独自坐在营地外。 当营火周围的人在你身后发出叽叽喳喳的嘲笑和欢呼时，你走近那个人，问他在生气什么。他耸耸肩。%SPEECH_ON%我不是在生闷气，先生，我只是在思考。 尽管我认为其中一个很容易被误认为另一个。%SPEECH_OFF%轻声笑着，他提供了一点酒，你接过去了。 在他身边坐下，你问他在“想”什么。 那个没落的的贵族又耸耸肩。%SPEECH_ON%啊，其实没什么。只是想家。 我现在离它还有很远一段路要走，我记得的最后一次也不是最好的，但我仍然觉得自己时不时地想去那里。 思乡病在我看来是一种高贵的疾病，想想看吧。%SPEECH_OFF%你把酒还给他，因为他可能比你更需要。 趁你头脑还清醒，你试着说出你的想法…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去他妈的老家，你现在是和我们在一起。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "偶尔想家也没啥大不了的。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
				_event.m.Disowned.getFlags().set("disowned_noble_reminisces", true);
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]你说。%SPEECH_ON%你离开的地方是一所房子，不是一个家。 你渴望在不一样的时间来到一个不一样的地方，当你来到这个地方的时候，就在这里，就在此刻。 %companyname% 照顾你，和你在一起，我们才会持之以恒。%SPEECH_OFF%这个男人盯着酒杯看了一会儿。 他低声笑着，抿着酒，擦去了脸上的泡沫。%SPEECH_ON%是的，我想这是看待思乡病的一种方式。谢谢你，队长。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Anytime.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
				local resolve = this.Math.rand(1, 3);
				_event.m.Disowned.getBaseProperties().Bravery += resolve;
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				_event.m.Disowned.improveMood(1.0, "和你谈得很愉快");

				if (_event.m.Disowned.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Disowned.getMoodState()],
						text = _event.m.Disowned.getName() + this.Const.MoodStateEvent[_event.m.Disowned.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_26.png[/img]你拍拍他的肩膀说。%SPEECH_ON%嘿，思念过去对灵魂是有好处的，即使它是通过一堆狗屎，残忍，邪恶和其他让人夜不能寐的东西。 但这只是暂时的。 你回顾过去，承认它，然后继续前进。 你必须确保只回顾过去，而不是停留在过去。 这里的每个人都有自己的过去，%disowned%，在这方面，你永远不会孤单。%SPEECH_OFF%这个没落的贵族盯着地面看了一会儿。 他慢慢地开始点头。%SPEECH_ON%是的，是的，没错。 我想我的一部分担心是我真的想回到那里。 我想象着炉火烧的很旺，烟囱冒着烟，窗前是柔和的烛光，我的家人在那儿等着我。 我不去理会那扇锁着的门，门外蹲着看门的狗狗，还有那些我喜欢的狗狗，它们告诉我永远不要回来，以免它被关在一个盒子里，埋在地底下很远的地方。 我不会对我的过去思虑太多了，我想是你帮助我认识到这一点的，队长。 谢谢你。我知道，总有一天，我不会强迫自己梦到 %companyname%，但取而代之的是清晰而亲切的回忆。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战队为此感到欣喜。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
				local resolve = this.Math.rand(1, 3);
				_event.m.Disowned.getBaseProperties().Bravery += resolve;
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				_event.m.Disowned.improveMood(1.0, "和你谈得很愉快");

				if (_event.m.Disowned.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Disowned.getMoodState()],
						text = _event.m.Disowned.getName() + this.Const.MoodStateEvent[_event.m.Disowned.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 5 && bro.getBackground().getID() == "background.disowned_noble" && !bro.getFlags().get("disowned_noble_reminisces"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Disowned = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"disowned",
			this.m.Disowned.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Disowned = null;
	}

});

