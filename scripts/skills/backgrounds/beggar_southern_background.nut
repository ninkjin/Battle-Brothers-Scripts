this.beggar_southern_background <- this.inherit("scripts/skills/backgrounds/beggar_background", {
	m = {},
	function create()
	{
		this.beggar_background.create();
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
	}

	function onBuildDescription()
	{
		return "{在一场大火中失去一切后 | 在他的赌瘾彻底没治了之后 | 被诬陷了他不曾犯下的罪名，并不得不向治安官交出全部财产避免牢狱之灾 | 作为一个村庄被烧成平地的难民 | 和他的兄弟发生暴力冲突后被从家中放逐 | 作为一个没有天赋也没有野心的人 | 被关在地牢中数不尽的岁月后终于得到释放 | 在把他所有物质财产都给了一个不知名的邪教以图拯救他永恒的灵魂之后 | 曾经是一个聪明人，但之后被强盗打昏了头}，{%name%发现自己呆在街头， | %name%被迫走上街头，}{不得不乞讨面包 | 完全依赖别人的善意 | 经常被揍并开始听天由命 | 只要有钱就买醉度日 | 到处翻其他人的垃圾并躲治安官 | 一边躲避暴徒一边乞讨克朗}。{虽然他看起来很想成为一名佣兵，但街头度日毫无疑问剥夺了%name%最好的年华。 | 这么多年过去，到今天他的健康已经受损。 | 像%name%这样的人一旦街头呆上几天，更不用说是几年，像佣兵这样非常危险的工作也会变成最棒的差事。 | 只有神知道%name%为了生存都经历了什么，但现在站在你面前的只是一个瘦弱的人。 | 他一看到你就准备张开双臂拥抱，声称多年前就认识你并一同进行了许多冒险，尽管他这会儿还想不起你的名字。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			local item = this.new("scripts/items/helmets/oriental/nomad_head_wrap");
			item.setVariant(16);
			items.equip(item);
		}
	}

});

