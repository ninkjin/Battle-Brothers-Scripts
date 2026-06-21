this.vagabond_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.vagabond";
		this.m.Name = "流浪汉";
		this.m.Icon = "ui/backgrounds/background_32.png";
		this.m.BackgroundDescription = "流浪汉习惯于长途旅行，但不擅长任何特别的事情。";
		this.m.GoodEnding = "有些人注定要漂泊。虽然他在%companyname%的时光很愉快，流浪汉%name%最终还是离开了战团，重新踏上了漫漫旅途。你不知道他去了哪里，你只知道他对旅行充满了兴趣。";
		this.m.BadEnding = "随着战团解散，像流浪者%name%这样的人选择离开并返回旅途并不奇怪。不幸的是，由于这个世界处于如此糟糕的状态，他很快就遇到了麻烦。他的尸体被发现悬挂在一个小农村外面。胸前钉着一块牌子，上面写着：'不欢迎居无定所者'。";
		this.m.HiringCost = 70;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.clubfooted",
			"trait.fat",
			"trait.loyal",
			"trait.gluttonous",
			"trait.asthmatic"
		];
		this.m.Titles = [
			"流浪汉",
			"游荡者",
			"三足",
			"挑袋",
			"破衣",
			"流浪者",
			"无休者",
			"旅行者",
			"乌鸦"
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
		return "{因战争被赶出他的小镇后，%name%以流浪汉的身份在世界各地游荡。 | 懒惰且没有动力，有一天%name%把自己所有的三个东西打了包就上了路。 | 在学校里学习不是很好，%name%辍学在各地游荡。 | %name%没有商业头脑来保护自己继承的遗产不受债务人、律师和其他不法分子的侵害。现在他一边四处游荡，口袋里仅剩的克朗一边叮当作响。 | 在路上的生活使%name%什么都懂一点，又什么都不精通，当然走路除外。 | 既不太适合城市，也不太适合野外，%name%在这两者之间漫无目的地旅行。 | 在他酗酒的日子里，%name%成功地赌输了一大笔钱。现在无家可归，而他仅仅四处流浪。 | 当他的妻子在他不在时被谋杀后，%name%拒绝回房子里睡觉。这个人大地上行走，试图忘却记忆。 | 由于他的儿子谋杀五个人，羞愧难当的%name%背井离乡四处游走，来忘记他是一个失败父亲。}{但是当一伙盗贼夺走了他所有的东西，甚至包括他的鞋子之后，他明白他需要再改变一次。 | 但当他来到一个岔路口时，这个人意识到他已经有一段时间没吃东西了。他的胃要求改变一下风景，以及饮食。 | 可悲的是，对于那些没有人会思念的人来说，这个世界不是一个令人愉快的地方。他每天都会受到骚扰和欺凌。 | 在泥泞中艰难跋涉了一天之后，他意识到四处走动是没有生活可言的。 | 奇怪的是，有一天他遇到了他从来没有过的被遗忘已久的兄弟，他说佣兵队伍会走许多路，而且还会付工资让你走！ | 像任何一个冲动的人一样，他掷硬币来决定是否要尝试佣兵工作。}{他没有什么特别擅长的，但是%name%已经见识和经历了很多事情，这至少有点价值。 | 在这片充满暴力的土地上混日子，不仅活下来了还四肢健全，这比大部分人厉害多了。 | 对于%name%这样的流浪汉来说，加入佣兵团不过是又一次冒险。希望他能活下来书写这些。 | 他旅行时唯一的武器就是拐杖，让我们看看他用锋利点的东西怎么样。 | 盗贼，恶棍，面包师，裁缝，%name%都当过，可惜他所有这些他都不擅长，也许这次会有所不同。 | 多年来，世界对%name%一直很苛刻。这不会改变，但至少他现在将和兄弟们在一起。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-3,
				0
			],
			Bravery = [
				-5,
				-7
			],
			Stamina = [
				10,
				15
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});

