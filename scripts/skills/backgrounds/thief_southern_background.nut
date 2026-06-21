this.thief_southern_background <- this.inherit("scripts/skills/backgrounds/thief_background", {
	m = {},
	function create()
	{
		this.thief_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.huge",
			"trait.teamplayer",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.paranoid",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.dumb",
			"trait.loyal",
			"trait.clumsy",
			"trait.fat",
			"trait.strong",
			"trait.hesitant",
			"trait.insecure",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.brute",
			"trait.strong",
			"trait.bloodthirsty"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{被盗贼们用蜂蜜牛奶和偷来的钱抚养长大，%name%从一开始就走错了路。 | 由一个酗酒的父亲和一个生病的母亲抚养长大，%name%被直接带入了偷窃的生活。 | 作为一个已经贫穷家庭的第六个孩子，初出茅庐的盗贼%name%最开始从偷走晚饭的最后残羹学到了这门手艺。 | 在一个富有商人的仆人家庭中长大，最终成为小偷的%name%花了多年时间盯着颓废的财富，以及从中窃取。 | 被当地一家孤儿院收留后，没过多久%name%就受到那些底层孤儿的虐待。他只有靠偷窃维生。 | 成了孤儿的%name%从小就是一个街头顽童，他的日子全都是割钱包和掏口袋。 | 虽然从来不是特别缺钱，%name%对物质财富的嫉妒使得他进行偷窃。 | 富人在穷人堆中的挥霍一直让%name%恼怒。所以他两边都偷，把东西留给自己。 | %name%的父亲教会了他所有关于偷窃的知识，不幸的是，也包括如何背刺。 | 教堂用银盘偷东西。领主用征税员偷东西。所以%name%思量着为什么他不能用自己的双手？ | 由于年幼时很贫穷，%name%偷起了面包。等吃饱了后，他很快就开始偷克朗了。}{在多年成功的盗窃之后，一次失误使%name%被扔进地牢。谢天谢地，多年的偷窃也意味着多年的开锁，这没花他太多时间。 | 但当他试图偷神庙的圣杯被抓住后，与僧侣的一次谈话说服了%name%去试试别的生路。 | 一次当地商店的砸抢以%name%被当场抓获而告终。很快写有他信息的海报贴的到处都是，使他的工作变得困难。 | 由于胆敢割开一个胖商人的钱包，%name%没过多久就在养护缺了几根手指的手。他还是很爱惜那些手指的。 | %name%的偷窃行为最终使他成为整个公会的头目。但在十几次暗杀未遂后，这个盗贼意识到同行之中根本没人可以信任。 | 和一个美女搭档，%name%能从任何人身上偷到东西。可惜最后那个女人偷了他的东西。 | 由于在试图销赃时受信任的黑商实际上已经背叛成了线人。在一次惨痛的示众之后，小偷被流放出了%randomtown%。 | 那是一次完美的劫案，这就是那件事的全部了。现在%name%只需要保持低调。 | 在一个敌对帮派的折磨下，他失去了一些牙齿、指甲，以及任何重返偷窃的动机。 |在被捕后，他在西红柿成熟的季节被示众了五天，从此他的盗贼时光结束了。 | 很自然的，他很快就进了监狱。他从不提起他在那的日子，但很明显他不想再回去了。 | 但有一天，他知道了旋转刀刃比起用来小偷小摸有更好的赚钱方式。 | 但他有一半血缘的兄弟被当地一伙匪徒抓获，迫使这个盗贼寻找新的方法支付巨额赎金。 | 但作为强盗的生活并不容易。这个人因吃了一只不属于他的鸡被捕，失去了两跟手指以及任何继续偷窃的意愿。 | 在一次劫案黄了之后，这名男子指认了所有以前的伙伴，只为保住自己小命。现在他再也不能回去偷东西了。}{据你所知，%name%只是在用佣兵的身份作掩护。不管他的原因是什么，工资还是需要他自己挣来。 | 你从海报上认出了%name%。好吧，一个陷入麻烦这么深却还没被抓的人一定有些价值。 | %name%一只手用手指旋转刀片。用另一只手则偷了你的钱包。令人印象深刻，现在把它还回来。 | 多年的偷窃使%name%善于逃避麻烦。 | %name%有着成为优秀佣兵所需的技能，只是他在身边时要小心你的钱包。 | 你不能相信像%name%这样的人，但不管怎样偷窃的本事还是有些用的。 | 据说，有人曾朝%name%射箭。他们不仅没射中，还被这个盗贼拿走了箭羽。 | %name%努力加入佣兵最好不是计划从你的金库中偷窃。 | 通缉海报上的%name%被认为'有武装且危险'，很完美。 | 有很多执法者在找%name%，也许你可以让他们也加入。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/knife"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/oriental/nomad_robe"));
		}

		items.equip(this.new("scripts/items/helmets/oriental/nomad_head_wrap"));
	}

});

