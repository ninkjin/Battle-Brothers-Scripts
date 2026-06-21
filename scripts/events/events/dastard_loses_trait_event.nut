this.dastard_loses_trait_event <- this.inherit("scripts/events/event", {
	m = {
		Dastard = null,
		Braveman1 = null,
		Braveman2 = null
	},
	function create()
	{
		this.m.ID = "event.dastard_loses_trait";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_58.png[/img]你偶然看到 %braveman1% 和 %braveman2% 与 %dastard% 坐在一起。两个人扶起那个有点神经质的队员，让他知道在战斗中没有什么可怕的。%dastard% 解释说他害怕在痛苦中死去。%braveman1% 说他已经见过太多人死于刀剑，说真的，剑是杀人最快的。%braveman2% 举起他的手。%SPEECH_ON%除非剑插到你胃里。%SPEECH_OFF%%braveman1% 点了点头。%SPEECH_ON%是这样的。但除此之外，你真没什么好怕的！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他毕竟成长为一个真正的佣兵了，是么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dastard.getImagePath());
				this.Characters.push(_event.m.Braveman1.getImagePath());
				_event.m.Dastard.getSkills().removeByID("trait.dastard");
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_icon_38.png",
						text = _event.m.Dastard.getName() + "不再畏缩"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_dastard = [];
		local candidates_brave = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getSkills().hasSkill("trait.dastard"))
			{
				candidates_dastard.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.brave") || bro.getSkills().hasSkill("trait.fearless"))
			{
				candidates_brave.push(bro);
			}
		}

		if (candidates_dastard.len() == 0 || candidates_brave.len() < 2)
		{
			return;
		}

		this.m.Dastard = candidates_dastard[this.Math.rand(0, candidates_dastard.len() - 1)];
		this.m.Braveman1 = candidates_brave[0];
		this.m.Braveman2 = candidates_brave[1];
		this.m.Score = candidates_dastard.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dastard",
			this.m.Dastard.getName()
		]);
		_vars.push([
			"braveman1",
			this.m.Braveman1.getName()
		]);
		_vars.push([
			"braveman2",
			this.m.Braveman2.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Dastard = null;
		this.m.Braveman1 = null;
		this.m.Braveman2 = null;
	}

});

