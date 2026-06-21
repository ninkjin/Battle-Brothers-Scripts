this.peddler_southern_background <- this.inherit("scripts/skills/backgrounds/peddler_background", {
	m = {},
	function create()
	{
		this.peddler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.huge",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.iron_jaw",
			"trait.clubfooted",
			"trait.brute",
			"trait.athletic",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dexterous",
			"trait.dumb",
			"trait.deathwish",
			"trait.bloodthirsty"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{挨家挨户上门， | 曾经是一个骄傲的商人，现在 | 能让大部分人感到厌烦，因为 | 在困难时期，每个人都得勉强度日，这就是为什么 | 不是什么手艺人，而是一个交易人，}%name%是个卑微的小贩。{他会跳舞，他会唱歌，他会吹嘘，他会扮演一个国王，只要能把东西卖出去就行。 | 充满进取心和不屈不挠的精神，他的毅力令人钦佩。 | 他会试图把生锈的水桶当做国王们曾戴过的头盔卖。这个人会去卖任何东西。 | 这个人会让你渴望你从不知道自己想要的东西。不过，概不退货。 | 他曾靠卖{二手货车 | 锅碗瓢盆}来维持体面的生活，直到激烈的竞争将他赶出了市场，用打断他手臂的方式。}{自我推销是这个虚弱的人最擅长的事情，尽管很少有人相信他那些'剑术高超，勇往直前'的话。 | 据说他为自己的服务发放了'优惠券'，不论服务是啥。然而他很活泼，现在这些日子任何一只队伍都用的上活人，不论他是否真有价值。 | 他承诺，如果他被雇佣，你在一瓶壮阳药剂上能得到特殊折扣。 | 这个人压低声音告诉你他有很多生锈的箭尖，只卖给你。见你不感兴趣，他看起来很失望。 | 这个人认识一个认识一个认识一个人的人的人。这三个陌生人都可能比他更擅长打架。 | 很可惜这段时间一个人没法用口舌战斗。否则%name%将无人能挡。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}

});

