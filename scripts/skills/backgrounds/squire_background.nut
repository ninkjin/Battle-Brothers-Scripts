this.squire_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.squire";
		this.m.Name = "侍从";
		this.m.Icon = "ui/backgrounds/background_03.png";
		this.m.BackgroundDescription = "侍从通常接受过一些战争方面的训练，而且通常有很高的决心去在自己的事业上出彩。";
		this.m.GoodEnding = "侍从%name%最终离开了%companyname%。你听说过他后来被封为了骑士。毫无疑问，无论他现在在哪里，都一定笑的跟朵花一样。";
		this.m.BadEnding = "侍从%name%最终离开了%companyname%。他打算回家受封为骑士，实现他的终身梦想。残酷的政治干扰了他的计划，他不仅没有被封为骑士，还被解除了侍从职务。有传言称他在一个谷仓悬梁自尽。";
		this.m.HiringCost = 160;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.clubfooted",
			"trait.irrational",
			"trait.disloyal",
			"trait.fat",
			"trait.fainthearted",
			"trait.craven",
			"trait.dastard",
			"trait.fragile",
			"trait.insecure",
			"trait.asthmatic",
			"trait.clumsy",
			"trait.pessimist",
			"trait.greedy",
			"trait.bleeder"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
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
		return "{作为一个年轻的侍从，%name%尽职地陪伴他的骑士参加了许多战斗。 | 作为一位严酷的骑士的侍从，%name%终日为他的主人跑腿。 | 虽然是一个侍从，%name%的生活很大程度上就是看守战俘，这让他非常懊恼。 | 虽然是一位骑士的侍从，但是%name%主要工作是扫扫厕所，喂狗狗，并且用了太多次擦鞋盒。}{一天晚上，一群陌生人鬼鬼祟祟的在月光下显出轮廓。警钟高鸣，一个小时后半个%townname%被毁了。 | 在旅行中，强盗袭击了他领主的车队。剑被拔出，头被砍下，当尘埃落地，侍从还是失败了：他应该保护的人都死了。 | 但是一天傍晚，一大群凶猛的长毛生物来到了他领主的宅邸。在绝望中，%name%释放了一群囚犯，希望他们能在战斗中帮助他。事与愿违，他们杀了他的领主后逃入了夜幕中。侍从勉强活了下来，脚下有十几具魁梧的尸体，但这场战斗让他孑然一人，再无目标。 | 被%townname%的一桩可怕的罪行激怒后，他亲自动手杀死了罪犯。这是正义的举措，也是一种不正当的行为。这个年轻的侍从因违命被放逐。 | 当一个魔鬼般的红骑士来到%townname%进行决斗时，%name%的骑士太过病弱无法战斗。在灌下一杯液体自信后，%name%穿上了他的领主的盔甲去直面红骑士。随着利剑的破空一击，%name%击倒了他的对手。}{现在留给他的任务只剩一个，就是获得骑士身份。 | 现在这个侍从在寻求优秀的同伴，以证明自己配的上成为骑士。 | 随着战争蹂躏大地，现在有很多机会来运用他的技能。 | 虽然有些太过热切，但毫无疑问，这个世界需要像%name%这样的人。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				12,
				12
			],
			Stamina = [
				7,
				5
			],
			MeleeSkill = [
				7,
				5
			],
			RangedSkill = [
				7,
				8
			],
			MeleeDefense = [
				1,
				3
			],
			RangedDefense = [
				1,
				3
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
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
	}

});

