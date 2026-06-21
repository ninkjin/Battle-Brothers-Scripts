this.fat_guy_gets_fit_event <- this.inherit("scripts/events/event", {
	m = {
		FatGuy = null
	},
	function create()
	{
		this.m.ID = "event.fat_guy_gets_fit";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_75.png[/img]%fatguy%，曾经是双腿鼓鼓的大肚男人，自从在战队工作以来，他的体重已经减轻了不少。 不在是仅仅一场拳击比赛的强度就让他喘不过气来。 事实上，他的步伐更灵敏了，表现出一种你以前从未见过的敏捷。 看起来这一切是个奇迹。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他也许已经成为一个出色的佣兵了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.FatGuy.getImagePath());
				_event.m.FatGuy.getSkills().removeByID("trait.fat");
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_icon_10.png",
						text = _event.m.FatGuy.getName() + "不再胖了"
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
			if (bro.getLevel() >= 5 && bro.getSkills().hasSkill("trait.fat"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.FatGuy = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 5;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fatguy",
			this.m.FatGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.FatGuy = null;
	}

});

