this.cultist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cultist";
		this.m.Name = "邪教徒";
		this.m.Icon = "ui/backgrounds/background_34.png";
		this.m.BackgroundDescription = "邪教徒有相当的决心去进一步传播他们颇具规模的邪教。";
		this.m.GoodEnding = "邪教徒%name%和一伙穿着斗篷的改信者离开了战团。你不知道他之后如何，但是他时不时就会出现在你的梦中。他经常独自站在一个巨大的虚空中，黑暗之外总有个什么人或什么东西在徘徊。这个景象每晚都会变得更加清晰，而你发现每晚你都睡得越来越晚，只是为了避免做梦。";
		this.m.BadEnding = "你听说邪教徒%name%后来离开了战团去传播他的信仰。没人知道他之后如何，但近来有一场针对邪恶信仰的宗教审判，在各地烧死了数百个身着黑斗篷的险恶之徒。";
		this.m.HiringCost = 50;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.night_blind",
			"trait.lucky",
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
			"通神术士",
			"错乱者",
			"追随者",
			"迷失者",
			"奇葩",
			"歧途",
			"狂热者",
			"狂信徒"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
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

	function onBuildDescription()
	{
		return "{这个人站在那里，脖子上挂着标语牌。 | 这个人的脸上满是花哨的纹身。他带着一份笔记。 | 这个人将他的脸深深的藏在兜帽中，黑暗中你只能看到一小块鼻梁。他脖子上挂着标语牌。 | 奇怪的是，虽然这个人穿着破烂衣服，但在炎热或寒冷的天气里既不出汗也不打颤。 他仅仅抓着一个卷轴，就仿佛它能从恶劣天气中保护他一样。 | 他的手臂上全是用疤痕写出经文，疯狂之典。 | 这个奇怪的人在泥土上写字就好像已经这样做过一千遍那样快。他写得话显而易见。 | 这个人站在那里，弯曲的胳膊中夹着一本书。他将书递给了你，表面的皮革感觉起来不是你触摸过的任何一种，打开之后里面只有段话，没完没了的重复。}它的内容是：“暗阴于人世救拯在所享分。端开是他，有所是他。候静此在达库尔的眠长，中耶莱拉间空世创在。”嗯…好古怪。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				5
			],
			Bravery = [
				15,
				10
			],
			Stamina = [
				3,
				3
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
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 50)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			tattoo_head.setBrush("tattoo_01_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_01_" + body.getBrush().Name);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/monk_robe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/cultist_leather_robe"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/cultist_hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/cultist_leather_hood"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

