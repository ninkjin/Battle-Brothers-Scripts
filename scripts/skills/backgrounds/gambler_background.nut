this.gambler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.gambler";
		this.m.Name = "赌徒";
		this.m.Icon = "ui/backgrounds/background_20.png";
		this.m.BackgroundDescription = "赌徒往往比牌桌上的对手反应更迅速，决心更高。";
		this.m.GoodEnding = "也许把像%name%这样的赌徒纳入你的队伍是有风险的。现在过去这么久之后，很明显你的决定没有错。据你最后听说，他仍在与战团同行并且利用他的收入来满足自己的嗜好。据传言说他累计赢取的赌资已经让他悄悄成为了全天下最富有的人之一。虽然你认为这是在胡说八道，但很多市长突然变得对赌博放松了许多...";
		this.m.BadEnding = "赌徒%name%从不断衰落的战团退休并重返了了赌博的生活方式。他很快欠下了他无法偿还的债务。你看到他在街角乞讨，少了一只手并且掉了一些牙。你往他的锡罐里扔了几个克朗并对他说了几句话，但他没有认出你。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.paranoid",
			"trait.brute",
			"trait.athletic",
			"trait.dumb",
			"trait.clumsy",
			"trait.loyal",
			"trait.craven",
			"trait.dastard",
			"trait.deathwish",
			"trait.short_sighted",
			"trait.spartan",
			"trait.insecure",
			"trait.hesitant",
			"trait.strong",
			"trait.tough",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"二点牌",
			"万能牌",
			"造运者",
			"幸运儿",
			"控牌者",
			"赌徒"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Thick;
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
		return "{他们说运气就像恶魔，那么像%name%这样的赌徒能赌运多久呢？ | 每个人都会赌博，所以%name%觉得干嘛不为钱赌呢？ | 骰子，牌，弹珠——有很多赚取别人钱的方法，而%name%全都精通。 | %name%有着沙漠蛇一样的眼睛，操纵牌就像他的嘶鸣。 | 在生死存亡的世界里，冒险就是%name%的游戏。 | 类似%name%这样的人能预见将发生的事，尤其是牌堆下一张牌。}{他以在镇子之间玩牌为生，只有在清空了当地人口袋后才会离开。 | 但一个人为何决定以赌博为生则是个谜。 | 来来往往的雇佣兵是很容易的目标，直到一个生气的输家用双手剑逼得他不得不逃跑。 | 出生即孤儿，他全靠跟别人赌博来混日长大。 | 当他还是孩子的时候，一个把戏家的杯子游戏向他展示了出千设局的价值。 | 当他的父亲陷入赌债时，他认为还债并报复的最佳方式是自己成为更强的出千者。 | 在钱都被他弄走后，各地的城镇以'宗教复兴'为名禁止%name%继续耍诈。}{现在，赌徒试图进行一场不成功便成仁的狂赌，加入了一支付报酬的队伍。 | 令人好奇的是这个赌徒不去玩牌到底是想如何。话说回来，他认为押注在你的团队上是妙招似乎很不错。 | 或许多年欺骗佣兵使得他认为自己可以轻易的成为其中一员。 | 聪明机智的做牌者靠着在别人动手前行动生存，这在这个世界中是一项非常有用的技能。 | 讽刺的是，一次糟糕的下注让他欠下一位男爵巨额债务。现在他必须找到另一种赚钱的方法来偿还。 | 战争已经使他的赌博游戏中大部分油水流失，比起啥都不干他觉得还不如参战。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-2,
				-2
			],
			Bravery = [
				12,
				12
			],
			Stamina = [
				-6,
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
				2
			],
			RangedDefense = [
				2,
				8
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
			items.equip(this.new("scripts/items/armor/noble_tunic"));
		}
		else
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
	}

});

