this.eunuch_southern_background <- this.inherit("scripts/skills/backgrounds/eunuch_background", {
	m = {},
	function create()
	{
		this.eunuch_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = null;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.weasel",
			"trait.lucky",
			"trait.cocky",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.deathwish",
			"trait.impatient"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{当沙漠强盗入侵他的村庄时%name%反抗了，最终作为惩罚他的下体被切除。 | 被控在一位不情愿的女性床上犯下了可耻的罪行，%name%只能在死亡和阉割后度过余生中二选一。你不需要物证就能知道他选了哪个。 | 在%name%小时候，他醉酒的{母亲 | 父亲 | 姐姐 | 哥哥}用{热锅 | 锯齿状的刀子}{在他睡觉时折磨了他的下体 | 残忍的折磨了他的下体}。 | 当%name%某次穿越无尽的沙漠时，他被野生的鬣狗袭击了，撕掉了他身上一大块肉。生还之后，他最终意识到野兽还把他阉割了。 | %name%来自%randomcitystate%的妓院，在那里他的身体为了满足某个特定客人的要求而遭到了毁伤。}{当你遇到他时，这个人似乎已经迷失方向。现在，他似乎只想逃离这个世界，即使这意味着加入{佣兵 | 雇佣军}。 | 你遇到他时他正被孩子们欺负着。见到你的剑，他礼貌地请求加入你的队伍，因为在里面一个人的过去或残疾都不重要。他已经习惯于生活的困难，而且恐怕是以大部分男人无法言说的方式。 | 令人惊讶的是，这个人比大多数人都更昂首挺胸。对于一个失去了重要器官的人来说，他看起来相当冷静镇定。 | 虽然这个太监的恐怖经历让你汗毛直竖，但他似乎对此毫不在乎。他是一个冷静、几乎被动的人物。 | 这个人的动作比你见过的大多数僧侣都更冷静坚忍。他似乎已经和自己惨痛的过去和解。 | 无法再去满足他的肉欲之后，这个人似乎相当平静且坚定不移，能看到更多事物多内在，而不局限于物质表象。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/padded_vest"));
		}
	}

});

