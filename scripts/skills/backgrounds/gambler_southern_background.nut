this.gambler_southern_background <- this.inherit("scripts/skills/backgrounds/gambler_background", {
	m = {},
	function create()
	{
		this.gambler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 90;
		this.m.Excluded = [
			"trait.superstitious",
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
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{他们说运气就像恶魔，那么像%name%这样的赌徒能赌运多久呢？ | 每个人都会赌博，所以%name%觉得干嘛不为钱赌呢？ | 骰子，牌，弹珠——有很多赚取别人钱的方法，而%name%全都精通。 | %name%有着沙漠蛇一样的眼睛，操纵牌就像他的嘶鸣。 | 在生死存亡的世界里，冒险就是%name%的游戏。 | 类似%name%这样的人能预见将发生的事，尤其是牌堆下一张牌。}{他以在镇子之间玩牌为生，只有在清空了当地人口袋后才会离开。 | 但一个人为何决定以赌博为生则是个谜。 | 来来往往的雇佣兵是很容易的目标，直到一个生气的输家用双手剑逼得他不得不逃跑。 | 出生即孤儿，他全靠跟别人赌博来混日长大。 | 当他还是孩子的时候，一个把戏家的杯子游戏向他展示了出千设局的价值。 | 当他的父亲陷入赌债时，他认为还债并报复的最佳方式是自己成为更强的出千者。 | 在钱都被他弄走后，各地的城镇以'宗教复兴'为名禁止%name%继续耍诈。}{现在，赌徒试图进行一场不成功便成仁的狂赌，加入了一支付报酬的队伍。 | 令人好奇的是这个赌徒不去玩牌到底是想如何。话说回来，他认为押注在你的团队上是妙招似乎很不错。 | 或许多年欺骗佣兵使得他认为自己可以轻易的成为其中一员。 | 聪明机智的做牌者靠着在别人动手前行动生存，这在这个世界中是一项非常有用的技能。 | 讽刺的是，一次糟糕的下注让他欠下一位男爵巨额债务。现在他必须找到另一种赚钱的方法来偿还。 | 战争已经使他的赌博游戏中大部分油水流失，比起啥都不干他觉得还不如参战。}";
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
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}
	}

});

