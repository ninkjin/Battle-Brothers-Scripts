this.glutton_gets_fat_event <- this.inherit("scripts/events/event", {
	m = {
		Glutton = null
	},
	function create()
	{
		this.m.ID = "event.glutton_gets_fat";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_14.png[/img] 你看见 %glutton% 已经第三次在找食了。 他吃的太多了，于是你勒令这是他今天最后一次吃东西。 一位兄弟凑过来，嘲笑他的食量。 馋嘴的家伙勃然大怒，一把摔下手中的吃食站了起来。 但他的肚子却没那么听话，软软的甩起来使他失去了重心一屁股坐倒在地，摔成一滩挥舞着手臂的肉山。 就在其他兄弟们大笑不止的时候，你不得不担心这个佣兵是不是太胖了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "把猪肉放下, 马上！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Glutton.getImagePath());
				local trait = this.new("scripts/skills/traits/fat_trait");
				_event.m.Glutton.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Glutton.getName() + "变得肥胖"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() < 100)
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
			if (bro.getLevel() >= 3 && bro.getSkills().hasSkill("trait.gluttonous") && !bro.getSkills().hasSkill("trait.fat"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Glutton = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"glutton",
			this.m.Glutton.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Glutton = null;
	}

});

