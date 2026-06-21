this.oathtaker_happy_with_company_event <- this.inherit("scripts/events/event", {
	m = {
		Oathtaker = null
	},
	function create()
	{
		this.m.ID = "event.oathtaker_happy_with_company";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_183.png[/img]{誓言守护者%oathtaker%在篝火旁加入了你。他点了点头。%SPEECH_ON%尊敬的队长，要求一个人表现出真正的善良是一件大事。当我初次认识你时，我不认为你有这样的能力。我以为这个世界逐渐的黑暗会消磨你的意志，像将沙子磨成石头一般。但你在这里，坚定不移。一次次遵守誓言。干得好。我想Young Anselm也会为你感到自豪的。%SPEECH_OFF%你感谢誓言守护者的夸奖。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴有人欣赏。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Oathtaker.getImagePath());
				_event.m.Oathtaker.getBaseProperties().Bravery += 2;
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Oathtaker.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
				_event.m.Oathtaker.improveMood(1.0, "对战团的道德方针感到高兴。");

				if (_event.m.Oathtaker.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Oathtaker.getMoodState()],
						text = _event.m.Oathtaker.getName() + this.Const.MoodStateEvent[_event.m.Oathtaker.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		if (this.World.Assets.getMoralReputation() < 80.0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local oathtaker_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin" && bro.getLevel() >= 5)
			{
				oathtaker_candidates.push(bro);
			}
		}

		if (oathtaker_candidates.len() == 0)
		{
			return;
		}

		this.m.Oathtaker = oathtaker_candidates[this.Math.rand(0, oathtaker_candidates.len() - 1)];
		this.m.Score = 5 * oathtaker_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Oathtaker = null;
	}

});

