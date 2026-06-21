this.daytaler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.daytaler";
		this.m.Name = "临时工";
		this.m.Icon = "ui/backgrounds/background_36.png";
		this.m.BackgroundDescription = "临时工习惯于各种体力劳动，但是不精通任何一项。";
		this.m.GoodEnding = "临时工%name%退休不再战斗了，但他还是继续在用双手工作。现在他回去垒砖或者搬运干草，而不是杀野兽或砸脑袋。他花了所有当佣兵赚的钱买了一小块地定居下来。虽然不是最富有的人，但传言说他是全天下最幸福的人。";
		this.m.BadEnding = "%name%选择在他手指脚趾大部分完好时退休。他回去以后为贵族工作。你上次听到他在{南部 | 北部 | 东部 | 西部}为某个贵族修建一座大塔。不幸的是，你也听说在建造过程中这座塔倒塌了，许多工人也随一起摔下。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
	}

	function onBuildDescription()
	{
		return "{这干一下那干一下 | 没有稳定的工作 | 断断续续地工作 | 做做这做做那 | 没有学过手艺}，%name%被称之为临时工，不管哪缺人手都能找他。 {工作稀缺已经有段时间了，所以 | 在过去的几周里几乎没有什么工作可做，所以 | %name%想做他以前没做过的事，所以 | 尽管他没有战斗经验，但盯着酒瓶子看得太深让他相信 | %name%觉得战斗职业不会缺工作，所以 | 就跟许多人的遭遇一样，%name%的爱人因病逝去使他最终崩溃了。在连续几周买醉消愁之后，} 一个四处旅行的佣兵团似乎是个好机会来{跟着混一段时间 | 赚点小钱 | 稍稍看看世界 | 让他清醒一下脑袋 | 带他去下一个村子并顺路把口袋塞满}。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				3
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
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
	}

});

