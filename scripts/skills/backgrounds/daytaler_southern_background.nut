this.daytaler_southern_background <- this.inherit("scripts/skills/backgrounds/daytaler_background", {
	m = {},
	function create()
	{
		this.daytaler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 90;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.fear_undead",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{这干一下那干一下 | 没有稳定的工作 | 断断续续地工作 | 做做这做做那 | 没有学过手艺}，%name%被称之为临时工，不管哪缺人手都能找他。 {工作稀缺已经有段时间了，所以 | 在过去的几周里几乎没有什么工作可做，所以 | %name%想做他以前没做过的事，所以 | 尽管他没有战斗经验，但盯着酒瓶子看得太深让他相信 | %name%觉得战斗职业不会缺工作，所以 | 就跟许多人的遭遇一样，%name%的爱人因病逝去使他最终崩溃了。在连续几周买醉消愁之后，} 一个四处旅行的佣兵团似乎是个好机会来{跟着混一段时间 | 赚点小钱 | 稍稍看看世界 | 让他清醒一下脑袋 | 带他去下一个村子并顺路把口袋塞满}。";
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
			local item = this.new("scripts/items/armor/oriental/cloth_sash");
			items.equip(item);
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}

});

