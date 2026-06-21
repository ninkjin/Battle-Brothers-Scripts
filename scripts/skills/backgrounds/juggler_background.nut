this.juggler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.juggler";
		this.m.Name = "杂耍者";
		this.m.Icon = "ui/backgrounds/background_14.png";
		this.m.BackgroundDescription = "杂耍者是需要有良好的反应和手眼协调的职业。";
		this.m.GoodEnding = "杂耍者%name%将所有当佣兵赚的钱都拿去启动了一家巡回表演团。你最后听到的消息是，他建立了一整座剧院并且每月上演一部新剧！";
		this.m.BadEnding = "杂耍者%name%从战斗退休。他在为{南边 | 北边 | 东边 | 西边}一个花哨的贵族表演时，某个节目出了严重的岔子。有传言称他因这个错误被从塔上扔下去，但你不想相信这个传言。";
		this.m.HiringCost = 75;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.clubfooted",
			"trait.brute",
			"trait.clumsy",
			"trait.tough",
			"trait.strong",
			"trait.short_sighted",
			"trait.dumb",
			"trait.hesitant",
			"trait.deathwish",
			"trait.insecure",
			"trait.asthmatic",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"杂耍者",
			"小丑",
			"蠢蛋"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
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
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "更高几率击中头部"
			}
		];
	}

	function onBuildDescription()
	{
		return "{在他继兄的教导下，%name%开始像水手摆弄桨一样杂耍。 | 虽然受到同龄人的嘲笑，%name%一直很喜欢杂耍。 | 在一家小丑剧团拜访后，%name%被一个特别有趣的人迷住了，并最终在这个人教导下成为了一个杂耍者。 | 作为当地一名领主的儿子，%name%对杂耍及娱乐可耻的痴迷使他被逐出了家族。 | %name%杂耍不仅仅是为了利益，更是为了赢得观众的欢笑和掌声。}{不幸的是，当战争肆虐这片土地时，没有多少人可以娱乐。 | 但是在这个充满不幸和苦难的土地上，人群和克朗都是稀少的。 | 但一场涉及飞斧和贵族婴儿的杂耍事故让这位艺人不得不逃命。 | 他非常擅长旋转翻转剑和匕首，没过多久他就被指控进行巫术，并被禁止他所热爱的活动。 | 可悲的是，%name%的杂耍技巧在他的小丑同伴中引起了很大的嫉妒。他们密谋对付他，以及他的手腕。 | 当一个刺客杀死了他招待的领主时，杂耍者是第一个被指控的人。他差点没逃过一劫。}{现在，%name% 寻求一条新的道路，即使死亡本身也已成为他的观众。 | 现在，%name%在和他同样倒霉的人的陪伴下找到了解脱。 | 鉴于他眼疾手快，%name%击中目标应该没有问题。 | 可以闭着眼睛杂耍玩刀，%name%知道该把每把刀扔到哪里。 | 杀戮比耍杂能赚更多的金币，%name%已经接受了这个可悲的事实。}";
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
				3,
				3
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
				12,
				10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/jesters_hat"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
	}

});

