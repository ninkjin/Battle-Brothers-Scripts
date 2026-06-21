this.gravedigger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.gravedigger";
		this.m.Name = "掘墓人";
		this.m.Icon = "ui/backgrounds/background_28.png";
		this.m.BackgroundDescription = "掘墓人习惯于体力劳动和处理尸体。";
		this.m.GoodEnding = "由于%companyname%的巨大成功，掘墓人%name%得以不停的练习他的活计。随着克朗的不断积累，他最终离开了战团并回到了墓地。据你所知，他已经从挖洞的活计退休了，并正在抚养起一个教堂司事之家。";
		this.m.BadEnding = "你听到的消息是，掘墓人%name%是最后离开%companyname%的人之一。由于身无分文，他沉迷于酗酒，最后你听说他的尸体在一个泥泞的沟渠里被发现了。";
		this.m.HiringCost = 50;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.night_blind",
			"trait.swift",
			"trait.cocky",
			"trait.craven",
			"trait.fainthearted",
			"trait.dexterous",
			"trait.quick",
			"trait.iron_lungs",
			"trait.optimist"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
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
		return "{掘墓人%name%的生涯是从埋葬还是婴儿的弟弟开始的。 | 把一把剑插进他醉酒父亲的脖子里，%name%开始掘墓是因为一件很糟糕的事。他先是埋葬了他的罪行，然后又埋葬了前来问话的执法者。 | 在疾病席卷%townname%之后，%name%是最后一个活下来的人。他不得不放弃自己的活计，去干唯一剩下的事情：掘墓。} 他们说，死人会有一种特殊的神情。但在那些见过死人的人也有一种特殊的神情。%name%现在花了半辈子的时间{盯着尸体 | 把尸体埋入地下 | 挖大大小小的坟墓}。对掘墓人来说，{死亡现在不过是一门科学 | 死人比活人是更好的伴侣 | 靠埋葬死者赚钱毫不新奇}。{受雇于货车商队，%name%走遍了这片土地，也把它挖了个遍。但是有一天他的掘墓事业突然中断。不是因为秃鹰或老鼠，而是因为死人本身。看到这样的景象，再加上不得不埋葬同一个人两次，无疑迫使他迅速改变了职业。 | 每一个掘墓人都饱受他人怀疑。没多久他的主顾们就成了原告，指控他犯下热心于亡灵的可怕罪行，并迫使他放弃工作。这些指控很荒谬，但你从他苍白的脸上看不出表情，就像跟月亮打牌那样。 | 现在看来，这个人看起来好像需要换个工作环境。只是别让他去埋葬伤亡者。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				4
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				5,
				7
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
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

