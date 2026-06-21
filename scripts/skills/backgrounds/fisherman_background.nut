this.fisherman_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.fisherman";
		this.m.Name = "渔夫";
		this.m.Icon = "ui/backgrounds/background_15.png";
		this.m.BackgroundDescription = "渔夫习惯于体力劳动。";
		this.m.GoodEnding = "%name%从战场上退役，回到了他的打渔事业中。一场巨大的风暴席卷海岸，摧毁了几乎每一艘小艇和小船，除了那个狡猾的渔夫的！拥有着唯一幸存的船只，%name%的生意蓬勃发展。他每天早上醒来都能享受美丽的海滩景色，生活舒适惬意。";
		this.m.BadEnding = "由于战斗生涯发展的不顺利，%name%决定从战场退休，回去捕鱼。在一场巨大的风暴摧残了海岸线后，他在海上失踪了。";
		this.m.HiringCost = 65;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.night_blind",
			"trait.tiny",
			"trait.fat"
		];
		this.m.Titles = [
			"渔夫",
			"渔民"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
	}

	function onBuildDescription()
	{
		return "{%name%热爱大海，喜欢独自在水上捕鱼的宁静 | 讽刺的是，虽然%name%一直讨厌水，但还是跟父亲和爷爷一样成了渔夫 | %name%是一名强壮能干的渔夫 | %name%很满足于当一名渔夫 | %name%总是能幸运的找到最好的捕鱼场所并抓住最肥的鱼}。只要没有暴风雨，他就在外面日复一日的捕鱼。{不幸的是，他的捕鱼小屋在他某次外出捕鱼时被烧毁了。 | 但是灾难降临了，一场风暴突然袭来，让他在海上失去了他最好的朋友，只给他留下了一条严重受损的船，再也无人结伴一起出海。 | 但是灾难降临了，他的妻子因难产而去世，粉碎了他所珍视的一切。 | 然而在无法还债一段时间后，他的船被一个无情的高利贷者抢走了。 | 然而在一时愤怒之下勒死了妻子之后，他对渔业失去了一切兴趣。 | 令他非常沮丧的是，几乎整整一个夏天，他捕到的鱼大部分不是已经死了就是里面已经腐烂了。 | 一位祭司告诉%name%成为渔夫并不是神们对他的期望，而是希望他能以神们名义杀戮溅血，他因此开始考虑其它行业。}某天晚上当他来到酒馆时，一个从事危险工作并且有着收入允诺的新机会出现了。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				0
			],
			Bravery = [
				5,
				0
			],
			Stamina = [
				5,
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
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});

