this.disowned_noble_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.disowned_noble";
		this.m.Name = "没落贵族";
		this.m.Icon = "ui/backgrounds/background_08.png";
		this.m.BackgroundDescription = "没落贵族往往从宫廷里的近身格斗训练中受益颇多。";
		this.m.GoodEnding = "内心始终是一名贵族，没落贵族%name%回到了他的家族。传言他踹开了门，并要求贵族地位。一个篡位者向他发起了决斗，然而%name%从呆在%companyname%的日子里学到了很多，于是他坐上了一个非常非常舒适的王座。";
		this.m.BadEnding = "作为一个内心始终是贵族的人，没落贵族%name%回到了他的家乡。传言一个篡位者在城门口将其逮捕，他的头目前插在一根长枪上，以群鸦作为王冠。";
		this.m.HiringCost = 135;
		this.m.DailyCost = 17;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.clumsy",
			"trait.fragile",
			"trait.spartan",
			"trait.clubfooted"
		];
		this.m.Titles = [
			"失地者",
			"流放者",
			"失势者"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.Level = this.Math.rand(1, 3);
		this.m.IsCombatBackground = true;
		this.m.IsNoble = true;
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
		return "{长期让望子成龙的父亲失望 | 作为一场涉及毒药和蛋糕的宫廷阴谋的受害者 | 在公开贬低自家的家族传承后 | 在和他妹妹的乱伦关系曝光后 | 在一次罢黜他哥哥的政变失败后 | 在骄傲和狂妄导致他将父亲的军队领入彻底失败之后 | 因为在一次狩猎中意外杀死了作为王位继承人的长兄 | 作为在一场继承战争中选错盟友的代价 | 因为试图把抓获的偷猎者当作奴隶出售 | 被逮到和一名男贵族同床 | 被发现是震惊平民们的孩子拐卖阴谋的主使 | 因为背弃神明在广大信徒中引起暴乱 | 被看到手臂下夹着邪教徒们的达库尔之书}，%name%{被剥夺了土地逐出了家族，不得返回。 | 被剥夺了头衔并放逐出了这片土地。 | 被强行赶出他的土地并被告知永远不要回来。 | 在被刽子手斧头威胁后，明白自己不再属于宫廷了。 | 已经见识了刽子手的绞索，全靠一条妙计才能勉强逃出。 | 被烙上耻辱的印记，并放逐出他的土地。 | 被认为参与了太多的阴谋，因此被赶出了这片土地。 | 被认为太过有野心，在贵族中这是是一种危险的特质。}{%name%现在寻求救赎及以及不辜负家族的名望。尽管对于佣兵队伍来说他有点自私，但依旧是个贵族。 | 因为流言蜚语耸拉着脑袋，%name%对挫折的抵抗能力减弱了。 | 他也许是个熟练的战士，但%name%除了他自己很少谈论任何人。 | 尽管用剑很熟练，但是你还是能感觉到%name%这样的人被流放是有原因的。 | 运气不好并别无他路，%name%探索进了佣兵的行当里。 | 没有了头衔和土地，%name%寻求加入他曾经统治过的那些人。 | 尽管这位前贵族装备精良，你还是注意到%name%最常用到的装备是他的靴子。}";
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
				-2
			],
			Stamina = [
				-10,
				-5
			],
			MeleeSkill = [
				8,
				10
			],
			RangedSkill = [
				3,
				6
			],
			MeleeDefense = [
				0,
				3
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/mail_shirt"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/mail_hauberk"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}

		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
	}

});

