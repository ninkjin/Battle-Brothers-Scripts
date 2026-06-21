this.messenger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.messenger";
		this.m.Name = "信使";
		this.m.Icon = "ui/backgrounds/background_46.png";
		this.m.BackgroundDescription = "信使习惯长途奔波。";
		this.m.GoodEnding = "在战团中接纳信使%name%乍看有点奇怪，这在他展露出佣兵的杀手本色后很快就被打消了。据你所知，他依旧留在战团中，比起作为信使行路更喜欢作为雇佣兵进军。你无法责怪他：一个信使必须向他遇到的每一个贵族弯下膝盖，但是跟一群雇佣兵在一起毫无疑问他时不时会有机会宰掉一两个这样的混蛋。这是一个不难接受的权衡！";
		this.m.BadEnding = "信使%name%离开了%companyname%并重新成为了信使，在领主之间传递信件。你曾尝试寻找他的去处，并且最终找到了他，或者说是他留下的残骸。不幸的是，'不要射杀信使'这句古话在在这片四分五裂的土地上并不怎么被遵循。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.clubfooted",
			"trait.asthmatic",
			"trait.cocky",
			"trait.craven",
			"trait.deathwish",
			"trait.dumb",
			"trait.fat",
			"trait.gluttonous",
			"trait.brute"
		];
		this.m.Titles = [
			"信使",
			"邮差",
			"奔跑者"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
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
		return "{有些人如此重要了以至于需要其他人来传递他们的话语。%name%就是这样一个人，说的是后者。 | %name%的肩膀上压着那么多包邮件，收件人等信送到基本必然已经死了。 | 为了逃离仆役的生活，%name%选择信使这一职业。 | 由于有那么多的人急于了解他们亲戚的情况，%name%发现当信使有足够多的工作。 | %name%曾经作为一个小信使走遍了这片土地。 | 就像他父亲和爷爷一样，%name%为贵族和执法者这类人传递信息。 | 在捡起一个已死信使的包后，%name%很快发现自己成了将来的信使。 | 作为一名前难民，%name%觉得既然他已经在四处游荡，那还不如去送信。}{但是来回往返开始变得无聊。这个信使开始寻求一个新的工作领域。 | 带着一大堆情书，这位将来的冒险者满脑子都在疑惑自己到底是在干啥。 | 自称是一个初出茅庐的英雄，%name%现在认为送信的工作配不上他了。 | 晴天雨天没问题，雨雪交加也没问题，但全面战争？改天吧。 | 但在打开了一封可能会毁掉一个好心贵族的信件后，信使决定离开他的岗位。 | 在劫匪把他的生活搞得一团糟后，%name%觉得他最好还是和武装团队一起旅行。 | 在信使和一位市长的妻子上床后，就有支小型军队在屁股后面追他。他觉得为了自保他最好溜进另一支武装队伍里。}{%name%花费多年来记忆信息。现在他必须记住在箭雨落下时保持盾墙。 | 讽刺的是，%name%一生中从未写过任何东西。 | 卷起袖子，%name%自夸说他还有最后一条信息留给世界。大家都看好了。 | 也许他加入佣兵的行为表明，笔实际上并不比剑更强大。 | %name%有将任何对他说的话进行重复的倾向，信使的旧习难改。 | 讽刺的是，这位四处奔波的信使在路上看到的恐怖事物可能比队伍里的大部分人都多。 | 就算有，%name%的战斗技能也还差得远。但他确实有两条坚实的腿，只是希望别用来逃跑。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				5,
				0
			],
			Stamina = [
				15,
				10
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
				2
			],
			RangedDefense = [
				3,
				3
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
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
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

