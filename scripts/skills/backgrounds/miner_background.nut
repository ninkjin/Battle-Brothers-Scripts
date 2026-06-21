this.miner_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.miner";
		this.m.Name = "矿工";
		this.m.Icon = "ui/backgrounds/background_45.png";
		this.m.BackgroundDescription = "矿工习惯于体力劳动，但多年来呼吸矿井里的粉尘可能对他的健康造成了损害。";
		this.m.GoodEnding = "矿工%name%之后再也没有回到矿井里，谢天谢地。如果有一种生活比为靠作战谋生还要糟糕，那么靠挖掘山脉谋生绝对算是其中之一！据说这位矿工在海边建了一座房子，在余生中悠闲地钓钓鱼看看日出或者干点其他啥类似玩意。";
		this.m.BadEnding = "如果说有一种生活比当佣兵更加艰苦，那便是当矿工。可悲的是，%name%回归了那种生活，重新到矿井里去开采金属和矿石，来填满一些富人的口袋。最近的一次地震使得很多类似的矿井坍塌。你不知道这位老兄是否安然无恙，但情况明显不怎么乐观。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.swift",
			"trait.iron_lungs",
			"trait.bright",
			"trait.fat",
			"trait.clumsy",
			"trait.fragile",
			"trait.strong",
			"trait.craven",
			"trait.dastard"
		];
		this.m.Titles = [
			"矿工",
			"爬行者",
			"地底人"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
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
			}
		];
	}

	function onBuildDescription()
	{
		return "{为了养活一个没有父亲的家庭，%name%在很小的时候就进入了矿山。 | 作为一个孤儿，%name%唯一能找到的工作就是在地下的矿井采矿。 | 采矿是一项艰苦的工作，许多像%name%这样的人却蜂拥而至。 | 尽管他的父亲死在矿井里，%name%觉得自己不得不在矿井里工作，就像他长大之处的大部分男人那样。 | %name在矿井工作，这是一个延续多代的家族传统。 | 每当战争开始时，人们比以往任何时候都更需要像%name%这样的矿工，以免军队没有钢铁装备可供使用。 | 一顶硬头盔和一把十字镐，%name%已经带着这些工具深入大地很多年了。}{但是就如往常一样，一个矿井不会永远存在，这位矿工差点没有逃过上次坍塌事故。 | 可悲的是，他被证明是竖井坍塌事故中唯一的幸存者，而且他不可能单靠自己原挖回去。 | 在一次悲惨的矿难之后，众多寡妇的场面触动了这个人去换一个工作领域。 | 在又一次坍塌中幸存下来，这个男人的妻子要求他去寻找一个新的工作，不管内容是什么。 | 不过，在黑暗中弯腰奔走实在太久之后，这个人寻求另一种职业。 | 在过于黑暗的环境中工作，这个人不小心杀了一个工友。这场悲剧使他离开了工作。 | 在他的亲生儿子在矿井中丧生后，这个人永远离开了这份工作。 | 由于不停的咳嗽，他觉得也许换个在新鲜空气中干活的工作会对他更好。}{%name%有着矿工结实的身躯。不幸的是，他也有一个矿工的肺。 | 虽然确实很坚韧，但%name%的喘息声听起来像生锈的刀片在一起摩擦。  | 你不得不好奇%name%肺里的金属粉尘是否足以制造一两把刀片。 | %name%的呼吸可能能够将煤染黑。 | %name%多年之间一直靠一家合资商铺糊口。现在他想去挣点大钱。 | %name%期待着能够把一部分他多年间从土地里挖出的黄金收入囊中。 | 令人恼火的是，%name%指着你的一半装备，大部分是金属的那些，并提醒大伙这些是谁的成果。 | %name%在黑暗中几乎有猫一样的视觉。要不是他那该死的喘息声，他本可以成为一个出色的刺客。 | %name%已经骗过死神几次了，为什么不以佣兵的身份再试几次呢？ | %name%已经有过大地都想要他命的经历，所以地面上的那点东西不怎么能吓到他。 | 如果黑暗真的是死亡的使节，%name%已经和它交谈了多年。 | 像%name%这样勇敢到愚蠢的人一定能在队伍里找个好差事。 | %name%自豪地说，从前他可以在黑暗中打牌。你对此毫不怀疑。 | 如果%name%能像挥舞十字镐那样挥剑，那么一切都很好。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				10
			],
			Bravery = [
				5,
				8
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				5,
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

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/pickaxe"));
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/mouth_piece"));
		}
	}

});

