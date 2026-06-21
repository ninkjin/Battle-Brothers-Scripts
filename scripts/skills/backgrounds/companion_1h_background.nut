this.companion_1h_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.companion";
		this.m.Name = "伙伴";
		this.m.Icon = "ui/traits/trait_icon_32.png";
		this.m.HiringCost = 0;
		this.m.DailyCost = 14;
		this.m.DailyCostMult = 1.0;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.dumb",
			"trait.clubfooted",
			"trait.drunkard",
			"trait.disloyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.GoodEnding = "%name%从一开始就追随着你，退休的时候也一样，他在你离开战团后不久也离开了。但他并没有放弃战斗生涯，而是开始为另一个战团——也就是他自己的战团——而战。他从你的领导中学到了很多，让你感到骄傲自豪，就像有出息的儿子那样。讽刺的是，他讨厌你扮演了他父亲角色这种想法，而你又总告诉他你的儿子压根不会像他这么丑。但你们到今天还保持着联系。";
		this.m.BadEnding = "%name%从一开始就追随着你，他既忠诚又有才华。他在战团待了一段时间之后最终离开去开拓自己的道路。前几天，你收到了这位佣兵的一封信，说他已经开创了自己的战团并急需帮助。不幸的是，这消息的日期几乎晚了一整年。当你调查他的战团是否还存在时，得知它已经在一场贵族间的战斗中被彻底消灭了。";
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.IsCombatBackground = true;
		this.m.IsUntalented = true;
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
		return "%name%并不是一个喜欢吹牛的家伙，但他完全有资格吹。{他曾救过%2h%和%ranged%的性命。 | 他曾从一个兽人恶毒的锁链下救护了你。 | 如果不是这个人，一名刺客可能已经杀害了你。 | 一支流矢差点带走你的眼睛，还好%name%举盾将其挡下。 | 他曾仅用盾牌和两条强壮的腿将两个人从悬崖上推下。 | 他从父亲那里学会了如何战斗，而他父亲在多名之战中充当先锋。 | 他牺牲了他家的传家宝－一块镶铁旧木盾－来救你的命。 | 他的英雄气概始终如一，曾从酒吧火灾中救出了醉酒的%2h%。 | 面对一大群哥布林，他用他的盾牌和力量在他们的战线上开了个洞，为%2h%和%ranged%打开道路并全歼对方。}凭借着回旋腾挪和盾牌挥舞，这个人架开了各种致命危险。尽管话不多，你发现%name%在一面盾墙中的地位无可替代。";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"1h",
			brothers.len() >= 1 ? brothers[0].getName() : ""
		]);
		_vars.push([
			"2h",
			brothers.len() >= 2 ? brothers[1].getName() : ""
		]);
		_vars.push([
			"ranged",
			brothers.len() >= 3 ? brothers[2].getName() : ""
		]);
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				10,
				5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				10,
				5
			],
			RangedSkill = [
				5,
				5
			],
			MeleeDefense = [
				5,
				5
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/full_leather_cap"));
		}
	}

});

