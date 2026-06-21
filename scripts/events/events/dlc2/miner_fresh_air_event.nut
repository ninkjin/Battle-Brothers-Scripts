this.miner_fresh_air_event <- this.inherit("scripts/events/event", {
	m = {
		Miner = null
	},
	function create()
	{
		this.m.ID = "event.miner_fresh_air";
		this.m.Title = "在途中…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{%miner%矿工深吸口气，然后长长地呼出，虽然有些喘气。他满意地点点头，好像满足了一些每个人都做的事情。看来有些人很容易满足。但他解释了一下。%SPEECH_ON%你知道我在矿井里度过了几年，呼吸着尘土和金属。我认为待在表面这么久已经是一种幸运，一种我不知道存在的宝藏。谢谢，队长，因为如果不是你，我现在不会在这里。%SPEECH_OFF%你点了点头，感谢他的好话。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "从海上吹来一阵清新的微风。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Miner.getImagePath());
				_event.m.Miner.improveMood(1.0, "很高兴有新的生活");

				if (_event.m.Miner.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Miner.getMoodState()],
						text = _event.m.Miner.getName() + this.Const.MoodStateEvent[_event.m.Miner.getMoodState()]
					});
				}

				local stamina = this.Math.rand(3, 6);
				_event.m.Miner.getBaseProperties().Stamina += stamina;
				_event.m.Miner.getSkills().update();
				_event.m.Miner.getFlags().add("fresh_air");
				this.List.push({
					id = 17,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Miner.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] 最大疲劳"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
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
			if (bro.getLevel() > 3 && bro.getBackground().getID() == "background.miner" && !bro.getFlags().has("fresh_air"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Miner = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"miner",
			this.m.Miner.getName()
		]);
	}

	function onClear()
	{
		this.m.Miner = null;
	}

});

