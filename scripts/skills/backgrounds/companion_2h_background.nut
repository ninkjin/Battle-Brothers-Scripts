this.companion_2h_background <- this.inherit("scripts/skills/backgrounds/character_background", {
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
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
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
			"trait.insecure",
			"trait.dexterous"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];
		this.m.GoodEnding = "%name%从一开始就追随着你，退休的时候也一样，他在你离开战团后不久也离开了。但他并没有放弃战斗生涯，而是开始为另一个战团——也就是他自己的战团——而战。他从你的领导中学到了很多，让你感到骄傲自豪，就像有出息的儿子那样。讽刺的是，他讨厌你扮演了他父亲角色这种想法，而你又总告诉他你的儿子压根不会像他这么丑。但你们到今天还保持着联系。";
		this.m.BadEnding = "%name%从一开始就追随着你，他既忠诚又有才华。他在战团待了一段时间之后最终离开去开拓自己的道路。前几天，你收到了这位佣兵的一封信，说他已经开创了自己的战团并急需帮助。不幸的是，这消息的日期几乎晚了一整年。当你调查他的战团是否还存在时，得知它已经在一场贵族间的战斗中被彻底消灭了。";
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.IsUntalented = true;
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
		return "郁郁寡欢有时又有点自我毁灭倾向，所以看到%name%经常拿着大型双手武器陷阵一点也不让人奇怪。{他杀气满溢，你曾经看见他把一个人从头到尾一劈两段。 | 据说他曾经把一个兽战战士一分为二，只留下它的腿还站在那。 | 大家都清楚他为了夺人性命可以毫不在意自己的血肉苦弱。 | 他乐于陷入激烈的战斗，因为他可以舍生忘死毫无顾忌的挥舞武器。 | 据说他曾赢得过一次骑枪比武，但在与一位观赛的贵族夫人上床后不得不跑路。 | 这个人虽不是杀人犯，却胜似一位出色的杀人犯。 | 他时不时看起来势不可挡，你很高兴这个人在你这边。 | 在一次嗜血狂怒中，他用一根长枪刺穿了两个哥布林。 | 他是个强壮的莽汉，你曾看见%name%仅仅通过后挥就杀死一个人。}他会使用你给他的任何武器，但%name%倾向于使用能彻底毁灭肉体的那些。";
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
				10,
				5
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
				0,
				0
			],
			MeleeDefense = [
				2,
				0
			],
			RangedDefense = [
				2,
				0
			],
			Initiative = [
				-5,
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
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}

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

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
	}

});

