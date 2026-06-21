this.gladiator_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.gladiator";
		this.m.Name = "角斗士";
		this.m.Icon = "ui/backgrounds/background_61.png";
		this.m.BackgroundDescription = "角斗士很昂贵，但是竞技场的生活把他们塑造成了熟练的战士。";
		this.m.GoodEnding = "你以为角斗士%name%会就像你想的那样回归竞技场，但来自南方的消息说负债者和角斗士似乎正在起义。与以往的暴动不同，此次使得大臣们被吊在了屋顶，奴隶主被在街头私刑。这次剧变显然将使得这位曾经的角斗士成为该地区一名合法的实权者。";
		this.m.BadEnding = "人群的呼声对角斗士%name%来说太过嘈杂。在你从并未成功的%companyname%迅速退休后，这位战士回到了南方王国的竞技场。不幸的是，佣兵时期的消耗使他迟钝了一步，最终被一名吃不饱饭的奴隶手持草叉和渔网致命击杀。";
		this.m.HiringCost = 200;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_undead",
			"trait.weasel",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Bodies = this.Const.Bodies.Gladiator;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 60;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
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
		return "{南方到处都是各种奴隶，他们因背负金铎之债而被称为负债者。当其中大多数人在田地里劳作时，少数被挑选出来的人被带到角斗场里去战斗。 | 虽然北方人也参加战斗锦标赛，但远比不上南方角斗场暴力和血腥。 | 在南方，富人和穷人都喜欢为角斗场的角斗士欢呼。 | 南方角斗场里充斥着负债者和好杀人者。 | 一幢用于战斗和下注的血腥建筑，南方的角斗场是一个人可以发现穷人富人齐聚一堂的地方。}{%name%就来自于这伙人。他迅速地在这伙人中提升并设法买通了自己的出路，走出了角斗场，进入了相较之下'自由'的生活。 | 深受观众喜爱的%name%作为角斗士的生涯在他富有的赞助商'赦免'后结束。但在早早退休后，他发现自己的生活并不充实。 | 像%name%这样的成功杀手可以赎身购买通向自由的道路，然而嗜血的欲望还未离开他的内心。 | %name%卷入了一次'假赛'事件并被禁止参加角斗一年。 | 但是像%name%这样的角斗士不仅受公众欢迎，而且尤其受女性欢迎。 与一位贵族的妻子进行了一次淫荡的幽会后，这名战士为了避免被阉割在夜色的掩护下溜走了。 | 最受欢迎的角斗士通常是凶残和英俊的混合体，而像%name%这样的人只是前者。由于觉得自己赢得的名气不够，他赎买了自己的自由，离开了这项血腥的运动。}{角斗士通常从一个角斗场奔波另一个角斗场，所以像%name%这样强壮、技术高超的战士在场外很少见。 然而他却站在这里，身上的伤疤足以让任何苦修者脸红。 | 你遇到过很多战士，但很少有人像%name%这样拥有着特殊的技能。竞技场中的各种冲突他成为一个非常聪明的战士，同时也拥有和他在竞技场时间长度匹配的伤势和伤疤。 | 这个世界上有很多种组合，但一个身体未受伤害的角斗士不是其中之一。%name%是一个熟练的战士，而他是用自己的鲜血和身体得到的这些经验。 | 一份令人印象深刻的角斗士简历暗示着%name%精通杀戮。 然而，众多伤疤却明确地表明，他在竞技场的时光有着不可逆转的代价。 | 像%name%这样的角斗士可能是世界上最熟练的战士，但是角斗场的比赛不仅多，而且是为了伤害所有参与者而设计的。这个人是一个有才华的战士，但他身上有着角斗从业者特有的伤疤。}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
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
				13,
				10
			],
			RangedSkill = [
				8,
				6
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
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(1, 2) == 2)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.GladiatorTitles[this.Math.rand(0, this.Const.Strings.GladiatorTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/swordlance",
				"weapons/oriental/polemace",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}

		local a = this.new("scripts/items/armor/oriental/gladiator_harness");
		local u;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			u = this.new("scripts/items/armor_upgrades/light_gladiator_upgrade");
		}
		else if (r == 2)
		{
			u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
		}

		a.setUpgrade(u);
		items.equip(a);
		r = this.Math.rand(2, 3);

		if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/oriental/gladiator_helmet"));
		}
	}

});

