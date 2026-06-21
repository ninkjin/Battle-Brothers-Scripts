this.ratcatcher_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ratcatcher";
		this.m.Name = "捕鼠人";
		this.m.Icon = "ui/backgrounds/background_41.png";
		this.m.BackgroundDescription = "捕鼠人需要快速反应才能捉住他们的猎物。";
		this.m.GoodEnding = "捕鼠人%name%来自于神秘的行业，亦归于神秘的行业。从%companyname%退休以后，他创办了一家捕鼠团队。他的生意非常好，直到有传言称他没有杀死抓到任何老鼠，而是把数千只老鼠藏在城镇外面的一个仓库里。据你最后听说，这个人对他数量庞大的新朋友感到非常满意。";
		this.m.BadEnding = "你曾觉得%name%不适合当佣兵，但是他证明了自己的能力。不幸的是，%companyname%分崩离析，他只能回去捉老鼠。你听说他的尸体在下水道被发现时正被一大群老鼠啃食。据说他的脸上带着一抹微笑。";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.clubfooted",
			"trait.brute",
			"trait.tough",
			"trait.strong",
			"trait.cocky",
			"trait.fat",
			"trait.hesitant",
			"trait.bright",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.sure_footing",
			"trait.clumsy",
			"trait.short_sighted"
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
		return "{老鼠捕手，这个头衔%name%曾经很喜欢。 | 也许是自尊心错位，%name%喜欢自称为阴沟人。 | 弯着双腿、骨瘦如柴，%name%的捕鼠生涯似乎把他变成了一只老鼠。} 他在%townname%长大，{在小巷里 | 靠老鼠这种下水道的果实 | 跟一些毛茸茸的动物还有老鼠一起}过活。{为了廉价的娱乐，他父亲教他如何诱捕小啮齿动物 | 他死去的兄弟的尸体被老鼠吃掉，塑造出对啮齿动物复仇的愤怒未来 | 他的母亲要求他尽他所能找到最好的肉，而她指的并不是从市场上购买}。 但是%townname%消磨着人们，它像一只巨大的啮齿动物一样消磨着%name%。{听说世界上有更大的老鼠 | 感觉到生活中一定有比老鼠更有意义的东西 | 相信他对老鼠低语的技巧}，%name%现在试图{把他干瘪的鼻子，奇怪的啃咬习惯，以及快速但有点恶心的手派上更好的用场。 | 压碎每只老鼠，看它们在他面前被驱赶，并听它们的亲族的惨叫。当他告诉你这些时，他瞪眼望着远方，握紧了拳头。 | 他说也许他的技能的对象能从老鼠升格到狗，或者是人类。他似乎不知道他要干的工作是什么，但也许最好不要告诉他。 | 烹饪些老鼠汤，老鼠沙拉，老鼠肉串，老鼠面包，老鼠炖肉，老鼠鸡，老鼠酒…过了一会儿，你就听不下去了。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
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
				18,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.RatcatcherTitles[this.Math.rand(0, this.Const.Strings.RatcatcherTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
	}

});

