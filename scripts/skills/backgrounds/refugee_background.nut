this.refugee_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.refugee";
		this.m.Name = "难民";
		this.m.Icon = "ui/backgrounds/background_38.png";
		this.m.BackgroundDescription = "难民缺乏为家园而战的信念，他们现在已经习惯了漫长而疲惫的旅行。";
		this.m.GoodEnding = "难民%name%展示出了自己是名天生的战士，然而他最终从%companyname%退休了。据说他回到了家乡，正在用他全部的克朗来帮助重建。";
		this.m.BadEnding = "由于%companyname%的衰落已经板上钉钉，难民%name%与战团分别。他用手头仅剩的克朗购买了一双鞋返回他被毁的家园并试图重建它。在走回家的路上，一个不识字的野人杀害了他并吃了那双鞋。";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.impatient",
			"trait.iron_jaw",
			"trait.athletic",
			"trait.tough",
			"trait.strong",
			"trait.loyal",
			"trait.cocky",
			"trait.fat",
			"trait.bright",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"难民",
			"幸存者",
			"长腿",
			"游民",
			"茧足"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
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
		return "{灾难很容易发生。 | 疾病是无形的终级命运之手。 | 无论战争输赢，一切都还是那样。}%name%来自一个小村庄，这村庄{的名字现在仅出现在口头交流，再过一代人就忘干净了。 | 简单来说已经被摧毁了。 | 现在不过是一个脚注，几乎不浪费历史学家的墨水。 | 遭受了这个世界的愤怒。}但是 %name%是一名幸存者。{他只带着身上的衣服逃离了灾难。 | 他的家着火了，他尽力挽救了能救到的东西然后逃走了。 | 在偶然撞上他死去的家人后，他收拾了能收拾的东西逃跑了。 | 战争、饥荒、疾病。现在对他来说已经模糊在了一起。}{%name%只是一个急于向前看而不是向后看的人。 | %name%唯一拥有的是他坚定的决心，但这是值得拥有的东西。 | 过往的经历让他伤痕累累，目光呆滞，但这个人很容易为了不再经历过去那些事情而被激励。 | 不管这个人的家乡发生了什么都没让这个人中招，从你听到的传闻来看，这可不简单。 | 这个人并不精通武艺，但他活下去的决心很强。 | 不论他曾经的职业为何，现在都已经不重要了。像许多其他人一样，他在这个日益血腥的世界里寻求佣兵工作。 | 他是你见过的众多难民中的一个，而这人已经决定停止逃跑并开始战斗。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-8,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				7,
				5
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
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
	}

});

