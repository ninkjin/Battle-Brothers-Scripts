this.converted_cultist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.converted_cultist";
		this.m.Name = "邪教徒";
		this.m.Icon = "ui/backgrounds/background_34.png";
		this.m.HiringCost = 45;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.athletic",
			"trait.bright",
			"trait.drunkard",
			"trait.dastard",
			"trait.gluttonous",
			"trait.insecure",
			"trait.disloyal",
			"trait.hesitant",
			"trait.fat",
			"trait.bright",
			"trait.greedy",
			"trait.craven",
			"trait.fainthearted"
		];
		this.m.Titles = [
			"邪教徒",
			"疯子",
			"教徒",
			"错乱者"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
	}

	function onBuildDescription()
	{
		return "这个人曾经是谁已不再重要。现在他前额标记着达库尔的印记，虽然他的舌头还没捋顺他新入宗教的词汇，但是却用熟悉的语调谈论邪教之神。黑暗就要来了，他如是说。";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (!tattoo_body.HasBrush && this.Math.rand(1, 100) <= 50)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		actor.setDirty(true);
	}

});

