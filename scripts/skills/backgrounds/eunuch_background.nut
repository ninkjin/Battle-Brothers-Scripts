this.eunuch_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.eunuch";
		this.m.Name = "太监";
		this.m.Icon = "ui/backgrounds/background_52.png";
		this.m.BackgroundDescription = "太监不能生孩子这件事可能不是佣兵团的首要考虑。";
		this.m.GoodEnding = "对于%name%来说，有些东西总是有点缺。但是这并没能阻止这个太监享受生活。他带着一大堆克朗从%companyname%退休了，并由于完全没有被女人所吸引，这个人过上了美好的、极其专注的生活。";
		this.m.BadEnding = "据说太监%name%在你离开战团不久也离开了，他浪迹四方，一贫如洗，生活窘迫，将仅剩的克朗用于酒和妓女。由于一个妓女用没有那玩意侮辱他，醉酒又暴怒的太监用山羊角刺进那女人的眼睛。当治安官找上来时仍然还醉着酒，这个困惑和惊骇的太监被剥光、绞死并被当地人分尸喂猪。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.weasel",
			"trait.lucky",
			"trait.cocky",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.deathwish",
			"trait.impatient"
		];
		this.m.Titles = [
			"太监",
			"阉马"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.IsOffendedByViolence = true;
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
		return "{当%name%还只是个男孩时，为了使他的嗓音在当地合唱团中音调更高，一位当地的牧师阉割了他。 | 当掠夺者入侵他的村庄时%name%反抗了，最终作为惩罚他的下体被切除。 | 被控在一位不情愿的女性床上犯下了可耻的罪行，%name%只能在死亡和阉割后度过余生中二选一。你不需要物证就能知道他选了哪个。 | 曾经是一名修行中的僧侣，据说%name%和不同信仰的女人上了床。在他被驱逐出了教派后，为了重新获取他们的认可，他除掉了那个引起不满的'装备'。看来信徒们并没有欢迎他回去。 | 在%name%小时候，他醉酒的{母亲 | 父亲 | 姐姐 | 哥哥}用{热锅 | 锯齿状的刀子}{在他睡觉时折磨了他的下体 | 残忍的折磨了他的下体}。 | 当%name%某次穿越距离%townname%不远的森林时，他被{野猪 | 野生的熊 | 野狗 | 野生的鹰}袭击了，撕掉了他身上一大块肉。生还之后，他最终意识到野兽还把他阉割了。 | %name%来自%randomtown%的妓院，在那里他的身体为了满足某个特定客人的要求而遭到了毁伤。}{当你遇到他时，这个人似乎已经迷失方向。现在，他似乎只想逃离这个世界，即使这意味着加入{佣兵 | 雇佣军}。虽然他的遭遇让你不想看到有第二例，但他本身是个相当沉着的家伙。 | 你遇到他时他正被孩子们欺负着。见到你的剑，他礼貌地请求加入你的队伍，因为在里面一个人的过去或残疾都不重要。他已经习惯于生活的困难，而且恐怕是以大部分男人无法言说的方式。 | 令人惊讶的是，这个人比大多数人都更昂首挺胸。对于一个失去了重要器官的人来说，他看起来相当冷静镇定。 | 虽然这个太监的恐怖经历让你汗毛直竖，但他似乎对此毫不在乎。他是一个冷静、几乎被动的人物。 | 这个人的动作比你见过的大多数僧侣都更冷静坚忍。他似乎已经和自己惨痛的过去和解。 | 无法再去满足他的肉欲之后，这个人似乎相当平静且坚定不移，能看到更多事物多内在，而不局限于物质表象。}";
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
	}

});

