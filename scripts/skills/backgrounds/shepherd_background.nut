this.shepherd_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.shepherd";
		this.m.Name = "牧羊人";
		this.m.Icon = "ui/backgrounds/background_44.png";
		this.m.BackgroundDescription = "牧羊人习惯于体力劳动，并知道如果用投石索将偶然遇到的狼赶走。";
		this.m.GoodEnding = "一个像%name%这样的牧羊人加入佣兵战团是不寻常的，但他证明了自己是一名合格的战士。随着伤病不断增多，他最终退休并回到了草场，拄着手杖放羊，度过他最终平静的日子。";
		this.m.BadEnding = "你曾认为一个牧羊人在佣兵战团中会格格不入，最终%name%也同意了。他在你离开后不久后也离开了%companyname%，据你所知，他回去照看他的羊了。虽然大多数人在离开战团时情绪低落，但%name%的伤势并没有使他温和的生活方式受到影响，无非就是盯着等同于恶梦的毛绒绒的可爱小动物而已。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.impatient",
			"trait.iron_jaw",
			"trait.athletic",
			"trait.deathwish",
			"trait.sure_footing",
			"trait.disloyal",
			"trait.greedy",
			"trait.drunkard",
			"trait.fearless",
			"trait.brave",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.brute",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"牧羊人",
			"谦逊者",
			"平和者",
			"山羊人",
			"蹄心",
			"羊"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
		this.m.IsLowborn = true;
	}

	function onBuildDescription()
	{
		return "{%name%只是一个来自普通小镇的普通牧羊人，多年来一直在照顾他的羊群。 | 像%townname%这样可爱的地方就应该有一个像%name%这样可爱的牧羊人。 | %name%在埋葬父亲的同一天继承了他的羊群。 | 小时候，%name%偶然发现了一个死去的牧羊人和他身边无精打采的羊群。这个男孩拿起了牧羊人的手杖，接着干了他的工作许多年。 | 由于色弱比狗还严重，%name%更喜欢跟颜色简单的羊群待在一起。 | 当%name%从一个塔上掉下来时，一群羊接住了他。为了回报它们的牺牲，他发誓要成为这片土地上最能保障羊群安全的牧羊人。 | %name%把羊从一个镇带到另一个镇，把羊毛卖给裁缝，把皮卖给制革匠，他靠此获利。 | 放羊是%name%能找到的最简单的工作。 | 跟他放牧的羊群一样与世无争，%name%通过牧羊来在残酷的世界里寻找安宁。 | 作为一个不擅长和人相处的人，%name%更喜欢羊的阴郁智慧。 | 从小被欺负的%name%在牧羊中找到了安宁。 | %name%那群贪玩温顺的羊给了成长过程艰难的他平静和安详。 | 曾经被误认为是{预言家 | 新的救世主}，%name%靠躲进牧羊工作逃脱了{宗教信众 | 愤怒的检察官}。 | 整天看着{羊群 | 一堆羊毛球}在草地上吃草听起来有点无聊，但对于%name%来说却是极乐。 | 被一场牧羊比赛迷住，%name%很意外的把牧羊当做一项竞争激烈的工作。 | 一直是一个温柔善良的男孩，牧羊对于%name%来说似乎是情理之中。 | 逃离虐待他的{母亲 | 父亲 | 姐姐 | 哥哥 | 叔叔 | 姑姑}后，%name%通过当一个牧羊人得到了宁静。}{被夹在神的信徒和邪教徒中间，他的羊群因那些寻找替罪羊和牺牲品的人们受了大罪。 | 在用手杖驱赶了{强盗 | 狼群}之后，牧羊人很好奇他的身体是否比他以前想的更加强壮。 | 随着时间的推移，这个人觉得{他的职业仿佛已经离他远去了。 | 似乎他的心思放不在这上面了。}{他悲伤地退休 | 他挂起了他的牧羊杖}去找别的工作。 | 感到仿佛单是在看世界的美丽却没有亲自去体会，这个人决定放弃牧羊。 | 当巨大且多毛的野兽屠杀了他的羊群后，牧羊人开始寻求复仇。 | 不幸的是，作为这个人唯一同伴的牧羊犬被{强盗 | 兽人 | 狼群}杀了，使这个平和的人去寻求复仇。 | 然而在陷入一个放贷人的阴谋中后，牧羊人突然需要超出他的羊群所能提供的金钱。 | 但是独自生活的寂寞终于找上了这个牧羊人。 | 但是独自一人度过漫长的白天黑夜使牧羊人疲惫不堪，换成其他任何人也会这样。 | 但他无法摆脱父亲对他男子气概的期许，之后某天他放下了手杖去寻找一个更有男子气概的职业。 | 但有一天，他一边放牧一边织羊毛，把所有的羊都领下了悬崖。 | 但在一个雨天下午，他受够了听羊的叫声：比起每天盯着羊看，他应该做些更有用的事情。 | 一天早晨，他醒来时浑身是血，内脏，还有带着血污的羊毛。狼在远处欢快地嚎叫。原来昨天晚上他多数了一只羊。 | 不幸的是，关于他私下对自己羊群做的事情的传闻实在太过难堪，他不得不逃往更青翠，更包容的牧场。 | 可悲的是，沉醉于暴力的强盗们偶然发现了他的羊群。贝茜，小阿达，甚至新出生的山羊西格都被血腥地屠杀了。} {在进城考虑问题时，%name%无意中收到了雇佣兵的召唤。反正再没什么可以失去，他随时都可以报名。 | 这片土地容不下下一个平和的牧羊人。是时候开始新生活了。 | %name%的脖子下面有一个带着血锈的小铃铛。它是另一种生活的遗物，也许也是新生活的标志。 | 他发誓仍能听到他的羊群的叫声。出于某种原因，这并不能激发其他人对他的战斗技巧的信心。 | 虽然尽可能的保持平和，但没有了他的羊群，这个人还是有点迷失。 | 虽然不是一个战士，但这个人知道如何保持严密的队形。 | %name%对星星惊人的了解，而且能像盲犬嗅食一样在黑暗中定位声音。 | 长期行走使%name%的腿变得结实，但他主要的战斗经验都用棍子得来。 | 世界在需要的时候通常不会求助于牧羊人，但现在这个世界非常的困难。 | 盯着牧羊人，你不禁在想情况有多糟糕才会使这样一个人站在这里。 | %name%把几乎所有的武器都像手杖一样带着，并且他有一个坏习惯，就是想让别人移动是总是敲打他们的腿。 | %name%的谦卑对通常来说都比较鲁莽的佣兵兄弟们是一个受欢迎的慰藉。 | %name%看起来都不会去伤害苍蝇，但是经过良好的训练，你预计能看到他去伤害远比苍蝇多的东西。 | %name%不像其他佣兵那样有凶残的念头，但和其他人一样，通过正确的训练可以把他变成那样。 | %companyname%的有些人比绵羊强不了多少。也许%name%终究在这里有一席之地。}";
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
				0
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				5,
				7
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

		if (this.Const.DLC.Wildmen)
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				items.equip(this.new("scripts/items/weapons/staff_sling"));
			}
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/straw_hat"));
		}
	}

});

