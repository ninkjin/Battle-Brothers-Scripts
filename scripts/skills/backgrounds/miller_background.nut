this.miller_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.miller";
		this.m.Name = "磨坊工";
		this.m.Icon = "ui/backgrounds/background_05.png";
		this.m.BackgroundDescription = "磨坊工习惯于体力劳动。";
		this.m.GoodEnding = "前磨坊工%name%在%companyname%继续呆了一段时间，赚够克朗后开了自己的面包店。据你最后听说，他的剑形甜点深受贵族们的喜爱，甚至他给贵族进行销售赚的钱比在战团里赚的还多。";
		this.m.BadEnding = "随着%companyname%陷入困境，磨坊工%name%觉得应该趁着命还在赶紧离开。他帮助一位贵族测试了一种利用骡子和水车联动磨粮的新方法。不幸的是，'帮助'指的是他掉进了装置里，被残酷地压死了。";
		this.m.HiringCost = 65;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.bright",
			"trait.cocky",
			"trait.quick",
			"trait.fragile",
			"trait.greedy",
			"trait.sure_footing",
			"trait.deathwish",
			"trait.dexterous",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"磨坊工"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
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
		return "{当磨坊工的日子总让%name%觉得有所缺憾，但繁重的工作使他无法制定任何远大计划。 | 延续着家族传统，%name%从父亲那里学到了磨坊工的手艺。 | 虽然只是一个普通的磨坊工，%name%却总是梦想着出去闯荡这个世界，将故事和满满的钱袋带回家。 | 作为一个单纯的人，%name% 不介意每天在磨坊里辛勤工作。 | %name%总是比其他人更有野心。在他哥哥满足于经营他们家的磨坊同时，他无法摆脱他必不平凡的感觉。}{一天晚上他被一声响雷惊醒。冲到外面后，%name%意识到他的磨坊被雷击点燃了。 | 当他逮到他的未婚妻在另一个男人床上时，他勃然大怒，狠狠地揍了他们两个。他的拳头淤伤了，人们在对他大喊大叫，但他在曾经是心脏的位置只能感到空虚。仿佛梦中一般，他迅速收拾好行李出发了，再也不打算回来。 | 当他年轻可爱的妻子被森林里的野兽撕碎身亡时，他一句话也没说。沉默中他收拾好了自己的行李并踏向世界，去遥远的某处开始新的生活。 | 在%townname%的酒馆里听了一个野骑士的荒诞故事后，他的想象力变得狂野起来，仿佛世界上所有的可能性都在等着他。 | 干旱意味着他的生意不景气。当%name%无力再继续偿还债务时，他的受到了无情的催债人的生命威胁。他不得不人间蒸发。}{想到他的堂兄%randomname%靠佣兵生意过着体面的生活，%name%决定也这样做。 | 在寻找机会时，他遇到了一个佣兵招募者，向他许诺下了名声和财富。 | 虽然%name%对战斗不知所然，但由于有机会去冒险，他还是热切的想加入佣兵团。 | 无论是由于走投无路，还是出于他的自由意志，%name%现在站在你面前，准备宣誓效忠。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				8,
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(this.Math.rand(6, 7));
			items.equip(item);
		}
	}

});

