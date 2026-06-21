this.anatomist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.anatomist";
		this.m.Name = "解剖学家";
		this.m.Icon = "ui/backgrounds/background_70.png";
		this.m.BackgroundDescription = "介于科学家和外科医生之间，解刨学家并不习惯于战斗，但他们稳定的双手很有帮助。";
		this.m.GoodEnding = "在%companyname%里你所认识的所有人中，解剖学家%name%可能是最令人难忘的一个。不停的来信更加确保你不可能忘记他。你浏览着他最新的单方面通信：“团长！我已经成功地……”跳过，跳过，“……最伟大的发明！最……”跳过，跳过，“我将会出名！我的大脑会被研究重量……”似乎一如既往，但你还是很高兴看到他很健康，如果精神上不是至少身体上是。";
		this.m.BadEnding = "在逃离%companyname%之后，解剖学家%name%换了别处继续进行他的研究。他因以粗鄙的方式在外冒险被同行告诫，并发现自己饱受智力平庸之苦。几年后，他对甲壳虫的研究做出了微小的贡献，然后毅然从海边悬崖跳下，把大脑捐献给了石头，身体则赠予了海洋。";
		this.m.HiringCost = 130;
		this.m.DailyCost = 12;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.craven",
			"trait.huge",
			"trait.determined",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.fear_greenskins",
			"trait.hate_greenskins",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.teamplayer",
			"trait.impatient",
			"trait.clumsy",
			"trait.iron_jaw",
			"trait.dumb",
			"trait.athletic",
			"trait.brute",
			"trait.fragile",
			"trait.iron_lungs",
			"trait.irrational",
			"trait.cocky",
			"trait.strong",
			"trait.tough",
			"trait.superstitious"
		];
		this.m.Titles = [
			"秃鹫",
			"乌鸦",
			"办案人",
			"送葬者",
			"送葬人",
			"阴风",
			"解剖学家",
			"好奇者",
			"失足者"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
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
		return "{%name%是一位聪明的男子，只是因不停进行恶性试验而面色憔悴。你希望他的方法最好能用在他的敌人而不是他自己身上。 | 传言说%name%曾试图搞明白如何飞行，这里不是在说什么机器，而是怎样长出翅膀。他究竟如何去做到这一点，亦或他的实验结果如何，均不得而知。然而他现在就在这，老实精明的站在地面上并环顾着四周。 | 像许多解剖学家一样，%name%独自开始了闯荡世界。当然，也就像许多人一样，他很快被那些完全不懂科学价值的人的饥渴给消磨殆尽了。目前他将和雇佣兵并肩作战，只希望能争取些时间来开展他的研究。 | %name%对这个世界有点愤世妒俗，因为他的一些同行们能坐享完整的教育，而他必须赚钱来支撑自己的学习。希望他的愤怒能在战场上展现出来。 | 一般认为像%name%这样的人会在战斗之后出现，而不是实际参与其中。像这样一个聪明但有点古怪的人还需要依靠当佣兵的薪水，让你不禁怀疑自己在这个世界上的前景是否要比想象中的还要糟糕。 | %name%的智力无可否认，他是一个聪明绝顶的家伙，具体点是会让你搞不懂神为啥不嫌麻烦的给你安了注水大脑那种。但作为雇佣兵，他只是普通的战士而已。希望他的武艺和他的才智一样出众。 | 你永远无法确定是时事不顺迫使%name%成为雇佣兵，还是他只是在通过另一种远为残酷的方式进行科学探究。他耗费许多晚上解剖被马车压死的狗和没有翅膀的蝴蝶，使你对这个充满好奇的伙计产生了很多思考。 | 把%name%带进了佣兵队伍的不是金钱，而是好奇心。他对于这个世界上都有什么生物以及他们内部长什么样都有着浓厚的兴趣。只要他能让前面提到的内部暴露出来，你也不在乎他还会对这些东西做些什么。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-4,
				-4
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				0,
				-5
			],
			MeleeSkill = [
				7,
				7
			],
			RangedSkill = [
				9,
				9
			],
			MeleeDefense = [
				1,
				0
			],
			RangedDefense = [
				1,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		r = this.Math.rand(0, 5);

		if (r < 3)
		{
			items.equip(this.new("scripts/items/armor/undertaker_apron"));
		}
		else if (r < 5)
		{
			items.equip(this.new("scripts/items/armor/wanderers_coat"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/armor/reinforced_leather_tunic"));
		}

		r = this.Math.rand(0, 5);

		if (r < 3)
		{
			items.equip(this.new("scripts/items/helmets/undertaker_hat"));
		}
		else if (r < 5)
		{
			items.equip(this.new("scripts/items/helmets/physician_mask"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/masked_kettle_helmet"));
		}
	}

});

