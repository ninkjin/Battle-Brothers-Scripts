this.servant_southern_background <- this.inherit("scripts/skills/backgrounds/servant_background", {
	m = {},
	function create()
	{
		this.servant_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.huge",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.impatient",
			"trait.iron_jaw",
			"trait.brute",
			"trait.athletic",
			"trait.strong",
			"trait.disloyal",
			"trait.fat",
			"trait.brave",
			"trait.fearless",
			"trait.optimist",
			"trait.cocky",
			"trait.bright",
			"trait.determined",
			"trait.greedy",
			"trait.sure_footing",
			"trait.bloodthirsty"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{生活很艰难，而对某些人来说尤其如此。 | 有些人还可以丧权失地，而其他人根本没得丧失，一出生就在最底层。 | 如果人生就像掷骰子，也许有些人比起当人还不如去当老鼠。}%name%{是一个颓废维齐尔的仆人。 | 为一个孩子们玩火自焚的嗜虐家庭服务。 | 被游牧民绑架，被迫满足他们每一个，新的，需求。 | 狂热地为那些盯着星星看得太久的疯子工作。}他很少因为他自己在这个世界上的地位犯错误。然而有一天，他的主人们{{把他打到晕厥。当他醒来时，他躺在一位仁慈医生的床上，医生拒绝把他交给他的'雇主'。相反，%name%被告知可以自由离开，而他的主人们则被告知他已经死了。 | 无条件的释放了他。没有在仪式上磨蹭，%name%热情地离开了。 | 邀请他参加一个聚会。他以为自己是客人，就穿上了他最好的衣服，也就是一件袖子卷边的衬衫和一套蓬松的长裤，能很好隐藏他嶙峋的骨架。不幸的是，他不过是派对上的一场秀，他们给了他一个木盾和一把剑，把他和一只鬣狗一起扔进竞技场，一边观看这可怕的场面一边下注。他差点没逃过这场'庆典'。}{%name%从此发誓不再为某人'服务'。 | 这个人，尽管现在从他的差事中解脱了，依然承担着他过去漫长艰难的生活带来的羞辱和痛苦。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}
	}

});

