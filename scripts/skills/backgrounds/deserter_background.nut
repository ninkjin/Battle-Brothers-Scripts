this.deserter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.deserter";
		this.m.Name = "逃兵";
		this.m.Icon = "ui/backgrounds/background_07.png";
		this.m.BackgroundDescription = "逃兵接受过一些军事训练，但通常不热衷于使用这些技巧。";
		this.m.GoodEnding = "逃兵%name%继续为%companyname%战斗，努力挽回他的名誉。有传言称在一次与兽人的恶战中，他从高处一头扎进了一群绿皮，掠过了它们被惊愕了的脑袋顶部。他的英勇行为鼓舞了士气，最终取得酣畅大胜，现在他每到一家酒馆都会受到热烈欢迎。";
		this.m.BadEnding = "你听说逃兵%name%凭行动更新了他的称号，他在%companyname%与一些绿皮的一场战斗中逃跑了。哥布林在森林中抓住了他，并把他的脑袋做成了一个兽人军阀的酒杯。";
		this.m.HiringCost = 85;
		this.m.DailyCost = 11;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.impatient",
			"trait.clubfooted",
			"trait.fearless",
			"trait.sure_footing",
			"trait.brave",
			"trait.loyal",
			"trait.deathwish",
			"trait.cocky",
			"trait.determined",
			"trait.fragile",
			"trait.optimist",
			"trait.bloodthirsty"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"逃兵",
			"变节者",
			"背叛者",
			"奔跑者",
			"狗",
			"蠕虫"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = this.Math.rand(1, 2);
		this.m.IsCombatBackground = true;
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
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "总是满足于充当后备"
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%曾经是一位领主军队里一名普通士兵，但在一次又一次的失利后， | 曾经在%randomtown%的郊区担任守卫，%name%亲眼看着他所有的朋友都被潜伏的野兽杀死。在经受如此损失之后 | 当两位领主为一个小池塘的归属发生争吵后，%name%被征召来帮助解决这件事。作为一个无名小卒，很明显他的生命毫无价值。在一次屠杀之后， | 在一位领主的职业军队服役时，一种可怕的疾病侵袭了%name%和他的战友。由于害怕这个疾病， | 在一次漫长的军事行动中，%name%觉得行动太多而战利品太少。所以}他{把他的武器插在地上离开了。 | 等到了晚上逃离了队伍。 | 和其他几人一起离队以示抗议。 | 自愿参加巡逻，但机会一出现就立刻跑路放弃了士兵生涯。}{逃兵被普遍鄙视已经不是什么秘密了，%name%一直保持低调避免引起他人注意 | 大多数逃兵在余生都在躲避绞索，%name%也没什么不同。 | 装扮成普通人，%name%一度避免了逃兵的惩罚。 | 幸运的是，目前为止%name%的罪行还没被追究。}{但现在生活窘迫、身无分文，他寻求回去干他原来那一行。 | 也许是迫于执法者围堵，他让自己加入了另一支战斗部队。 | 不幸的是，他不是个聪明人。由于缺乏去追求一个更安全职业的想象力，%name%再次重返战斗。 | 他对抛弃自己的同袍兄弟感到内疚，现在他为另一支队伍作战以寻求救赎。但谁能保证他不会再逃跑呢？ | 买醉以忘却他的过去，导致他钱包空空，他现在不放弃任何谋生的机会。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-15,
				-10
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				7,
				0
			],
			MeleeDefense = [
				3,
				5
			],
			RangedDefense = [
				3,
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
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}

		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;
	}

});

