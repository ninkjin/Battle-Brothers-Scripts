this.historian_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.historian";
		this.m.Name = "历史学家";
		this.m.Icon = "ui/backgrounds/background_47.png";
		this.m.BackgroundDescription = "历史学家是一群好学的人，他们拥有大量的知识，不过没一样在战场上有用。";
		this.m.GoodEnding = "你并没有指望历史学家%name%会永远留在战团。他最终离开了，并且据说带走了一大堆卷轴。事实证明，他正在编撰一份%companyname%的成就列表。他创造了一本记录战团所有成就的法典，把所有雇佣兵的名字都铭刻在了历史书中，供后人瞻仰。你希望他们能从你的作为中学到东西。";
		this.m.BadEnding = "%companyname%持续衰落，许多如历史学家%name%这样的并非战士的人视其为离开的好时机。你试图保持和这些人的联系，但这个历史学家特别好找：他留下了一串纸质线索。你找到这个人，询问文书是否听说过他。他们说他只是一个小人物，写了一本关于佣兵的生活是多么黑暗、暴力和毫无意义的书。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_beasts",
			"trait.paranoid",
			"trait.impatient",
			"trait.iron_jaw",
			"trait.dumb",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.iron_lungs",
			"trait.irrational",
			"trait.cocky",
			"trait.dexterous",
			"trait.sure_footing",
			"trait.strong",
			"trait.tough",
			"trait.superstitious",
			"trait.spartan"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		this.m.Titles = [
			"猫头鹰",
			"好学者",
			"历史学家"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
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
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color]经验获取"
			}
		];
	}

	function onBuildDescription()
	{
		return "{作为一个始终贪婪的读者，%name%的早年生活就是在%randomcity%的图书馆里度过漫长的夜晚。 | 遭受更强壮的同龄人欺凌，年幼%name%躲进了书本的世界里。 | 为了寻找人类过去的真实所在，%name%阅读书籍并研究人性。 | 由于世界上发生了这么多变化，%name%决定帮忙记录它们。 | 作为一个嗜好阅读的快速学习者，%name%试图在纸上为他人展望这个世界。 | 作为一位来自%randomcity%的小学院的学者，%name%为后代记录着世界的历史。 | 由于被发生在世界上的黑暗事件惊悚，%name%停止了对植物的研究并开始记录人类历史。}{一个真正的历史学家会寻找他够得着的最近的原始资料，这使他加入了佣兵的行列。 | 在强盗毁灭了他已写下的作品后，这个人就穿上靴子并亲自开始新的研究。 | 当他的教授说他的研究是垃圾时，这位历史学家走向世界去证明教授错了。 | 被指控剽窃后，这位历史学家被逐出学术界。他在他曾研究的领域中寻求救赎：战争。 | 由于利用他在学术界的地位去女人们上床，最终丑闻和争议把这位历史学家赶出了自己的领域，使他身无分文并准备接受任何工作。 | 厌倦了阅读冒险家故事，这位历史学家觉得它可以把自己武装起来以便能更近距离地观察些真东西。 | 由于有这么多的佣兵团四处游荡，这位历史学家试图投身其中以进行些实践研究。}{%name%与真正的士兵没有什么共同之处，但他富有想象力的头脑一样幻想着一场精彩的战斗。 | %name%毕生都在写作，从来没有花时间去战斗。到此为止了。 | %name%渴望记录你队伍的旅行。他可以用抓起武器穿上盔甲的方式帮忙。 | %name%的肩上扛着一包书。你建议用链枷代替。很相似，但更尖锐。 | %name%经常被发现乱写笔记，因为他仍然用研究者的眼光看世界。 | %name%携带了一口袋鹅毛笔。这些羽毛可以做成很好的箭。 | 你可以对%name%想要进行研究的渴望抱有信心，但对他挥剑的能力可能没法一视同仁。 | %name%跟着队伍是为了发展一套理论，但他能在实验中幸存下来吗？ | 你向%name%保证，如果他死了，你会想办法记录他的生平。他很感谢并交出遗嘱。它是用一种你不懂的语言写的，你完全看不懂。不管怎样，你还是微笑着回应着。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-2,
				-5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				-5,
				-5
			],
			RangedSkill = [
				-3,
				-2
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
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.15;
	}

});

