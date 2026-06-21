this.strength_contest_event <- this.inherit("scripts/events/event", {
	m = {
		Strong1 = null,
		Strong2 = null
	},
	function create()
	{
		this.m.ID = "event.strength_contest";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img] %strong1% and %strong2%－从某种程度上说是整个队伍中最强壮的人－他们显然是在进行一场竞赛，看谁更强壮。 你看着他们把巨大的石头从临时竞争场地的一边搬到另一边。 然后他们轮流着看能把这些石头扔多远。 然后他们把石头滚到附近的山上。 然后他们看谁能更快的完全掩埋一块石头。\n\n总之，有很多沉重的石头被挤来挤去，直到这个节日般的活动结束时，两人都筋疲力尽了。 即使没有胜利者，搬石头这个历史悠久的传统也提升了队员们的士气。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们是头脑简单的生物。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Strong1.getImagePath());
				this.Characters.push(_event.m.Strong2.getImagePath());
				_event.m.Strong1.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Strong2.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Strong1.getBaseProperties().Stamina += 1;
				_event.m.Strong1.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Strong1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 最大疲劳"
				});
				_event.m.Strong2.getBaseProperties().Stamina += 1;
				_event.m.Strong2.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Strong2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 最大疲劳"
				});
				_event.m.Strong1.improveMood(1.0, "建立友谊与 " + _event.m.Strong2.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Strong1.getMoodState()],
					text = _event.m.Strong1.getName() + this.Const.MoodStateEvent[_event.m.Strong1.getMoodState()]
				});
				_event.m.Strong2.improveMood(1.0, "建立友谊与 " + _event.m.Strong1.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Strong2.getMoodState()],
					text = _event.m.Strong2.getName() + this.Const.MoodStateEvent[_event.m.Strong2.getMoodState()]
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

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.strong") && !bro.getSkills().hasSkill("trait.bright"))
			{
				if (!bro.getFlags().has("ParticipatedInStrengthContests") || bro.getFlags().get("ParticipatedInStrengthContests") < 2)
				{
					candidates.push(bro);
				}
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		this.m.Strong1 = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Strong2 = null;
		this.m.Score = candidates.len() * 5;

		do
		{
			this.m.Strong2 = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		while (this.m.Strong2 == null || this.m.Strong2.getID() == this.m.Strong1.getID());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"strong1",
			this.m.Strong1.getName()
		]);
		_vars.push([
			"strong2",
			this.m.Strong2.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Strong1 = null;
		this.m.Strong2 = null;
	}

});

