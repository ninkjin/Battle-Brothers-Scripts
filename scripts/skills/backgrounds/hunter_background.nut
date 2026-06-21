this.hunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.hunter";
		this.m.Name = "猎人";
		this.m.Icon = "ui/backgrounds/background_22.png";
		this.m.BackgroundDescription = "猎人们习惯于专业的用弓箭猎杀动物，以及独自穿行树林。";
		this.m.GoodEnding = "虽然%companyname%取得了巨大的成功，猎人%name%最终还是决定把这一切都抛在身后。他回到树林和田野狩猎鹿和小动物。他很少再展现出狩猎人类的残酷现实，但你不得不想象他只是宁愿停止这样做。据你所知，他现在过得很好。他购买了一小块土地，并帮助贵族进行高价狩猎旅行。";
		this.m.BadEnding = "由于%companyname%的衰落显而易见，猎人%name%离开了战团并重返狩猎。不幸的是，与一位贵族的狩猎旅行除了岔子，领主的脸颊被一只野猪顶穿了个对穿。猎人觉得自己会被责怪于是独自穿越森林逃跑了，一路遭到了贵族和他的护卫的射击。从那以后就再也没有人见过他。";
		this.m.HiringCost = 120;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.short_sighted",
			"trait.fat",
			"trait.clumsy",
			"trait.gluttonous",
			"trait.asthmatic",
			"trait.craven",
			"trait.dastard",
			"trait.drunkard"
		];
		this.m.Titles = [
			"猎鹿人",
			"林语者",
			"巡林者",
			"猎人",
			"无虚发",
			"独一箭",
			"鹰眼"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 2);
		this.m.IsCombatBackground = true;
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
		return "{没有父亲在身边，%name%的母亲教会了他如何射箭以及养活家人。 | 出生于%randomtown%的腹地，%name%花费相当多的时间在树林间追猎野兽。 | %name%曾经打赌要从猪头上射下一个苹果。他失手了。肚子里装满了培根，他下定决心再也不失手了。当然，除非意味着有更多的培根。 | 在他的早年时光，%name%喜欢在森林里漫步。当一只疯狂的狐狸袭击他时，他学会了拉弓。当一只凶猛的老鹰用爪子抓他的脸时，他学会了射击。}{他曾经被当地贵族雇佣，但一场灾难性的野猪猎杀以男爵被顶伤以及%name%的手上沾着的血并背负的所有罪责而告终。 | 这名猎人将一个想法藏得很深，但从很久之前他就一直在考虑狩猎的终极猎物是什么：是人。 | 可悲的是，一次糟糕的轮盘赌博迫使这名猎鹿人寻求其他收入来源。 | 不幸的是，他烹饪鹿肉的技术远不如狩猎鹿的技术好。一顿肉没完全煮熟的晚餐使全家中毒。他对新的人生的迫切渴望是可以理解的。 | 经过长途跋涉进城卖肉和皮革后，他听从了佣兵工作的号召。 | 战争将猎物赶出了森林，也使%name%不能再狩猎。现在他在找另一个工作。 | 当他的妻子生病时，他无法用狩猎到的肉来治愈她。由于需要挣克朗来支付治疗费用，他开始了出卖自己武力的生涯，或者说是出卖弓艺的生涯。}{任何队伍都用得上像这人一样的神射手。 | 虽然并非毫无缺点，但不论如何%name%仍然是一名专业的弓箭手。 | %name%提供了一个快速展示：他将一支箭射向天空，然后用另一支箭将其击中。令人印象深刻。 | %name%看起来想要要证明的什么，只要确保让他在远距离这么做就行了。第一次给他一把剑时，他抓住了错误的一端。是的，那一端。 | 猎人持着弓就仿佛弓是他的肢体一样，射出的箭像传教士的话语样犀利。}";
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
				5
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
				20,
				17
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				3
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
		local r;
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/thick_tunic"));
		}
		else
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else
		{
			items.equip(this.new("scripts/items/helmets/hunters_hat"));
		}
	}

});

