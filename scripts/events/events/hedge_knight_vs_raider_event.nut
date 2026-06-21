this.hedge_knight_vs_raider_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight = null,
		Raider = null
	},
	function create()
	{
		this.m.ID = "event.hedge_knight_vs_raider";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%raider% 坐在篝火旁边，他的眼神深深地盯着火焰。 不久之前，几个人曾经朝着他吼过一顿。 作为一个掠夺者，此人很明显得罪过不少人。 野骑士%hedgeknight% 走到他身边站着。 两人互相瞥了一眼，你还以为他们俩要打上一架。 结果，野骑士却坐下了。 他平静地开口，不过他深沉的声音还是充满了威慑力。%SPEECH_ON%你以前曾经驾着长船掠夺海岸，是吧？ 屠杀女人和孩子？ 从教士手里抢东西？%SPEECH_OFF%掠夺者点头。%SPEECH_ON%嗯，还有更多更坏的事。%SPEECH_OFF%%hedgeknight% 从火堆里捞出一块冒着火的焦炭。 用两只空手碾得粉碎，火焰熄灭了，变成烟与灰烬。 他松开手，抖落那些灰渣。%SPEECH_ON%别理那些人说的话，掠夺者。 这是一个肮脏、饥饿的世界，而你从它的利齿下活了下来。 让那些弱者哭叫着丧命吧。 我们能做的只有穿好铠甲，面对那些吃婴儿的饥渴的死者，它们可想要我们的命呢。%SPEECH_OFF%掠夺者也拿起一块火炭，把它捏碎。 两个人最后握了一下手，再未发一言。",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "命运偏向于强者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				this.Characters.push(_event.m.Raider.getImagePath());
				_event.m.HedgeKnight.improveMood(1.0, "建立友谊与 " + _event.m.Raider.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.HedgeKnight.getMoodState()],
					text = _event.m.HedgeKnight.getName() + this.Const.MoodStateEvent[_event.m.HedgeKnight.getMoodState()]
				});
				_event.m.Raider.improveMood(1.0, "建立友谊与 " + _event.m.HedgeKnight.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Raider.getMoodState()],
					text = _event.m.Raider.getName() + this.Const.MoodStateEvent[_event.m.Raider.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local hedge_knight_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.hedge_knight")
			{
				hedge_knight_candidates.push(bro);
			}
		}

		if (hedge_knight_candidates.len() == 0)
		{
			return;
		}

		local raider_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.raider")
			{
				raider_candidates.push(bro);
			}
		}

		if (raider_candidates.len() == 0)
		{
			return;
		}

		this.m.HedgeKnight = hedge_knight_candidates[this.Math.rand(0, hedge_knight_candidates.len() - 1)];
		this.m.Raider = raider_candidates[this.Math.rand(0, raider_candidates.len() - 1)];
		this.m.Score = (hedge_knight_candidates.len() + raider_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hedgeknight",
			this.m.HedgeKnight.getNameOnly()
		]);
		_vars.push([
			"raider",
			this.m.Raider.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.HedgeKnight = null;
		this.m.Raider = null;
	}

});

