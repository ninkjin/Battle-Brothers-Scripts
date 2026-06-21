this.killer_on_the_run_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.killer_on_the_run";
		this.m.Name = "在逃杀人犯";
		this.m.Icon = "ui/backgrounds/background_02.png";
		this.m.BackgroundDescription = "一个在逃杀人犯还可能继续杀戮，并且他知道该瞄准哪里。";
		this.m.GoodEnding = "你总是冒险，即便%name%是一个在逃杀人犯，你也让他加入了%companyname%的行列。结果对你来说很好，因为他证明了自己是一个有能力且勇敢的佣兵。据你所知，他依然在战团里，彻底享受战团能给他带来的每个'生意'。";
		this.m.BadEnding = "虽然很多人质疑雇佣在逃杀人犯%name%的风险，但这个人证明了自己是一个非常有能力的佣兵。不幸的是，旧生活终究不会离开太远，赏金猎人在夜晚绑架了他。你可以在空中五十英尺高的绞架上找到他的骸骨。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.hate_undead",
			"trait.lucky",
			"trait.clubfooted",
			"trait.cocky",
			"trait.clumsy",
			"trait.loyal",
			"trait.hesitant",
			"trait.bright",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.fainthearted",
			"trait.craven",
			"trait.fearless",
			"trait.optimist"
		];
		this.m.Titles = [
			"黑心",
			"背刃",
			"割喉",
			"在逃",
			"通缉犯",
			"凶手"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "更高几率击中头部"
			}
		];
	}

	function onBuildDescription()
	{
		return "{%fullname%有一张没有人希望得到的脸，即一张通缉海报上的脸。 | 手上沾满了鲜血，%name%很像最近赏金猎人给你描述的一个人。 | %name% 似乎已经准备好加入任何队伍，或者消失在它们的行列里。 | 见到别人时，%name%结结巴巴地说出了自己的名字，好像不乐意与其分离。}{认出%name%并不是一件难事：这个人是众所周知的杀人犯，他手上沾着出轨的妻子和她情人的鲜血。 | 他的目光又阴暗又飘忽不定。其后藏有一种罪恶，但也有一种人性的感觉，好像他知道自己做错了，正在寻求弥补。 | 泥巴沾满了他的双腿，他已经跑了很长时间了。他的手也在颤抖，因为那些他的腿所逃离的他亲手做过的事情。 | 他们说他杀死了刚出生的女儿，因为他一直想要个儿子。 | 有人坚持认为他是出于自卫而杀死了一个人。 | 由于他受到诽谤的勒索，你很难责怪他所做的事。}{即使他做错了，一伙杀手也许能用到像他这样的人。但这个人可以信任吗？ | %name%的目光回避着你的眼睛。当你问他是否知道如何使用武器时，他喃喃地说只用来攻击过'那个人'一次。 | 一个拥有%name%这样体格的人是有用的，但是你能在多大程度上依靠一个之前的生活中一直在逃亡的人呢？ | 这个人啃着他的指甲，就像海狸啃树一样。他很神经质，但在这样世界里或许是一件好事。 | 佣兵团对像他这样的人恰到好处。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				4,
				0
			],
			RangedSkill = [
				2,
				3
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
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

});

