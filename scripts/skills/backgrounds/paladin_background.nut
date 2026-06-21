this.paladin_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.paladin";
		this.m.Name = "宣誓者";
		this.m.Icon = "ui/backgrounds/background_69.png";
		this.m.BackgroundDescription = "宣誓者是勇敢的战士，他们发誓要遵守严格的规则，并且十分熟悉战斗。";
		this.m.GoodEnding = "宣誓者%name%留在了%companyname%中，挥舞着小安瑟姆的头骨向世界宣扬骑士美德。大多数人将他看做某种烦人的东西，但完全相信荣誉、自豪和行善的人也有些迷人之处。据你所知，他独力从一帮后巷小偷手中拯救了一位领主的公主。在欢庆中他与少女结婚，尽管有传言称她在床上不开心，声称宣誓者坚持让小安瑟姆的头骨在角落里看着。无论发生了什么，你都很高兴这个人仍然全力以赴地做他自己的事情。";
		this.m.BadEnding = "曾经是名彻底的宣誓者，%name%逐渐开始不再对信徒同伴们抱有期望，某天夜晚他梦到他们才是真正的异端。于是，他杀害了身边能够得着的所有宣誓者然后逃跑了，最终竟然还偏偏加入了渡誓者。后来听说，他夺回了小安瑟姆的头骨后用锤子将之敲成碎片。他那些新的渡誓者兄弟们被激怒了，立刻杀害了他。%name%的尸体被发现刺了一百多刀，疯狂狞笑的脸上沾满了血迹还有头骨碎片。";
		this.m.HiringCost = 150;
		this.m.DailyCost = 22;
		this.m.Titles = [
			"十字军",
			"狂信徒",
			"虔诚者",
			"虔信者",
			"圣骑士",
			"正义者",
			"守誓者",
			"立誓者",
			"高尚者"
		];
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.bright",
			"trait.clubfooted",
			"trait.clumsy",
			"trait.craven",
			"trait.dastard",
			"trait.disloyal",
			"trait.drunkard",
			"trait.fainthearted",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_undead",
			"trait.fragile",
			"trait.greedy",
			"trait.hesitant",
			"trait.insecure",
			"trait.paranoid",
			"trait.tiny",
			"trait.tough",
			"trait.weasel"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.RangedSkill
		];
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 60;
		this.m.Level = this.Math.rand(1, 3);
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
		return "{渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者 渡誓者！\n\n渡誓者，渡誓者，渡誓者，渡誓者，渡誓者，渡誓者！\n\n渡誓者！渡誓者！渡誓者！ | %name%是宣誓者的著名创始人小安瑟姆的忠诚追随者，他相信自己受到了祝福才能与志同道合的人们在一起，虽然并不完美，但会尝试为世界做正确的事情。 | 有人说%name%自出生就是宣誓者，实际上最喜欢说这话的人就是他自己。这使得人们猜测他几乎肯定曾是可怕的堕落者，现在才在弥补可怕的过去。 | 当你想到宣誓者时，%name%就是一个非常明晰的例子。保持制服和盔甲干净整洁。尊重上级但从不装腔作势。他在让钢铁穿过渡誓者的脸这一方面十分出色。如果有非常出色的宣誓者的话那一定就是他了。 | 生活在遥远的地方，追求荣誉并给渡誓者带去死亡，%name%听说了%companyname%久负盛名的过去，他现在只需将其找到并加入。他是一个有着惊人决心的人，更重要的是他跟渡誓者不共戴天。 | 小安瑟姆的精神把%name%指引到了%companyname%。至少他是这样说的。不管是什么把他带进了战团，他无疑是一个有才华的战士，能为队伍做出贡献。 | 小安瑟姆的精神的威严是无法授予或夺取。至少%name%是这么认为的。他声称他在为死去的宣誓者们战斗。小安瑟姆一定是个精神饱满的家伙，因为这个人在使用各种武器方面是个天杀的天才。 | 和许多宣誓者一样，%name%知道三条圣律：小安瑟姆的精神需要珍爱，誓言需要被认真对待，所有的渡誓者都必须死。但在此之外稍微赚点钱也不错，这就是为什么他的'第四'圣律是为%companyname%这样的队伍作战。 | 一个宣誓者通过战斗赚取佣金有点奇怪，但%name%说这并不被小安瑟姆的教导所禁止。相反，每个宣誓者都有维持自己誓言的个人责任，他可以通过为%companyname%斩击敌人来实现。 | %name%带着一份只有一项内容的清单：他杀死了多少个渡誓者。他甚至列出了何时何地干的这活，当然还有方式。'方式’这一条目获得了格外的投入，一行一行的文字一丝不苟的描述了他如何消灭了他的仇敌。坦白地说，你喜欢这个人的热情。 | 作为一名宣誓者，%name%的思想是如此的单一，以至于让你几乎担忧如果没有了小安瑟姆的指引他会做什么。话说回来，现在你又有点好奇他如果专注于另一种手艺会怎样。凭借他的决心和动力，他可能可以编织出难以置信的篮子，甚至就像那些学习过的专家一样在水下完成。 | %name%有着人们认为高尚的人该有的素质：聪明，健康，善于挥动武器。他对誓言的专注与他彻底毁灭挡路敌人的能力相匹配。实话实说，他非常适合%companyname%。 | 随着%companyname%声名鹊起，它正在成为这片土地上最有名的队伍之一。自然，像%name%这样才华横溢，追求荣耀的人会寻求加入其中，尽管需要花费一些代价。他为小安瑟姆的事业奉献意味着他的注意力无疑是分散的，但即使陷在正义之中，他仍然是一名不知疲倦的战士，值得成为%companyname%的一员。}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
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
				10,
				6
			],
			Bravery = [
				13,
				16
			],
			Stamina = [
				0,
				-4
			],
			MeleeSkill = [
				13,
				10
			],
			RangedSkill = [
				-2,
				-3
			],
			MeleeDefense = [
				4,
				5
			],
			RangedDefense = [
				-10,
				-5
			],
			Initiative = [
				13,
				12
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/arming_sword",
				"weapons/fighting_axe",
				"weapons/winged_mace",
				"weapons/military_pick",
				"weapons/warhammer",
				"weapons/billhook",
				"weapons/longaxe",
				"weapons/greataxe",
				"weapons/greatsword"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/longsword",
					"weapons/polehammer",
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 75)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		r = this.Math.rand(0, 5);

		if (r < 3)
		{
			items.equip(this.new("scripts/items/armor/adorned_mail_shirt"));
		}
		else if (r < 5)
		{
			items.equip(this.new("scripts/items/armor/adorned_warriors_armor"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/armor/adorned_heavy_mail_hauberk"));
		}

		r = this.Math.rand(0, 5);

		if (r < 3)
		{
			items.equip(this.new("scripts/items/helmets/heavy_mail_coif"));
		}
		else if (r < 5)
		{
			items.equip(this.new("scripts/items/helmets/adorned_closed_flat_top_with_mail"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/helmets/adorned_full_helm"));
		}
	}

});

