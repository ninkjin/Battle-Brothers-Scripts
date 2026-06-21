this.butcher_southern_background <- this.inherit("scripts/skills/backgrounds/butcher_background", {
	m = {},
	function create()
	{
		this.butcher_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 60;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{在他父亲去世后，%name%接管了在%randomtown%的家族肉铺。 | 因为成长过程中很贫穷，%name%很快学会了杀死动物并剥皮，最终建立了一家肉铺。 | 由于干旱毁坏了农田，%name%的肉铺开始在%randomtown%营业。 | %name%从小就很奇怪，他开始屠宰不仅是为了赚钱，也是为了快乐。 | 在肉铺开业并收到第一批活猪时，%name%笑得合不拢嘴，他看起来从来没有这么高兴过。 | 作为一名屠夫，%name%多年来一直在把死兔子的内脏挤出来，或剁掉不知死活的鱼的脑袋。}{但是关于他虐待动物的谣言最终让这名屠夫失去了生意 | 由于关于黑魔法的可怕谣言早就四处流传，没多久人们就开始质疑他的肉源并将他赶出市场。 | 然而因为这样或那样的原因，杀死动物无法再让他感到兴奋。他在寻求新鲜的东西。 | 当一个人类手指在他的一个鹿皮卷中被发现后，这个人就被赶出了市场。 | 有人说他很享受在对抗沙漠部落的战役期间为维齐尔的士兵屠宰，并希望重新体验那种经历。 | 不幸的是，战争席卷了他的肉铺，留下了一些他不敢屠宰的尸体。 | 然而屠宰一头小猪成了他的重大丑行，因为它原来是贵族的宠物。他只能逃跑以保住自己的脑袋。} {跟血还有内脏相关的事情正适合%name%。因此，欢迎来到战场。 | %name%看所有的东西都是会呼吸且有包装的肉，可能可以宰了卖。 | 光是%name%的存在和他的眼神就能让许多人困扰。 | 大家知道%name%会咬破自己舌头然后品尝鲜血。 | 每当听到猪在尖叫的时候%name%的耳朵都会竖起来。有意思的是，当人在尖叫时也一样。 | 虽然%name%是个屠夫，但显然他的兴趣不在供养队伍上面。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/butcher_apron"));
		}
	}

});

