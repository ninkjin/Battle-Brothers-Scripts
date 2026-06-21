this.houndmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.houndmaster";
		this.m.Name = "驯犬师";
		this.m.Icon = "ui/backgrounds/background_50.png";
		this.m.BackgroundDescription = "驯犬师习惯于与战犬打交道。";
		this.m.GoodEnding = "尽管他的称号是'驯犬师'，狗对于%name%来说不只是他的'猎犬'，它们是他生命中最忠诚的朋友。在离开了战团后，他设计出狗狗育种的独门秘笈，专门为贵族的需求量身定制。需要一只狂暴野兽做看门犬？他可以做到。想要为孩子们准备一只小巧可爱的狗狗？他也可以做到。这位前佣兵现在靠着他热爱的驯犬事业赚取了可观的收入。";
		this.m.BadEnding = "对于随便某人来说，一只猎犬可能只是一只狗，但对于%name%来说，它是一头忠诚的野兽。在离开战团后，猎犬大师去为贵族工作。不幸的是，他拒绝让他的数百只狗被用作战斗先锋，以换取短暂的战术优势。最终，他因为'叛逆思想'而被绞死。";
		this.m.HiringCost = 80;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.bleeder",
			"trait.bright",
			"trait.asthmatic",
			"trait.fainthearted",
			"trait.tiny"
		];
		this.m.Titles = [
			"驯犬师",
			"狗舍管理",
			"养狗人"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
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
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "这个角色释放的战犬将以自信士气开始战斗"
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%对狗的喜爱始于他父亲在射击比赛中赢得一只小狗。 | 当一只狗把他从熊手中救出来时，%name%将他一生致力于了犬类。 | 看到一条狗拖住了一个想抢劫的人，%name%对狗的喜爱有增无减。 | 作为一个年轻的猎鸟者，%name%很快就发现了狗的荣誉、忠诚和技艺。 | 曾经被野狗咬伤，%name%学会训练犬只，以克服对犬只的恐惧。}{驯犬师为当地一位领主工作了多年。在领主为了运动消遣而击倒一只狗后，他放弃了这个岗位。 | 由于训练杂种狗的速度很快，这个驯犬师将他的狗放进了一个有利可图的巡回贸易展览会中。 | 这个人在斗犬圈子里赚了很多钱，他的狗以其容易指挥和释放后很凶猛而闻名。 | 受雇于执法人员，驯犬师用他鼻子灵敏的狗协助追捕了许多犯罪分子。 | 被当地一位领主雇佣，驯犬师的许多狗都被送上了战场。 | 多年来，这名驯犬师用他的狗来帮助孤儿和残废的人们振作精神。}{然而现在，%name%正寻求改变职业。 | 当他听到佣兵的报酬时，%name%决定尝试一下当一个佣兵。 | 有佣兵找他来买一只狗，但%name%对他自己成为一个佣兵的前景更加感兴趣。 | 厌倦了出于这样那样的目的训练狗，%name%试图训练自己…好吧，还是出于这样那样的目的。 | 有着有趣的前景，你只希望%name%像他曾经指挥的狗一样忠诚。}";
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
				5
			],
			Stamina = [
				5,
				0
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
				3,
				3
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				5,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
	}

});

