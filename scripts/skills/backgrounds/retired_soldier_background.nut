this.retired_soldier_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.retired_soldier";
		this.m.Name = "退役士兵";
		this.m.Icon = "ui/backgrounds/background_24.png";
		this.m.BackgroundDescription = "退役士兵往往有丰富的战争经验，他们的决心不易动摇。 然而，他们的年龄可能对他们的身体素质造成了影响。";
		this.m.GoodEnding = "%name%再次退休了，这次不是从当兵退休，而是从当佣兵退休。将%companyname%抛之身后，他在树林里搭建了一间小屋并享受着安静祥和的生活，尽可能的远离所有战斗。";
		this.m.BadEnding = "因为厌倦了所有的战斗，%name%离开了急剧衰落中的%companyname%，并在树林里给自己建造了一间小屋。不幸的是，流浪汉们袭击了他。据说被发现时他倒在地板上大量出血，周围有六个死人，站到最后的人是一个紧张并垮掉了的男孩，他颤抖着将剑挥向了那个快要死去的老人。";
		this.m.HiringCost = 140;
		this.m.DailyCost = 15;
		this.m.Excluded = [
			"trait.weasel",
			"trait.swift",
			"trait.clubfooted",
			"trait.irrational",
			"trait.gluttonous",
			"trait.disloyal",
			"trait.clumsy",
			"trait.tiny",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.hesitant",
			"trait.fragile",
			"trait.iron_lungs",
			"trait.tough",
			"trait.strong",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"老骥",
			"老人",
			"军士",
			"老兵",
			"士兵"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 3);
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
		return "曾经是当地领主的军队中的{一名军士 | 一位贵族护卫 | 一名职业士兵 | 一名受人尊敬的军人 | 一名前线士兵 | 一名士兵 | 一个步兵}，%fullname%{在膝盖中了一箭后退役了 | 被一个有抱负的年轻人取代了 | 在警戒任务中睡着后被开除了 | 在长期模范服役后退休了 | 在战斗中受伤被迫退休 | 厌倦了不停的浴血作战，在他的精神崩溃前正式的退役了 | 与凶猛的兽人部落作战，这些战役最终迫使他退休}。{他把自己的装备连同他履行职责的记忆一起锁在一个箱子里，打算再也不将他们拾起 | 他把剑和盾牌都放在书房的架子上，仅仅是当做是战争过往的遗物 | 他把武器挂在烟囱上方，默默地提醒着自己过去是何许人也 | 但他生命中的一个新篇章正等待着他，这个篇章中他不需要剑就能度过他的一天 | 在服役多年后，他终于可以得到一些安宁 | 没有军事训练的叫嚷，他的生活从来没有这么安静过}。{多年来，他和心爱的妻子过着幸福的生活，直到她因年迈死去。因为生活再无目标， | 直到他发现他以前的战友在一次埋伏中被残忍杀害时， | 直到他听到传言说一次大规模的入侵将要摧毁他的家园时， | 他试着当了一段时间的农夫，但每天他都怀念手持好剑身处盾墙的日子。最终 | 但事实证明，军队之外的生活并不适合他，因为他感到无所事事，毫无用处。最终 | 有一段时间，他感到很自在。但随着战火的蔓延， | 远离战争的时间是短暂的，因为战争很快就找上了他。很快 | 在一个农场里过日子，无聊感在%name%的头脑中蔓延，最终}他再次拿起了武器。尽管{他最好的时光已经过去了 | 他的身体状况不如从前 | 他已不再有年轻人的体质了 | 他已不再是以前那个年轻气盛的战士 | 离开军队后的时光消磨了他的能力}，{他的剑术仍然足以打败任何一个小兔崽子 | 他仍然知道如何在战场上战斗 | 他的经验无与伦比 | 他可以依靠一生的战斗经验 | 他渴望站在兄弟之中 | 他渴望能够再次战斗 | 他对战斗的渴望和他实际作战的能力匹配 | 他还是知晓如何保持盾墙}。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-15
			],
			Bravery = [
				13,
				10
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				13,
				10
			],
			RangedSkill = [
				5,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				-5,
				-10
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
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
		}

		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
	}

});

