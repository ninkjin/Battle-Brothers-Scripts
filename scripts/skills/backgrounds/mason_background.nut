this.mason_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.mason";
		this.m.Name = "石匠";
		this.m.Icon = "ui/backgrounds/background_17.png";
		this.m.BackgroundDescription = "一个优秀的石匠习惯于体力劳动和研究学习提高他的手艺。";
		this.m.GoodEnding = "石匠有着自己独特的召唤，尤其是完美切割石块和不可思议的高塔，让人的眼睛难以在天空的背景下描述它们的轮廓。石匠%name%回归了他的老本行，在使用%companyname%赚到的那些钱后，他开始了一桩有口碑的生意，以其建造的能够在冬天保暖，在夏天保凉的石制房间而闻名。";
		this.m.BadEnding = "%companyname%在你离开后持续遭受损失。越来越多的兄弟离开了战团，其中不少人返回从前的活计。其中石匠%name%也不例外。悲剧的是，所有这些作战经历摧毁了他仅剩的稳定性。由于双手不停颤抖，他再也不能像从前那样刻石了。据你最后听说，他已经开始作为临时工拖运石头，而不再作为石匠刻石了。";
		this.m.HiringCost = 90;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.athletic",
			"trait.asthmatic",
			"trait.dumb",
			"trait.clumsy",
			"trait.bloodthirsty"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
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
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color]经验获取"
			}
		];
	}

	function onBuildDescription()
	{
		return "{在%townname%长大，%name%在年轻时热切地研读建筑书籍。 | 由一个商人公会养大的，%name%在建筑领域的迅速崛起并不令人惊讶。 | 作为%randomtown%备受尊敬的学院的学生，%name%怀着远大的期望毕业，并且还有更远大的东西等着他去建造。 | 由于父亲是个砖瓦匠，%name% 进入石工行业只迈了很小的一步。 | 被教堂和国家的宏伟建筑打动，%name%爱上了石工。 | 当%randomtown%急需防御城墙时，%name%在一个非常幸运的时刻开始了从事石工行当。}{不幸的是，他的石匠生涯很短命。他建造的一座教堂倒塌了，从废墟中爬出的人群化为凶残的暴徒想要报复他。 | 建造了五个建筑，被毁了五个建筑。无休止的战争使这个人的职业变得不可能进行得下去。 | 由于一位建筑师的背叛，这个石匠在把他的对手砌进了他下一个项目的墙里。不久人们就开始问这问那。 | 在盖屋顶时，这个人失足跌下。接踵而来的伤病迫使他离开了他的职场。 | 但是当一个领主要求他建造一个可怕的地牢时，石匠拒绝了。现在他被禁止再去哪怕垒一块砖。 | 一张错位的蓝图让石匠建成了达库利安神殿，而不是应该的达库利德神殿。他说现在诸神在亲自追他。}{放下他的锤子和凿子换成一把战锤和一把锋利到被称作剑的凿子，%name%现在在佣兵领域工作。 | 一天，一张佣兵的海报引起了他的注意。就像他的以前的建筑一样，剩下的都成了历史。 | 多年的砖石工程使这个人很适合沾满鲜血和污泥的生活。 | %name%对他经过的每栋建筑都找出了缺陷。希望他能把那些烦人的分析调整到战场上。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
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
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.MasonTitles[this.Math.rand(0, this.Const.Strings.MasonTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/armor/linen_tunic"));
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.05;
	}

});

