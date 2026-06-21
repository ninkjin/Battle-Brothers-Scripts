this.raider_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.raider";
		this.m.Name = "掠夺者";
		this.m.Icon = "ui/backgrounds/background_49.png";
		this.m.BackgroundDescription = "任何一个能幸存到现在的掠夺者在战斗方面都会十分专业。";
		this.m.GoodEnding = "作为一名前掠夺者，%name%很好地适应了%companyname%并证明了自己是一名出色的战士。他攒了一大笔克朗后，便从战团退休并回到了他的家乡。他最后一次被看到时正在驾驶一条内河小船驶向一个小村庄。";
		this.m.BadEnding = "随着%companyname%的快速衰落，掠夺者%name%离开了战团并重新去开拓自己的道路。他重新开始掠夺，带着他贪婪的暴力沿着河岸袭击河边村庄。你不清楚是否属实，但消息称他被一个马厩男孩用草叉刺穿了。据说那个城镇将他的尸体残肢高悬城墙，以警示可能的掠夺者。";
		this.m.HiringCost = 160;
		this.m.DailyCost = 28;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",
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
		this.m.Titles = [
			"掠夺者",
			"收割者",
			"穷凶极恶",
			"强盗",
			"四指",
			"黑鸦",
			"乌鸦",
			"不法者",
			"烧杀者",
			"祸源"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
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
		return "{由于住在海边，%name%的生活被海洋掠夺者这种香料所点缀。成年后，他加入了他们的掠夺行动。 | 当他的家人都被屠杀之后，新生的%name%被做了这一切掠夺者们接纳了。 | 出生在一个遥远的地方，%name%来到这片土地寻找城镇来烧杀掳掠。 | 作为一个来自偏远地区的壮汉，%name%出现在这对当地居民来说非常可怕。 | 作为掠夺者，%name%用来划桨的手臂十分强壮，用来持斧的手臂则更加强壮。他是用来让孩子们在晚上老实呆在床上的民间传说的一部分。 | 既是战士，亦是罪犯，%name%作为一名掠夺者过得不错。 |  多年前%name%决定用武力从软弱无力的人手中夺取他想要的东西，自那以后他已经因为劫掠村庄和打劫过路商队而有了名头。 | 作为一个贫困且饥饿的男孩长大，出于绝望%name%加入了抢劫犯和杀人犯的行列。这是有生以来他第一次不用每晚感到饥饿，所以他继续用武力从别人那里夺取他需要的东西。他学会了毫无怜悯地战斗和杀戮，没多久他就成了一个怪物般的人。 | 穿着领主的靴子，撕开女王裙子当作披肩，%name%的着装很好的反映了他多年的掠夺。 | 让领主在梦中惊醒，害家庭主妇躲到床下，%name%是一名作恶多端的掠夺者。 | 弱肉强食，这就是%name%赖以生存的准则。}{他和同伴们掠夺商队，洗劫边远的农场，直到有一天发现自己成了被掠夺的对象。一小群兽人发现了%name%的营地，如同自然之力搬冲平了它，少数幸存者被驱散到了各个方向。%name%头也不回的逃走了。 | 在多年赚取不义之财之后，这个人结束了这种生活，原因是一次对孤儿院的掠夺以一场大火失控并烧死了里面所有人告终。 | 作为一名旧信仰的虔诚信徒，%name%渴望像一个光荣的战士那样战死，以在神的身边获得一席之地。但是像杀牛一样屠杀村民并不能引起神的注意，所以他正在寻找一个更大的挑战。 | 但是在掠夺和强奸的时候，%name%被注意到比起妻子更偏爱丈夫。他的性癖使他遭到战团其他人的排斥。 | 一切从对一个商队的成功掠夺开始。聊聊无几的护卫很快就被砍倒，商人跑的明显不够快，他背上插得标枪可以证明这一点。战利品很丰富，但很快激烈的争执就因如何分赃爆发。等到了晚上，大部分掠夺者都互相残杀而死了。%name%只是勉强逃过一劫，一天下来除了一条受伤的腿外什么都没得到。 | 但他总是对女人们下不了狠手，同伴们不停的强奸和谋杀促使这个掠夺者远离了这种生活方式。 | 被一个领主的卫兵抓住后，这个掠夺者侥幸逃脱，然而只是在山上看到自己的同伴们被处决。 | 但是在一次掠夺中一个村庄伏击了他们，除了他以外的所有人都被砍刀了，他从马厩偷了一匹马逃离了毁灭。 | 有次在森林里行动时，掠夺者的队伍被恶毒的野兽袭击了。为了救自己的性命，他把自己的同伴喂给了那些肮脏的东西。 | 但是随着战争把世界撕裂，掠夺者意识到能真正去抢到的东西越来越少了。 | 但随着冲突的加剧，他遇到的每一个村庄要么一贫如洗，要么已经武装好了准备面对这个世界上的其他恶魔。}{现在，%name%只是想要一个新的开始，即使是在阴暗的佣兵领域。 | %name% 作为一个佣兵不能被完全信任，但至少曾经与强盗和掠夺者为伍使得他很适合这项工作。 | 这个人一点也不兄弟，但他可以挥舞武器，就像武器是他失去的一根手指一样。 | 虽然%name%的过去留给人了坏印象，但更糟糕的还多得是。 | %name%擅长杀戮和掠夺，只是需要确保这些技能被用向你的敌人。 | 虽然%name%是一名优秀的战士，但他优先忠于掠夺。 | %name%是来杀东西和抢东西的。对你来说，他是个好东西。 | %name%脖子上戴着一条耳朵项链，另一条项链上则装饰着那些耳朵的耳环。很是花哨。 | %name%是一个强大的斗士，但是他几乎难逃成为你整个团队中最不受欢迎的人。 | 乡村是一块诱人的绿色帆布，可以在上面建立生活。也许这个掠夺者只是想安定下来。 | 穿着沾有前主人血迹的衣服，%name%看上去已经完全准备好去工作。 | 你有种感觉，%name%穿的衣服可能是某个人被谋杀的时候正穿着的。}";
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

		if (this.Math.rand(1, 100) <= 40)
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
				0,
				-3
			],
			Stamina = [
				2,
				0
			],
			MeleeSkill = [
				12,
				10
			],
			RangedSkill = [
				5,
				0
			],
			MeleeDefense = [
				6,
				5
			],
			RangedDefense = [
				6,
				5
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
		r = this.Math.rand(0, 5);

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
			items.equip(this.new("scripts/items/weapons/morning_star"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		r = this.Math.rand(0, 0);

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
			items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/worn_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
		}
	}

});

