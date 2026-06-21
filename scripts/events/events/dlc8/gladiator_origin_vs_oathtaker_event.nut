this.gladiator_origin_vs_oathtaker_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator = null,
		Oathtaker = null
	},
	function create()
	{
		this.m.ID = "event.gladiator_origin_vs_oathtaker";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%oathtaker%和%gladiator%正思考着武器的正确使用。Oathtaker倾向于认为每一次挥剑都由一种意图驱动，而这种意图是为了做好事。角斗士反驳道，保护自己的生命才是最重要的，所以每一次挥剑都已经具有了好的意图，因此其最终目的不应该是为自己，而应该是为看台上的观众。%oathtaker%抬起了他的眉毛说,%SPEECH_ON%你认为战斗就是表演吗，角斗士？%SPEECH_OFF%%gladiator%微笑着靠近他%SPEECH_ON%生命本身就是一场表演,Oathtaker，而我是这场表演的主角%SPEECH_OFF%...你很遗憾听到了他们的对话。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真是个恐怖的表演。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				this.Characters.push(_event.m.Oathtaker.getImagePath());
				_event.m.Gladiator.improveMood(1.0, "确信他在世界上的重要性");

				if (_event.m.Gladiator.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Gladiator.getMoodState()],
						text = _event.m.Gladiator.getName() + this.Const.MoodStateEvent[_event.m.Gladiator.getMoodState()]
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

		if (this.World.Assets.getOrigin().getID() != "scenario.gladiators")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local gladiator_candidates = [];
		local oathtaker_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				oathtaker_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.gladiator" && bro.getFlags().get("IsPlayerCharacter"))
			{
				gladiator_candidates.push(bro);
			}
		}

		if (oathtaker_candidates.len() == 0 || gladiator_candidates.len() == 0)
		{
			return;
		}

		this.m.Gladiator = gladiator_candidates[this.Math.rand(0, gladiator_candidates.len() - 1)];
		this.m.Oathtaker = oathtaker_candidates[this.Math.rand(0, oathtaker_candidates.len() - 1)];
		this.m.Score = 3 * oathtaker_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gladiator",
			this.m.Gladiator.getName()
		]);
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getName()
		]);
	}

	function onClear()
	{
		this.m.Gladiator = null;
		this.m.Oathtaker = null;
	}

});

