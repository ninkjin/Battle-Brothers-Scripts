this.pacified_flagellant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.pacified_flagellant";
		this.m.Name = "被平息的苦修者";
		this.m.Icon = "ui/backgrounds/background_13.png";
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
		return "在和一位僧侣长谈之后，%name%换用了一种更和平的方式来表达他的信仰。现在你可以放心，当他拿起武器时只会指向别人而不是他自己。";
	}

	function onAddEquipment()
	{
	}

});

