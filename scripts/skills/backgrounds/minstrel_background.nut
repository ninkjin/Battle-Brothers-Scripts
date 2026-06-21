this.minstrel_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.minstrel";
		this.m.Name = "吟游诗人";
		this.m.Icon = "ui/backgrounds/background_42.png";
		this.m.BackgroundDescription = "一个好的吟游诗人会传唱传奇故事来激励人们，吹笛使人们平静下来，或者在篝火旁用诗歌来娱乐人们。 然而，鲁特琴不是武器，吟游诗人也通常不习惯于体力劳动或流血杀戮。";
		this.m.GoodEnding = "啊，%name%。他是%companyname%的重要补充！这位吟游诗人不仅成为了杰出的战士，而且在最艰难的时刻中对维持士气高昂起着关键作用。因为内心本质上还是诗人和演员，他最终从战团退役并成立了一家剧院团队。他目前不仅为贵族也为普通人表演戏剧。这位吟游诗人还没有意识到，他的幽默机智和尖锐评论正在慢慢地将不同阶层的人们联系在一起。";
		this.m.BadEnding = "从未真正想成为战士，%name%很快就离开了日渐衰落的%companyname%。他和一群音乐家还有小丑在夜晚为喝醉了的贵族表演。你设法亲眼看到了其中一场表演。%name%大部分时间都被喝醉的人嘲讽，还被扔吃了一半的鸡骨头。其中一个贵族甚至认为放一只狗去追一个小丑会很有趣。你可以在吟游诗人的眼中看到他的梦想正在死去，但是表演还在继续。";
		this.m.HiringCost = 65;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.iron_jaw",
			"trait.athletic",
			"trait.craven",
			"trait.dumb",
			"trait.strong",
			"trait.tough",
			"trait.dumb",
			"trait.brute",
			"trait.clubfooted",
			"trait.dastard",
			"trait.insecure",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"吟游诗人",
			"韵律诗人",
			"诗人",
			"百灵鸟",
			"游唱诗人",
			"合唱歌手",
			"情人",
			"说唱者"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
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
		return "“{我可以挥剑劈斧， | 有人可能会要求我一个任务， | 上帝在上，而酒瓶在手，}{要我说，'你质疑一个没有戴面具的人？'。 | 我必须快点行动，但也不是那么快。}{盯着我缝制的玩具熊， | 穿上我的破裤子， | 沿着泥泞的道路，我的靴子打着滑，}{那么多东西我都摆脱了。 | 真相！我可耻的天赋被!凶猛的!编织。}{所以带我一起去冒险吧， | 带上我和你那些乱嚷嚷的人一起， | 把你的盾牌递给我，还有那个像我小弟的玩意儿，}{让我们走吧，向恐惧大道一别！ | 让我们－哦，噢！我被扎了一根刺！ | 愿我们，所有人，来年冬天都健康！}”。{这人在胡言乱语。 | 它很押韵！}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-3
			],
			Bravery = [
				5,
				10
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
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local armor = this.new("scripts/items/armor/linen_tunic");
		armor.setVariant(this.Math.rand(3, 4));
		items.equip(armor);
		local r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			items.equip(this.new("scripts/items/weapons/lute"));
		}
	}

});

