this.butcher_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.butcher";
		this.m.Name = "屠夫";
		this.m.Icon = "ui/backgrounds/background_43.png";
		this.m.BackgroundDescription = "屠夫习惯于流血杀戮。";
		this.m.GoodEnding = "佣兵工作充满了血腥，这大概是屠夫%name%非常适应的原因。虽然他是一个出色的战士，但传闻他还是跟团里的战犬们过不去，并多次被逮到试图屠杀他们。几乎别无他法，最终战团给了他一只可爱的狗仔让他自己抚养。从你所知道的来看，这小家伙那水灵灵的大眼睛把这个厌狗者变成了爱狗者。现在只要有战犬受伤他就会陷入一种无法满足的嗜血状态，他抚养的小杂种狗也长成了战团中最凶猛的野兽。！";
		this.m.BadEnding = "屠夫%name%最终离开了衰落中的战团。他加入了另一支队伍，但在屠杀他们的一只战犬时被逮住了。显然，他一直在用他们那些'失踪'的狗的肉喂食雇佣兵们。他们没有和善地接受这个消息，而且剥光了屠夫的衣服，然后把他喂给了猛兽们。";
		this.m.HiringCost = 80;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.swift",
			"trait.bleeder",
			"trait.bright",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.spartan",
			"trait.iron_lungs",
			"trait.tiny",
			"trait.optimist"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"屠夫",
			"切肉刀",
			"血红",
			"红肉",
			"血眼"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Thick;
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
		return "{在他父亲去世后，%name%接管了在%randomtown%的家族肉铺。 | 因为成长过程中很贫穷，%name%很快学会了杀死动物并剥皮，最终建立了一家肉铺。 | 由于干旱毁坏了农田，%name%的肉铺开始在%randomtown%营业。 | %name%从小就很奇怪，他开始屠宰不仅是为了赚钱，也是为了快乐。 | 在肉铺开业并收到第一批活猪时，%name%笑得合不拢嘴，他看起来从来没有这么高兴过。 | 作为一名屠夫，%name%多年来一直在把死兔子的内脏挤出来，或剁掉不知死活的鱼的脑袋。}{但是关于他虐待动物的谣言最终让这名屠夫失去了生意 | 由于关于黑魔法的可怕谣言早就四处流传，没多久人们就开始质疑他的肉源并将他赶出市场。 | 然而因为这样或那样的原因，杀死动物无法再让他感到兴奋。他在寻求新鲜的东西。 | 当一个人类手指在他的一个鹿皮卷中被发现后，这个人就被赶出了市场。 | 有人说他很享受在兽人入侵期间为士兵屠宰，并希望重新体验那种经历。 | 不幸的是，战争席卷了他的肉铺，留下了一些他不敢屠宰的尸体。 | 他住在一个被围困的城市里，为饥饿的人提供食物。当人们发现肉是从哪里来的后，他就被交给围攻者，而围攻者竟稀里糊涂让他活了下来。 | 这个人对偷猎者的友好态度使他陷入困境，最终迫使他在一屁股领主随从的情况下跑路。 | 然而屠宰一头小猪成了他的重大丑行，因为它原来是贵族的宠物。他只能逃跑以保住自己的脑袋。} {跟血还有内脏相关的事情正适合%name%。因此，欢迎来到战场。 | %name%看所有的东西都是会呼吸且有包装的肉，可能可以宰了卖。 | 光是%name%的存在和他的眼神就能让许多人困扰。 | 大家知道%name%会咬破自己舌头然后品尝鲜血。 | 每当听到猪在尖叫的时候%name%的耳朵都会竖起来。有意思的是，当人在尖叫时也一样。 | 虽然%name%是个屠夫，但显然他的兴趣不在供养队伍上面。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				4
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				0,
				4
			],
			MeleeSkill = [
				3,
				2
			],
			RangedSkill = [
				-3,
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
		r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/butcher_apron"));
		}
	}

});

