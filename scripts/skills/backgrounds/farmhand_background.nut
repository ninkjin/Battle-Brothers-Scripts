this.farmhand_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.farmhand";
		this.m.Name = "农夫";
		this.m.Icon = "ui/backgrounds/background_09.png";
		this.m.BackgroundDescription = "农夫习惯于艰苦的体力劳动。";
		this.m.GoodEnding = "前农夫%name%从%companyname%退休了。他赚到的钱都用于购买一小片土地。接下来的余生中，他都在幸福的种地并组建出人丁超级兴旺的家庭。";
		this.m.BadEnding = "前农夫%name%很快离开了%companyname%。他在{南方 | 北方 | 东方 | 西方}购买了一小片土地，并且过的还算不错，直到贵族士兵因他拒绝交出所有的粮食而将他吊死在树上。";
		this.m.HiringCost = 90;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.clubfooted",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
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
		return "{开垦土地是一份艰苦的活，需要壮汉们洒下血与汗。 | 这片土地上的每一个农场都需要一批坚韧的人来耕种。 | 人在土地上挥洒汗水是为了喂饱自己，而喂饱自己是为了将来还能继续在土地上挥洒汗水。 | 不管天气如何，农场都需要工作。 | 猪圈、马厩和围栏，这些既是农夫的梦想也是恶梦。 | 有些人靠杀戮来维持生计，而另一些人则看着脚下的土地，想知道这土壤能种什么庄稼。 | 农场主和农夫中总是产生一类特殊的人，他们壮实、坚定、勤奋。 | 粮食是如此重要，毫不奇怪农夫是这片土地上最普遍的一类人。 | 一个农夫讨厌看到自己的土地被鲜血浇灌，但这种情况现在越来越普遍了。 | 在战争中，农场是军队的关注热点。不仅是为了获取给养，也是为了能从耕种这些土地的壮汉中募兵。 | 随着城市逐渐发展并与偏远地区越来越疏远，市民们常常忘记自己能吃饱肚子应该感谢谁。}%name%{是一个身材魁梧汗水铸就的农夫。 | 来自%randomtown%的郊区，在那里他犁地驯马。 | 知道好几种锄头，所有这些锄头他都能轻松挥动。 | 在这片土地上众多农场的其中一个里长大。 | 多年来一直忙着收割庄稼，养活这片土地上的人们。 | 作为农夫耕种着一小片田产。 | 在他的船运业务完蛋以后开始从事农业。 | 为了养活他的两个妻子和众多孩子成为了农夫。 | 把种田当作填饱肚子的手段。 | 长着一副结实的身体，非常适合种植、收割和熬过冬天。}{不幸的是，没过多久他的农场就遭遇了战争和动乱。 | 但歉收使得他不得不离开农场。 | 不幸的是，他的农场在这艰难时期是最早遭到袭击的那一批。 | 然而，暴力动荡将会到来的消息迫使他放弃了和平的农耕职业。 | 一如往常那样时机糟糕的干旱已经使这个人失业了。 | 由于没有得到劳动报酬，他最终放弃了农场生活。 | 由于刀尖舔血现在越来越赚钱，很轻易地将这个人从杂七杂八的庄稼那勾引走。 | 有一天，他意识到自己强壮的身体用来砍脑袋比挤牛奶更有价值。 | 在掠夺者抢劫了他的庄稼后，他受够了一切，永远离开了农场生活。 | 天气害他的收成不佳后，农夫决定选择一个不完全受制于大自然母亲突发奇想的职业。 | 据说他真的和农场主的女儿上了床，他不再呆在农场还真是让人大吃一斤。}{由农作物和畜牧产品喂养大的%name%站在你面前，他是你见过的最健康的男人。 | 虽然他确实想念奶牛，不过%name%应该能轻松地接受佣兵的艰苦生活。 | 在农场里长大可以能让人获得所需要的各种营养，而%name%显然由此受益。 | %name%曾被骡子照脸踢了一脚。结果骡子的脚断了，他们不得不把那个畜生杀了。 | 如果人是树，那%name%将永远屹立不倒。用其他的比喻也差不多意思。 | 别让他简单的过去愚弄了你，%name%可以和任何摔跤手或斗士匹敌。 | %name%与驮畜有很多共同之处，只需要给他指引正确的方向就行。 | 从他的体型来看，%name%这辈子一直在吃的那些玉米里一定含着不少肉。 | %name%强壮到可以像给奶牛挤奶一样挤断一个人的脖子。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				12,
				10
			],
			Bravery = [
				-2,
				-3
			],
			Stamina = [
				10,
				20
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
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
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

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});

