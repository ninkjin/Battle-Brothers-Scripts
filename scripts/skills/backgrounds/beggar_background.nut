this.beggar_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.beggar";
		this.m.Name = "乞丐";
		this.m.Icon = "ui/backgrounds/background_18.png";
		this.m.BackgroundDescription = "乞丐并非意志坚定的人，并且流落街头损害了他们的健康。";
		this.m.GoodEnding = "在厌倦了一切战斗之后，曾经的乞丐%name%从%companyname%退休了。你清楚这个人在跟着佣兵团这段时间赚取了可观的收入，但某一天你又看到他在乞讨。你问他是否把钱全浪费光了，他大笑了起来说他买了土地并且过得很好。然后他伸出了他的小锡罐，请求你给一枚克朗。你给了他俩。";
		this.m.BadEnding = "战斗生活充满艰辛，曾经的乞丐%name%觉得比起哪天战死不如退休。不幸的是，他又跑回去乞讨了。传言说一位贵族清理了城中的底层流氓，并且在大冬天依旧让他们向北方前进。又冷又饿的%name%最终死在了路边，一个锡罐牢牢的冻在他的手指上。";
		this.m.HiringCost = 30;
		this.m.DailyCost = 3;
		this.m.Excluded = [
			"trait.iron_jaw",
			"trait.tough",
			"trait.strong",
			"trait.cocky",
			"trait.fat",
			"trait.bright",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.athletic"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"脏屁虫",
			"穷光蛋",
			"穿破布",
			"病秧子",
			"骗子",
			"无职",
			"懒蛋",
			"废物",
			"乞丐",
			"黄鼠狼",
			"臭鼬",
			"懒汉",
			"流浪者"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
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
		return "{在一场大火中失去一切后 | 在他的赌瘾彻底没治了之后 | 被诬陷了他不曾犯下的罪名，并不得不向治安官交出全部财产避免牢狱之灾 | 作为一个村庄被烧成平地的难民 | 和他的兄弟发生暴力冲突后被从家中放逐 | 作为一个没有天赋也没有野心的人 | 被关在领主地牢中数不尽的岁月后终于得到释放 | 在把他所有物质财产都给了一个不知名的邪教以图拯救他永恒的灵魂之后 | 曾经是一个聪明人，但之后被强盗打昏了头}，{%name%发现自己呆在街头， | %name%被迫走上街头，}{不得不乞讨面包 | 完全依赖别人的善意 | 经常被揍并开始听天由命 | 只要有钱就买醉度日 | 到处翻其他人的垃圾并躲治安官 | 一边躲避暴徒一边乞讨克朗}。{虽然他看起来很想成为一名佣兵，但街头度日毫无疑问剥夺了%name%最好的年华。 | 这么多年过去，到今天他的健康已经受损。 | 像%name%这样的人一旦街头呆上几天，更不用说是几年，像佣兵这样非常危险的工作也会变成最棒的差事。 | 只有神知道%name%为了生存都经历了什么，但现在站在你面前的只是一个瘦弱的人。 | 他一看到你就准备张开双臂拥抱，声称多年前就认识你并一同进行了许多冒险，尽管他这会儿还想不起你的名字。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-10
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				-10,
				-10
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
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			local item = this.new("scripts/items/helmets/hood");
			item.setVariant(38);
			items.equip(item);
		}
	}

});

