this.belly_dancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.belly_dancer";
		this.m.Name = "肚皮舞者";
		this.m.Icon = "ui/backgrounds/background_64.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "南方的肚皮舞者%name%在合适的时机离开了战团。虽然他的…专长…让他成为了出色的士兵，但这并不是他终身的梦想。通过旋律配合奇妙且充满情调的动作来娱乐人们，这才是他想要的。你听到的最新消息是他在一名维齐尔的宫殿里不仅充当表演者，同时还担任武术顾问，真是多亏了他跟%companyname%在一起的那段时间。";
		this.m.BadEnding = "由于战团未能取得你所希望的成功，许多人离开了它的队伍。南方的肚皮舞者%name%也在其中。不幸的是，他试图在北方进行他的老行当，觉得他可能可以将自己的文化传播开来。本地人很快指责他使用'未受监管的身体巫术'并将其绑在了火刑柱上。";
		this.m.HiringCost = 0;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.huge",
			"trait.clubfooted",
			"trait.clumsy",
			"trait.fat",
			"trait.strong",
			"trait.hesitant",
			"trait.insecure",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.brute",
			"trait.strong",
			"trait.bloodthirsty",
			"trait.deathwish"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.Bravery
		];
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.IsCombatBackground = false;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				5,
				5
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("肚皮舞者");
	}

	function onAddEquipment()
	{
	}

});

