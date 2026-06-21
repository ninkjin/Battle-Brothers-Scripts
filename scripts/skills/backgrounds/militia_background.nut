this.militia_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.militia";
		this.m.Name = "民兵";
		this.m.Icon = "ui/backgrounds/background_35.png";
		this.m.BackgroundDescription = "任何参加过民兵组织的人都至少会接受一些基本的战斗训练。";
		this.m.GoodEnding = "前民兵%name%最终离开了%companyname%。他游历各地，拜访村庄并帮助他们建立可靠的民兵来保卫自己。在这个越来越危险的世界中取得了成功后，%name%最终成为一个知名人物，被当成'问题解决者'一样的人叫来叫去以确保这些村庄能够保持安全。据你最后听说，他购买了一块土地并组建了一个家庭，远离了这个纷争的世界。";
		this.m.BadEnding = "%name%离开了崩溃中的战团并回到了他的村庄。回到民兵队伍后不久，{兽人 | 劫掠者}就袭击了他们的村庄，他也参加了防御行动。据说他顽强挺立，一边杀死无数敌人一边重新组织防御，最终因致命伤倒下。当你访问该村庄时，你发现孩子们在一个用他形象刻成的雕像下玩耍。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.clubfooted",
			"trait.fat",
			"trait.insecure",
			"trait.dastard",
			"trait.craven",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = this.Math.rand(1, 2);
		this.m.IsCombatBackground = true;
		this.m.IsLowborn = true;
	}

	function onBuildDescription()
	{
		return "{像%name%这样的民兵只有在需要的时候才会被组织起来。 | 身无分文，没有工作，%name%加入了当地民兵组织。 | 因为偷苹果被逮到，作为惩罚%name%被迫加入了民兵组织。 | 虽然只是老百姓中的一员，但%name%一直愿意加入民兵组织来保护自己的家园。 | 战争是一头饥饿的野兽，像%name%这样的应征民兵是它的口粮。}{虽然他接受了适当的训练，但几乎没有足够的食物来供给这位'二等士兵'。 | 尽管他和专业士兵一样奋力战斗，但他发现自己无法从中获得任何尊重。 | 身处士兵的底层，他很快意识到这意味着他的生命是可消耗的。 | 他的武器生锈，盔甲也不存在。不幸的是，敌人可没好心到装备一样差劲。}{身着劣质的装备摸滚打爬了一年之后，他决定去寻找一种更和自己胃口的东西：佣兵。 | 当一个领主将他的全部民兵派往几乎必死之战，%name%意识到如果他想活下去，他最好去找些更好的工作。他将他些许的战斗技能带进了佣兵的领域。 | 多年来，身处无法依靠身边战友的部队驱使着%name%寻找更好的队伍。他不是你见过的最好的士兵，但他是最热切的。 | 当他的民兵队伍解散后，他回到家里，只发现他的城镇已被烧成灰烬。一只脚已经迈进了门槛，只有加入在这片土地上游荡的众多佣兵团之一才算合理。 | %name% 朴素的军事装束掩盖了他所经历过的大量训练和战斗。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				3,
				5
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				6,
				5
			],
			MeleeDefense = [
				2,
				2
			],
			RangedDefense = [
				2,
				2
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

		if (this.Math.rand(0, 4) == 4)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.MilitiaTitles[this.Math.rand(0, this.Const.Strings.MilitiaTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/hooked_blade",
			"weapons/bludgeon",
			"weapons/hand_axe",
			"weapons/militia_spear",
			"weapons/shortsword"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/warfork"
			]);
		}

		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 6);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/full_leather_cap"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});

