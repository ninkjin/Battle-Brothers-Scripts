this.monk_turned_flagellant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.monk_turned_flagellant";
		this.m.Name = "僧侣转化的苦修者";
		this.m.Icon = "ui/backgrounds/background_26.png";
		this.m.HiringCost = 60;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.clubfooted",
			"trait.tough",
			"trait.strong",
			"trait.disloyal",
			"trait.insecure",
			"trait.cocky",
			"trait.fat",
			"trait.fainthearted",
			"trait.bright",
			"trait.craven",
			"trait.greedy",
			"trait.gluttonous"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.IsOffendedByViolence = true;
	}

	function onBuildDescription()
	{
		return "这个世界太黑暗了%name%无法继续坚持他的修行方式。一次与苦修者的谈话向他表明，古神对人类通过合理手段追求正义并不满意。现在可以发现这个前僧侣在鞭打自己，一次一次地将正义之血注入世界。";
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();

			if (actor.getTitle() == "")
			{
				actor.setTitle(this.Const.Strings.PilgrimTitles[this.Math.rand(0, this.Const.Strings.PilgrimTitles.len() - 1)]);
			}
		}
	}

	function onAddEquipment()
	{
	}

});

