this.caravan_hand_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.caravan_hand";
		this.m.Name = "商队帮工";
		this.m.Icon = "ui/backgrounds/background_12.png";
		this.m.BackgroundDescription = "商队帮工习惯于漫长而疲惫的旅行。";
		this.m.GoodEnding = "曾经的商队帮工%name%从战斗中退役了。他用当佣兵赚的钱开展了贸易保护的生意，专精于在那些特别危险的地区运送货物。";
		this.m.BadEnding = "商队帮工%name%退役后又回到保护商队货车的行当。他在抵御一次强盗伏击时死亡。他们拿走了他的衣服并将他的尸体抛弃在沟渠中。";
		this.m.HiringCost = 75;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.tiny",
			"trait.clubfooted",
			"trait.gluttonous",
			"trait.bright",
			"trait.asthmatic",
			"trait.fat"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
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
		return "{作为总是喜欢冒险的那类人，%name%轻易的被商队帮工式的生活所吸引。 | 战争和瘟疫使%name%成为孤儿，他在一名旅行商人的翅膀下长大。 | 商队帮工的生活艰苦，但%name%就是无法忍受在一个地方呆太久。 | 尽管这项工作很危险，但作为商队帮工使得%name%可以见见世面。 | 当他的家庭和义务都被大火夺取后，%name% 觉得没有理由不加入路过的商队。 | %name%刚毅而果敢，被一个商人第一个选中作为商队帮工保护他的货物。 | 离家出走后，%name%很快就加入商队并最终为之工作。}{但他之前为之工作的那个商人太能压榨，离奴隶监工只差一个鞭子。在和那个女人激烈争吵后，%name%认为最好在他干出啥蠢事前离开。 | 有一天，货物不见了并且这名帮工背了锅，立刻终结了他跟商队在一起的时间。 | 但商队需要保护是有原因的，强盗的一场伏击就是答案。%name%勉强活逃了出来。 | 多年的旅途一帆风顺，直到一位新的商队老板拒绝给%name%支付工资。这名商队帮工只用一只手就打翻了老板并夺回了他的工资，然而他跑的时候两条腿都用上了。 | 商队也是一处人们精神紧绷的地方。在一个宿命的傍晚，由赌债引起的一场纠纷中他惹恼了另外一个旅行者。因为害怕报复，%name%在天亮之前便逃走了。 | 悲剧的是，战争的扩大使得商队的利润微乎其微。随着商人们让它们的货车退役，%name%也被遣散了。 | 在看到野兽袭击另一个商队留下的可怕残骸后，%name%很快发现自己的工资跟周围的威胁相比不在一个层次。 | 随着战争剥夺了商队的库存，很快它的头领就开始买卖奴隶了。%name%对此又惊又恶，在离开之前释放了尽可能多的人。 | 可悲的是，他的商队开始买卖奴隶。虽然利润巨大，但却引起了一支当地民兵和他们草叉的注意。一次伏击之后%name%就在逃命了。}{现在他还没确定去做什么，所以打算抓住能遇到的任何机会。 | 像%name%这样的人对危险并不陌生，令他很适合加入佣兵团。 | 他在商队的日子已经过去，当名佣兵不过是冒险和获利的另一条途径。 | 在%name%的心目中，当佣兵和当商队帮工差不多，只是报酬更好。 | 由于精通旅行，%name%似乎天生适合那些佣兵们的任务。 | 多年行路使得%name%结实耐劳。任何一支佣兵团都用的上他这样的人。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				5
			],
			Bravery = [
				3,
				3
			],
			Stamina = [
				5,
				7
			],
			MeleeSkill = [
				4,
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
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/thick_tunic"));
		}
		else
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 2);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
	}

});

