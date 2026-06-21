this.hedge_knight_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.hedge_knight";
		this.m.Name = "野骑士";
		this.m.Icon = "ui/backgrounds/background_33.png";
		this.m.BackgroundDescription = "野骑士是非常竞争力的个体，擅长于用蛮力和重甲与人对抗，但在与他人合作或迅速行动方面则不那么出色。";
		this.m.GoodEnding = "像%name%这样的人总是会找到路子。很难说是不是无法避免，这位野骑士最终独自一人离开了战团。与其他许多兄弟不同，他并没有把克朗用来买地或爬上贵族社会的阶梯。相反，他买了最好的战马和铠甲。这位巨兽般的人在一场又一场骑枪比武间奔波，轻松赢得了所有比赛。他至今还在这样做，你觉得除非他死了否则根本不会停下来。这位野骑士只是单纯的不知道其它活法。";
		this.m.BadEnding = "野骑士%name%最终离开了战团。他漫游于各地，回归了他以前最爱的骑枪比武，其实这只是幌子，他以前最爱的是用骑枪在一片碎屑和荣耀中将人从马上顶下来。某一时刻，他接到指令要在骑枪比武中放水，让一个可怜且瘦弱的王子获得些名气。相反，这名野骑士用骑枪穿透了那位王子的头颅。愤怒的领主下令将这位野骑士处死。据说，超过一百个士兵前往了他的住所，但只有一半生还。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.ailing",
			"trait.swift",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"独狼",
			"狼",
			"猎犬",
			"钢舞者",
			"杀手",
			"比武骑士",
			"巨人",
			"大山",
			"硬脸",
			"玷污者",
			"骑士杀手",
			"野骑士"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 5);
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
		return "{有些人生来就是为了令人畏惧。身高六英尺多，%name%光是身材就足以让人望而生畏。 | %name%的影子笼罩在身材矮小的人身上，当他走过身边时，他们似乎只会进一步缩小。 | 像身披战甲的熊一样站在人群当中，%name%赚取了许多份双倍工资。 | 多年来与他同样身形魁梧的兄弟们进行残酷战斗给%name%留下了一个伤痕累累的可怕形象。}{这位野骑士花了很时间带着他那匹珍贵的马参加骑枪比武。不幸的是，一杆长柄武器敲到了的坐骑，使得他没有马骑。 | 作为一个人的佣兵团，野骑士徘徊多年，为那些支付最多克朗的人战斗。 | 当他一次挥舞劈死五个人，并且其中三个还是战友时，这名野骑士被禁止在这片土地上的任何一支军队服役。 | 被命令去杀死一个领主的敌人，野骑士踢开了一户人家的门并徒手杀了他们。当领主拒绝付钱时，%name%也杀了他。 | 野骑士曾经在苍白的月光下安详地睡过很多晚，也同样在灿烂的阳光下无情地杀了很多人。}{总是在寻找更多的克朗，与佣兵战团为伍似乎很合适。 | 太骇人了以至于没有人敢长期雇佣他，%name%找的是那些在他抓起武器时不会被吓尿裤子的战友。 | 厌倦了杀死比武骑士和领主，还有妇女和儿童，%name%把佣兵工作看作是一种休假。 | 战争显然阻碍了%name%的骑枪比武生涯。他正试图修正这个问题。}";
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

		if (this.Math.rand(1, 100) <= 25)
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
				12,
				13
			],
			Bravery = [
				9,
				4
			],
			Stamina = [
				15,
				10
			],
			MeleeSkill = [
				11,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				6,
				5
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-14,
				-7
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 2) == 2)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.HedgeKnightTitles[this.Math.rand(0, this.Const.Strings.HedgeKnightTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/greataxe"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/greatsword"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/two_handed_flanged_mace"));
			}
		}
		else
		{
			r = this.Math.rand(0, 1);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/greataxe"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/greatsword"));
			}
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/mail_hauberk"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/scale_armor"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/bascinet_with_mail"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/closed_flat_top_helmet"));
		}
	}

});

