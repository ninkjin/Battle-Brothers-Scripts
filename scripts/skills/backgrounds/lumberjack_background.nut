this.lumberjack_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.lumberjack";
		this.m.Name = "伐木工";
		this.m.Icon = "ui/backgrounds/background_04.png";
		this.m.BackgroundDescription = "伐木工习惯于体力劳动，还有斧子。";
		this.m.GoodEnding = "强壮的伐木工%name%最终离开战团回到了森林。他开办了一项伐木业务并全年每天运营。幸运的是，时机对他有利：贵族们最近非常青睐小木屋，并向任何能够建造它们的人大量支付克朗。";
		this.m.BadEnding = "伐木工%name%受够了佣兵的生活并重返了伐木工作。据你最后听说，他在一次放倒树木的事故中受伤，骨头被砸的粉碎，身子已经能像抹布一样卷起来了。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.ailing",
			"trait.clubfooted",
			"trait.asthmatic",
			"trait.clumsy",
			"trait.fat",
			"trait.craven",
			"trait.fainthearted",
			"trait.bright",
			"trait.bleeder",
			"trait.fragile",
			"trait.tiny"
		];
		this.m.Titles = [
			"壮汉",
			"斧子",
			"巡林者"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
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
		return "作为一名伐木工，%fullname%{大部分时间都在树林里砍树 | 靠伐木砍柴赚取他的克朗 | 肩上总是背着斧头或木头 | 是一个安静的人，比起跟人在一起，他更喜欢森林的气氛。 | 因为他的健美的身材和强壮的双手总是被许多年轻女子盯着看 | 总是做他是骑士的白日梦，挥舞斧头不是对着树木而是对着兽人和巨魔}。{作为一个高大壮实的男人，外出工作很容易就找上了他 | 他喜欢他的斧子收藏，每一把斧子都以他曾认识的女人的名字命名 | 他每天的工作都很辛苦，但这是一项诚实的工作 | 独自一人在树林里时他会和树木交谈，让它们告诉他哪一颗能给出最棒的木材 | 很少有人能像他那样挥舞斧头，或让一棵树如他所希望的那样倒下 | 凭借他高大壮实的体格，他可以背着重量能压垮别人的东西}。{像大多数人一样，他继承了他父亲的职业。然而这些年来，他突然意识到比起每天看同一片树林他更想看看世界各处。经过长时间的深思熟虑后，他下定决心 | 当他心爱的妻子在分娩时死去时，他的生活崩溃了。随着一切都被夺走，他变得越来越离群索居，甚至连树林都不能再给他带来安宁。只是想离开这一切，他决定 | 有一天从树林里回来，他看到远处有烟。他的村庄正在燃烧，人们被屠杀或掳走。他的家被毁了。他满怀怒气出发并决定 | 随着时间的推移，森林里开始出现奇怪的生物。村民一个接一个的失踪，有些人搬走了。在一个漫长的不眠之夜后，他决定是时候他也离开了。由于没有什么生活来源，他不顾一切地 | 让村民们都很奇怪的是，随着时间推移%name%逐渐对森林失去了兴趣，越来越频繁地提到要离开。某个命运之日，他们看到他自告奋勇去 | 在某个命运之日，他砍倒的树砸死了一只鹿。因为不想浪费，%name%把它带回家，结果发现自己被指控偷猎。在宣判前，他匆忙决定离开村子并试图}加入一个旅行中的佣兵战团。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				10
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				5,
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
				-5,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(6);
			items.equip(item);
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

