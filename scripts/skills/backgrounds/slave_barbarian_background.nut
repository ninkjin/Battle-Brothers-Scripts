this.slave_barbarian_background <- this.inherit("scripts/skills/backgrounds/slave_background", {
	m = {},
	function create()
	{
		this.slave_background.create();
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Bodies = this.Const.Bodies.AllMale;
		this.m.Names = this.Const.Strings.BarbarianNames;
		this.m.Titles = [
			"野蛮人",
			"北境人",
			"苍白",
			"囚犯",
			"倒霉蛋",
			"被奴役者",
			"掠夺者",
			"俘虏",
			"不自由者",
			"不驯者",
			"被束缚者",
			"戴镣铐者",
			"被捆缚者"
		];
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				-2,
				-1
			],
			RangedDefense = [
				-2,
				-1
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

});

