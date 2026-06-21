this.servant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.servant";
		this.m.Name = "仆人";
		this.m.Icon = "ui/backgrounds/background_16.png";
		this.m.BackgroundDescription = "仆人不经常从事艰苦的体力劳动。";
		this.m.GoodEnding = "事实证明仆人%name%一直积攒着他在%companyname%赚来的每一枚克朗。当他积攒足够之后，他退休并买了一块土地，开始缓慢地攀登社会阶层。他最终在一张舒适的床上去世，身边是朋友、家人和忠诚的仆人。";
		this.m.BadEnding = "仆人%name%厌倦了佣兵的生活并离开了战团，他重新回去伺候贵族。当掠夺者攻击了他领主的城堡时，这个仆人在只有一把厨刀能用来自卫的情况下被推出了门外。他无头的尸体在一堆破碎的椅子中被发现，几个死去的掠夺者散布在他的周围。";
		this.m.HiringCost = 45;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.impatient",
			"trait.iron_jaw",
			"trait.brute",
			"trait.athletic",
			"trait.strong",
			"trait.disloyal",
			"trait.fat",
			"trait.brave",
			"trait.fearless",
			"trait.optimist",
			"trait.cocky",
			"trait.bright",
			"trait.determined",
			"trait.greedy",
			"trait.sure_footing",
			"trait.bloodthirsty"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
	}

	function onBuildDescription()
	{
		return "{生活很艰难，而对某些人来说尤其如此。 | 有些人还可以丧权失地，而其他人根本没得丧失，一出生就在最底层。 | 如果人生就像掷骰子，也许有些人比起当人还不如去当老鼠。}%name%{是一个颓废领主的仆人。 | 为一个孩子们玩火自焚的嗜虐家庭服务。 | 被强盗绑架，被迫满足他们每一个，新的，需求。 | 狂热地为那些盯着星星看得太久的疯子工作。}他很少因为他自己在这个世界上的地位犯错误。然而有一天，他的主人们{把他打到晕厥。当他醒来时，他躺在一位仁慈医生的床上，医生拒绝把他交给他的'雇主'。相反，%name%被告知可以自由离开，而他的主人们则被告知他已经死了。 | 无条件的释放了他。没有在仪式上磨蹭，%name%热情地离开了。 | 邀请他参加一个聚会。他以为自己是客人，就穿上了他最好的衣服，也就是一件袖子卷边的衬衫和一套蓬松的长裤，能很好隐藏他嶙峋的骨架。不幸的是，他不过是派对上的一场秀，他们给了他一个木盾和一把剑，把他和一头野猪一起扔进竞技场，一边观看这可怕的场面一边下注。他差点没逃过这场'庆典'。}{%name%从此发誓不再为某人'服务'。 | 这个人，尽管现在从他的差事中解脱了，依然承担着他过去漫长艰难的生活带来的羞辱和痛苦。}";
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
				2,
				0
			],
			Initiative = [
				5,
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
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
	}

});

