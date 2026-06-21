this.bowyer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.bowyer";
		this.m.Name = "弓匠";
		this.m.Icon = "ui/backgrounds/background_29.png";
		this.m.BackgroundDescription = "弓匠对如何使用他们以前制造的远程武器有一定的了解。";
		this.m.GoodEnding = "在一次骑士比武大会中，一个年轻男孩使用了一张形状奇特但做工完美的弓。他瞄准用的那只手抖得很厉害，但箭矢被放出后却没有抖动。在他赢得比赛后，你询问他从哪得到了这样了不起的弓。他说是一名叫%name%的弓匠制作的。很显然，他已经因制作最好的弓而闻名天下。";
		this.m.BadEnding = "在离开%companyname%后，你曾寄信询问弓匠%name%的近况。你得到消息说，他发现了一种能制作最好的弓的方法，比起将这个秘密与战团分享，他选择离开战团并开始自己的事业。然而出师不利，不管他在制弓上有了什么新点子，现在都和他一起永远的死在了{北 | 南 | 西 | 东}边的一条泥泞的路上，有传言说他很讽刺的被十几只箭扎成了刺猬。";
		this.m.HiringCost = 80;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.iron_jaw",
			"trait.athletic",
			"trait.clumsy",
			"trait.short_sighted",
			"trait.fearless",
			"trait.brave",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dumb",
			"trait.brute",
			"trait.bloodthirsty"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill
		];
		this.m.Titles = [
			"弓匠",
			"制箭师",
			"箭匠",
			"恒心"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
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
		return "{手上长满老茧，对细绳有着敏锐的洞察力， | 出生在一个铁匠家庭，绝对会让人纳闷的是 | 从远见卓识的祖先那里继承了优良的手艺，}%name%是一名弓箭匠。{在为贵族提供服务时，一根弓弦崩断并切下了一名备受期望的继承人的手指，他的职业生涯因此结束。 | 不幸的是，战争摧毁了他用来伐取最优质木材的森林。 | 悲剧的是，他把弓箭卖给了一个小男孩，这导致了一场与箭相关的可怕事故。经过多次辩论，他被从城镇中放逐。 | 但是在为他人制造武器这么多年之后，他开始思考人生中除了木头和绳子之外还会有什么。}{现在%name%正在寻找一条不同的路线。如果他没办法卖弓，或许他可以直接用弓。 | 如今%name%混迹于他那些曾经客户的队伍中。 | 随着他对制弓的兴趣消失，不知这位前弓匠能否像制弓那样射箭？}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-5,
				0
			],
			Stamina = [
				-5,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				10,
				10
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
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/apron"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
	}

});

