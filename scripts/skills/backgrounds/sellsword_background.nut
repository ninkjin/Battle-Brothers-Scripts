this.sellsword_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.sellsword";
		this.m.Name = "佣兵";
		this.m.Icon = "ui/backgrounds/background_10.png";
		this.m.BackgroundDescription = "佣兵很昂贵，但是战斗的一生将他们铸就成娴熟的斗士。";
		this.m.GoodEnding = "佣兵%name%离开了%companyname%并创建了自己的佣兵团。据你所知，这个冒险非常成功，而且他经常和%companyname%的人抱团一起工作。";
		this.m.BadEnding = "%name%离开了%companyname%并创建了自己的佣兵团进行竞争。两个战团在一场贵族间的战斗中站分别站在两边并发生了冲突，这个佣兵的脑袋被%companyname%的一名雇佣兵用野骑士的头盔砸扁了。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.weasel",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
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
			"trait.insecure"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
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
		return "{当%fullname%的父亲将自己的装备交给他后，他开始了佣兵的工作。 | %fullname%根本想不起来自己不是一个佣兵的日子。 | 作为一个佣兵，%fullname%从不需要花太长时间找工作。 | 当文化人们谈到释放战争之犬时，%fullname%就是其中一只战争之犬。 | 战争既有死亡，也有收益。%fullname%靠造成前者来赚取后者。 | 对于像%name%这样的佣兵来说，赚钱的机会从来没有像现在这么多。 | 在他妻子带着孩子出走后，愤怒的%name%作为一个难缠的佣兵稳步发展了职业生涯。 | 十年前，%name%在一场火灾中失去了一切。从那之后他一直在当佣兵。 | %name%的思想里一直包含暴力，并长期从事佣兵职业。 | 曾经又脏又穷的%name%多年来作为佣兵赚了一大笔钱。 | %fullname%从来不向他人透露自己的出生，但他作为佣兵的名声已经不言而喻。}{他经验丰富，曾跟随多支队伍一同旅行。 | 军事战役对他来说不过是皮带上的又一个孔而已。 | 从作为一个领主的保镖到充当一个肮脏商人的打手，%name%见识过各种各样的事。 | 他曾经以杀戮侵占人类定居点的野兽为生。 | 他咧嘴一笑，吹嘘自己杀死了各种各样的生物。 | 通过大量的实践，这名佣兵学会了使用一些你甚至都不知道其存在武器。 | 这名佣兵在计算至今他已经杀了多少人，而他似乎一时半会儿不会停下来。 | 手里拿着剑和盾牌，这名佣兵明显在用他最擅长的事情过活。}{这个人对战场并不陌生。 | 这个人对战争的残酷并不陌生。 | 他已经习惯了雇佣兵严酷的生活。 | 据称他能在任何盾墙中成为一个可靠的齿轮。 | 有人说他能像橡树一样坚守阵线。 | 传闻说这个人喜欢。 | 他毫无羞愧的从战场上其他人的不幸中获得让人不安的快感。 | 奇怪的是，他很少和其他人一起坐在篝火旁，而是保持沉默。 | 这个人喜欢讲他如何杀了这个或那个东西的故事。 | 如果有机会，这个人很快就能展示出各种各样的战斗风格。}{只要你还有钱，%name% 就归你指挥。 | 作为一个真正的雇佣兵，只要价钱合适%name%会与任何人战斗。 | 展示着高超的剑术，%name%说他刺穿任何人。 | 只是点了下头，%name%同意了加入你，如果你有克朗的话。 | 因为有机会赚钱而兴奋，%name%在桌子上敲着酒杯。}";
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
				12,
				10
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

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 8)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 9)
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/armor/mail_shirt"));
		}

		r = this.Math.rand(0, 9);

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
			items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/reinforced_mail_coif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/kettle_hat"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/helmets/padded_kettle_hat"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

