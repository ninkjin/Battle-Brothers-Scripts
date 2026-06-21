this.nomad_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.nomad";
		this.m.Name = "游牧民";
		this.m.Icon = "ui/backgrounds/background_63.png";
		this.m.BackgroundDescription = "任何一个能在沙漠中生存下来的游牧民都会有战斗方面的专长。";
		this.m.GoodEnding = "游牧民%name%在你离开%companyname%几个月后也离开了。他显然旅行去了南方并且现在领导着所谓的'腿上城市'，这是一大批游荡沙漠的人组成的。这个社区的富裕和成功如此明显，以至于维齐尔们担心他们自己的人民会蜂拥去那里。";
		this.m.BadEnding = "你获悉游牧民%name%离开了战团，希望能找到新的平原来游荡。显然，他一拍脑袋想到他可以向北旅行并在那里与野蛮人一起舒适的生活。在他看来，尽管外表普遍不同，野蛮人和游牧民有相似的生活方式，文化，语言，宗教，法律，斗争和冲突。这个游牧民在进入野蛮人营地后几乎立刻被宰掉了，之后在一场战士仪式上被分食。";
		this.m.HiringCost = 200;
		this.m.DailyCost = 28;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.weasel",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Titles = [
			"沙漠掠夺者",
			"沙漠民",
			"沙漠之子",
			"沙漠灾厄",
			"蝎子",
			"游牧民",
			"红沙",
			"鬣狗",
			"鹰",
			"大蛇",
			"自由民",
			"游荡者",
			"拦路匪"
		];
		this.m.Bodies = this.Const.Bodies.SouthernMuscular;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
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
		return "{和许多南方人一样，%name%在沙漠中长大，在沙丘间游荡并且埋伏商队和旅行者这类人。 | 出生于南方众多沙漠部落中的一个，%name%在学到其他东西之前就学会了沙之道。 | 游牧民像胡椒一般点缀着南方沙漠，%name%就是在其中一个这样漫游的队伍中诞生的。 | 真正的游牧民在南方的城市中很少见，%name%也不例外。 | 你很少见到游牧民出现在他们本土的南方沙丘以外的地方。但是%name%就站在这里，黝黑的皮肤任风沙磨砺。}{然而，游牧政治有点复杂。某些事情驱使着他进入城市寻找工作，具体信息这位游牧民出身的佣兵拒绝解释。 | 他部落的一个规矩就是第三个儿子都要出去看看世界，并且如果愿意的话可以再回来。所以，%name%站在了这里。 | 被指控与一个没有被正式赠予他的女性有不当性行为，%name%只能从死刑或被驱逐出部落中选择。他站在你面前并且还能呼吸暗示着他选择了哪一个。 | 由于因赌债问题谋杀了同部落的人，这个游牧民被流放出了部落。 | 由于负责策划了一场灾难性的伏击，他被投票逐出了自己的部落。 | 但是这个游牧民希望能亲眼看看更宽广的世界，去看看比自己部落中能看到的更宽广的东西，所以他离开并跋涉入城寻找冒险的工作。}{这个游牧民站在你面前，透漏着他的成长经历：肤色黝黑，深色眼睛，双手磨砺。如果他现在还不算是一个战士的话，那么假以时日他肯定能被训练成一个。 | 作为一个生活在南方难以忍受的沙漠中的人，游牧民的身体素质已经准备好承担佣兵的任务也就不足为奇了。技能是否到位完全是另一回事。 | 在沙漠荒地跋涉的人是吃苦耐劳的，%name%也不例外。 | 像 %name%这样的游牧民大部分战斗经验来自于伏击商队。这可能在佣兵团中有用，尽管前线的工作和埋伏可怜的商人可能有那么点不同。 | %name%符合你对南方的一切期望：遭受沙子的磨砺，但却以准备好克服日间万难的体格挺立。 | %name%现在可能还不算是一个训练有素、技术过硬的战士，但作为一个南方荒原的人，毫无疑问他有一名战士的心和精神。}";
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
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
				-3
			],
			Stamina = [
				2,
				0
			],
			MeleeSkill = [
				12,
				10
			],
			RangedSkill = [
				5,
				0
			],
			MeleeDefense = [
				6,
				5
			],
			RangedDefense = [
				6,
				5
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/nomad_robe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/oriental/thick_nomad_robe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/oriental/stitched_nomad_armor"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/oriental/leather_nomad_robe"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/nomad_head_wrap"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/oriental/nomad_leather_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/oriental/nomad_light_helmet"));
		}
	}

});

