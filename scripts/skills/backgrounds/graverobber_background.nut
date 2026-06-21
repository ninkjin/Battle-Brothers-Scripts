this.graverobber_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.graverobber";
		this.m.Name = "盗墓贼";
		this.m.Icon = "ui/backgrounds/background_25.png";
		this.m.BackgroundDescription = "盗墓贼胆子可不小。";
		this.m.GoodEnding = "像%name%这样的盗墓贼在这个世界上可并不怎么受欢迎，但你只需要他能成为优秀的佣兵就行，而他超标准的合格了。在你离开这个行业后，你得知这位盗墓贼留了下来。据你所知，他现在是该战团的教官，帮助新手们快速上手。";
		this.m.BadEnding = "一个像%name%这样的人加入战团是为了帮助他逃脱他那些最卑鄙且不道德的错误，还有什么比靠杀戮挣钱更好的方式呢？不幸的是，%companyname%逐渐瓦解了。你得知%name%最终离开了战团，并加入了一家类似的竞争对手的队伍。你不确定他现在在哪里，也不确定是否要为他的背叛感到受侮辱，还是去理解背后的原因。毕竟，生意只是生意。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.night_blind",
			"trait.cocky",
			"trait.craven",
			"trait.fainthearted",
			"trait.loyal",
			"trait.optimist",
			"trait.superstitious",
			"trait.determined",
			"trait.deathwish"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
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
		return "{是什么让一个人去打扰那些已经逝去的人？ | 随着死者爬起的传闻四处传播，四处挖开坟墓似乎非常具有前瞻性。 | 作为道德标准和人情世故的敌人，拿铁锹盗墓的人几乎找不到盟友。 | 懦夫在一个人倒下的时候攻击他，盗墓贼在他真正倒下的时候攻击他。 | 一个已死之人有多容易被区区盗墓坑到是微不足道。 | 说到死亡，虫子吃了肉，时间风化了骨头，而盗墓贼得到了珠宝。}{被虐待他的母亲带大，%name%发现与死者的相处相比活人更加快乐。 | 在隐居着度过了许多孤独的夜晚后，据说%name%开始与死者共舞。 | %name%在星空下冒险，但苍白和寒冷描述的不仅仅是夜空。 | 为了在无聊的生活中找点乐子，据说%name%会去拜访阴暗的墓地。 | 被一个商人骗了，%name%发现自己靠挖坟搜刮物品。不管怎样，故事是这样说的。 | 曾经是一个优秀的珠宝匠，痴呆驱使%name%打造一套非常与众不同的装饰。在他向你解释的时候一条牙齿做成项链在吱吱作响。}{这样一个人的越轨行为也许是毫无底线的，但他尚且温暖的身体还是有用处的。 | 他脑袋不对劲，但也许用剑能对劲。也许吧。 | 尽管他可能让他人不安，但绝望的时刻需要绝望的新兵。 | 他戴着一条朴素的项链，有着淡淡的灰白色，准确点描述是'骨头'色。 | 被一群尤为疯狂的暴民赶走，%name%成为了众多流落到佣兵世界的外道中的一员。 | 这个人很安静，但在墓地附近你没法让他闭嘴。 | 希望他喜欢把冰冷的尸体埋进坟墓，就像他喜欢把它们挖出来那样。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				8,
				5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				3,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				1
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				0,
				4
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/ancient/ancient_household_helmet"));
		}
	}

});

