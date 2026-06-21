this.poacher_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.poacher";
		this.m.Name = "偷猎者";
		this.m.Icon = "ui/backgrounds/background_21.png";
		this.m.BackgroundDescription = "偷猎者在使用弓箭猎杀兔子等猎物方面往往有一定的技巧。";
		this.m.GoodEnding = "前偷猎者%name%最终攒够了足够的钱并离开了%companyname%。你得知他找到了一块山地并负责为一位当地领主将其看护。讽刺的是，他的职责是追捕偷猎者。";
		this.m.BadEnding = "在看不到为那么点克朗冒生命危险还有什么意义后，前盗猎者%name%放弃了佣兵的生活，重新回到森林里去非法猎鹿。有一位贵族曾向你提供了一大笔克朗让你专门去追捕这个人。尽管你拒绝了这个提议，但事情已经明朗：他的时日无多。";
		this.m.HiringCost = 65;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.loyal",
			"trait.fat",
			"trait.fearless",
			"trait.brave",
			"trait.bright"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
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
		return "{热衷于狩猎的刺激， | 为了养家糊口， | 肚子饿的咕咕直响， | 在一个漫长严峻的冬季耗尽他的食物储备后，}%name%{出发到树林里去追捕鹿 | 开始寻找野生动物，他的担惊受怕可能暗示着他没有狩猎许可 | 能吃下各种各样的林中生物，肩上挂着的一把频繁使用的弓暗示了觅食的方式 | 带着弓和矛到森林里狩猎猎物}。来自%townname%，%name%{作为一个偷猎者，既是猎手也是被狩猎的对象 | 需要养活家里的妻子和孩子 | 寻求养活自己，保住性命，还有填饱肚子 | 一直在偷猎，这是一种对秩序的叛逆，也是一种填饱肚子的手段}。{由于担心自己的工作会吸引赏金猎人或执法者，他决定靠出卖他的箭术来过日子。 | 他厌倦了仅为桌上有饭工作的那么辛苦，在他看来用佣兵的薪水去买一顿饭要轻松地多。 | 在一次糟糕的狩猎导致他被关在领主地牢很长一段时间之后，他宁愿作为佣兵去命悬一线也不愿意作为偷猎者被套上绞索。 | 多年孤独的狩猎折磨着这个人。虽然佣兵的生活远远更为危险，但比起独自死去，他宁愿死的时候还有同伴。 | 他的妻子恳求他改过自新，以免全家为他的罪行付出代价。他现在站在这里，证明了谁赢了这场争论。}";
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
				5
			],
			Stamina = [
				3,
				0
			],
			MeleeSkill = [
				2,
				0
			],
			RangedSkill = [
				15,
				7
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
				4
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Wildmen)
		{
			r = this.Math.rand(1, 100);

			if (r <= 50)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r <= 80)
			{
				items.equip(this.new("scripts/items/weapons/staff_sling"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
		}
		else
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
			}

			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

