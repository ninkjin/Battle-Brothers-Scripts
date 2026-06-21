this.companion_ranged_background <- this.inherit("scripts/skills/backgrounds/character_background", {
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
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.paranoid",
			"trait.night_blind",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.clubfooted",
			"trait.dumb",
			"trait.fragile",
			"trait.short_sighted",
			"trait.disloyal",
			"trait.drunkard",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.dastard",
			"trait.insecure",
			"trait.hesitant"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.MeleeDefense
		];
		this.m.GoodEnding = "%name%从一开始就追随着你，退休的时候也一样，他在你离开战团后不久也离开了。但他并没有放弃战斗生涯，而是开始为另一个战团——也就是他自己的战团——而战。他从你的领导中学到了很多，让你感到骄傲自豪，就像有出息的儿子那样。讽刺的是，他讨厌你扮演了他父亲角色这种想法，而你又总告诉他你的儿子压根不会像他这么丑。但你们到今天还保持着联系。";
		this.m.BadEnding = "%name%从一开始就追随着你，他既忠诚又有才华。他在战团待了一段时间之后最终离开去开拓自己的道路。前几天，你收到了这位佣兵的一封信，说他已经开创了自己的战团并急需帮助。不幸的是，这消息的日期几乎晚了一整年。当你调查他的战团是否还存在时，得知它已经在一场贵族间的战斗中被彻底消灭了。";
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
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
		return "%name%是你旅途中遇到的最有天赋的射手之一。{在他用一支箭射中刺客的心脏救你一命后，你立刻雇佣这个人。 | 想了解这个人很容易，只需去找到并了解谁是当地射击竞赛的获胜者。 | 他曾在一场有来自各地超过百名参加者的箭术比赛中获胜。 | 据说他能射中飞在半空中的一支箭。 | 你在农场里找到了他，很明显继续待那只会浪费他的射击天赋。 | 一名偷猎者、弓匠、弓箭手，这个人的技能有着诸多用途。你怀疑他欣然接受了你提供的佣兵合同只是因为'他全搞定过了'。 | 你曾见他挽弓射月，但那可能只是某种花招。 | 作为一名聪明的弓箭手，他曾一次同时射出两箭杀死了一对冲锋中的强盗。}虽然他更喜欢远距离杀戮，但%name%在近身格斗中也毫不懈怠。";
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
				5,
				5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				5,
				0
			],
			RangedSkill = [
				16,
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
				5,
				5
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
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/light_crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/knife"));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/thick_tunic"));
		}
	}

});

