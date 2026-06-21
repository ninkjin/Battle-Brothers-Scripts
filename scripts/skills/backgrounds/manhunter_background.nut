this.manhunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.manhunter";
		this.m.Name = "搜捕者";
		this.m.Icon = "ui/backgrounds/background_62.png";
		this.m.BackgroundDescription = "搜捕者习惯在南方的恶劣环境中搜捕人类。";
		this.m.GoodEnding = "搜捕者%name%在你离开%companyname%后在战团呆了很长一段时间。你没听到多少这个人的消息，除了他在佣兵的世界中赚到了比追捕负债者多的多的钱。";
		this.m.BadEnding = "对于他在%companyname%战团的经历感到不满意，搜捕者%name%逃离战团回到了南方。很难说他最终的结局如何，但追捕人类的事业充满了无尽的危险。你唯一收到的他的消息是与他职业相关联的：大量负债者起义使得许多搜捕者被活埋或者喂给各种沙漠野兽。";
		this.m.HiringCost = 120;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.bleeder",
			"trait.bright",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.iron_lungs",
			"trait.tiny",
			"trait.optimist",
			"trait.dastard",
			"trait.asthmatic",
			"trait.craven",
			"trait.insecure",
			"trait.short_sighted"
		];
		this.m.Titles = [
			"搜捕者",
			"捕人者",
			"猎人",
			"无情",
			"赏金猎人",
			"禽兽",
			"残暴者",
			"无情者",
			"冷酷者",
			"追踪者",
			"捕手",
			"无心",
			"肥猪",
			"奴隶贩子"
		];
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
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
		return "{南方大量的奴隶、囚犯、罪犯和负债者仆人造就了一种经济模式，除了卖家、买家，因为商品善逃的特性，还由猎人组成。 | 南方城邦必须拥有巨大的劳动力储备来驱动他们的沙漠经济。虽然许多人生来就为维齐尔不倦地工作，但还有有些人必须被迫过上奴役的生活。 | 沙漠的自然资源如此稀少，往往是充足的被捕罪犯和负债灵魂供给才能刺激南方经济。而捕猎这些最终将会成为仆人的家伙们的事业非常繁荣。 | 南方维齐尔对叛乱如此恐惧，以至于整个搜捕者市场出现了，从而将叛乱抹杀在萌芽。}{%name%带着复仇的心态进入了搜捕者的事业：他的家人都在奴隶起义中被屠杀。 | %name%曾经是一名普通的商队护卫，但后来转而搜捕那些不停试图伏击他保护对象游牧民。在人口贸易中发现了更多的利润，从那以后他就一直干下去了。 | %name%是一个善于追踪罪犯、逃兵、战俘等等的搜捕者。你有时会好奇他是否对惊恐的冷汗有着灵敏的嗅觉。 | 曾经是大型猎物猎人，%name%逐渐开始喜欢追逐最大的猎物：人。他是一个追踪专家，有着能嗅出绝望的鼻子。}{对于%name%来说，选择为一个佣兵团工作只是工作更加稳定，不用空等那些对他手中的锁链感到不安的罪犯。 | %name% 是个粗野、阴暗的人，很可能他和他要追捕的人们一样轻浮。 | 像%name%这样的猎人拥有在佣兵团中能派上用场的特质和技能，但对某些人来说，他们的过去可能永远会遭到蔑视。并不是所有的搜捕者都被看好。 | 许多人不赞成出于需要劳动力去抓捕人类，同样也反对抓捕那些追求自由的人。 像%name%这样的搜捕者当然拥有有用的技能，但也可能会触怒一些人。 | 毫不奇怪，许多人认为像%name%这样的人是机会主义懒虫。如果他能呆在战团里，也许需要时间来改变一些人对他的过去的看法。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				2,
				3
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				2,
				2
			],
			RangedDefense = [
				-1,
				-1
			],
			Initiative = [
				3,
				5
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
			items.equip(this.new("scripts/items/weapons/battle_whip"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/nomad_robe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/thick_nomad_robe"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}

});

