this.slave_southern_background <- this.inherit("scripts/skills/backgrounds/slave_background", {
	m = {},
	function create()
	{
		this.slave_background.create();
		this.m.GoodEnding = "你以极低的价格将%name%作为负债者购买，之后又给他佣兵的工作支付了'奴隶的工资'。他确实成为了一名出色的战士，毫无疑问他觉得无偿战斗比无偿去死要好。在你离开之后，你听说%companyname%前往南方执行任务，而这名负债者有机会向过去的一些敌人报仇。令人欣慰的是，他不认为你也是那类人，虽然你曾奴役过他。";
		this.m.BadEnding = "你将%name%作为负债者购买，并且在你退休后他继续留在%companyname%的队伍里。有关佣兵团问题的消息已经传出，但都无关于这个负债者目前状况。你知道这个世界是如何运作的，他可能已经作为炮灰被充当前锋，或者甚至被出售以收回利润。无论哪种情况，这个世界对佣兵来说并不容易，对负债者也不容易，而不幸的是，这个人两者都是。";
		this.m.Bodies = this.Const.Bodies.SouthernSlave;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Titles = [
			"被奴役者",
			"囚犯",
			"倒霉蛋",
			"负债者",
			"负债者",
			"负债者",
			"不自由者",
			"罪犯",
			"顺从者",
			"戴镣铐者",
			"被捆缚者"
		];
	}

	function onBuildDescription()
	{
		return "{许多南方城邦建立在战俘、罪犯和负债者作为耗材的身体上，这些人蔑视了金铎或他的追随者，必须通过努力工作来'赚取'救赎。%name%就是这样一个不幸的灵魂。}{跟非常多的人一样，%name%并不一直是一个被追捕的人。直到他的商队被游牧民伏击前，他都是一个旅行商人。游牧民把他带到一个维齐尔那里，假装这个人是罪犯，然后把他当做一个被追捕的人卖掉了。 | 因其英俊的外表受到注意，%name%在%randomcitystate%的街道上被绑架，然后被直接卖给了一个善于操控维齐尔。他不怎么提及都发生了什么，但有一种感觉就是体力劳动不是他唯一的职责。 | 先辈们的宗教冒犯如此之大，%name%出生在了一个负债者的家庭里，不知道要追朔多少辈祖先才能找到一个自由人。 | 为了从代代积累的债务中拯救家庭，%name%把自己出卖成契约奴役，以确保妻子和孩子有自己的生活。 | %name%发誓他来自北方，但南方的沙漠把他晒得黝黑。坦白地说，你没有太多的理由相信一个前战俘的话，不管他来自哪里。 | 作为一个曾经的航海者，%name%当了多年的浆手，从一个港口到另一个港口运送富商们的货物。把他交给你的人说他有当海盗的犯罪前科。 | %name%被指控猥亵一位老妇人，判决给了他两个选项，死刑或者终生奴役。 | 在水果摊偷东西被抓，%name%被迫终身奴役。 | 与“非女性”的通奸导致%name%依照他所违反的城邦法律被奴役。不那样就得当太监，你也不能怪他在这种情况下选择了当苦役。}{相当力奇的是，他艰辛的生活可以作为一个优秀的模子来塑造合格的佣兵。 | 他遭受的奴役无疑使这个人在外表上令人畏惧，尽管很难说他在成为本质上是契约佣兵这件事上的想法如何。 | 在南方城邦奴隶战士十分常见，%name%可能会成为一个有用的，尽管被奴役了的佣兵。 | 你希望%name%能成为一个优秀的佣兵，但是你感觉到他主要效忠的是任何人都想尝到的东西：自由。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-10
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
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
				-5,
				-5
			]
		};
		return c;
	}

});

