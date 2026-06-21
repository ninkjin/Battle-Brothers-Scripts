this.assassin_southern_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.assassin_southern";
		this.m.Name = "刺客";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.BackgroundDescription = "刺客腿脚迅捷并且能熟练使用武器。";
		this.m.GoodEnding = "刺客%name%带着一大箱金子离开了%companyname%并远走他乡。从你听到的传言中得知，他在南部王国以东的山脉中建造了一座城堡。你不确定这是真是假，但最近维齐尔和领主们的死亡率一直稳步上升。";
		this.m.BadEnding = "%name%在你从%companyname%退休不久后就消失了。这名刺客可能不希望被找到并且无人知道他到底在哪。在坦率时你告诉别人你希望自己从没有雇佣过他。你就是无法摆脱那种自己就是他追猎目标的恐惧感，并且经常睡觉时睁着一只眼，用来寻找那个拿着弯匕的黑衣人。";
		this.m.HiringCost = 800;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.huge",
			"trait.weasel",
			"trait.teamplayer",
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
			"trait.short_sighted",
			"trait.bloodthirsty"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		this.m.Titles = [
			"暗影",
			"潜伏者",
			"刺客",
			"背刺者",
			"无形者",
			"凶手",
			"匕首",
			"匿踪者"
		];
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
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
			}
		];
	}

	function onBuildDescription()
	{
		return "{你本来根本不会多想，但%name%跟其他人看起来没有不同，就是一个很普通的普通人。 | %name%面容看起来仿佛是你认识的所有人揉合到了一起，你永远无法准确回忆起他的长相。 | %name%有着温和的笑容和举止，和所有人都平等交谈，权衡贫富的意见仿佛就是在测量他自己。 | %name%没有任何能够引起注意的地方，他毫无特征，注定要成为世界这块背景板的一部分。}{当然，这都是有意设计的。他是一名由训练有素的杀手组成的公会派来的刺客。他随身携带的卷轴不带威胁的建议你将他雇佣并纳入麾下。 | 这份不起眼的存在是被刻意训练出来的面具。事实上，他是一名训练有素的刺客，并且携带着他的公会独有的卡塔尔匕首。 | 然而平淡的面容下却隐藏着凶残的过去。事实上，他携带着卡塔尔匕首，南方的刺客公会只会给予最优秀的杀手这种匕首。 | 然而这'熟悉的陌生人'式面容只是一种掩饰，旨在隐藏他来自一家刺客公会的事实，而他被派出来的原因你可能永远不会知道。}{%name%可能就站在你身边，但感觉上就仿佛消失在了只有两个人的人群之中。 | 尽管你知道直到刚才为止你都没见过这个人，但你就是忍不住觉得以前在哪个地方见过%name%。 | 你很自然的在%name%周围感到放松，但这仿佛就像被设了局一样，因此你在他周围时反过来强迫自己保持警惕。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				20,
				15
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
			items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/tools/smoke_bomb_item"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/tools/daze_bomb_item"));
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/thick_nomad_robe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/oriental/assassin_robe"));
		}

		items.equip(this.new("scripts/items/helmets/oriental/assassin_head_wrap"));
	}

});

