this.assassin_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.assassin";
		this.m.Name = "刺客";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name%代替作为他目标的贵族私生子加入了战团。这样的协议十分奇怪，令你盯着刺客观察了许多天。但他只是在为%companyname%而战，而且打得很出色。据你最后所知，刺客已经离开了战团并且从此再无音讯。你去查看那贵族私生子，想知道刺客是否完成了任务，但发现他还活得好好的。最终这只是一次奇特的相遇。";
		this.m.BadEnding = "%name%代替作为他目标的贵族私生子加入了战团。这样的协议十分奇怪，令你盯着刺客观察了许多天。但他只是在为%companyname%而战，而且打得很出色。据你最后所知，刺客在你匆忙退休后很快就离开了战团。你决定去查看作为他目标的贵族私生子，只发现他被一个没有遭到目击的刺客杀死了。看来%name%最终还是完成了任务。";
		this.m.HiringCost = 800;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			"trait.huge",
			"trait.weasel",
			"trait.teamplayer",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.dumb",
			"trait.loyal",
			"trait.clumsy",
			"trait.fat",
			"trait.strong",
			"trait.hesitant",
			"trait.insecure",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.brute",
			"trait.strong",
			"trait.bloodthirsty"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"刺客"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = 4;
		this.m.IsCombatBackground = true;
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
				10,
				10
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				12,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				20,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("刺客");
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		items.equip(this.new("scripts/items/armor/thick_dark_tunic"));
		items.equip(this.new("scripts/items/helmets/hood"));
	}

});

