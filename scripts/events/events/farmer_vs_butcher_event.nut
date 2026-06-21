this.farmer_vs_butcher_event <- this.inherit("scripts/events/event", {
	m = {
		Butcher = null,
		Farmer = null
	},
	function create()
	{
		this.m.ID = "event.farmer_vs_butcher";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]你发现 %farmhand% 和 %butcher% 为了一块肉而争吵。 农夫提高了嗓门。%SPEECH_ON%最好的肉来自肩膀。 这就是为什么你要先割掉它！ 你这样切，不是这样，你个白痴。%SPEECH_OFF%屠夫也提高了嗓门，握紧拳头，摇了摇头。%SPEECH_ON%你有啥资格质疑我？ 老子他妈的是个屠夫，你是个狡猾的农民！ 我以此谋生，你这么做是因为你杀了一头牛，然后用力抓它的乳房，毫无疑问，你把它当成你爹的雄鸡了！%SPEECH_OFF%这场骂战引起了一场争斗。 有人被划伤了，有人的鼻子被撞了。 他们被拉开了，但拉开前都受了伤。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你俩现在都是雇佣兵了！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				this.Characters.push(_event.m.Farmer.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury1 = _event.m.Butcher.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury1.getIcon(),
						text = _event.m.Butcher.getName() + " 遭受 " + injury1.getNameOnly()
					});
				}
				else
				{
					_event.m.Butcher.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Butcher.getName() + "遭受轻伤"
					});
				}

				_event.m.Butcher.worsenMood(0.5, "发生斗殴和 " + _event.m.Farmer.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Butcher.getMoodState()],
					text = _event.m.Butcher.getName() + this.Const.MoodStateEvent[_event.m.Butcher.getMoodState()]
				});

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury2 = _event.m.Farmer.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury2.getIcon(),
						text = _event.m.Farmer.getName() + " 遭受 " + injury2.getNameOnly()
					});
				}
				else
				{
					_event.m.Farmer.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Farmer.getName() + "遭受轻伤"
					});
				}

				_event.m.Farmer.worsenMood(0.5, "发生斗殴和 " + _event.m.Butcher.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Farmer.getMoodState()],
					text = _event.m.Farmer.getName() + this.Const.MoodStateEvent[_event.m.Farmer.getMoodState()]
				});
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

		local butcher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.butcher")
			{
				butcher_candidates.push(bro);
				break;
			}
		}

		if (butcher_candidates.len() == 0)
		{
			return;
		}

		local farmer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.farmhand")
			{
				farmer_candidates.push(bro);
			}
		}

		if (farmer_candidates.len() == 0)
		{
			return;
		}

		this.m.Butcher = butcher_candidates[this.Math.rand(0, butcher_candidates.len() - 1)];
		this.m.Farmer = farmer_candidates[this.Math.rand(0, farmer_candidates.len() - 1)];
		this.m.Score = (butcher_candidates.len() + farmer_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"farmhand",
			this.m.Farmer.getNameOnly()
		]);
		_vars.push([
			"butcher",
			this.m.Butcher.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Farmer = null;
		this.m.Butcher = null;
	}

});

