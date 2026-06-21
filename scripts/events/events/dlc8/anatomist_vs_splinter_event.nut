this.anatomist_vs_splinter_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		SplinterBro = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_splinter";
		this.m.Title = "露营时…";
		this.m.Cooldown = 110.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{你看到%anatomist%拿着%splinterbro%的赤裸裸的脚。当然，你问了他们在干什么。解剖学家拿着镊子，夹着一个巨大的木屑，站了起来。 %splinterbro%扭动着脚趾，然后站了起来。他在房间里走来走去，然后迅速地把脚落在地上并向前和向后走动。%SPEECH_ON%该死，我以为我的脚或者其他什么地方出了毛病，结果原来我带着一个巨大的垃圾碎片走了好多年！感觉太棒了！%SPEECH_OFF% %anatomist%没有扔掉木片，而是将其放在一个木盒子里，那里还有其他的医疗奇异物品。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最好不要看到你用它当牙签。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.SplinterBro.getImagePath());
				_event.m.SplinterBro.getBaseProperties().MeleeDefense += 1;
				_event.m.SplinterBro.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.SplinterBro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 近战防御"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local splinter_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.bright") && bro.getBackground().getID() != "background.monk" || bro.getBackground().getID() != "background.historian" || bro.getBackground().getID() != "background.adventurous_noble" || bro.getBackground().getID() != "background.disowned_noble" || bro.getBackground().getID() != "background.regent_in_absentia" || bro.getBackground().getID() != "background.minstrel")
			{
				splinter_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0 || splinter_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.SplinterBro = splinter_candidates[this.Math.rand(0, splinter_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
		_vars.push([
			"splinterbro",
			this.m.SplinterBro.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.SplinterBro = null;
	}

});

